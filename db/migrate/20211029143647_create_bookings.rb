class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.belongs_to :room, index: true
      t.references :guest, index: true #Comme la table hosts n'existe pas, tu ne mets pas foreign_key: true, mais index: true > La table bookings a donc une colonne guest_id

      t.timestamps
    end
  end
end
