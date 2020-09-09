require_relative 'item'

class GildedRose

  MAXIMUM_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def backstage_passes?(item)
    item.include?('Backstage passes')
  end

  def sulfuras?(item)
    item.include?('Sulfuras')
  end

  def aged_brie?(item)
    item == 'Aged Brie'
  end

  def quality_below_maximum?(item)
    item.quality < MAXIMUM_QUALITY
  end


  def update_quality
    @items.each do |item|
      unless aged_brie?(item.name) or backstage_passes?(item.name)
        if item.quality.positive?
          unless sulfuras?(item.name)
            item.quality -= 1
          end
        end
      else
        if quality_below_maximum?(item)
          item.quality = item.quality + 1
          if backstage_passes?(item.name)
            if item.sell_in < 11
              if quality_below_maximum?(item)
                item.quality += 1
              end
            end
            if item.sell_in < 6
              if quality_below_maximum?(item)
                item.quality += 1
              end
            end
          end
        end
      end
      unless sulfuras?(item.name)
        item.sell_in -= 1
      end
      if item.sell_in.negative?
        unless aged_brie?(item.name)
          unless backstage_passes?(item.name)
            if item.quality.positive?
              unless sulfuras?(item.name)
                item.quality -= 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if quality_below_maximum?(item)
            item.quality = item.quality + 1
          end
        end
      end
    end
  end
end
