// Generated by CoffeeScript 1.8.0
(function() {
  var Evernote, async, client, findNote, lsTag, noteStore;

  client = require('./lib/evernote');

  Evernote = require('evernote').Evernote;

  async = require('async');

  noteStore = client.getNoteStore('https://app.yinxiang.com/shard/s5/notestore');

  async.waterfall([
    lsTag = function(cb) {
      return noteStore.listTags(function(err, info) {
        if (err) {
          return console.log(err);
        }
        return cb(null, info);
      });
    }, findNote = function(tags, cb) {
      return async.eachSeries(tags, function(item, callback) {
        var filterNote, reParams;
        filterNote = new Evernote.NoteFilter();
        filterNote.tagGuids = [];
        filterNote.tagGuids.push(item.guid);
        reParams = new Evernote.NotesMetadataResultSpec();
        reParams.includeTitle = true;
        reParams.includeCreated = false;
        reParams.includeUpdated = false;
        reParams.includeDeleted = false;
        reParams.includeTagGuids = false;
        reParams.includeNotebookGuid = false;
        return noteStore.findNotesMetadata(filterNote, 0, 1, reParams, function(err, info) {
          if (err) {
            return console.log(err);
          }
          if (info.totalNotes === 0) {
            console.log("item need remove", item);
          }
          return callback();
        });
      });
    }
  ]);

}).call(this);

//# sourceMappingURL=app.js.map
