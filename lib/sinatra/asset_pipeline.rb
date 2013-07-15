require "sinatra/asset_pipeline/version"
require 'sprockets'
require 'sprockets-helpers'

module Sinatra
  module AssetPipeline
    def self.registered(app)
      # TODO: only set if unset
      app.set :sprockets, Sprockets::Environment.new(app.root)
      app.set :assets_prefix, "/assets"
      app.set :assets_digest, true

      app.set :static, true
      app.set :static_cache_control, [:public, :max_age => 525600]

      # TODO: make configurable
      %w(javascripts stylesheets images).each do |subdir|
        app.sprockets.append_path File.join(app.root, 'assets', subdir)
        app.sprockets.append_path File.join(app.root, 'vendor', 'assets', subdir)
        %w(vendor lib app).each do |base_dir|
          # load for all gems
          Gem.loaded_specs.map(&:last).each do |gemspec|
            path = File.join(gemspec.gem_dir, base_dir, "assets", subdir)
            app.sprockets.append_path path if File.directory? path
          end
        end
      end

      Sprockets::Helpers.configure do |config|
        config.environment = app.sprockets
        config.prefix      = app.assets_prefix
        config.digest      = app.assets_digest
        config.public_path = "/public"
      end

      app.helpers Sprockets::Helpers

      # TODO: this whole bit seems pretty ghetto.
      # What's the equivalent of .mount in sinatra?
      app.get app.assets_prefix+"/*" do
        env["PATH_INFO"].gsub!(app.assets_prefix, "")
        app.sprockets.call(env)
      end
    end
  end
end
