#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'
require 'open3'
require 'net/http'
require 'uri'

# sudo ln -s ~/projects/commit-suggestion/commit_suggestion.rb /usr/local/bin/commit
api_key = ENV['ANTHROPIC_API_KEY']

unless api_key
  puts 'Erro: a variável de ambiente ANTHROPIC_API_KEY não está definida.'
  exit 1
end

diff, _status = Open3.capture2('git diff --staged')

if diff.strip.empty?
  puts 'Nenhuma diff encontrada para commitar.'
  exit 1
end

prompt = <<~PROMPT
  Generate a semantic and meaningful Git commit message in English for the following code diff.
  Use the Conventional Commits specification (e.g., feat:, fix:, chore:, refactor:).
  Be concise and return only the commit message:

  #{diff}
PROMPT

payload = {
  model: 'claude-3-7-sonnet-20250219',
  max_tokens: 1024,
  messages: [
    {
      role: 'user',
      content: prompt
    }
  ]
}.to_json

uri = URI('https://api.anthropic.com/v1/messages')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri)
request['x-api-key'] = api_key
request['anthropic-version'] = '2023-06-01'
request['content-type'] = 'application/json'
request.body = payload

response = http.request(request)

begin
  parsed = JSON.parse(response.body)
  message = parsed.dig('content', 0, 'text')&.strip

  unless message
    puts 'Erro: mensagem não encontrada na resposta da API.'
    puts response.body
    exit 1
  end

  # Remove blocos de markdown (```...```)
  commit_msg = message.gsub(/^```|```$/, '').strip

  # puts "Mensagem de commit gerada: #{commit_msg}"

  # Realiza o commit
  system("git commit -m \"#{commit_msg}\"")
rescue JSON::ParserError
  puts 'Erro ao interpretar resposta JSON da API:'
  puts response.body
  exit 1
end
