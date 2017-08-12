class ChangePriceDataType < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :price, :integer
  end
end
