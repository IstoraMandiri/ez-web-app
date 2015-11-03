# EZ Web App (ALPHA)

### Easy Mode for `apple-mobile-web-app` metadata

![hitchcott:ez-web-app](http://i.imgur.com/UbbsC5v.png)

## Usage

Just `meteor add hitchcott:ez-web-app` and add `{{> EZWebApp}}` to your admin UI

Then set your allow/deny rules for uploading and downloading.

```coffeescript
EZWebApp.collection.allow
  insert: -> true
  update: -> true
  remove: -> true
  download: -> true
```

## Features

* UI for uploading and convert images for
  * DONE: Web app icon
  * TODO: Splash page (nearly implemented but currently out of action)
  * TODO: Favicon
  * vNext: Meta tag config (eg web-app-title etc)

* Dynamically Adds & Maintains the following meta tags:

```
<link href="icons/apple-touch-icon-XxY.png" sizes="XxY" rel="apple-touch-icon">
```

## Lisence

MIT 2015, C Hitchcott