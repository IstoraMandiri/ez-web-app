if(Meteor.isClient){
  Template.hello.helpers({'imageData' : EZWebApp.imageData});
}

if(Meteor.isServer){
  EZWebApp.collection.allow({
    insert : function() {return true},
    update : function() {return true},
    remove : function() {return true},
    download : function() {return true}
  })
}