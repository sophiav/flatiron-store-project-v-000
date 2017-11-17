class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :line_items
  has_many :items, through: :line_items

  def total
    self.line_items.reduce(0) do |total, line_item|  
      total + (line_item.item.price * line_item.quantity)
    end
    #using BOTH map & reduce/sum
    # self.items.map(&:price).reduce(:+)
  end

  def add_item(item_id)
    line_item = self.line_items.find_by(item_id: item_id)


    if line_item
      line_item.quantity += 1
      line_item.save
    else
      line_item = self.line_items.build(item_id: item_id)
    end
    line_item
  end

end
