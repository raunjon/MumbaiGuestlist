 require 'rubygems'
 require 'plivo'

AUTH_ID = "MAZJLMYZY4NZGWNDG2ND"
AUTH_TOKEN = "NDZjN2JjNDI4Y2VlYTg5MGM2ZDJkMmZmZGM2NGM4"


class Sms < ActiveRecord::Base


include Plivo

# Send SMS


  def self.send_sms(guestlist)
    #     'src' => 'ALPHA-ID', # Sender's Alphanumeric sender ID
    #     'dst' => '+919930549237', # Receiver's phone Number with country code
    #     'text' => 'Hi, from Sms' # Your SMS Text Message - English
    # }
    # api.send_message(params)
    api = RestAPI.new(AUTH_ID, AUTH_TOKEN)
    entry_date_string = guestlist.entry_date.strftime('%d-%B-%Y')
    if guestlist.status == 1
      message = 'You\'re entry for ' + guestlist.club.title + ' has been accepted for ' + entry_date_string + ' Please read the club policy carefully. Thank you for using MumbaiGuestlist'
    elsif guestlist.status == 2
      message = 'You\'re entry for ' + guestlist.club.title + ' has been declined for ' + entry_date_string + ' Please try another club or date. Thank you for using MumbaiGuestlist'
    else
      message = 'We have received your entry for ' + guestlist.club.title + ' for ' + entry_date_string  + ' We shall forward your details yo club and confirm it shortly.'
    end

    @message = message
# Send SMS
    params = {
        'src' => 'ALPHA-ID', # Sender's Alphanumeric sender ID
        'dst' => '+91'+guestlist.mobile, # Receiver's phone Number with country code
        'text' => message # Your SMS Text Message - English
    }
    api.send_message(params)
  end

 def self.send_push(push_id)
   Parse.init application_id: 'SZY7gEQ31pScXKwfJmI0ODEm1QkLaPilaCKwDgBY',
              api_key: 'FA411Fy7XOePvpJxMIx6kkT5yYyehAKKkKgyeso6',
              quiet: false
   data = { alert: @message, sound: 'chime' }
   push = Parse::Push.new(data, push_id)
   push.type = 'ios'
   push.save
 end

end