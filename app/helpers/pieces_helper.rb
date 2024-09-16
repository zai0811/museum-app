module PiecesHelper
  def in_display_label(in_display)
    in_display ? t("pieces.show.displayed") : t("pieces.show.not_displayed")
  end

  def in_display_tooltip(in_display)
    in_display ? t("pieces.show.displayed_tooltip") : t("pieces.show.not_displayed_tooltip")
  end

  def in_display_class(in_display)
    in_display ? "icon_piece_displayed" : "icon_piece_not_displayed"
  end
end
