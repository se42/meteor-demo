{ Template } = require 'meteor/templating'
{ Tasks } = require '../api/tasks.coffee'
require './task.jade'

clickToggleChecked = ->
    Tasks.update(@_id, {$set: { checked: ! @checked }})

clickDelete = ->
    Tasks.remove(@_id)

Template.task.events({
    'click .toggle-checked': clickToggleChecked
    'click .delete': clickDelete
    })
