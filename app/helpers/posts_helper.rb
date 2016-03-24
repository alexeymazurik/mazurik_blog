module PostsHelper
  def str_date(date)
    date.strftime('%e %b %Y') if date
  end
end
