{ Meteor } = require 'meteor/meteor'
{ Mongo } = require 'meteor/mongo'
{ check } = require 'meteor/check'

# module.exports.Tasks = new Mongo.Collection('tasks')
# ^that didn't seem to actually make a Tasks variable that could be used
#  in this file so Tasks.insert(), Tasks.remove(), etc. were failing
#  with ReferenceError: Tasks is not defined
`export const Tasks = new Mongo.Collection('tasks');`

insertTask = (text) ->
  check(text, String)

  if !@userId
    throw new Meteor.Error('not-authorized')

  Tasks.insert({
    text
    createdAt: new Date()
    owner: @userId
    username: Meteor.users.findOne(@userId).username
    })

removeTask = (taskId) ->
  check(taskId, String)

  Tasks.remove(taskId)

setCheckedOnTask = (taskId, setChecked) ->
  check(taskId, String)
  check(setChecked, Boolean)

  Tasks.update(taskId, {$set: {checked: setChecked}})


Meteor.methods({
  'tasks.insert': insertTask
  'tasks.remove': removeTask
  'tasks.setChecked': setCheckedOnTask
  })
