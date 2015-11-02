# EZ Web App (ALPHA)

### Easy Mode for `apple-mobile-web-app` metadata

![hitchcott:ez-web-app](http://i.imgur.com/UbbsC5v.png)

## Usage

Just `meteor add hitchcott:ez-web-app` and add `{{> EZWebApp}}` to your admin UI

TODO: Security

* UI for uploading and convert images for
  * DONE: Web app icon
  * TODO: Splash page (nearly implemented but currently out of action)
  * TODO: Favicon
  * vNext: Meta tag config

* Dynamically Adds & Maintains the following meta tags:

```
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-title" content="Web App">
<meta name="format-detection" content="telephone=no">
<meta name='viewport' content='width=device-width, initial-scale=1, minimal-ui=1, maximum-scale=1'>
<link href="icons/apple-touch-icon-XxY.png" sizes="XxY" rel="apple-touch-icon">
<link href="splash/apple-touch-startup-image-XxY.png" media="(device-width: X) and (device-height: Y) and (orientation: portrait) and (-webkit-device-pixel-ratio: 1)" rel="apple-touch-startup-image">
```

## Lisence

MIT 2015, C Hitchcott