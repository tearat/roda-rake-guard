require 'active_model_serializers'

class ShopDetailSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :books

  def books
    object.books.as_json except: %i[created_at updated_at]
  end
end

class ShopListSerializer < ActiveModel::Serializer
  attributes :id, :title, :books?

  def books?
    object.books.any?
  end
end
