# maintain a single CFS collection for the images
@EZWebApp = {}

EZWebApp.imageData =
  icon: [
    {w:57, h: 57} #<link href="icons/apple-touch-icon-57x57.png" sizes="57x57" rel="apple-touch-icon">
    {w:72, h: 72} #<link href="icons/apple-touch-icon-72x72.png" sizes="72x72" rel="apple-touch-icon">
    {w:76, h: 76} #<link href="icons/apple-touch-icon-76x76.png" sizes="76x76" rel="apple-touch-icon">
    {w:114, h:114} #<link href="icons/apple-touch-icon-114x114.png" sizes="114x114" rel="apple-touch-icon">
    {w:120, h:120} #<link href="icons/apple-touch-icon-120x120.png" sizes="120x120" rel="apple-touch-icon">
    {w:144, h:144} #<link href="icons/apple-touch-icon-144x144.png" sizes="144x144" rel="apple-touch-icon">
    {w:152, h:152} #<link href="icons/apple-touch-icon-152x152.png" sizes="152x152" rel="apple-touch-icon">
    {w:180, h:180} #<link href="icons/apple-touch-icon-180x180.png" sizes="180x180" rel="apple-touch-icon">
  ]
  splash: [
    {w:320, h:460, dw:320, dh:480, pd:1, o:"portrait"} # <link href="splash/apple-touch-startup-image-320x460.png" media="(device-width: 320px) and (device-height: 480px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 1)" rel="apple-touch-startup-image">
    {w:480, h:320, dw:320, dh:480, pd:1, o:"landscape"} # <link href="splash/apple-touch-startup-image-480x320.png" media="(device-width: 320px) and (device-height: 480px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 1)" rel="apple-touch-startup-image">
    {w:640, h:920, dw:320, dh:480, pd:2, o:"portrait"} # <link href="splash/apple-touch-startup-image-640x920.png" media="(device-width: 320px) and (device-height: 480px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:960, h:640, dw:320, dh:480, pd:2, o:"landscape"} # <link href="splash/apple-touch-startup-image-960x640.png" media="(device-width: 320px) and (device-height: 480px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:640, h:1096, dw:320, dh:568, pd:2, o:"portrait"} # <link href="splash/apple-touch-startup-image-640x1096.png" media="(device-width: 320px) and (device-height: 568px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:1136, h:640, dw:320, dh:568, pd:2, o:"landscape"} # <link href="splash/apple-touch-startup-image-1136x640.png" media="(device-width: 320px) and (device-height: 568px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:750, h:1294, dw:375, dh:667, pd:2, o:"portrait"} # <link href="splash/apple-touch-startup-image-750x1294.png" media="(device-width: 375px) and (device-height: 667px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:1334, h:750, dw:375, dh:667, pd:2, o:"landscape"} # <link href="splash/apple-touch-startup-image-1334x750.png" media="(device-width: 375px) and (device-height: 667px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:1242, h:2148, dw:414, dh:736, pd:3, o:"portrait"} # <link href="splash/apple-touch-startup-image-1242x2148.png" media="(device-width: 414px) and (device-height: 736px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image">
    {w:2208, h:1242, dw:414, dh:736, pd:3, o:"landscape"} # <link href="splash/apple-touch-startup-image-2208x1242.png" media="(device-width: 414px) and (device-height: 736px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image">
    {w:768, h:1004, dw:768, dh:102, pd:1, o:"portrait"} # <link href="splash/apple-touch-startup-image-768x1004.png" media="(device-width: 768px) and (device-height: 1024px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 1)" rel="apple-touch-startup-image">
    {w:1024, h:748, dw:768, dh:102, pd:1, o:"landscape"} # <link href="splash/apple-touch-startup-image-1024x748.png" media="(device-width: 768px) and (device-height: 1024px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 1)" rel="apple-touch-startup-image">
    {w:1536, h:2008, dw:768, dh:102, pd:2, o:"portrait"} # <link href="splash/apple-touch-startup-image-1536x2008.png" media="(device-width: 768px) and (device-height: 1024px) and (orientation: portrait) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
    {w:2048, h:1496, dw:768, dh:102, pd:2, o:"landscape"} # <link href="splash/apple-touch-startup-image-2048x1496.png" media="(device-width: 768px) and (device-height: 1024px) and (orientation: landscape) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image">
  ]

# generate the list of of stores
stores = []
generateStoreName = (w, h, type) -> "#{type}_#{w}x#{h}"
generateStore = (w, h, type) ->
  storeName = generateStoreName w, h, type
  settings =
    maxTries: 3 # optional, default 1 max 5
    transformWrite: (fileObj, readStream, writeStream) ->
      console.log('hi there', type, fileObj._id)
      # only generate the thumb for the right image type
      if fileObj._id is type
        # TODO attach the size info to the image?
        fileObj.extension('png', {store: storeName})
        fileObj.type('image/png', {store: storeName})
        gm(readStream, fileObj.name())
        .resize("#{w}^", "#{h}^")
        .gravity('Center')
        .background("#FFF")
        .extent("#{w}","#{h}")
        .gravity('Center')
        .crop(w, h)
        .stream('PNG')
        .pipe(writeStream)
      else
        return false

  return new FS.Store.GridFS storeName, settings

# loop through icons and splash pages
for storeName, imageData of EZWebApp.imageData
  for imageItem in imageData
    stores.push generateStore(imageItem.w, imageItem.h, storeName)

# create the CFS Collection
EZWebApp.collection = new FS.Collection "EZWebApp",
  stores: stores
  filter:
    maxSize: 1024 * 1024 * 20 # 20 mb max filesize
    allow:
      extensions: ['png', 'jpg', 'gif', 'jpeg']
      contentTypes: ['image/*']

    onInvalid: (message) ->
      if Meteor.isClient
        alert message
      else
        console.log message

if Meteor.isClient
  # always hook into and re-populate meta tags on change
  Meteor.startup ->
    $head = $('head')
    # recompute whenever our images collection changes
    # TODO debounce
    Tracker.autorun ->
      # TODO: appTitle
      $('.ez-web-app', $head).remove()
      $head.append Blaze.toHTMLWithData(Template.EZWebAppMetaTags, {images: EZWebApp.imageData})

  # admin UI
  grabUrl = (imageType) ->
    image = EZWebApp.collection.findOne(imageType)
    if image
      # add new Date().valueOf() to prevent caching
      return image.url({filename: "#{imageType}.png", store:generateStoreName(@w, @h, imageType)}) + "&c=#{new Date().valueOf()}"
    else
      return false

  Template.EZWebApp.helpers
    imageData: EZWebApp.imageData
    grabUrl: grabUrl

  Template.EZWebApp.events
    'change input': (e) ->
      thisFile = new FS.File(e.currentTarget.files[0])
      thisFile._id = $(e.currentTarget).attr('name')
      EZWebApp.collection.remove thisFile._id
      EZWebApp.collection.insert thisFile

  Template.EZWebAppMetaTags.helpers
    imageData: EZWebApp.imageData
    grabUrl: grabUrl
