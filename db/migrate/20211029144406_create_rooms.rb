class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :title
      t.text :room_description
      t.string :adress
      t.integer :price_unit
      t.integer :beds_available
      t.boolean :booking_available
      t.boolean :wifi_available
      t.text :welcome_message
      t.belongs_to :city, index: true
      t.references :host, index: true #Comme la table hosts n'existe pas, tu ne mets pas foreign_key: true, mais index: true > La table rooms a donc une colonne host_id

      t.timestamps
    end
  end
end
