class AddProductPriceToLineItem < ActiveRecord::Migration
  def self.up
    add_column :line_items, :price, :decimal, precision: 9, scale: 2

    say_with_time "Updating prices..." do
    	LineItem.all.each do |lineItem|
    		lineItem.update_attribute :price, lineitem.product.price
    	end
    end
  end

  def self.down
  	remove_column :line_items, :price
  end
end
