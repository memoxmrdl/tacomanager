class AddScheduleAndPhoneToEstablishments < ActiveRecord::Migration
  def change
    add_column :establishments, :schedule, :string
    add_column :establishments, :phone, :string
  end
end
