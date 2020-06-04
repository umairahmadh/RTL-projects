<!DOCTYPE html><html lang="en-US" class="" data-primer><head><link href="https://a.slack-edge.com/e33f3/style/rollup-slack_kit_legacy_adapters.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/78f01/style/rollup-plastic.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/39b7/style/rollup-slack_kit_base.css" rel="stylesheet" id="slack_kit_helpers_stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/25e45/style/rollup-slack_kit_helpers.css" rel="stylesheet" id="slack_kit_helpers_stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/87e4f2/style/find_team.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/c74a7/style/sticky_nav.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/b9c9/style/footer.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><link href="https://a.slack-edge.com/77a4d/style/libs/lato-2-compressed.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"><script>window.ts_endpoint_url = "https:\/\/slack.com\/beacon\/timing";(function(e) {
	var n=Date.now?Date.now():+new Date,r=e.performance||{},t=[],a={},i=function(e,n){for(var r=0,a=t.length,i=[];a>r;r++)t[r][e]==n&&i.push(t[r]);return i},o=function(e,n){for(var r,a=t.length;a--;)r=t[a],r.entryType!=e||void 0!==n&&r.name!=n||t.splice(a,1)};r.now||(r.now=r.webkitNow||r.mozNow||r.msNow||function(){return(Date.now?Date.now():+new Date)-n}),r.mark||(r.mark=r.webkitMark||function(e){var n={name:e,entryType:"mark",startTime:r.now(),duration:0};t.push(n),a[e]=n}),r.measure||(r.measure=r.webkitMeasure||function(e,n,r){n=a[n].startTime,r=a[r].startTime,t.push({name:e,entryType:"measure",startTime:n,duration:r-n})}),r.getEntriesByType||(r.getEntriesByType=r.webkitGetEntriesByType||function(e){return i("entryType",e)}),r.getEntriesByName||(r.getEntriesByName=r.webkitGetEntriesByName||function(e){return i("name",e)}),r.clearMarks||(r.clearMarks=r.webkitClearMarks||function(e){o("mark",e)}),r.clearMeasures||(r.clearMeasures=r.webkitClearMeasures||function(e){o("measure",e)}),e.performance=r,"function"==typeof define&&(define.amd||define.ajs)&&define("performance",[],function(){return r}) // eslint-disable-line
})(window);</script><script>

(function () {
	
	window.TSMark = function (mark_label) {
		if (!window.performance || !window.performance.mark) return;
		performance.mark(mark_label);
	};
	window.TSMark('start_load');

	
	window.TSMeasureAndBeacon = function (measure_label, start_mark_label) {
		if (!window.performance || !window.performance.mark || !window.performance.measure) {
			return;
		}

		performance.mark(start_mark_label + '_end');

		try {
			performance.measure(measure_label, start_mark_label, start_mark_label + '_end');
			window.TSBeacon(measure_label, performance.getEntriesByName(measure_label)[0].duration);
		} catch (e) {
			
		}
	};

	
	if ('sendBeacon' in navigator) {
		window.TSBeacon = function (label, value) {
			var endpoint_url = window.ts_endpoint_url || 'https://slack.com/beacon/timing';
			navigator.sendBeacon(
				endpoint_url + '?data=' + encodeURIComponent(label + ':' + value),
				''
			);
		};
	} else {
		window.TSBeacon = function (label, value) {
			var endpoint_url = window.ts_endpoint_url || 'https://slack.com/beacon/timing';
			new Image().src = endpoint_url + '?data=' + encodeURIComponent(label + ':' + value);
		};
	}
})();
</script><script>window.TSMark('step_load');</script><script>
(function () {
	function throttle(callback, intervalMs) {
		var wait = false;

		return function () {
			if (!wait) {
				callback.apply(null, arguments);
				wait = true;
				setTimeout(function () {
					wait = false;
				}, intervalMs);
			}
		};
	}

	function getGenericLogger() {
		return {
			warn: (msg) => {
				
				if (window.console && console.warn) return console.warn(msg);
			},
			error: (msg) => {
				if (!msg) return;

				if (window.TSBeacon) return window.TSBeacon(msg, 1);

				
				if (window.console && console.warn) return console.warn(msg);
			},
		};
	}

	function globalErrorHandler(evt) {
		if (!evt) return;

		
		var details = '';

		var node = evt.srcElement || evt.target;

		var genericLogger = getGenericLogger();

		
		
		
		
		if (node && node.nodeName) {
			var nodeSrc = '';
			if (node.nodeName === 'SCRIPT') {
				nodeSrc = node.src || 'unknown';
				var errorType = evt.type || 'error';

				
				details = `[${errorType}] from script at ${nodeSrc} (failed to load?)`;
			} else if (node.nodeName === 'IMG') {
				nodeSrc = node.src || node.currentSrc;

				genericLogger.warn(`<img> fired error with url = ${nodeSrc}`);
				return;
			}
		}

		
		if (evt.error && evt.error.stack) {
			details += ` ${evt.error.stack}`;
		}

		if (evt.filename) {
			
			var fileName = evt.filename;
			var lineNo = evt.lineno;
			var colNo = evt.colno;

			details += ` from ${fileName}`;

			
			if (lineNo) {
				details += ` @ line ${lineNo}, col ${colNo}`;
			}
		}

		var msg;

		
		if (evt.error && evt.error.stack) {
			
			msg = details;
		} else {
			
			msg = `${evt.message || ''} ${details}`;
		}

		
		if (msg && msg.replace) msg = msg.replace(/\s+/g, ' ').trim();

		if (!msg || !msg.length) {
			if (node) {
				var nodeName = node.nodeName || 'unknown';

				
				
				
				if (nodeName === 'VIDEO') {
					return;
				}

				msg = `error event from node of ${nodeName}, no message provided?`;
			} else {
				msg = 'error event fired, no relevant message or node found';
			}
		}

		var logPrefix = 'ERROR caught in js/inline/register_global_error_handler';

		msg = `${logPrefix} - ${msg}`;

		genericLogger.error(msg);
	}

	
	
	
	var capture = true;

	
	var throttledHandler = throttle(globalErrorHandler, 10000);

	window.addEventListener('error', throttledHandler, capture);
})();
</script><script type="text/javascript" src="https://a.slack-edge.com/bv1-8-8cacda2/manifest.8ddc06b.primer.min.js" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"></script><noscript><meta http-equiv="refresh" content="0; URL=/?redir=%2Ffiles-pri%2FTLXMEFA3X-F014XTV14QH%2Ftop.v&amp;nojsmode=1"></noscript><script type="text/javascript">var safe_hosts = ['app.optimizely.com', 'tinyspeck.dev.slack.com'];

