class Avo::Resources::Category < Avo::BaseResource
  self.title = :name

  self.find_record_method = -> {
    if id.is_a?(Array)
      query.where(slug: id)
    else
      # We have to add .friendly to the query
      query.friendly.find id
    end
  }

  # self.includes = []
  # self.attachments = []
  self.search = {
    query: -> { query.ransack(name_cont: params[:q], description_cont: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    # field :id, as: :id
    field :name, as: :text
    field :description, as: :textarea
    field :listings, as: :has_many, through: :category_listings,
      attach_scope: lambda {
        query.where.not(id: parent.category_listings.select(:listing_id))
      }
  end
end
