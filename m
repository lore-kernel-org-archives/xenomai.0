Date: Mon, 3 May 2004 10:03:14 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Subject: Re: [Adeos-main] 2.6.5 + vesuvio + gcc-3.4.0 = success
In-Reply-To: <1083517623.683.73.camel@domain.hid>
Message-ID: <Pine.LNX.4.53.0405030949360.25142@domain.hid>
References: <Pine.LNX.4.53.0405021911080.23891@domain.hid>
 <1083517623.683.73.camel@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main@gna.org

On Sun, 2 May 2004, Philippe Gerum wrote:

:> The rtai_up examples works ok, but lxrt scheduler failed (box freezed
:> solid while starting XFree 4.4.0 and running lxrt latency test).
:
:As far as I can remember, starting the X server while a RT app is
:running always crashed the box. There must be something in the card
:support messing with the interrupt machinery well beyond the real-time
:layer can bear...

 Yes you may be right (XFree 4.4.0 issued cli/sti and can hold cpu bus in
any time - depends from the m/b and video card chipset combination), but
kernel mode latency example working like a sharm while X server
started/exited. Anyway framebuffer X gives the smallest and stablest
latencies in the linux/RTAI world.

:However, we made good progress on vesuvio last week, and now the full
:stack works in UP+SMP, including with the preemptible kernel support
:enabled.

Several comments to vesuvio branch :

 - the 2.6 kernel has an option to compile ctitical funcs with
	gcc regparm(3) attribute, the help says that even kernel modules
	need to be compiled with this attribute. So vesuvio ignores this
	config option and this resulted in box crash while simple
	inserting the rtai_hal module.
 - I tried to rem CONFIG_MODVERSIONS check in configure - no problems at
	all.

:Thanks, but it was not deliberate! Nah, just kidding... :o)
:

Welcome to Linux 2.6 world my dear RTAI ! Yea, kidding too ... ;)

:
:

		Rus

