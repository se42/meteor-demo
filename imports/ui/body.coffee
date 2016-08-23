{ Meteor } = require 'meteor/meteor'
{ Template } = require 'meteor/templating'
{ ReactiveDict } = require 'meteor/reactive-dict'

{ Tasks } = require '../api/tasks.coffee'

require './task.coffee'
require './body.jade'


# BODY ONCREATED

Template.body.onCreated(bodyOnCreated = -> @state = new ReactiveDict())


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

  entry =
    text: event.target.text.value
    createdAt: new Date()
    owner: Meteor.userId()
    username: Meteor.user().username

  Tasks.insert(entry)

  event.target.text.value = ''


changeHideCompletedInput = (event, instance) ->
  instance.state.set('hideCompleted', event.target.checked)

Template.body.events({
  'submit .new-task': submitNewTask
  'change .hide-completed input': changeHideCompletedInput
  })
