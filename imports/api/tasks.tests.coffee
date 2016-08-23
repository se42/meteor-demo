{ Meteor } = require 'meteor/meteor'
{ Random } = require 'meteor/random'
{ assert } = require 'meteor/practicalmeteor:chai'

{ Tasks } = require './tasks.coffee'

if Meteor.isServer
  describe('Tasks', =>
    describe('methods', =>
      userId = Random.id()
      taskId = undefined
      
      beforeEach(=>
        Tasks.remove({})
        taskId = Tasks.insert({
          text: 'test task'
          createdAt: new Date()
          owner: userId
          username: 'testuser'
        })
      )

      it('can delete owned task', =>
        deleteTask = Meteor.server.method_handlers['tasks.remove']
        invocation = { userId }
        deleteTask.apply(invocation, [taskId])
        assert.equal(Tasks.find().count(), 0)
      )
    )
  )
