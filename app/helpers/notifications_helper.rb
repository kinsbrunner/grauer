module NotificationsHelper
  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end

  class Calendar < Struct.new(:view, :date, :callback)
    HEADER = %w[Lunes Martes Miercoles Jueves Viernes]
    START_DAY = :sunday

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "calendar" do
        header + week_rows
      end
    end

    def header
      content_tag :tr do
        HEADER.map { |day| content_tag :th, day.upcase }.join.html_safe
      end
    end

    def week_rows
      weeks.map do |week|
        day_num = week[-1].mday
        next if day_num == 1 #elimino el primer renglón si el Sábado empieza el mes
        adjusted_week = week.map { |day| day_cell(day) }
        adjusted_week.shift #saco el 1er valor, el del Domingo
        adjusted_week.pop   #saco el último valor, el del Sábado
        content_tag :tr do
          adjusted_week.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "notmonth" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end

    def weeks
      first = date.beginning_of_month.beginning_of_week(START_DAY)
      last = date.end_of_month.end_of_week(START_DAY)
      if last.day >= 6
        #Si el último día es > = 6, restar una semana ya que sino va a mostrar la primera semana del mes siguiente
        last = last - 7
      end
      (first..last).to_a.in_groups_of(7)
    end
  end
end
