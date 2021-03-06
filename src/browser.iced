
base = require './base'

#=============================================================================================

jquery_to_req = ($) ->
  ({url,qs}, cb) ->

    success = (body, status, jqXHR) -> finish true, body, jqXHR
    error   = (jqXHR, textStatus, erroThrown) -> finish false, null, jqXHR

    finish = (success, body, jqXHR) ->
      return unless (tmp = cb)?
      cb = null
      err = null
      res = {}

      if (res.statusCode = jqXHR.status) isnt 200
        err = new Error "Non-OK HTTP error: #{res.statusCode}"
        body = null
      tmp err, res, body

    $.ajax {type : "GET", data : qs, url, success, error }

#=============================================================================================

exports.Blockchain = class Blockchain extends base.Blockchain

  constructor : (arg) ->
    arg.req = jquery_to_req($)
    super arg

#=============================================================================================

