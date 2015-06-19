require 'rubygems'
require 'httparty'

class bingapi
	include HTTParty
	base_uri 'bing.com'
	default_params :output => 'json'
	format :json

	def initialize(user, passwd)
		self.class.basic_auth user, passwd
	end

	def self.get_description(descript)
		get('/', :query => {:descript => descript})
	end
		
	def self.get_image(image)
		get('/', :query => {:image => image})
	end

end