if (self !== top && safe_hosts.indexOf(top.location.host) === -1) {
	window.document.write(
		'\u003Cstyle>body * {display:none !important;}\u003C/style>\u003Ca href="#" onclick=' +
			'"top.location.href=window.location.href" style="display:block !important;padding:10px">Go to Slack.com\u003C/a>'
	);
}

(function() {
	var timer;
	if (self !== top && safe_hosts.indexOf(top.location.host) === -1) {
		timer = window.setInterval(function() {
			if (window) {
				try {
					var pageEl = document.getElementById('page');
					var clientEl = document.getElementById('client-ui');
					var sectionEls = document.querySelectorAll('nav, header, section');

					pageEl.parentNode.removeChild(pageEl);
					clientEl.parentNode.removeChild(clientEl);
					for (var i = 0; i < sectionEls.length; i++) {
						sectionEls[i].parentNode.removeChild(sectionEls[i]);
					}
					window.TS = null;
					window.TD = null;
					window.clearInterval(timer);
				} catch (e) {}	
			}
		}, 200);
	}
})();</script><script type="text/javascript">
document.addEventListener("DOMContentLoaded", function(e) {
	var gtmDataLayer = window.dataLayer || [];
	var gtmTags = document.querySelectorAll('*[data-gtm-click]');
	var gtmClickHandler = function(c) {
		var gtm_events = this.getAttribute('data-gtm-click');
		if (!gtm_events) return;
		var gtm_events_arr = gtm_events.split(",");
		for(var e=0; e < gtm_events_arr.length; e++) {
			var ev = gtm_events_arr[e].trim();
			gtmDataLayer.push({ 'event': ev });
		}
	};
	for(var g=0; g < gtmTags.length; g++){
		var elem = gtmTags[g];
		elem.addEventListener('click', gtmClickHandler);
	}
});
</script><script type="text/javascript">
(function(e,c,b,f,d,g,a){e.SlackBeaconObject=d;
e[d]=e[d]||function(){(e[d].q=e[d].q||[]).push([1*new Date(),arguments])};
e[d].l=1*new Date();g=c.createElement(b);a=c.getElementsByTagName(b)[0];
g.async=1;g.src=f;a.parentNode.insertBefore(g,a)
})(window,document,"script","https://a.slack-edge.com/bv1-8-8cacda2/slack_beacon.5256c1f252f9ae885071.min.js","sb");
window.sb('set', 'token', '3307f436963e02d4f9eb85ce5159744c');
window.sb('track', 'pageview');
</script><script type="text/javascript">var TS_last_log_date = null;
var TSMakeLogDate = function() {
	var date = new Date();

	var y = date.getFullYear();
	var mo = date.getMonth()+1;
	var d = date.getDate();

	var time = {
	  h: date.getHours(),
	  mi: date.getMinutes(),
	  s: date.getSeconds(),
	  ms: date.getMilliseconds()
	};

	Object.keys(time).map(function(moment, index) {
		if (moment == 'ms') {
			if (time[moment] < 10) {
				time[moment] = time[moment]+'00';
			} else if (time[moment] < 100) {
				time[moment] = time[moment]+'0';
			}
		} else if (time[moment] < 10) {
			time[moment] = '0' + time[moment];
		}
	});

	var str = y + '/' + mo + '/' + d + ' ' + time.h + ':' + time.mi + ':' + time.s + '.' + time.ms;
	if (TS_last_log_date) {
		var diff = date-TS_last_log_date;
		//str+= ' ('+diff+'ms)';
	}
	TS_last_log_date = date;
	return str+' ';
}

