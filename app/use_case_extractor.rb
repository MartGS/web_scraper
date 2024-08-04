require "nokogiri"
require_relative '../models/product'

class UseCaseExtractor
  def initialize(html_content)
    @doc = Nokogiri::HTML(html_content)
  end

  def extract_use_cases
    use_case_cards.each do |use_case_card|
      product = extract_product_data(use_case_card)
      save_product(product)
    end
  end

  private

  def use_case_cards
    @doc.css(".layout-body")
  end

  def extract_product_data(use_case_card)
    name = extract_name(use_case_card)
    price = extract_price(use_case_card)
    Product.new(name:, price:)
  end

  def extract_name(use_case_card)
    use_case_card.at_css(".module_title h1").text.strip
  end

  def extract_price(use_case_card)
    use_case_card.at_css(".price span").text.strip.gsub(/\$/, "").strip.to_f
  end

  def save_product(product)
    product.save
  end
end
