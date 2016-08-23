{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

require './task.jade'

clickToggleChecked = ->
  Meteor.call('tasks.setChecked', @_id, !@checked)

clickDelete = ->
  Meteor.call('tasks.remove', @_id)

clickTogglePrivate = ->
  Meteor.call('tasks.setPrivate', @_id, !@private)

Template.task.events({
  'click .toggle-checked': clickToggleChecked
  'click .delete': clickDelete
  'click .toggle-private': clickTogglePrivate
})


isOwner = ->
  @owner == Meteor.userId()

Template.task.helpers({
  isOwner
})
