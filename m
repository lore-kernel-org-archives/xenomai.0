From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1241700440.6157.15.camel@domain.hid>
References: <1043994168.4085071240493189508.JavaMail.root@domain.hid>
	<49F06D77.7050103@domain.hid> <1241695394.6157.7.camel@domain.hid>
	<4A02D4C2.3060009@domain.hid>  <4A02D609.2010202@domain.hid>
	<1241700440.6157.15.camel@domain.hid>
Content-Type: text/plain
Date: Thu, 07 May 2009 15:03:00 +0200
Message-Id: <1241701380.26544.724.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Problem of freeze
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Raistlin <raistlin@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@domain.hid>

On Thu, 2009-05-07 at 14:47 +0200, Raistlin wrote:
> On Thu, 2009-05-07 at 14:37 +0200, Gilles Chanteperdrix wrote:
> > > As usual, please send us /proc/interrupts, /proc/xenomai/irq, your
> > > .config, and the version of the I-pipe patch you use.
> > > 
> I will.
> 
> > > Run the latency and switchtest tests, and tell us if you have the freeze
> > > with them too.
> > 
> It has happened once during a test (latency I think), but I've also been
> (next times, after reboot) able to run both of them without any issue.
> 
> Anyway, as soon as I reboot I'll run all the tests again.
> 
> > Also, Benoit's problem was not in fact due to xenomai but to gnome power
> > management. 
> I see... Well, of course, all is possible... I'm using
> gnome-power-manager too, but while running plain Ubuntu kernel no freeze
> happens, but... I mean... Who knows?!?!

The point is not about blaming Gnome PM, but we do know for sure that
power management related drivers may have adverse effects on a
Xenomai-patched kernel - see the troubleshooting guide. If your kernel
enable those, and Gnome PM triggers actions on those such as CPU freq
governors, bad things may happen.

You .config will confirm or not whether this assumption is correct.

> 
> > This shows that the notion of "freeze" is very vague, and
> > without further information, we can not tell you more.
> I know, and I'm sorry of being able to be more specific since now. :-(
> I'll test it deeper and let you know in detail.
> 
> For now, thanks a lot for your support! :-)
> 
> Regards,
> Dario
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



