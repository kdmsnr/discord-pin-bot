require 'discordrb'
require 'sinatra'
require 'dotenv'
Dotenv.load

bot_token = ENV['DISCORD_BOT_TOKEN']

bot = Discordrb::Bot.new token: bot_token

# 絵文字がメッセージに追加されたとき
bot.reaction_add do |event|
  if event.emoji.name == '📌'
    event.message.pin
  end
end

# 絵文字がメッセージから削除されたとき
bot.reaction_remove do |event|
  if event.emoji.name == '📌'
    event.message.unpin
  end
end

# ウォームアップリクエストを処理するエンドポイント
get '/_ah/warmup' do
  'Warmup successful'
end

# Botを起動する
# bot.run
Thread.new { bot.run }

# Sinatraアプリを起動する
run Sinatra::Application
