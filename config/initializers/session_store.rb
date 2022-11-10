if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_wis2_app", domain:"wis2-app-api.herokuapp.com"
else 
    Rails.application.config.session_store :cookie_store, key: "_wis2_app"
end