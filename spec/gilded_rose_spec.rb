require 'gilded_rose'

describe GildedRose do

  describe '#update_quality' do

    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'decreases quality by 1' do
      items = [Item.new('beer', 1, 5)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 4
    end

    it 'does not make the quality negative' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'reduces quality twice as fast after sell by' do
      items = [Item.new('foo', 0, 4)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 2
    end

    it 'increases quality of aged Brie' do
      items = [Item.new('Aged Brie', 2, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 1
    end

    it 'does not increase quality above 50' do
      items = [Item.new('Aged Brie', 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it 'does not change quality of Sulfuras items' do
      items = [Item.new('Sulfuras, Hand of Ragnaros', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 10
    end

    it 'increases quality of backstage passes by 1 when over 10 days to go' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 12, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 11
    end

    it 'increases quality of backstage passes by 2 when 10 days or less to go' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 12
    end

    it 'increases quality of backstage passes by 3 when 5 days or less to go' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 5, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 13
    end
    it 'drops quality of backstage passes to 0 after concert' do
      items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end
end
