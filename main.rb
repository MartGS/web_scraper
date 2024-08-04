require_relative 'app/web_scraper'
require_relative 'app/use_case_extractor'

urls = %w[
  https://www.alibaba.com/product-detail/2024-Made-in-China-kitchen-sink_1601204934672.html?spm=a2700.details.you_may_like.8.7fb418b3Aj9Cza
  https://www.alibaba.com/product-detail/304-Stainless-Steel-Single-Bowl-Kitchen_1601197680644.html?spm=a2700.details.you_may_like.1.36a84808kfZg9E
  https://www.alibaba.com/product-detail/2024-Hot-kitchen-faucet-scratch-resistant_1601198788452.html?spm=a2700.details.you_may_like.11.781f1212mulOa7
  https://www.alibaba.com/product-detail/wholesale-popular-29-inch-21-speed_1600107379759.html?spm=a2700.galleryofferlist.topad_classic.d_image.7f4e40c9G9QXcu
]

web_scraper = WebScraper.new(urls)

html_contents = web_scraper.fetch_contents

html_contents.each do |html_content|

  use_case_extractor = UseCaseExtractor.new(html_content)
  use_case_extractor.extract_use_cases
end

use_cases = Product.all

use_cases.each do |use_case|
  puts "Name: #{use_case.name}, Price: #{use_case.price}"
end
