class SgStrangeCalendar
  # 月の名前を定数の配列として定義
  MONTH = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
  WEEKDAYS = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"]
  # 最長月（31日）に必要な曜日の表示回数を定数として定義
  NEEDED_REPETITIONS = ((31 + 6) / 7.0).ceil

  def initialize(year)
    @year = year
  end

  def generate
    result = []

    first_line = format('%4d', @year)
    weekdays_header = (' ' + WEEKDAYS.map { |day| format('%2s', day) }.join(' '))
    result << first_line + weekdays_header * NEEDED_REPETITIONS

    (1..12).each do |month|
      days = days_in_month(month)
      month_name = format('%-5s', MONTH[month - 1]) # -5sで左寄せの5文字で表示

      # 月の1日の日付オブジェクトを取得し、wdayメソッドで曜日を取得（0:日曜日, 1:月曜日, ...）
      first_day_wday = Time.new(@year, month, 1).wday
      space = '   ' * first_day_wday # 1日までの空白を追加

      day_line = (1..days).map { |day| format('%2d', day) }.join(' ') # format('%2d', day)で右寄せの2桁で表示
      result << month_name + space + day_line
    end
    result.join("\n")
  end

  private

  def days_in_month(month)
    case month
    when 4, 6, 9, 11
      30
    when 2
      leap_year? ? 29 : 28
    else
      31
    end
  end

  def leap_year?
    if @year % 400 == 0
      true
    elsif @year % 100 == 0
      false
    else
      @year % 4 == 0
    end
  end
end

calendar = SgStrangeCalendar.new(2024)
puts calendar.generate
