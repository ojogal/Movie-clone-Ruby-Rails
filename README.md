
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

Add the following to config/environment/production.rb:

```
config.serve_static_files = true
```

Paste in terminal this:
```
rails assets:precompile
```
