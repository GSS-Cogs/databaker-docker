all: requirements.pypi.txt requirements.git.txt \
	requirements-dev.pypi.txt requirements-dev.git.txt \
	poetry.lock pyproject.toml docker

docker:
	$(eval CID := $(shell docker run --rm -dit python:3.9))

pyproject.toml: docker
	docker cp pyproject.toml $(CID):/root

poetry.lock: pyproject.toml docker
	docker cp poetry.lock $(CID):/root || true
	docker exec $(CID) pip install poetry
	docker exec -w /root $(CID) poetry lock
	docker cp $(CID):/root/poetry.lock .

requirements.pypi.txt requirements.git.txt: poetry.lock pyproject.toml docker
	# Production export
	docker exec -w /root $(CID) poetry export -f "requirements.txt" -o requirements.txt
	docker cp $(CID):/root/requirements.txt .
	cat requirements.txt | awk '/git\+git/{print>"requirements.git.txt";next} 1'> requirements.pypi.txt && rm requirements.txt

requirements-dev.pypi.txt requirements-dev.git.txt: poetry.lock pyproject.toml docker
	# Development export
	docker exec -w /root $(CID) poetry export -f "requirements.txt" -o requirements-dev.txt --dev
	docker cp $(CID):/root/requirements-dev.txt .
	cat requirements-dev.txt | awk '/git\+git/{print>"requirements-dev.git.txt";next} 1'> requirements-dev.pypi.txt && rm requirements-dev.txt

clean:
	docker stop $(CID)