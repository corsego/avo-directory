# This controller has been generated to enable Rails' resource routes.
# More information on https://docs.avohq.io/3.0/controllers.html
class Avo::ListingsController < Avo::ResourcesController
  def show
    super
    set_meta_tags description: @record.payload&.dig("meta_description"),
                  og: {
                    title: @record.payload&.dig("page_title"),
                    image: @record.cover_image_for_display
      }
  end
end
