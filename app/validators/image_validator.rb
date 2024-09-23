class ImageValidator < ActiveModel::EachValidator
  VALID_TYPES = ["image/jpeg", "image/jpg", "image/png"]
  VALID_TYPES_ERROR = ["JPEG", "JPG", "PNG"]
  MAX_SIZE = 1

  def validate_each(record, attribute, value)
    return unless value.attached?

    unless value.blob.byte_size <= MAX_SIZE.megabyte
      record.errors.add(attribute, "excede el límite de #{MAX_SIZE} MB")
    end

    unless value.content_type.in? VALID_TYPES
      record.errors.add(attribute, "debe ser del tipo #{VALID_TYPES_ERROR.to_sentence}")
    end
  end
end