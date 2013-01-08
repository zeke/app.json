Meteor.startup ->
  
  Apps.remove {}
  Submissions.remove {}
  
  Submissions.find().observe
    added: (submission) ->
      return if submission.status?
      console.log "new submission: #{submission._id} #{submission.domain}"
      Meteor.http.get "http://#{submission.domain}/app.json", (err, res) ->
        if err
          Submissions.update submission._id, {$set: {status: 'error'}}
        else
          Submissions.update submission._id, {$set: {status: 'success'}}
          Apps.insert res.data