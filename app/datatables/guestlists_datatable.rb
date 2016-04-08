include Rails.application.routes.url_helpers

class GuestlistsDatatable
  delegate :params, :link_to, :number_to_currency, to: :@view

  def initialize(view,glists)
    @view = view
    @glists = glists
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: @glists.count,
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
          link_to(
          guestlist.user.name,url,:target => '_blank', :only_path=>true),
          guestlist.entry_date.strftime('%d-%B-%Y'),
          guestlist.club.title,
          guestlist.couples,
          guestlist.mobile,
          get_status(guestlist.status),
          get_source(guestlist.source),
          link_to("Accept", admin_guestlist_path(guestlist, :status => Status::ACCEPTED, :autoaccept => true), :method => :put) + " " + link_to("Decline", admin_guestlist_path(guestlist, :status => Status::DECLINED), :method => :put) + " " + link_to("Delete",admin_guestlist_path(guestlist),method: :delete, data: {confirm: 'Are you sure?'})
      ]
    end
  end

  def guestlists
    @guestlists ||= fetch_guestlists
  end

  def fetch_guestlists
    guestlists = @glists.order("#{sort_column} #{sort_direction}")
    guestlists = guestlists.page(page).per_page(per_page)
    guestlists = guestlists.joins(:user, :club)
    if params[:sSearch].present?
      #guestlists = guestlists.joins(:user, :club)
      guestlists = guestlists.where("LOWER(name) like LOWER(:search) or LOWER(title) like LOWER(:search) or LOWER(email) like LOWER(:search) or guestlists.mobile like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[user_id entry_date title couples mobile status source]
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

  def get_source(source)
    if source==0
      "Web"
    elsif source==1
      "Android"
    elsif source==2
      "iOS"
    else
      "Undefined
"
    end
  end
end