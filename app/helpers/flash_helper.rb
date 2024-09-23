module FlashHelper
  def flash_type_indicator(flash_type)
    case flash_type.to_sym
    when :error, :alert
      "flash__error"
    else
      "flash__success"
    end
  end
end
