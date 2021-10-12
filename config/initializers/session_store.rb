if Rails.env == 'production'
  Rails.application.config.session_store :cookie_store, key: '_api', domain: '_coyote_api'
else
  Rails.application.config.session_store :cookie_store, key: '_api'
end
