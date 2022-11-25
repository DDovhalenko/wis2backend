Rails.application.config.middleware.insert_before 0, Rack::Cors do 
    allow do
        origins 'http://localhost:3000'
        resource '*',
        headers: ["Authorization"],
        expose: ["Authorization"],
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        max_age: 600,
        credentials: true
      end

    allow do
        origins "https://wis2front.herokuapp.com"
        resource "*", headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head],
        credentials: true
    end
end