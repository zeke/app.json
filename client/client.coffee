Template.submitter.events 
  "submit form" : -> 
    domain = document.querySelector('.submitter input').value
    Submissions.insert({domain: domain}) if domain.length > 0
    false
  
Template.apps.app = ->
  Apps.find()

Template.submissions.submission = ->
  Submissions.find()

Meteor.startup ->
	Meteor.autorun ->

    Meteor.autosubscribe ->
      Apps.find().observe
        added: (app) ->
          console.log app