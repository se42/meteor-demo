`import { Template } from 'meteor/templating';`
`import { Tasks } from '../api/tasks.js';`

`import './task.coffee';`
`import './body.jade';`


# BODY HELPERS

tasks = -> Tasks.find({}, { sort: { createdAt: -1 } })

Template.body.helpers({tasks})


# BODY EVENTS

submitNewTask = (event) ->
  console.log(event)
  event.preventDefault()
  target = event.target
  text = target.text.value

  entry =
    text: text
    createdAt: new Date()

  Tasks.insert(entry)

  target.text.value = ''


Template.body.events({
  'submit .new-task': submitNewTask
  })
