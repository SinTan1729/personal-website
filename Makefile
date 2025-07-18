# SPDX-FileCopyrightText: 2025 Sayantan Santra <sayantan.santra689@gmail.com>
# SPDX-License-Identifier: GPL-3.0

.PHONY: publish

current_dir = $(shell pwd)
timestamp:=$(shell date +%s)
publish:
	@echo "Minifying resources..."
	@minify -rs "${PWD}/" -o "/tmp/personal-website/${timestamp}/"
	@echo "Deploying website for public access..."
	@rsync -aAXhP "/tmp/personal-website/${timestamp}/" "vps-rsync:/srv/personal-website/"
	@echo "Cleaning up..."
	@rm -rf "/tmp/personal-website/${timestamp}/"
	@echo "Done!"
