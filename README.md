# Kyan Standard CMS

This repository contains what is considered to be the standard requirements for a basic CMS.  The idea is to make 
sure we have consistent set of functionality that is added to every CMS as base to build on for further development.

## Base CMS

Currently [Active Admin](https://github.com/activeadmin/activeadmin) is the starting point for all CMSes. The current 
version in development support Rails 5 and can be installed by tracking the master branch:

```ruby
gem 'activeadmin', github: 'activeadmin'
```

To get it to play nicely with Rails 5 add the `inherited_resources` gem:

```ruby
gem 'inherited_resources', github: 'activeadmin/inherited_resources'
```

Before you `bundle install` it's worth adding Devise as well as Active Admin will create all the required login functionality
when the install process is run.  Check the [Setting up Active Admin](https://github.com/activeadmin/activeadmin/blob/master/docs/0-installation.md#setting-up-active-admin) documentation to do this.

## Default CMS functionality

Listed here are what the default expected functionality of a CMS should contain, this list is not exhaustive but it 
should be the bare minimum that a new CMS should contain.

### Pages

Pages are the standard dynamic pages that a client would expect to be able to manage inside the CMS.  These pages 
could include About us, Cookie and Privacy Polices, Contact and, unless it requires a large amount of customisation, 
the Home page.

The minimum set of editable content for a Page is:
* Name (or the title)
* Introduction or hero banner text
* Publish/unpublish check box
* Publish date
* Body - WYSIWYG editor
* Image uploads/gallery
* Meta data (title / keywords / description)

### News Articles / Events

New article are another type of page that should be created by default.  They are generally always built the same way and
share a lot of similarities with [Pages](#pages) with a few differences:
* Publish/unpublish check box
* Publish date
* Unpublish date
* Event date (i.e. if the article relates to an Event on a specific day)
* Body - WYSIWYG editor
* Image uploads/gallery
* File download (PDF etc)
* Meta data (title / keywords / description)
