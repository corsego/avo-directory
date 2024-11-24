class Avo::Resources::Listing < Avo::BaseResource
  self.title = :url
  # self.includes = []
  # self.attachments = []
  self.search = {
    query: -> { query.ransack(url_cont: params[:q], m: "or").result(distinct: false) }
  }

  def fields
    field :id, as: :id
    field :logo, as: :external_image do
      record.payload&.dig("favicon_url")
    rescue
      nil
    end
    field :meta_title, as: :text do
      record.payload&.dig("page_title")
    end
    field :meta_description, as: :text do
      record.payload&.dig("meta_description")
    end
    field :url, as: :text
    # field :payload, as: :text, hide_on: [:index]
    field :categories, as: :has_many, through: :category_listings,
      attach_scope: lambda {
        query.where.not(id: parent.category_listings.select(:category_id))
      }
  end

  def actions
    action Avo::Actions::UrlCrawler
  end

  self.profile_photo = {
    source: -> {
      if view.index?
        # We're on the index page and don't have a record to reference
        "/icon.png"
      else
        # We have a record so we can reference it's profile_photo
        record.payload&.dig("favicon_url") || "/icon.png"
      end
    }
  }

  self.cover_photo = {
    size: :lg, # :sm, :md, :lg
    visible_on: [:show, :forms], # can be :show, :index, :edit, or a combination [:show, :index]
    source: -> {
      if view.index?
        # We're on the index page and don't have a record to reference
        "/icon.png"
      else
        # We have a record so we can reference it's cover_photo
        record.payload&.dig("og_image_url") || "/icon.png"
      end
    }
  }

  self.default_view_type = :grid
  self.grid_view = {
    card: -> do
      {
        cover_url: record.payload&.dig("og_image_url"),
        title: record.payload&.dig("page_title"),
        body: record.payload&.dig("meta_description"),
      }
    end
  }
end
