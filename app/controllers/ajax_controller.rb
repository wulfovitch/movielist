class AjaxController < ApplicationController
  def collections
    if params[:term]
      like = "%".concat(params[:term].downcase.concat("%"))
      collections = Collection.where("lower(collection_title) like ?", like)
    else
      collections = Collection.all
    end
    list = collections.map {|c| Hash[ id: c.id, label: c.collection_title, name: c.collection_title]}
    render json: list
  end
end