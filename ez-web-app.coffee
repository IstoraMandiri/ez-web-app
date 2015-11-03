# maintain a single CFS collection for the images
@EZWebApp = {}

EZWebApp.imageData =
  icon: [
    {w:57, h: 57}
    {w:72, h: 72}
    {w:76, h: 76}
    {w:114, h:114}
    {w:120, h:120}
    {w:144, h:144}
    {w:152, h:152}
    {w:167, h:167}
    {w:180, h:180}
  ]
  splash: [
    # TODO fix the splash page issue and uncomment this
    # {w:320, h:460, dw:320, dh:480, pd:1, o:"portrait", show: true}
    # {w:480, h:320, dw:320, dh:480, pd:1, o:"landscape", show: true}
    # {w:640, h:920, dw:320, dh:480, pd:2, o:"portrait"}
    # {w:960, h:640, dw:320, dh:480, pd:2, o:"landscape"}
    # {w:640, h:1096, dw:320, dh:568, pd:2, o:"portrait"}
    # {w:1136, h:640, dw:320, dh:568, pd:2, o:"landscape"}
    # {w:750, h:1294, dw:375, dh:667, pd:2, o:"portrait"}
    # {w:1334, h:750, dw:375, dh:667, pd:2, o:"landscape"}
    # {w:1242, h:2148, dw:414, dh:736, pd:3, o:"portrait"}
    # {w:2208, h:1242, dw:414, dh:736, pd:3, o:"landscape"}
    # {w:768, h:1004, dw:768, dh:102, pd:1, o:"portrait"}
    # {w:1024, h:748, dw:768, dh:102, pd:1, o:"landscape"}
    # {w:1536, h:2008, dw:768, dh:102, pd:2, o:"portrait"}
    # {w:2048, h:1496, dw:768, dh:102, pd:2, o:"landscape"}
  ]

# generate the list of of stores
stores = []
generateStoreName = (w, h, type) -> "#{type}_#{w}x#{h}"
generateStore = (w, h, type) ->
  storeName = generateStoreName w, h, type
  settings =
    maxTries: 3 # optional, default 1 max 5
    transformWrite: (fileObj, readStream, writeStream) ->
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

if Meteor.isServer
  Meteor.publish 'EZWebApp', -> EZWebApp.collection.find()

if Meteor.isClient
  # always hook into and re-populate meta tags on change
  # TODO only hook up client if they are on mobile
  Meteor.subscribe 'EZWebApp'

  Meteor.startup ->

    $head = $('head')

    debounced = _.debounce ->
      $('.ez-web-app', $head).remove()
      $head.append Blaze.toHTMLWithData(Template.EZWebAppMetaTags, {imageData: EZWebApp.imageData})
    , 100
    Tracker.autorun ->
      # recompute whenever our collection changes
      EZWebApp.collection.find().fetch()
      debounced()


  # admin UI
  grabUrl = (imageType) ->
    image = EZWebApp.collection.findOne(imageType)
    if image
      # add new Date().valueOf() to prevent caching
      return image.url({filename: "#{imageType}_#{new Date().valueOf()}.png", store:generateStoreName(@w, @h, imageType)})
    else
      return false

  Template.EZWebAppMetaTags.helpers
    imageData: EZWebApp.imageData
    grabUrl: grabUrl

  Template.EZWebApp.helpers
    imageData: EZWebApp.imageData
    grabUrl: grabUrl
    largestIconSize: ->
      largest = EZWebApp.imageData.icon[EZWebApp.imageData.icon.length-1]
      "#{largest.w}px x #{largest.h}px"

  Template.EZWebApp.events
    'change input': (e) ->
      thisFile = new FS.File(e.currentTarget.files[0])
      thisFile._id = $(e.currentTarget).attr('name')
      EZWebApp.collection.remove thisFile._id
      EZWebApp.collection.insert thisFile

