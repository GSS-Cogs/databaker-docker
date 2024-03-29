# Don't bring the lock file over otherwise poetry lock takes ages.
poetry.lock: pyproject.toml
	$(eval CID := $(shell docker run -dit --rm python:3.9))
	docker cp pyproject.toml $(CID):/pyproject.toml
	docker exec $(CID) pip install poetry
	docker exec $(CID) poetry lock
	docker cp $(CID):/poetry.lock poetry.lock
	docker stop $(CID)

