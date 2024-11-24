class RecordUrlScreenshotJob < ApplicationJob
  queue_as :default

  def perform(record)
    url = record.url
    browser = Ferrum::Browser.new(headless: true,
      process_timeout: 30,
      timeout: 200,
      pending_connection_errors: true)
    browser.resize(width: 1200, height: 630)
    browser.goto(url)
    sleep(0.3)

    tmp = Tempfile.new
    browser.screenshot(path: tmp.path, quality: 40, format: "jpg")

    record.cover_image.attach(io: File.open(tmp.path), filename: "#{record.id}-screenshot.jpg")
    # Do something later
  ensure
    browser.quit
  end
end
