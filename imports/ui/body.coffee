{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'
{ ReactiveDict } = require 'meteor/reactive-dict'

{ Tasks } = require '../api/tasks.coffee'

require './task.coffee'
require './body.jade'


# BODY ONCREATED

Template.body.onCreated(
  bodyOnCreated = ->
    @state = new ReactiveDict()
    Meteor.subscribe('tasks')
)


# BODY HELPERS

tasks = ->
  instance = Template.instance()
  if instance.state.get('hideCompleted')
    Tasks.find({checked: {$ne: true}}, {sort: {createdAt: -1}})
  else
    Tasks.find({}, {sort: {createdAt: -1}})

incompleteCount = ->
  Tasks.find({checked: {$ne: true}}).count()

Template.body.helpers({
  tasks
  incompleteCount
})


# BODY EVENTS

submitNewTask = (event) ->
  event.preventDefault()
  Meteor.call('tasks.insert', event.target.text.value)
  event.target.text.value = ''


changeHideCompletedInput = (event, instance) ->
  instance.state.set('hideCompleted', event.target.checked)

Template.body.events({
  'submit .new-task': submitNewTask
  'change .hide-completed input': changeHideCompletedInput
  })
