require 'http'
require 'json'
require 'dotenv'

Dotenv.load

conversation_history = ""

api_key = ENV["OPENAI_API_KEY"]
url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

headers = {
  "Content-Type" => "application/json",
  "Authorization" => "Bearer #{api_key}"
}

data = {
  "prompt" => conversation_history,
  "max_tokens" => 150,
  "n" => 1,
  "temperature" => 0
}

while true
    puts "Bonjour comment puis-je vous aider ?"
    user_input = gets.chomp
    if user_input == "stop"
        puts "Revenez quand vous voulez !"
        break
    end
    conversation_history += user_input + "\nBot: "
    data["prompt"] = conversation_history
    response = HTTP.post(url, headers: headers, body: data.to_json)
    response_body = JSON.parse(response.body.to_s)
    response_string = response_body['choices'][0]['text'].strip
    puts response_string
    conversation_history += response_string + "\n"
end
