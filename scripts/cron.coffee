cronJob = require('cron').CronJob
module.exports = (robot) ->
  new cronJob('0 30 13 * * 4', () ->
    @exec = require("child_process").exec
    command = "scripts/check_close_tickets.sh"
    @exec command, (error, stdout, stderr) ->
    	robot.send {room: "C1KMSPAHE"}, stdout if stdout?
  ).start()

