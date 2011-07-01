MongoMapper.database = Rails.env == "development" ? "base_development" : "base_test"
MongoMapper.database = "base_production" if Rails.env == "production"