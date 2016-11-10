# Description:
#   preparing useful tool for SI team
#
# Commands:
#   newyork - show status of SI team in newyork.
#   zendesk - show zendesk update within 2 hours.
#   rep [customer name(case-insensitive)] - show the person in charge
#   goto - show whether gotoassist accounts usable or not
#
# Author:
#   ykuniyasu (ykuniyasu@iij.com)
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->
   # folk for command
   @exec = require("child_process").exec

   #Log = require 'log'
   #TEMPLATE without argument
   #robot.hear /[regular expression]/i, (msg) ->
   #  command = "relative path. /home/hubot is root"
   #  exec command, (error, stdout, stderr) ->
   #    msg.send stdout if stdout?

   #TEMPLATE with argument
   #robot.hear /[regular expression] (.*)/i, (msg) ->
   #  rep = msg.match[1]
   #  command = "relative path. /home/hubot is root #{rep}"
   #  exec command, (error, stdout, stderr) ->
   #    msg.send stdout if stdout?

   robot.hear /[Nn]ewyork$/i, (msg) ->
     command = "scripts/newyork.sh"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?
       #robot.logger.info(command" success") if stdout?
       #robot.logger.error(command" failed") if error?

   robot.hear /[Cc]heck close$/i, (msg) ->
     command = "scripts/check_close.sh"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?
       #robot.logger.info('stdout')
       #robot.logger.error('stderr')

   robot.hear /[Zz]endesk$/i, (msg) ->
     command = "scripts/zendesk.sh"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.hear /[Rr]ep (.*)/i, (msg) ->
     rep = msg.match[1]
     command = "scripts/rep.sh #{rep}"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.hear /[Gg]oto$/i, (msg) ->
     command = "scripts/goto.sh"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.hear /[check |]ticket (.*)/i, (msg) ->
     rep = msg.match[1]
     command = "scripts/check_tickets.sh #{rep}"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.hear /[Kk]b (.*)/i, (msg) ->
     rep = msg.match[1]
     command = "scripts/kb.sh #{rep}"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.hear /[Aa]ddress (.*)/i, (msg) ->
     rep = msg.match[1]
     command = "scripts/address.sh #{rep}"
     exec command, (error, stdout, stderr) ->
       msg.send stdout if stdout?

   robot.enter (res) ->
     res.send "Commands:"
     res.send "`newyork`"
     res.send " >show status of SI team in newyork."
     res.send ""
     res.send "`zendesk`"
     res.send " >show zendesk update within 2 hours."
     res.send ""
     res.send "`rep [customer name(case-insensitive)]`"
     res.send " >show the person in charge"
     res.send ""
     res.send "`goto`"
     res.send " >show whether gotoassist accounts usable or not"
     res.send ""
     res.send "`kb [customer name(case-insensitive)]`"
     res.send " >show customer knoledgebase"
     res.send ""
     res.send "`address [customer name(case-insensitive)]`"
     res.send " >show customer address"
     res.send ""
     res.send "`check close`"
     res.send " >check zendesk tickets should be closed"
     res.send ""
     res.send "`ticket [assigner]`"
     res.send " >check zendesk tickets are assigned [assigner]"

   robot.respond /help$/i, (res) ->
     res.send "Commands:"
     res.send "`newyork`"
     res.send " >show status of SI team in newyork."
     res.send ""
     res.send "`zendesk`"
     res.send " >show zendesk update within 2 hours."
     res.send ""
     res.send "`rep [customer name(case-insensitive)]`"
     res.send " >show the person in charge"
     res.send ""
     res.send "`goto`"
     res.send " >show whether gotoassist accounts usable or not"
     res.send ""
     res.send "`kb [customer name(case-insensitive)]`"
     res.send " >show customer knoledgebase"
     res.send ""
     res.send "`address [customer name(case-insensitive)]`"
     res.send " >show customer address"
     res.send ""
     res.send "`check close`"
     res.send " >check zendesk tickets should be closed"
     res.send ""
     res.send "`ticket [assigner]`"
     res.send " >check zendesk tickets are assigned [assigner]"

