class CreateWorktimes < ActiveRecord::Migration
  def change
    create_table :worktimes do |t|
      t.integer :employee_id
      t.datetime :checkin
      t.datetime :checkout
      t.string :place_checkin
      t.string :place_checkout

      t.timestamps
    end
  end
end
