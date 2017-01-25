class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.date :date
      t.decimal :pr_1_mpa, :precision => 10, :scale => 1
      t.decimal :pr_1_p, :precision => 10, :scale => 1
      t.decimal :pr_28_mpa, :precision => 10, :scale => 1
      t.decimal :pr_28_p, :precision => 10, :scale => 1
      t.decimal :pr_pr_mpa, :precision => 10, :scale => 1
      t.decimal :pr_pr_p, :precision => 10, :scale => 1
      t.string :mark	
      t.string :username
      t.text :body
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
