class Api::VariantsController < ApplicationController
  def index
    ids = params[:ids]
    @variants = if ids
                  Variant.where(id: ids)
                else
                  Variant.all
                end
  end
end
