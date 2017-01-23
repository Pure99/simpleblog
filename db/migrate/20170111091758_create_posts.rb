class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.date :date
      t.decimal :pr_1_mpa
      t.decimal :pr_1_p
      t.decimal :pr_28_mpa
      t.decimal :pr_28_p
      t.decimal :pr_pr_mpa
      t.decimal :pr_pr_p
      t.string :mark
      t.string :title
      t.text :body

      t.timestamps
    end

  end
end
