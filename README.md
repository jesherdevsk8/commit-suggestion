# commit-suggestion

Generates short and semantically correct commit messages based on a code diff.

## Installation

1. `curl -L https://raw.githubusercontent.com/jesherdevsk8/commit-suggestion/master/commit_suggestion.rb -o /usr/local/bin/commit`
2. Add the following line to your shell configuration file (e.g. `~/.bashrc`):
   `export ANTHROPIC_API_KEY=sk-ant-api.......`

## Usage

Open the file and replace the `api_key` variable with your Anthropics API key, which should start with "sk-ant-api".

## Example

In your repository's directory, run the command `commit` and the script will
generate a commit message based on the diff of your code.

