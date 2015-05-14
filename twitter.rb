#!/usr/bin/env ruby

require 'twitter'
client = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY'] 
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
  config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
end



class TommyTwitter

	def initialize(client)
		@client = client
		@user = @client.user
		@recentTweets = []
		@tweetsAboutTom = []
		findTweets("mentions_timeline", @tweetsAboutTom)
		findTweets("user_timeline", @recentTweets)
		
	end

	def putUserId
		puts @user.id
	end

	def findTweets(endpoint, array)
		results = @client.send(endpoint).each {|tweet| array << tweet }
	end
	def showRecentTweets
		displayTweets(@recentTweets)
	end

	def showTweetsAboutTom
		displayTweets(@tweetsAboutTom)
	end

	def displayTweets(tweetArray)
		tweetArray.each do |tweet|
			puts tweet.text
		end
	end

end


if __FILE__ == $0
	tt = TommyTwitter.new(client)
	tt.putUserId
	
	puts "Tom's Tweets".center(100, "*")
	tt.showRecentTweets
	puts "Tweets about Tom".center(100, "*")
	tt.showTweetsAboutTom

end


