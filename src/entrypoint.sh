#!/usr/bin/env bash
declare -a options

# Use standard formatting, the GitHub Action annotation is nice, but
# hides information from the logs. This action uses standard output
# with a problem matcher instead.
options+=(--format standard)

# Register problem matcher
cp /matcher.json "${PWD}/matcher.json"
echo "::add-matcher::matcher.json"

# Custom path for yamllint configuration input
options+=(--config-file "/config.yml")

[[ "${INPUT_STRICT,,}" = "true" ]] \
  && options+=(--strict)

[[ "${INPUT_WARNINGS,,}" = "false" ]] \
  && options+=(--no-warnings)

# Output version
yamllint --version

# Lint!
exec yamllint "${options[@]}" "${INPUT_PATH:-.}"
