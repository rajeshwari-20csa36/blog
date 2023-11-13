module ApplicationHelper
  include Pagy::Frontend
  def date_from_parameters
    if params[:search].present?
      params[:search][:date]
    else
      Date.yesterday.strftime("%m-%d-%Y").concat(" - ").concat(Date.today.strftime("%m-%d-%Y"))
    end
  end
end
