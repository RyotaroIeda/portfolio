require 'refile/s3'

if Rails.env.production? # 本番環境の場合
  aws = {
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
    region: 'ap-northeast-1',
    bucket: 'ryotarosauna',
  }
end
