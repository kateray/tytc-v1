window.VoteList = Backbone.Collection.extend
  model: Vote
  url: "/votes"