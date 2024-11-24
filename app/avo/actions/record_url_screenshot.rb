class Avo::Actions::RecordUrlScreenshot < Avo::BaseAction
  self.name = "Record Url Screenshot"
  # self.visible = -> do
  #   true
  # end

  # def fields
  #   # Add Action fields here
  # end

  def handle(query:, fields:, current_user:, resource:, **args)
    query.each do |record|
      RecordUrlScreenshotJob.perform_later(record)
      # Do something with your records.
    end
  end
end
