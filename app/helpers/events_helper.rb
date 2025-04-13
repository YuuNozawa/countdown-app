module EventsHelper
  def year_options(years_ahead: 5)
    current = Date.current.year
    (current..current + years_ahead).map do |y|
      [ y.to_s, y ]
    end
  end

  def month_options
    Date::MONTHNAMES.compact.each_with_index.map do |name, index|
      [ name[0, 3], index + 1 ]
    end
  end
end
