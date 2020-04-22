Pipfile.lock: Pipfile
	docker run -v $(CURDIR):/workspace -w /workspace -e PIPENV_VENV_IN_PROJECT=1 gsscogs/databaker pipenv update
