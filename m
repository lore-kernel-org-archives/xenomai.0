Subject: RE: [Xenomai-help] Kernel-OOps
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01B5387C@is-hdq-exchange.marel.net>
References: <DD39B5C3F4963040ADC9768BE7E430CB01B5368C@is-hdq-exchange.marel.net>
	<DD39B5C3F4963040ADC9768BE7E430CB01B536B3@domain.hid>
	<1172587094.27967.10.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B53705@domain.hid>
	<1172603004.10171.24.camel@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01B5387C@is-hdq-exchange.marel.net>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 11:35:14 +0100
Message-Id: <1172658914.23961.9.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

On Wed, 2007-02-28 at 08:59 +0000, Daniel Schnell wrote:
> Philippe Gerum wrote:
> > 
> > It's not a magic value, it means that up to 32 memory contexts may be
> > stalled in the drop queue at any point in time, waiting for a normal
> > Linux task to be switched in to flush them, while a large number of
> > Xenomai threads is going through frequent domain migrations. Hitting
> > this limit _is_ where the problem lies, not the static limit itself,
> > and it tells that something needs to be fixed in the application, so
> > that it does not starve the regular Linux activities this way.      
> > 
> > IOW, it's ok to raise this compile-time value to account for
> > applications living on the edge, but we should not make a feature out
> > of an application design issue, by adding such a configuration knob.  
> 
> 
> I do not understand. In my opionion no application behaviour should ever
> cause the Kernel to oops. Playing around with Kernel configuration
> values, to come around such Oopses is where the problem lies and not in
> the application itself. I do nat have fully understood what exactly does
> the Kernel cause to oops in this specific case, but a killall of an
> application is similar to e.g. a caught SIGSEGV, which might happen in
> normal development, and looks very weird if it leads to a Kernel crash
> whatsoever. In my opinion the BUG_ON() call inside sched.c is a bug and
> should be replaced by something that handles the situation more
> gracefully.
> 

In theory, you might be right. In practice, there is no way to be 100%
sure that under such situation, the wipe out would succeed, _that_ is
the problem. We could devise something with a watermark, starting to
spam the syslog with warning messages after some pressure level is
reached, but even the wipe out operation would have to follow the OOM
"strategy", i.e. not necessarily killing the real offending application
but any random thread which happens to be registered in the drop queue,
which is terminally useless when debugging.

Again, the situation you encounter is a sign of a patent dysfunctioning
due to a design issue in your application. We could raise the limit so
that statistically, the issue would not even trigger in your case, like
it never triggered for anyone else for the last two years. But, for that
particular issue occurring in sched.c, there is nothing 100% safe and
sane we could do to recover such situation, so let's not pretend that a
system works just because it does not run into any BUG_ON(). As it is,
your application is living on the edge, and this is what you need to
solve, and for that purpose, a BUG_ON() which points you at the problem
immediately during the testing phase is much better that killing any
thread around randomly while in production, just for the purpose of
"being graceful". This would not be graceful, at all.

> 
> 
> Best regards,
> 
> Daniel Schnell.
-- 
Philippe.



