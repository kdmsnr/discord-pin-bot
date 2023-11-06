require 'discordrb'
require 'sinatra'

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

# Botを起動する
bot.run

# ウォームアップリクエストを処理するエンドポイント
class MyWebApp < Sinatra::Base
  get '/_ah/warmup' do
    'Warmup successful'
  end
end

# Sinatraアプリを起動する
Thread.new { MyWebApp.run! }

