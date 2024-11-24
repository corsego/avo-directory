require "test_helper"

class ListingTest < ActiveSupport::TestCase
  test "ransack payload" do
    listing = Listing.create(url: "https://example.com", payload: { page_title: "My app" })

    assert_includes Listing.ransack(url_cont: "exam").result, listing
    assert_includes Listing.ransack(payload_cont: "My app").result, listing
  end
end
