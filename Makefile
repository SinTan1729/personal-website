# SPDX-FileCopyrightText: 2025 Sayantan Santra <sayantan.santra689@gmail.com>
# SPDX-License-Identifier: GPL-3.0

.PHONY: publish deploy minify clean purge-cache

clean:
	@echo "Cleaning up..."
	rm -rf "./minified-tmp/"

minify:
	rm -rf "./minified-tmp/"
	@echo "Minifying resources..."
	minify -rs "${PWD}/" -o "./minified-tmp/"
	find ./minified-tmp/ -type f -regextype egrep -not -regex '.+\.(html|js|css|svg|ico|png|webp|jpg)' -delete

deploy: minify
	@echo "Deploying website for public access..."
	rsync -aAXhP --delete "./minified-tmp/" "vps-rsync:/srv/admin/personal-website/"

purge-cache:
	@set -e; \
	token="$$(cat "$$HOME/.config/cloudflare_cache_purge_token")"; \
	zone_id="$$(curl -fsS \
		"https://api.cloudflare.com/client/v4/zones?name=sayantansantra.com" \
		-H "Authorization: Bearer $$token" \
		| jq -r '.result[0].id')"; \
	if [ -z "$$zone_id" ] || [ "$$zone_id" = "null" ]; then \
		echo "Failed to find Cloudflare zone for sayantansantra.com" >&2; \
		exit 1; \
	fi; \
	response="$$(curl -fsS \
		-X POST \
		"https://api.cloudflare.com/client/v4/zones/$$zone_id/purge_cache" \
		-H "Authorization: Bearer $$token" \
		-H "Content-Type: application/json" \
		--data '{"hosts":["about.sayantansantra.com"]}')"; \
	if ! printf '%s\n' "$$response" | jq -e '.success == true' >/dev/null; then \
		echo "Cloudflare cache purge failed:" >&2; \
		printf '%s\n' "$$response" | jq . >&2; \
		exit 1; \
	fi; \
	echo "Cloudflare cache purged for about.sayantansantra.com"

publish:
	@$(MAKE) deploy
	@$(MAKE) clean
	@$(MAKE) purge-cache
	@echo "Done!"
