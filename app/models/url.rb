class Url < ActiveRecord::Base

	# This is Sinatra! Remember to create a migration!
	validates :long_url, presence: true
	validates :long_url, uniqueness: {case_sensitive: false, message: "was shortened before"}
	validates :long_url, format: {with: (URI::regexp(['http', 'https'])), message: "URL format is inaccurate"}

	def shorten
		url_char = ("a".."z").to_a + ("A".."Z").to_a + (0..9).to_a
		self.short_url = url_char.sample(7).join("")
		self.save
	end

end
