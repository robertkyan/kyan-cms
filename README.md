# Kyan - How We CMS

This repository contains what is considered to be the standard requirements for a basic CMS.  The idea is to make sure we have consistent set of functionality that is added to every CMS as base to build on for further development.


## Initial Setup - Including Docker

Ensure you have Docker running and Postgres isn't running

Github
- https://github.com/organizations/kyan/repositories/new
- Add repository name
- Ensure Private is selected
- Initialize with a README

```
git clone git@github.com:kyan/xxxxxxxx.git
```

```
rails new xxxxxxxx
```

Clean up Gemfile of comments, update gems to the latest relevant versions:
* gem 'rails'
* gem 'pg'
* gem 'puma'
* gem 'sass-rails'
* gem 'uglifier'
* gem 'coffee-rails'
* gem 'jquery-rails'
* gem 'jbuilder'
* gem 'inherited_resources', github: 'activeadmin/inherited_resources'
* gem 'activeadmin', github: 'activeadmin'
* gem 'devise'
* gem 'carrierwave'
* gem 'mini_magick'
* gem 'redactor-rails', github: 'kyan/redactor-rails'
* gem 'fog'
* gem 'seedbank'
* gem 'faker'
* gem 'file_validators'


The inherited_resources gem is used to get activeadmin to play nicely with Rails 5

Set up the database.yml

```ruby
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  user: postgres
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: xxxxxxxx_development

test:
  <<: *default
  database: xxxxxxxx_test

production:
  <<: *default
  database: xxxxxxxx_production
  username: xxxxxxxx
  password: <%= ENV['xxxxxxxx_DATABASE_PASSWORD'] %>

```

Next we need to set up Devise with a default AdminUser

```
rails g active_admin:install
```

Running active_admin:install with no additional arguments will create this default for us with a seeded default user of:

* User: admin@example.com
* Password: password


```
docker-compose up
docker-compose exec web bin/setup
```



## Default CMS objects

Listed here are what the default expected functionality of a CMS should contain, this list is not exhaustive but it should be the bare minimum that a new CMS should contain.

### Pages

Used by default for all pages on the site, at a minimum will provide meta information. A label is also always to be included to name the page which will appear in the admin, but cannot be changed and must not appear on the front end.

As standard, will also be where the title and introduction text for pages is updated.

Also contains a body (WYSIWYG) which can be toggled on for pages which only need this for their content, such as the About Us, Cookie and Pricacy Policy or Terms and Conditions pages, where no other models will be called.

Depending on the project, the page model can also include a hero/banner image, a published flag and a publish date.

The default full Page model contains (bold are considered required):
* `label:string`
* `title:string`
* introduction:text
* published:boolean
* publish_on:date
* banner_image:string
* has_body:boolean
* body:text
* `page_title:string`
* `meta_description:text`

Default generation for Pages:
```
./bin/rails g model Page label:string title:string introduction:text published:boolean publish_on:date banner_image:string body:text page_title:string meta_description:text
```
and then add to Active Admin with:
```
./bin/rails g active_admin:resource Page
```



## Active Admin

Now we have active admin set up, an admin user and a page model, we need to format active admin


```ruby
ActiveAdmin.register Page do
  menu priority: 1

  actions :index, :show, :edit, :update
  batch_action :destroy, false
  permit_params :title, :body, :body, :page_title, :meta_description,
  :introduction, :banner_image,
  :banner_image_cache, :remove_banner_image

  controller do
    def find_resource
      scoped_collection.find(params[:id])
    end
  end

  config.filters = false

  index do
    column :label
    actions
  end

  form(html: { multipart: true }) do |f|
    inputs t('active_admin.common.details') do
      input :title
      input :introduction
      input :banner_image, as: :file, hint: image_tag_or(f.object.banner_image.admin_thumb, 'Page header images should be 1360px(w) x 700px(h)')
      input :remove_banner_image, as: :boolean if f.object.banner_image.present?
    end
    inputs t('active_admin.common.contents') do
      input :body, input_html: { class: 'redactorbox' }
    end
    inputs t('active_admin.common.search_engine_optimisation') do
      input :page_title
      input :meta_description
    end
    actions
  end

  show do
    panel t('active_admin.common.details') do
      attributes_table_for page do
        row :title
        row :introduction
        row :banner_image do |i|
          image_tag_or(i.banner_image)
        end
      end
    end
    panel t('active_admin.common.contents') do
      page.body.html_safe
    end
    panel t('active_admin.common.search_engine_optimisation') do
      attributes_table_for page do
        row :page_title
        row :meta_description
      end
    end
  end
end
```


