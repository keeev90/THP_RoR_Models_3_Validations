class RemoveCityFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :city_id
  end
end
