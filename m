Message-ID: <4A044932.1010005@domain.hid>
Date: Fri, 08 May 2009 17:01:06 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OFBB398D5A.1ED06DE3-ONC12575B0.00262F81-C12575B0.0026A81A@datacon.at>
In-Reply-To: <OFBB398D5A.1ED06DE3-ONC12575B0.00262F81-C12575B0.0026A81A@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

henning.richter@domain.hid wrote:
> So here are some more results.
> The switchtest is now working with the enabled kernel option.
> My adeos Ipipe version is 2.2-06.
> I run both, latency and switchtest, in graphical mode.
> I send you my .config in a seperate mail, as there where problem the last
> time.

Ok. The working switchtest is a good news.
The latency results are a bit high, if they are taken on an idle system
(only latencies taken on a busy system are meaningful), do not you get a
message in kernel console talking about SMIs ? In any case, we do not
see the same results as your application, so, the cause of the latencies
observed by your application is not Xenomai latencies.

and:
> Here the .config as plain text.

Nope, your mailer still sends your mail with twice its body: once in
plain text, once in HTML. This is pure bandwith waste for the few
hundred people subscribed to the list, and this makes people think that
your mail is spam, because spam is usually HTML too. Please switch your
mailer to plain text instead.

As for the config itself you should disable CONFIG_X86_PM_TIMER.


and also:
> Things are still strange.
> The 'freeze' still appears sporadically, but only in graphical mode.
> When I login via console I don't get any freeze.

Ok. As I already told you, if when you see freezes the keyboard leds
blink, it means that what you have is a BUG, an oops, or a kernel panic.
In any case, the kernel console will tell us what happens. Try to get
the kernel console through a serial cable, or if not possible using the
less reliable netconsole.

-- 
					    Gilles.

