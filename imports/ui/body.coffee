`import { Template } from 'meteor/templating';`
`import './body.jade';`

tasks = [
    { text: 'This is task 1'},
    { text: 'This is task 2'},
    { text: 'This is task 3'}
]

Template.body.helpers({tasks})
