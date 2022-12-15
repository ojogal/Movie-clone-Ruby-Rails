
ImageMagick (image processor) set up:

```
sudo apt update
```

```
sudo apt install imagemagick
```

Rails set up:

```
bundle install
```

```
rails db:create
```

```
rails db:migrate
```

```
rails s -p 4001
```

If you have error "The asset "application.css" is not present in the asset pipeline." do the following

Add the following to config/environment/production.rb:

```
config.serve_static_files = true
```
Paste in terminal this:
```
rails assets:precompile
```
If you have error "undefined method `user_url' for #<Devise::RegistrationsController:0x00000000024ef0>" do the following:

Add this to config/initializers/devise.rb:
```
config.navigational_formats = ['*/*', :html, :turbo_stream]
<<<<<<< HEAD
```
=======
```
>>>>>>> 364c6ea (Search field added)
