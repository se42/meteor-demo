{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'

require './task.jade'

clickToggleChecked = ->
    Meteor.call('tasks.setChecked', @_id, !@checked)

clickDelete = ->
    Meteor.call('tasks.remove', @_id)

Template.task.events({
    'click .toggle-checked': clickToggleChecked
    'click .delete': clickDelete
    })
