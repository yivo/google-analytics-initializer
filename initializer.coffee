initialize = do ->
  initialized = no

  (trackingID) ->
    return if initialized

    throw new Error('Google Analytics initializer: Tracking ID is required') unless trackingID
    initialized = yes

    window.GoogleAnalyticsObject         = 'ga'
    window[window.GoogleAnalyticsObject] = ->
      args = []
      len  = arguments.length
      idx  = -1
      args.push(arguments[idx]) while ++idx < len
      (ga.q ?= []).push(args)
      return

    ga.l = Date.now?() ? +new Date()

    script       = document.createElement('script')
    script.type  = 'text/javascript'
    script.async = true

    # Use HTTPS to download script. Google redirects from HTTP to HTTPS.
    # This will save us from one redirect.
    script.src   = 'https://www.google-analytics.com/analytics.js'
    document.getElementsByTagName('head')[0]?.appendChild(script)

    ga('create', trackingID, 'auto')

    pageview = -> ga('send', 'pageview', location.href.split('#')[0]); return

    if Turbolinks?
      if Turbolinks.supported
        $(document).on('page:change', pageview)
      else
        pageview()
    else
      pageview()
      $(document).on('pjax:end', pageview) if $.fn.pjax?

    return

if (head = document.getElementsByTagName('head')[0])?
  for el in head.getElementsByTagName('meta')
    if el.getAttribute('name') is 'ga:tracking_id'
      initialize(trackingID) if trackingID = el.getAttribute('content')
      break