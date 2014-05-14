class CreateDocuments < ActiveRecord::Migration
	def change
		create_table :documents do |t|
			t.string :name, null: false
			t.integer :pages, null: false

			t.timestamps
		end

		add_index :documents, :name, unique: true
	end
end
