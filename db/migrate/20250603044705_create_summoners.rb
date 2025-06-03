class CreateSummoners < ActiveRecord::Migration[7.2]
  def change
    create_table :summoners do |t|
      t.string :name
      t.string :tagline
      t.string :region
      t.string :puuid

      t.timestamps
    end
  end
end
