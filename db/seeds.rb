urls = %w[
  https://nitrokit.dev/
  https://rbui.dev/
  https://ui.darksea.dev/
  https://rapidrails.cc/
  https://github.com/lazaronixon/css-zero
  https://railsui.com/
  https://github.com/baoagency/polaris_view_components
  https://zestui.com/
  https://railsdesigner.com/
]
listings = []
urls.each do |url|
  listing = Listing.find_or_create_by(url:)
  listings << listing
end
category = Category.find_or_create_by(name: "Rails UI Component libraries")
category.listings << listings

urls = %w[
  https://superails.com/
  https://www.driftingruby.com/
  https://webcrunch.com/
  http://railscasts.com/
]
listings = []
urls.each do |url|
  listing = Listing.find_or_create_by(url:)
  listings << listing
end
category = Category.find_or_create_by(name: "Ruby on Rails Screencasts")
category.listings << listings
