desc "Schedule post article"
task post_article: :environment do
  Article.on_schedule.each do |article|
    article.update_attributes post_status: Settings.post_status.published,
      published_at: article.schedule_at, schedule_at: nil
  end
end
