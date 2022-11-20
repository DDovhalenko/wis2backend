if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, key: "_wis2back", domain:"wis2backend.vercel.app"
else 
    Rails.application.config.session_store :cookie_store, key: "_wis2_app"
end