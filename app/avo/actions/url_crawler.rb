class Avo::Actions::UrlCrawler < Avo::BaseAction
  self.name = "Update metadata from URL"
  # self.visible = -> do
  #   true
  # end

  # def fields
  #   # Add Action fields here
  # end

  def handle(query:, fields:, current_user:, resource:, **args)
    query.each do |record|
      UrlCrawlerJob.perform_later(record)
    end
  end
end
