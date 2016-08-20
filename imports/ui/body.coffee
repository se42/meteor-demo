`import { Template } from 'meteor/templating';`
`import { ReactiveDict } from 'meteor/reactive-dict';`

`import { Tasks } from '../api/tasks.js';`

`import './task.coffee';`
`import './body.jade';`


# BODY ONCREATED

Template.body.onCreated(bodyOnCreated = -> @state = new ReactiveDict())


# BODY HELPERS

# tasks = -> Tasks.find({}, { sort: { createdAt: -1 } })

tasks = ->
  instance = Template.instance()
  if instance.state.get('hideCompleted')
    Tasks.find({ checked: { $ne: true } }, { sort: { createdAt: -1 } })
  else
    Tasks.find({}, { sort: { createdAt: -1 } })

Template.body.helpers({tasks})


# BODY EVENTS

submitNewTask = (event) ->
  event.preventDefault()

  entry =
    text: event.target.text.value
    createdAt: new Date()

  Tasks.insert(entry)

  event.target.text.value = ''

changeHideCompletedInput = (event, instance) ->
  instance.state.set('hideCompleted', event.target.checked)

Template.body.events({
  'submit .new-task': submitNewTask
  'change .hide-completed input': changeHideCompletedInput
  })
