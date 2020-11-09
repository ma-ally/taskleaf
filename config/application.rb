require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Taskleaf
  class Application < Rails::Application

    config.i18n.default_locale            = :ja          # ロケールを日本に設定
    config.time_zone                      = "Asia/Tokyo" # 日本中央標準時で、時刻を表示
    config.active_record.default_timezone = :local       # DBにローカル時刻で保存する

    # config.active_storage.variant_processor = :vips      # 画像変換にlibvipsを使う
          # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
