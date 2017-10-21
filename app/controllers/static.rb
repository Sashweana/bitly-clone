get '/' do
  erb :"static/index"
end

post '/urls' do
	@user_url = Url.new(long_url: params["long_url"])

	if @user_url.save #it will go to app/models/url.rb runs the validation or any call back methods, if everything pass, then only its saved succcessfully
		@user_url.shorten
		@message = "URL shortened successfully"
	else
		@message = @user_url.errors.full_messages.join("\n")
		p @message
	end
	erb :"static/index"
end

##redirect to appropriate "long" url
get '/:short_url' do
	a = Url.find_by(short_url: params[:short_url])
	if a 
		redirect a.long_url
	else
		redirect '/'
	end
end