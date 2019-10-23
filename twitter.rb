#!/usr/bin/ruby
# encoding: utf-8

# twitterライブラリの呼び出し
require 'twitter'

#証明書
ENV['SSL_CERT_FILE'] = File.expand_path('./cacert.pem')

# アクセストークンなどを設定
@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "axHD0WAzFf3MCXlaAsAgLTXWZ"
  config.consumer_secret     = "iiCnGplFv8v5DzTm7pfdXr5bv3rPdOPMkWdDvISrNKskz0vOfF"
  config.access_token        = "1184344564137463808-clmqpL7NbsHgxbcso23s4ZVhEhAKcP"
  config.access_token_secret = "PQgvfVtR1ILW8m7OF6TqhJ4auGSFWWNhPC2JEJkkzruOd"
end

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

option = ARGV[0].to_s

if option == "" then
  tutorial
elsif option == "-t" then
  homeTimeline
elsif option == "-m" then
  mentionTimeline
elsif option == "-l" then
  listTimeline
else
  tweet
  homeTimeline
end


