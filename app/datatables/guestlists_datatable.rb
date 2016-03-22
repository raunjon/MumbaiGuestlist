include Rails.application.routes.url_helpers

class GuestlistsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Guestlist.count,
        iTotalDisplayRecords: guestlists.total_entries,
        aaData: data
    }
  end

  private

  def data
    guestlists.map do |guestlist|
      if guestlist.user.uid.blank?
        url = "https://facebook.com/"
      else
        url = "https://facebook.com/"+guestlist.user.uid
      end
      [

          link_to(guestlist.user.username,url,:target => '_blank'),
          guestlist.entry_date.strftime("%B %e, %Y"),
          guestlist.club.title,
          guestlist.couples,
          guestlist.mobile,
          get_status(guestlist.status),
          link_to("Accept", admin_guestlist_path(guestlist, :status => Status::ACCEPTED, :autoaccept => true), :method => :put) + " " + link_to("Decline", admin_guestlist_path(guestlist, :status => Status::DECLINED), :method => :put) + " " + link_to("Delete",admin_guestlist_path(guestlist),method: :delete, data: {confirm: 'Are you sure?'})
      ]
    end
  end

  def guestlists
    @guestlists ||= fetch_guestlists
  end

  def fetch_guestlists
    guestlists = Guestlist.order("#{sort_column} #{sort_direction}")
    guestlists = guestlists.page(page).per_page(per_page)
    guestlists = guestlists.joins(:user, :club)
    if params[:sSearch].present?
      #guestlists = guestlists.joins(:user, :club)
      guestlists = guestlists.where("username like :search or  title like :search or entry_date like :search or mobile like :search or email like :search", search: "%#{params[:sSearch]}%")
    end
    guestlists
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[user_id entry_date title couples mobile status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def get_status(status)
    if status==Status::PENDING
      "Pending"
    elsif status==Status::ACCEPTED
      "Accepted"
    elsif status==Status::DECLINED
      "Declined"
    end
  end
end