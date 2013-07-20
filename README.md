# Sinatra::AssetPipeline

Simple Rails-style asset pipeline for Sinatra. Towards a world where even the smallest throwaway hack can be regally clothed in Twitter Bootstrap.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-asset_pipeline'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-asset_pipeline

## Usage

Just add the following to your Sinatra app and you're done:

```ruby
require "sinatra/asset_pipeline"

register Sinatra::AssetPipeline
```

There are some configuration options too.

You might want some other stuff in your Gemfile too. Here's what's in mine:

```ruby
gem 'sinatra-asset_pipeline'
gem 'sass'
gem 'sprockets-sass'
gem 'coffee-script'
gem 'compass'
gem 'bootstrap-sass', require: false # for bootstrap
```
It includes [sprockets-helpers](https://github.com/petebrowne/sprockets-helpers), so reference your assets like this: `stylesheet_path 'application'`

It will look for assets in both your app directory and in any installed gems. By default it will search the following paths:

- In your app:
  - `assets/*`
  - `app/assets/*`
  - `lib/assets/*`
  - `vendor/assets/*`

By default it will server them from:

`/assets/filename.ext` (same as rails)

These defaults mean it's compatible with most of the rails gems that bundle assets.

All the stuff gets served through Sinatra, so definitely Put A CDN On It in prod. Or it will be slow.

## TODO

- Manifests and precompilation and stuff for production.
- See if it can be mounted in a way that's let less ghetto.
- Other fancy sprockets options.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
