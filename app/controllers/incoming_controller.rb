class IncomingController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # {sender: user.email, subject: topic.title, 'body-plain': 'http://example.org'}

    title = params[:subject]
    topic = Topic.find_by(title: title)
    topic.bookmarks.create(
      url: params['body-plain']) 

    head 200
  end
end
