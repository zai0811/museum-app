module HomeHelper
  def free_entrance_label(free_entrance, entrance_price)
    price = entrance_price.blank? ? "" : entrance_price
    free_entrance ? t("museums.show.free") : t("museums.show.payed", price: price)
  end
end
