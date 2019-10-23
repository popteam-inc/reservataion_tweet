#!/usr/bin/ruby
# encoding: utf-8

# twitterライブラリとDateクラスの呼び出し
require 'twitter'
require "date"

#環境変数を読み込み
require 'dotenv'
Dotenv.load

#証明書
ENV['SSL_CERT_FILE'] = File.expand_path('./cacert.pem')

# アクセストークンなどを設定
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['CONSUMER_KEY']
  config.consumer_secret     = ENV['CONSUMER_SECRET']
  config.access_token        = ENV['ACCESS_TOKEN']
  config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
end

#編集者リスト
editors = [ "編集者のアカウント名"]

# client tutorial
def tutorial
  puts "Welcome to Hoge Client."
  puts "このclientを起動時する際、末尾にオプションをつけてください"
  puts "-t HomeのTimeline取得"
  puts "-m リプライの取得"
  puts "-l リストの取得"
  puts "ツイートしたい内容 ツイートする！"
end

# display timeline
def homeTimeline
  @client.home_timeline.each do |tweet|
    puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
    puts "\e[0m" + tweet.text
  end
end


# display mentions
def mentionTimeline
  @client.mentions_timeline.each do |tweet|
    puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
    puts "\e[0m" + tweet.text
  end
end

# display list
def listTimeline
  @client.list_timeline("niidomemomoko", "niidome").each do |tweet|
    puts "\e[33m" + tweet.user.name + "\e[32m" + "[ID:" + tweet.user.screen_name + "]"
    puts "\e[0m" + tweet.text
  end
end

# tweet
def tweet
  @client.update(ARGV[0])
  puts "Tweetしたぞい"
end

# 予約投稿機能


#日付の指定
d = DateTime.new(2007, 5 ,30, 16, 20, 45, 0.375)

# from_editors = dm.select do |msg|
#   editors.include? msg.sender_screen_name
# end

# scheduled_tweet = from_editors.select do |tweet|
#   tweet.text
# end

# scheduled_tweet.each do | tweet|
#   twitter.update(tweet.text)
#   twitter.direct_messages_destroy(tweet.id)
# end

def reservateTweet
  puts "予約日時を入力してください　例）"
  reservate_daytime = gets
  puts reservate_daytime + "の日時で予約しました"
  puts "投稿したい内容を入力してください"
  reservate_tweet = gets
  puts reservate_tweet + "という内容で予約しました"

  if DateTime.now == reservate_daytime then
    puts reservateTweet + "とツイートしました。"
    @client.update(reservateTweet)

end

option = ARGV[0].to_s

if option == "" then
  tutorial
elsif option == "-t" then
  homeTimeline
elsif option == "-m" then
  mentionTimeline
elsif option == "-l" then
  listTimeline
elsif option == "-r" then
  reservateTweet
else
  tweet
  homeTimeline
end
end

