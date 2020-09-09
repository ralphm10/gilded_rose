require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
    it "does not make the quality negative" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
    it "reduces quality twice as fast after sell by" do
      items = [Item.new("foo", 0, 4)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end
    it "increases quality of aged Brie" do
      items = [Item.new("Aged Brie", 2, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 1
    end
    it "does not increase quality above 50" do
      items = [Item.new("Aged Brie", 0, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end
    it "does not change quality of Sulfuras items" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 10
    end
  end
end
