class Avo::Resources::Listing < Avo::BaseResource
  self.title = :url
  # self.includes = []
  # self.attachments = []
  self.search = {
    query: -> { query.ransack(url_cont: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    field :id, as: :id
    field :url, as: :text
    field :payload, as: :text
    field :categories, as: :has_many, through: :category_listings,
      attach_scope: lambda {
        query.where.not(id: parent.category_listings.select(:category_id))
      }
  end

  def actions
    action Avo::Actions::UrlCrawler
  end
end
