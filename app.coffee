client = require('./lib/evernote')
Evernote = require('evernote').Evernote;
async = require('async')
noteStore = client.getNoteStore('https://app.yinxiang.com/shard/s5/notestore')


async.waterfall [
  lsTag = (cb) ->
    noteStore.listTags (err, info) ->
      return console.log err if err

      cb(null, info)


  findNote = (tags, cb) ->
    async.eachSeries tags, (item, callback) ->
      filterNote = new Evernote.NoteFilter()
      filterNote.tagGuids = []
      filterNote.tagGuids.push item.guid
      reParams = new Evernote.NotesMetadataResultSpec()
      reParams.includeTitle = true
      reParams.includeCreated = false
      reParams.includeUpdated = false
      reParams.includeDeleted = false
      reParams.includeTagGuids = false
      reParams.includeNotebookGuid = false

      noteStore.findNotesMetadata filterNote, 0, 1, reParams, (err, info) ->
        return console.log err if err

        if info.totalNotes is 0
          console.log "item need remove", item

        callback()



]

#
#noteStore.listTags (err, info) ->
#  return console.log err if err

#  console.log info
#  console.log info.length

#noteStore.listSearches (err, info) ->
#  return console.log err if err
#
#  console.log info


#filterNote = new Evernote.NoteFilter()
#filterNote.tagGuids = ['e59b1a1a-3501-489e-a1e1-1543f6f8fdb1']
#reParams = new Evernote.NotesMetadataResultSpec()
#reParams.includeTitle = true
#reParams.includeCreated = false
#reParams.includeUpdated = false
#reParams.includeDeleted = false
#reParams.includeTagGuids = false
#reParams.includeNotebookGuid = false
#
#
#noteStore.findNotesMetadata filterNote, 0, 10,reParams, (err, info) ->
#  return console.log(err) if err
#  console.log info
#  console.log info.totalNotes
##  if info.totalNotes is 0
##    noteStore.expungeTag filterNote.tagGuids[0], (err, res) ->
##      return console.log err if err
##
##      console.log res

