class Avo::Resources::Listing < Avo::BaseResource
  self.title = :url
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :url, as: :text
    field :categories, as: :has_many
  end
end
