env :PATH, ENV['PATH']
set :environment, "production"

every 1.minute do
  rake "post_article"
end
