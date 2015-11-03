Package.describe({
  name: 'hitchcott:ez-web-app',
  version: '0.0.2',
  summary: 'Easy Mode for `apple-mobile-web-app` metadata',
  git: 'https://github.com/hitchcott/ez-web-app',
  documentation: 'README.md'
});

Package.onUse(function(api) {
  api.versionsFrom('1.2.1');

  api.use([
    'templating',
    'coffeescript',
    'tracker',
    'cfs:standard-packages@0.5.9',
    'cfs:gridfs@0.0.33',
    'cfs:graphicsmagick@0.0.18',
    'cfs:ui@0.1.3'
  ])

  api.addFiles([
    'ez-web-app.html',
    'ez-web-app.css',
    'ez-web-app.coffee'
  ])
});