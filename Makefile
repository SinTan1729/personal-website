# SPDX-FileCopyrightText: 2025 Sayantan Santra <sayantan.santra689@gmail.com>
# SPDX-License-Identifier: GPL-3.0

.PHONY: publish deploy minify clean

clean:
	@echo "Cleaning up..."
	rm -rf "./minified-tmp/"

minify:
	rm -rf "./minified-tmp/"
	@echo "Minifying resources..."
	minify -rs "${PWD}/" -o "./minified-tmp/"

deploy: minify
	@echo "Deploying website for public access..."
	rsync -aAXhP "./minified-tmp/" "vps-rsync:/srv/personal-website/"

publish: deploy clean
	@echo "Done!"
