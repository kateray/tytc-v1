Tytc::Application.middleware.use( Oink::Middleware, :logger => Hodel3000CompliantLogger.new(STDOUT))
