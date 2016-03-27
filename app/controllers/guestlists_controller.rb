require 'date'
class GuestlistsController <ApplicationController
  before_action :set_guestlist, only: [:show]
  before_action 'require_user', only: [:create]
  def index
    @guestlist = Guestlist.new
  end

  def new
    @guestlist = Guestlist.new
  end

  def show
    if @guestlist.user != current_user
      redirect_to(guestlists_path)
    end
  end

  def create
    @guestlist = Guestlist.new(guestlist_params)
    dateString = @guestlist.entry_date.to_s
    date = Date.parse(dateString)
    @guestlist.entry_date = date.strftime('%Y-%m-%d')
    @guestlist.user = current_user
      if @guestlist.save
        @guestlist.user.update_attribute(:mobile, @guestlist.mobile)
        redirect_to clubs_path
      #   EntryConfirmationMailer.send_email(@guestlist).deliver
      #   respond_to do |format|
      #       format.html { redirect_to guestlist_path(@guestlist), notice: 'Guestlist entry was successfully made.' }
      #       format.json { render :show, status: :created, location: @guestlist.user }
      #   end
      # else
      #   respond_to do |format|
      #       format.html { render :new }
      #       format.json { render json: @guestlist.user.errors, status: :unprocessable_entity }
      #   end
      #   render :new
      end
  end

def send_simple_message
  RestClient.post "https://api:key-20363f23cc857d99c36510c50fd5ed8a"\
  "@api.mailgun.net/v3/sandbox0b89e4bc8e69432797897d8a0b809b89.mailgun.org/messages",
                  :from => "Mailgun Sandbox <postmaster@sandbox0b89e4bc8e69432797897d8a0b809b89.mailgun.org>",
                  :to => "Raunak Joneja <jonejaraunak99@gmail.com>",
                  :subject => "Hello Raunak Joneja",
                  :text => "Congratulations Raunak Joneja, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
end

  private
  def guestlist_params
    params.require(:guestlist).permit(:club_id, :mobile, :couples, :entry_date)
  end
  def set_guestlist
    @guestlist = Guestlist.find(params[:id])
  end
end