var parseDeepLinkRequest = function(code) {
	var m = code.match(/"id":"([CDG][A-Z0-9]{8,})"/);
	var id = m ? m[1] : null;

	m = code.match(/"team":"(T[A-Z0-9]{8,})"/);
	var team = m ? m[1] : null;

	m = code.match(/"message":"([0-9]+\.[0-9]+)"/);
	var message = m ? m[1] : null;

	return { id: id, team: team, message: message };
}

if ('rendererEvalAsync' in window) {
	var origRendererEvalAsync = window.rendererEvalAsync;
	window.rendererEvalAsync = function(blob) {
		try {
			var data = JSON.parse(decodeURIComponent(atob(blob)));
			if (data.code.match(/handleDeepLink/)) {
				var request = parseDeepLinkRequest(data.code);
				if (!request.id || !request.team || !request.message) return;

				request.cmd = 'channel';
				TSSSB.handleDeepLinkWithArgs(JSON.stringify(request));
				return;
			} else {
				origRendererEvalAsync(blob);
			}
		} catch (e) {
		}
	}
}</script><script type="text/javascript">var TSSSB = {
	call: function() {
		return false;
	}
};</script><title>Slack</title><meta name="referrer" content="no-referrer"><meta name="superfish" content="nofish"><meta name="author" content="Slack"><meta name="description" content=""><meta name="keywords" content=""></head><body class="full_height"><nav class="top persistent"><a href="https://slack.com/" class="logo" data-qa="logo" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=logo" aria-label="Slack homepage"></a><ul><li><a href="https://slack.com/is" data-qa="product" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_product">Product</a></li><li><a href="https://slack.com/pricing?ui_step=55&ui_element=5" data-qa="pricing" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_pricing">Pricing</a></li><li><a href="https://get.slack.help/hc/en-us" data-qa="support" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_support">Support</a></li><li class="mobile_btn download_slack"><a href="/get" data-qa="download_slack" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_download">Download Slack</a></li><li><a data-gtm-click="SignUp,optout_nav_create_team" href="https://slack.com/create" class="" data-qa="create_team" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_create_team">Create a new workspace</a></li><li><a href="https://slack.com/get-started" data-gtm-click="optout_nav_find_team" data-qa="find_team" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_find_team">Find your workspace</a></li><li class="sign_in hide_on_mobile"><a data-gtm-click="optout_nav_signin" href="https://slack.com/signin" class="btn_sticky btn_filled" data-qa="sign_in" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_sign_in">Sign in</a></li><li class="mobile_btn mobile_menu_btn"><a href="#" class="btn_sticky" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_mobile_menu_btn">Menu</a></li></ul></nav><nav class="mobile_menu loading menu_scroll" aria-hidden="true"><div class="mobile_menu_wrapper"><div class="mobile_menu_header"><a href="https://slack.com/" class="logo" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_logo"></a><a href="#" class="close" aria-label="close" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_menu_close"><ts-icon class="ts_icon ts_icon_times"></ts-icon></a></div><ul><li><a href="https://slack.com/is" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_product">Product</a></li><li><a href="https://slack.com/pricing?ui_step=55&ui_element=5" class="mobile_nav_pricing" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_pricing">Pricing</a></li><li><a href="https://get.slack.help/hc/en-us" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_support">Support</a></li><li><a href="/get" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_download">Download <span class="optional_desktop_nav_message">the Slack app</span></a></li></ul><ul class="mobile_menu_footer"><li><a href="https://slack.com/signin" data-gtm-click="optout_nav_signin" target="_blank" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_sign_in"><ts-icon class="ts_icon small float_none team_icon ts_icon_plus default signup_icon"></ts-icon><span class="switcher_label">Sign in</span></a></li><li><a data-gtm-click="SignUp,optout_nav_create_team" href="https://slack.com/get-started#/create" class="" target="_blank" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=nav_create_team"><ts-icon class="ts_icon small float_none team_icon c-icon--slack default signup_icon"></ts-icon><span class="switcher_label">Create a new workspace</span></a></li></ul></div></nav><div id="page_contents"><div id="props_node" data-props="{&quot;featureNewxp4147&quot;:false,&quot;experimentNewxp4249&quot;:false,&quot;loggedInTeams&quot;:[],&quot;entryPoint&quot;:&quot;&quot;,&quot;isPlusTeam&quot;:false,&quot;teamName&quot;:&quot;ACCELR&quot;,&quot;teamDomain&quot;:&quot;accelr-net&quot;,&quot;emailJustSent&quot;:false,&quot;showMagicLogin&quot;:false,&quot;shouldRedirect&quot;:true,&quot;redirectURL&quot;:&quot;\/files-pri\/TLXMEFA3X-F014XTV14QH\/top.v&quot;,&quot;redirectQs&quot;:&quot;\/?redir=%2Ffiles-pri%2FTLXMEFA3X-F014XTV14QH%2Ftop.v&quot;,&quot;remember&quot;:false,&quot;hasRemember&quot;:true,&quot;noSSO&quot;:false,&quot;crumbValue&quot;:&quot;s-1591105774-da8cf5d7f6ef770b3955333390dbb86227de20c748a27063bc45e9c9fff05467-\u2603&quot;,&quot;isSSB&quot;:false,&quot;hasPromoOffer&quot;:false,&quot;isSSBSignIn&quot;:false,&quot;isSSBSonicSignIn&quot;:false,&quot;SSBVersion&quot;:&quot;&quot;,&quot;hasEmailError&quot;:false,&quot;emailValue&quot;:&quot;&quot;,&quot;hasPasswordError&quot;:false,&quot;hasAuthReloginFlow&quot;:false,&quot;hasRateLimit&quot;:false,&quot;recaptchaSitekey&quot;:&quot;6LcQQiYUAAAAADxJHrihACqD5wf3lksm9jbnRY5k&quot;,&quot;hasSmsRateLimit&quot;:false,&quot;forgotPasswordLink&quot;:&quot;\/forgot&quot;,&quot;showSignupEmailLink&quot;:true,&quot;getStartedLink&quot;:&quot;https:\/\/slack.com\/get-started&quot;,&quot;loggedOutPasswordResetSentAddress&quot;:&quot;&quot;,&quot;isSSOAuthMode&quot;:false,&quot;isNormalAuthMode&quot;:true,&quot;signinUrl&quot;:&quot;https:\/\/slack.com\/signin&quot;,&quot;signinFindUrl&quot;:&quot;https:\/\/slack.com\/signin\/find&quot;,&quot;ssbRelogin&quot;:&quot;&quot;,&quot;isLoggedOut2fa&quot;:false,&quot;isLoggedOutTeam2fa&quot;:false,&quot;isLoggedOutSelfPasswordReset&quot;:false,&quot;isLoggedOutPasswordReset&quot;:false,&quot;isLoggedOutGodPasswordReset&quot;:false,&quot;isLoggedOutOwnerPasswordReset&quot;:false,&quot;isLoggedOutOwnerSSOReset&quot;:false,&quot;isLoggedOutSSOMaybeRequired&quot;:false,&quot;isLoggedOutRedirect&quot;:true,&quot;teamAuthMode&quot;:null,&quot;authModeGoogle&quot;:&quot;google&quot;,&quot;samlProviderLabel&quot;:null,&quot;errorMissing&quot;:false,&quot;errorNoUser&quot;:false,&quot;errorDeleted&quot;:false,&quot;errorPassword&quot;:false,&quot;errorSSONoOwner&quot;:false,&quot;errorSSONonRA&quot;:false,&quot;errorTwoFactorWrong&quot;:false,&quot;errorSmsRateLimit&quot;:false,&quot;errorConfirmed&quot;:false,&quot;errorNoPassword&quot;:false,&quot;errorTwoFactorState&quot;:false,&quot;errorGoogleOauth&quot;:false,&quot;hasEmailOnDomain&quot;:false,&quot;truncatedEmailDomains&quot;:null,&quot;truncatedEmailDomainsCount&quot;:0,&quot;formattedEmailDomains&quot;:&quot;&quot;,&quot;isReloginFlow&quot;:false,&quot;downloadLinkSigninCTA&quot;:{&quot;linkUrl&quot;:&quot;\/create&quot;,&quot;isDownload&quot;:false},&quot;twoFactorRequired&quot;:false,&quot;usingBackup&quot;:false,&quot;twoFactorType&quot;:null,&quot;twoFactorBackupType&quot;:null,&quot;sig&quot;:null,&quot;authcodeInputType&quot;:&quot;text&quot;,&quot;backupPhoneNumber&quot;:null,&quot;googleSignInRedirectURL&quot;:&quot;https:\/\/accelr-net.slack.com\/signin\/oauth\/google\/start&quot;}"></div></div><footer data-qa="footer"><section class="links"><div class="grid"><div class="col span_1_of_4 nav_col"><ul><li class="cat_1">Using Slack</li><li><a href="/is" data-qa="product_footer" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_product">Product</a></li><li><a href="/enterprise" data-qa="enterprise_footer" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_enterprise">Enterprise</a></li><li><a href="/pricing?ui_step=28&ui_element=5" data-qa="pricing_footer" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_pricing">Pricing</a></li><li><a href="https://get.slack.help/hc/en-us" data-qa="support_footer" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_support">Support</a></li><li><a href="/guides" data-qa="getting_started" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_getting_started">Slack Guides</a></li><li><a href="/apps" data-qa="app_directory" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_app_directory">App Directory</a></li><li><a href="https://api.slack.com/" data-qa="api" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_api">API</a></li></ul></div><div class="col span_1_of_4 nav_col"><ul><li class="cat_2">Slack <ts-icon class="ts_icon_heart"></ts-icon></li><li><a href="/jobs" data-qa="jobs" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_jobs">Jobs</a></li><li><a href="/customers" data-qa="customers" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_customers">Customers</a></li><li><a href="/developers" data-qa="developers" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_developers">Developers</a></li><li><a href="/events" data-qa="events" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_events">Events</a></li><li><a href="https://slackhq.com/" data-qa="blog_footer" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_blog">Blog</a></li></ul></div><div class="col span_1_of_4 nav_col"><ul><li class="cat_3">Legal</li><li><a href="/privacy-policy" data-qa="privacy" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_privacy">Privacy</a></li><li><a href="/security" data-qa="security" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_security">Security</a></li><li><a href="/terms-of-service" data-qa="tos" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_tos">Terms of Service</a></li><li><a href="/policies" data-qa="policies" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_policies">Policies</a></li></ul></div><div class="col span_1_of_4 nav_col"><ul><li class="cat_4">Handy Links</li><li><a href="/downloads" data-qa="downloads" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_downloads">Download desktop app</a></li><li><a href="/downloads" data-qa="downloads_mobile" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_downloads_mobile">Download mobile app</a></li><li><a href="/brand-guidelines" data-qa="brand_guidelines" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_brand_guidelines">Brand Guidelines</a></li><li><a href="https://slackatwork.com" data-qa="slack_at_work" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_slack_at_work">Slack at Work</a></li><li><a href="https://status.slack.com/" data-qa="status" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_status">Status</a></li></ul></div></div></section><div class="footnote"><section><a href="https://slack.com" aria-label="Slack homepage" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_slack_icon"><ts-icon class="c-icon--slack" aria-hidden></ts-icon></a><ul><li><a href="/help/contact" data-qa="contact_us" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_contact_us">Contact Us</a></li><li><a href="https://twitter.com/SlackHQ" data-qa="slack_twitter" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_slack_twitter" aria-label="Slack on Twitter"><ts-icon class="ts_icon_twitter" aria-hidden></ts-icon></a></li><li class="yt"><a href="https://www.youtube.com/channel/UCY3YECgeBcLCzIrFLP4gblw" data-qa="slack_youtube" data-clog-event="WEBSITE_CLICK" data-clog-params="click_target=footer_slack_youtube" aria-label="Slack on YouTube"><ts-icon class="ts_icon_youtube" aria-hidden></ts-icon></a></li></ul></section></div></footer><script type="text/javascript">
/**
 * A placeholder function that the build script uses to
 * replace file paths with their CDN versions.
 *
 * @param {String} file_path - File path
 * @returns {String}
 */
