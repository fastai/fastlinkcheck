.ONESHELL:
SHELL := /bin/bash
SRC = $(wildcard ./*.ipynb)

all: fastlinkcheck docs

fastlinkcheck: $(SRC)
	nbdev_build_lib
	touch fastlinkcheck

sync:
	nbdev_update_lib

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

release: pypi # conda_release
	nbdev_bump_version

conda_release:
	fastrelease_conda_package --upload_user fastai --build_args '-c pytorch -c fastai'

pypi: dist
	twine upload --repository pypi dist/*

dist: clean
	python setup.py sdist bdist_wheel

clean:
	rm -rf dist
