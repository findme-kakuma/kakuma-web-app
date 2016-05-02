class Admin::ResidentsController < Admin::ApplicationController
  def index
    @residents = Resident.all.page params[:page]
  end

  def destroy
    resident = Resident.find params[:id]
    resident.destroy
    redirect_to admin_residents_path
  end
end
