require "sinatra/asset_pipeline/version"
require 'sprockets'
require 'sprockets-helpers'

module Sinatra
  module AssetPipeline
    def self.registered(app)
      app.set_default :sprockets, Sprockets::Environment.new(app.root)
      app.set_default :assets_prefix, "/assets"
      app.set_default :assets_digest, true

      app.set_default :static, true
      app.set_default :static_cache_control, [:public, :max_age => 525600]

      app.set_default :assets_dirs, [ 'assets',
                                      ['app',     'assets'],
                                      ['lib',     'assets'],
                                      ['vendor',  'assets'] ]

      app.assets_dirs.each do |asset_dir|
        asset_dir = [asset_dir] unless asset_dir.is_a?(Array)
        Dir[File.join(*(asset_dir + ["*"]))].each do |path|
          app.sprockets.append_path path  if File.directory? path
        end

        Gem.loaded_specs.map(&:last).each do |gemspec|
          Dir[File.join(*[[gemspec.gem_dir] + asset_dir + ["*"]])].each do |path|
            app.sprockets.append_path path  if File.directory? path
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
      app.get app.assets_prefix + "/*" do
        env["PATH_INFO"].gsub!(app.assets_prefix, "")
        app.sprockets.call(env)
      end
    end

    def set_default(key, default)
      self.set(key, default) unless self.settings.respond_to? key
    end
  end
end
