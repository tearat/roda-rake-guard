require 'active_model_serializers'

class BookListSerializer < ActiveModel::Serializer
  attributes :id, :title
end

class BookDetailSerializer < ActiveModel::Serializer
  attributes :id, :title, :shop

  def shop
    object.shop.as_json except: %i[created_at updated_at]
  end
end
