
/*!
 * google-analytics-initializer 1.0.7 | https://github.com/yivo/google-analytics-initializer | MIT License
 */

(function() {
  var el, head, i, initialize, len1, ref, trackingID;

  initialize = function(trackingID) {
    var $document, pageset, pageview, ref, script;
    if (!trackingID) {
      throw new TypeError('[Google Analytics Initializer] Tracking ID is required');
    }
    window.GoogleAnalyticsObject = 'ga';
    window[window.GoogleAnalyticsObject] = function() {
      var args, idx, len;
      args = [];
      len = arguments.length;
      idx = -1;
      while (++idx < len) {
        args.push(arguments[idx]);
      }
      return (ga.q != null ? ga.q : ga.q = []).push(args);
    };
    ga.l = (ref = typeof Date.now === "function" ? Date.now() : void 0) != null ? ref : +new Date();
    script = document.createElement('script');
    script.type = 'text/javascript';
    script.async = true;
    script.src = 'https://www.google-analytics.com/analytics.js';
    document.getElementsByTagName('head')[0].appendChild(script);
    ga('create', trackingID, 'auto');
    pageset = function() {
      return ga('set', 'page', location.href.split('#')[0]);
    };
    pageview = function() {
      return ga('send', 'pageview');
    };
    if (typeof Turbolinks !== "undefined" && Turbolinks !== null ? Turbolinks.supported : void 0) {
      $document = $(document);
      $document.one('page:change', function() {
        return $document.on('page:change', function() {
          pageset();
          return pageview();
        });
      });
    }
    return pageview();
  };

  if ((head = document.getElementsByTagName('head')[0]) != null) {
    ref = head.getElementsByTagName('meta');
    for (i = 0, len1 = ref.length; i < len1; i++) {
      el = ref[i];
      if (el.getAttribute('name') === 'ga:tracking_id') {
        if (trackingID = el.getAttribute('content')) {
          initialize(trackingID);
        }
        break;
      }
    }
  }

}).call(this);
