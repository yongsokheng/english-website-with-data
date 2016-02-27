class Notification < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :link, presence: true

  before_save :push_notification_to_devise

  private
  def push_notification_to_devise
    gcm = GCM.new "AIzaSyAVMGTJYLiaIkeRYEfcHCawOKXXfFzAgwo"
    registration_ids = Device.pluck :registered_id
    options = {data: {content: content, url: link}}
    response = gcm.send registration_ids, options
    body = response[:body].split ","
    self.result = "#{body[1]}, #{body[2]}"
  end
end
