class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.timestamp :date_time_pay
      t.date :date_valut
      t.string :num_ticket
      t.string :code_ticket
      t.string :key_operation
      t.text :destination
      t.decimal :sum_operation, default: 0.0, precision: 12, scale: 2
      t.string :currency_operation
      t.string :priv_acc_payer
      t.date :period_pay_start
      t.date :period_pay_end

      t.timestamps null: false
    end
  end
end
