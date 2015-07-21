class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # {sender: user.email, subject: topic.title, 'body-plain': 'http://example.org'}

    puts "INCOMING PARAMS HERE: #{params}"
      user = User.find_by(email: params[:sender])
      title = params[:subject]
      topic = Topic.find_by(title: title)

      User.create(email: params[:sender]) unless user

      topic.bookmarks.create(
        url: params['body-plain']) 

      head 200
  end
end
