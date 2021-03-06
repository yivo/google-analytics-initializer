###!
# google-analytics-initializer 1.0.7 | https://github.com/yivo/google-analytics-initializer | MIT License
###
  
initialize = (trackingID) ->
  unless trackingID
    throw new TypeError('[Google Analytics Initializer] Tracking ID is required')    

  window.GoogleAnalyticsObject         = 'ga'
  window[window.GoogleAnalyticsObject] = ->
    args = []
    len  = arguments.length
    idx  = -1
    args.push(arguments[idx]) while ++idx < len
    (ga.q ?= []).push(args)

  ga.l = Date.now?() ? +new Date()

  script       = document.createElement('script')
  script.type  = 'text/javascript'
  script.async = true

  # Use HTTPS to download script. Google redirects from HTTP to HTTPS.
  # This will save us from one redirect.
  script.src   = 'https://www.google-analytics.com/analytics.js'

  document.getElementsByTagName('head')[0].appendChild(script)

  ga('create', trackingID, 'auto')

  pageset  = -> ga('set', 'page', location.href.split('#')[0])
  pageview = -> ga('send', 'pageview')

  # https://developers.google.com/analytics/devguides/collection/analyticsjs/single-page-applications
  if Turbolinks?.supported
    $document = $(document)
    $document.one 'page:change', ->
      $document.on 'page:change', ->
        pageset()
        pageview()

  pageview()

if (head = document.getElementsByTagName('head')[0])?
  for el in head.getElementsByTagName('meta')
    if el.getAttribute('name') is 'ga:tracking_id'
      initialize(trackingID) if trackingID = el.getAttribute('content')
      break
