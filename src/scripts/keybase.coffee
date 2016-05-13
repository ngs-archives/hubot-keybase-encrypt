# Description:
#    Encrypt messages for Keybase users
#
# Commands:
#    hubot keybase encrypt:<keybase_user_name> <any message>

openpgp = require 'openpgp'

module.exports = (robot) ->
  robot.respond /\s*(?:keybase|kb)\s+enc(?:rypt?)\:([^\s]+)\s(.+)$/i, (msg) ->
    [_, username, data] = msg.match
    robot
      .http("https://keybase.io/_/api/1.0/user/lookup.json?usernames=#{username}")
      .get() (err, httpRes, body) ->
        json = try JSON.parse body
        unless pubKeyStr = json?.them?[0]?.public_keys?.primary?.bundle
          return msg.reply "Could not lookup user `#{username}`."
        publicKeys = openpgp.key.readArmored(pubKeyStr).keys
        openpgp
          .encrypt({ publicKeys, data })
          .then (ciphertext) =>
            msg.send "```\n#{ciphertext.data.replace(/\r\n/g, '\n')}```"