function vvv(file_path) {
		 var vvv_warning = 'You cannot use vvv on dynamic values. Please make sure you only pass in static file paths.'; if (window.TS && window.TS.warn) { window.TS.warn(vvv_warning); } else { console.warn(vvv_warning); } 
	return file_path;
}

var cdn_url = "https:\/\/a.slack-edge.com";
var vvv_abs_url = "https:\/\/slack.com\/";
var inc_js_setup_data = {
	emoji_sheets: {
		apple: 'https://a.slack-edge.com/80588/img/emoji_2017_12_06/sheet_apple_64_indexed_256.png',
		google: 'https://a.slack-edge.com/80588/img/emoji_2017_12_06/sheet_google_64_indexed_256.png',
	},
};
</script><script nonce="" type="text/javascript">	// common boot_data
	var boot_data = {"feature_builder_avatar_crop_enabled":false,"feature_edu88":true,"feature_builder_allow_custom_time_scheduled_trigger":true,"feature_builder_scheduled_trigger":true,"feature_component_animation_wrapper":true,"feature_builder_message_button_helper_text":false,"feature_builder_getting_started_i18n":true,"feature_builder_creation_org_policy":true,"feature_builder_extensions":false,"feature_builder_webhook_admin":true,"feature_builder_webhook_trigger":true,"feature_help_menu_i18n":true,"feature_builder_feedback_button":false,"feature_builder_message_step_rich_text":false,"feature_chime_access_check":true,"feature_app_views_v1":true,"feature_audit_logs_view":false,"feature_audit_logs_view_workspace":false,"feature_org_teams_in_local_config":false,"feature_data_location_new_translations":false,"feature_org_dash_exports_part1":false,"feature_sso_combine_config_preferences":true,"feature_default_browser_control_v2":true,"feature_accessible_selects":false,"feature_slack_kit_neue":true,"feature_builder_disable_global_triggers":true,"feature_workflow_builder_enabled_org_setting":true,"feature_builder_can_access":false,"feature_always_show_archive_channel_option":true,"feature_granular_dnd":false,"feature_custom_dnd_translations":false,"feature_context_bar_tz_issues":false,"feature_newxp_3266":true,"feature_newxp_3848":true,"feature_setup_page_i18n":true,"feature_setup_page_i18n_two":false,"feature_copy_joiner_flow":true,"feature_newxp_3279":true,"feature_newxp_4160":true,"feature_newxp_4014":true,"feature_newxp_4153":true,"feature_newxp_4202":true,"feature_newxp_3994":true,"feature_tinyspeck":false,"feature_olug_esc_channels_work":false,"feature_org_level_user_groups_phase_2_frontend":false,"feature_data_table_in_org_level_user_groups":false,"feature_use_new_list_teams_response":true,"feature_desktop_copy_text":false,"feature_ssb_q319_deprecation":true,"feature_ssb_q319_deprecation_dark":true,"feature_ssb_q319_deprecation_modal":true,"feature_ssb_q319_deprecation_modal_store_override":false,"feature_ssb_q319_deprecation_block":true,"feature_deprecate_get_member_by_name":false,"feature_unknown_files":true,"feature_unknown_messages":true,"feature_add_message_perf":false,"feature_fix_custom_emoji_errors":true,"feature_modern_delete_file":true,"feature_copy_channel_link":true,"feature_collapse_reactions":false,"feature_ia_status_button":true,"feature_full_profile_link":true,"feature_print_pdf":false,"feature_email_workflow":false,"feature_wider_reaction_tip":false,"feature_message_kit_in_message_pane":true,"feature_ia_education":true,"feature_sort_by_recency":false,"feature_channel_details_membership_list":false,"feature_bye_slackbot_help":true,"feature_all_dm_mute_bots":false,"feature_file_threads":true,"feature_broadcast_indicator":true,"feature_new_replies_after_bcast":true,"feature_sonic_emoji":true,"feature_emoji_12":false,"feature_emoji_search_keywords_in_autocomplete":true,"feature_email_ingestion":false,"feature_attachments_inline":false,"feature_fix_files":true,"feature_aaa_admin_apis":true,"feature_app_action_picker_frecency":true,"feature_shortcuts_speedbump":true,"feature_pad_1383":false,"feature_shortcuts_in_quickswitcher":true,"feature_app_launcher_add_icon":false,"feature_app_launcher_banners":false,"feature_app_launcher_search_pagination":false,"feature_help_test_primer":true,"feature_shortcuts_menu_height_tweak":false,"feature_shortcuts_app_collection_links":false,"feature_channel_sidebar_drafts_section":true,"feature_navigate_history":true,"feature_time_zone_desc":false,"feature_wysiwyg_unlink":true,"feature_custom_status_modal_updates":true,"feature_custom_recent_statuses":false,"feature_convert_wrapped_whitespace":true,"feature_compose_flow":false,"feature_compose_flow_xws":true,"feature_temp_channel_subscriptions":true,"feature_faster_count_all_unreads":true,"feature_sonic_user_groups":false,"feature_channel_selector_for_team_guests_update":true,"feature_admin_member_csv_update":true,"feature_sk_data_table_a11y":false,"feature_desktop_symptom_events":false,"feature_data_residency_debugging":false,"feature_ent_admin_approved_apps_v2":true,"feature_dashboard_sortable_lists":false,"feature_sk_loading_button_motions":true,"feature_sk_base_icon":false,"feature_sk_basic_select_arialabel":false,"feature_ce_eng_search_demo":false,"feature_ce_eng_contact_huck_gold":true,"feature_ce_eng_contact_purple_peruvian":false,"feature_ce_eng_contact_high_volume_banner":true,"feature_calls_shared_channel_invite":true,"feature_shared_channels_multi_org":false,"feature_shared_channels_multi_org_mpim":false,"feature_shared_channels_multi_org_mpim_fe":false,"feature_chat_mpim_open_refactor_log_verbose":false,"feature_chat_mpim_open_refactor_full":true,"feature_chat_mpim_open_refactor_fe_copy":false,"feature_multi_org_reconnect_mpim":false,"feature_multi_org_disconnect_mpim":false,"feature_multi_org_disconnect_messages_copy":true,"feature_find_an_admin_disconnect_explainer":false,"feature_multi_org_disconnect_in_msc":true,"feature_shared_channels_multi_org_invites_be":false,"feature_multi_org_join_messages_copy":true,"feature_multi_org_invites_messages_copy":true,"feature_multi_org_invite_unfurl":false,"feature_shared_channels_reconnect":true,"feature_multi_org_accept_flow_copy":true,"feature_manage_sc_channel_card":true,"feature_shared_channels_multi_org_qa_limit_override":false,"feature_remove_double_rings":false,"feature_remove_double_diamonds":false,"feature_remove_pending_connections":true,"feature_channels_view_in_msc":false,"feature_share_option_additional_options":true,"feature_create_private_c_channels":false,"feature_gdpr_user_join_tos":true,"feature_user_invite_tos_april_2018":true,"feature_channel_mgmt_phase_three":true,"feature_channel_mgmt_phase_four":false,"feature_neue_type":false,"feature_cust_acq_i18n_tweaks":false,"feature_product_ui_text_bar":false,"feature_whats_new_shortcuts_gtm":true,"feature_whitelist_zendesk_chat_widget":false,"feature_live_support_free_plan":false,"feature_offline_mode":false,"feature_force_ls_compression":false,"feature_use_imgproxy_resizing":true,"feature_share_mention_comment_cleanup":false,"feature_disable_bk_in_thread":false,"feature_new_locale_toast":true,"feature_channel_exports":false,"feature_docs_mentions_and_channels":false,"feature_docs_gantry_v2":false,"feature_vacation_delight":true,"feature_threads_unread_translations":false,"feature_calls_esc_ui":true,"feature_calls_survey_request_response":true,"feature_remote_files_api":true,"feature_token_ip_whitelist":true,"feature_sidebar_theme_undo":true,"feature_hide_on_startup":true,"feature_allow_intra_word_formatting":true,"feature_i18n_channels_validate_emoji":true,"feature_fw_eng_normalization":true,"feature_slim_scrollbar":false,"feature_primary_search":false,"feature_modern_sounds":false,"feature_quick_copy_code_blocks":false,"feature_sli_channel_archive_suggestions":true,"feature_steeple_church":true,"feature_steeple_church_link":true,"feature_steeple_church_ext":true,"feature_strollers_to_perch":true,"feature_fantail_nurture":true,"feature_pourover":false,"feature_people_search":false,"feature_react_messages":true,"feature_edge_upload_proxy_check":true,"feature_legacy_file_upload_analytics":true,"feature_sonic_find_more_wksps":false,"feature_sonic_inputs":false,"feature_threaded_slack_owned_plugins":true,"feature_app_popouts_i18n":false,"feature_snippet_modes_i18n":false,"feature_gdrive_do_not_install_by_default":true,"feature_ekm_backfill_add_sleep":false,"feature_ekm_message_revocation_polling_test":false,"feature_team_admins_list_api":true,"feature_ms_latest":true,"feature_guests_use_entitlements":true,"feature_app_canvases":false,"feature_rooms_join_api":false,"feature_rooms_join_url":false,"feature_calls_sip_integration_labels":false,"feature_tasks_v1_copy":false,"feature_app_home_admin_pages":false,"feature_feature_custom_status_calendar_sync_copy":false,"feature_app_actions_admin_pages":true,"feature_app_views_reminders":true,"feature_reminders_org_shard":true,"feature_reminders_grid_migrations_org_shard":true,"feature_blocks_reminders_list":false,"feature_message_blocks":false,"feature_silence_app_dms":false,"feature_set_tz_automatically":true,"feature_confirm_clear_all_unreads_pref":true,"feature_block_mounts":true,"feature_attachments_v2":true,"feature_block_kit_expandable_block":false,"feature_group_block":false,"feature_block_kit_deep_links":true,"feature_show_block_kit_in_share_dialogs":false,"feature_block_kit_event_block":false,"feature_block_kit_user_block":false,"feature_block_kit_radio_buttons":true,"feature_mrkdwn_on_radio_button":true,"feature_block_kit_table":false,"feature_block_kit_range_datepicker":false,"feature_block_kit_timepicker":false,"feature_block_kit_timepicker_remind":false,"feature_block_kit_datepicker_input":false,"feature_block_kit_builder_gantry":true,"feature_add_app_home_team_name":false,"feature_beacon_js_errors":false,"feature_beacon_js_admin_errors":false,"feature_user_app_disable_speed_bump":true,"feature_tractor_shared_invite_link":true,"feature_newxp_2119":true,"feature_tractor_backup_channelname_copy":true,"feature_degraded_rtm_always_fails":false,"feature_apps_manage_permissions_scope_changes":true,"feature_reminder_cross_workspace":true,"feature_p2p":false,"feature_global_nav":false,"feature_global_nav_rollback":false,"feature_classic_nav":false,"feature_new_reactions":true,"feature_pages_example":false,"feature_sonic_pins":false,"feature_sonic_video_placeholder":true,"feature_iap1":false,"feature_ia_ga":true,"feature_ia_debug_off":false,"feature_ia_i18n":false,"feature_ia_themes":true,"feature_ia_member_profile":false,"feature_sonic_hard_reload":true,"feature_workspace_scim_management":false,"feature_unified_member":false,"feature_turn_mpdm_notifs_on":true,"feature_desktop_reload_on_generic_error":true,"feature_dolores":false,"feature_desktop_force_production_channel":false,"feature_desktop_logs_upload":true,"feature_macos_disable_hw":true,"feature_quill_cjk_code_block":true,"feature_bots_not_members":true,"feature_wta_stop_creation":true,"feature_m11n_channel_details":false,"feature_channel_actions":true,"feature_channel_actions_client":true,"feature_shortcuts_prompt":true,"feature_accessible_dialogs":true,"feature_accessible_emoji_skin_tone_picker":true,"feature_calls_clipboard_broadcasting_optin":true,"feature_screen_share_needs_aero":false,"feature_accessible_fs_dialogs":true,"feature_channel_header_labels":false,"feature_trap_kb_within_fs_modals":true,"feature_modern_image_viewer":true,"feature_emoji_by_id":true,"feature_mc_migration_banner":true,"feature_aria_application_mode":false,"feature_update_multiworkspace_channel_modal":true,"feature_modern_request_workspace_dialog":false,"feature_workspace_apps_manage_gantry":false,"feature_app_settings_gantry":false,"feature_modern_profile_flexpane":false,"feature_scg_conversion_channels":true,"feature_reduce_unexpected_uninstalls":true,"feature_enterprise_retention_allow_override_on_org_level_channels":false,"feature_track_time_spent":true,"feature_channel_invite_tokenization":true,"feature_imports_cancel":true,"feature_email_workobject_ui":false,"feature_email_notify":false,"feature_email_private":true,"feature_office_directory":false,"feature_calendar_simple_agenda_view":false,"feature_analytics_enable_division":false,"feature_enterprise_analytics_apps_tab":false,"feature_enterprise_analytics_2019_q1_update":true,"feature_insights_allow_access_to_app":false,"feature_insights_comms_impact_message_stats":true,"feature_insights_message_activity_admin":true,"feature_insights_message_activity_demo":false,"feature_team_themes":false,"feature_org_level_messages":false,"feature_unfurl_metadata":false,"feature_paperclip_coachmark_experiments":true,"feature_plus_menu_add_apps_link":false,"feature_recent_files_omnipicker":false,"feature_link_protocol_beta":false,"feature_stripe_billing":true,"feature_stripe_billing_renewal":true,"feature_stripe_invoices":true,"feature_stripe_billing_dunning":true,"feature_stripe_light":true,"feature_stripe_light_rest_of_world":true,"feature_stripe_light_legacy_purchase_mode":false,"feature_checkout_force_into_legacy":false,"feature_tax_refactor":true,"feature_sonic_placeholder_labels":false,"feature_sonic_esc_creation":false,"feature_dangerously_guard_ia_translations":false,"feature_ia_context_menus":true,"feature_ia_layout":true,"feature_platform_calls_api":true,"feature_threaded_call_block":false,"feature_slack_message_attachment_tooltip":false,"feature_enterprise_mobile_device_check":true,"feature_newxp_4125":true,"feature_newxp_4127":true,"feature_newxp_4233":true,"feature_newxp_4250":true,"feature_newxp_4101":false,"feature_shared_channels_custom_emojis_url":false,"feature_new_copy_for_identity_basic":false,"feature_sonic_leave_workspace_dialog":false,"feature_shared_channels_new_user_trial":true,"feature_shared_channels_inviter_trial":false,"feature_shared_channels_inviter_trial_baby_teams":false,"feature_shared_channels_email_invite":true,"feature_shared_channels_shortcut":true,"feature_shared_channels_90_day_trial":true,"feature_shared_channels_90_day_trial_inviter":false,"feature_shared_channels_skip_choose_team":true,"feature_shared_channels_invites_internal":true,"feature_shared_channel_invites_v2":true,"feature_better_invites_call_v2_api":true,"feature_shared_channels_invite_create_education":false,"feature_paid_onboarding_pageupdate":true,"feature_trace_webapp_init":true,"feature_trace_jq_init":false,"feature_stripe_completely_down_banner":false,"feature_group_calls_discovery":false,"feature_uae_tax_id_collection":false,"feature_chile_tax_id_collection":false,"feature_ksa_tax_id_collection":false,"feature_malaysia_tax_email":true,"feature_malaysia_tax_assessment":true,"feature_japan_tax_billing_statements":true,"feature_singapore_tax_email":true,"feature_enterprise_analytics_2019_q3_enhancements":false,"feature_org_level_apps":false,"feature_sso_validate_audience":true,"feature_channel_sections":true,"feature_channel_sections_sidebar_behavior_ui":false,"feature_global_actions_v0":false,"feature_search_limit_team_filter":true,"feature_analytics_scim_fields_paid":false,"feature_google_directory_invites":false,"feature_migrate_google_directory_apis":true,"feature_help_center_incident_banner":true,"feature_scg_error_message":true,"feature_search_results_virtualized":false,"feature_show_email_forwarded_by":false,"feature_new_enough_periodic_reloads":false,"feature_iap1_downloads":true,"feature_jump_to_date_divider":true,"feature_builder_display_export_form_csv":true,"feature_builder_workflow_activity":false,"feature_builder_export_form_csv_admin":true,"feature_new_billing_emails_translations":true,"feature_new_billing_emails_translations_part_two":true,"feature_channel_mgmt_phase_one":true,"feature_channel_mgmt_phase_two":true,"feature_org_dash_deactivated_members":false,"feature_rate_limit_app_creation":true,"feature_giphy_shortcut":true,"feature_shared_channels_home_reminders":true,"feature_shared_channels_away_reminders":true,"feature_feat_say_my_name":false,"feature_put_a_mention_on_it":false,"feature_builder_fe_ekm_enabled":false,"feature_mobile_min_app_version_frontend":false,"feature_covid_contact":true,"feature_browser_picker":true,"feature_focus_transition_manager":false,"feature_edu_101":false,"feature_newxp_3172":true,"feature_parsec_methods":false,"feature_soul_searchers":false,"feature_newxp_4309":false,"feature_email_classification":false,"feature_primary_owner_consistent_roles":false,"feature_invite_to_channel_by_email_ui":false,"feature_invite_to_workspace":false,"feature_focus_transition_messages":false,"feature_newxp_4350":true,"feature_edu_110":false,"experiment_assignments":{},"no_login":false};</script><script type="text/javascript" src="https://a.slack-edge.com/bv1-8-8cacda2/primer-vendor.b1f0600.primer.min.js" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"></script><script type="text/javascript" src="https://a.slack-edge.com/bv1-8-8cacda2/login-core.88298eb.primer.min.js" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous"></script><link href="https://a.slack-edge.com/bv1-8-8cacda2/login-core.88298ebc3eb4ee4c40bc.bundle.css" rel="stylesheet" type="text/css" onload="window._cdn ? _cdn.ok(this, arguments) : null" onerror="window._cdn ? _cdn.failed(this, arguments) : null" crossorigin="anonymous">

<!-- slack-www-hhvm-main-iad-2w4m/ 2020-06-02 06:49:34/ v74b14d70675ab27efe6f03f93ecaa781ad740a58/ B:H -->

</body></html>