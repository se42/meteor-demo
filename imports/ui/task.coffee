`import { Template } from 'meteor/templating';`
`import { Tasks } from '../api/tasks.js';`
`import './task.jade';`

clickToggleChecked = ->
    Tasks.update(@_id, {$set: { checked: ! @checked }})

clickDelete = ->
    Tasks.remove(@_id)

Template.task.events({
    'click .toggle-checked': clickToggleChecked
    'click .delete': clickDelete
    })
