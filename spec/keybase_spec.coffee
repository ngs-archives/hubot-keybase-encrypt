path = require 'path'
Robot = require("hubot/src/robot")
TextMessage = require("hubot/src/message").TextMessage
nock = require 'nock'
chai = require 'chai'
chai.use require 'chai-spies'
{ expect, spy } = chai

describe 'hubot-keybase', ->
  robot = null
  user = null
  adapter = null
  nockScope = null

  beforeEach (done)->
    nock.disableNetConnect()
    nockScope = nock('https://keybase.io')
    robot = new Robot null, 'mock-adapter', yes, 'TestHubot'
    robot.adapter.on 'connected', ->
      robot.loadFile path.resolve('.', 'src', 'scripts'), 'keybase.coffee'
      hubotScripts = path.resolve 'node_modules', 'hubot', 'src', 'scripts'
      robot.loadFile hubotScripts, 'help.coffee'
      user = robot.brain.userForId '1', {
        name: 'ngs'
        room: '#mocha'
      }
      adapter = robot.adapter
      waitForHelp = ->
        if robot.helpCommands().length > 0
          do done
        else
          setTimeout waitForHelp, 100
      do waitForHelp
    do robot.run

  afterEach ->
    robot.server.close()
    robot.shutdown()
    nock.cleanAll()
    process.removeAllListeners 'uncaughtException'

  describe 'help', ->
    it 'should have 4', (done)->
      expect(robot.helpCommands()).to.have.length 3
      do done

    it 'should parse help', (done)->
      adapter.on 'send', (envelope, strings)->
        try
          expect(strings).to.deep.equal ["""
          TestHubot help - Displays all of the help commands that TestHubot knows about.
          TestHubot help <query> - Displays all help commands that match <query>.
          TestHubot keybase encrypt:<keybase_user_name> <any message>
          """]
          do done
        catch e
          done e
      adapter.receive new TextMessage user, 'TestHubot help'

  describe 'Encrypt', ->
    msg = 'testHubot keybase  encrypt:ngs  hello  world  '
    describe 'Found a user', ->
      beforeEach ->
        nockScope
          .get('/_/api/1.0/user/lookup.json')
          .query( usernames: 'ngs' )
          .replyWithFile(200, "#{__dirname}/fixtures/lookup.json")

      it 'should send encrypted message', (done) ->
        adapter.on 'send', (envelope, strings)->
          try
            expect(strings).to.have.length 1
            expect(strings[0].indexOf '```\n-----BEGIN PGP MESSAGE-----').to.equal 0
            expect(strings[0].indexOf '-----END PGP MESSAGE-----\n```').to.equal 564
            do done
          catch e
            done e
        adapter.receive new TextMessage user, msg

    describe 'Could not find a user', ->
      beforeEach ->
        nockScope
          .get('/_/api/1.0/user/lookup.json')
          .query( usernames: 'ngs' )
          .replyWithFile(200, "#{__dirname}/fixtures/notfound.json")

      it 'should reply not found', (done) ->
        adapter.on 'reply', (envelope, strings)->
          try
            expect(strings).to.deep.equal ['Could not lookup user `ngs`.']
            do done
          catch e
            done e
        adapter.receive new TextMessage user, msg
