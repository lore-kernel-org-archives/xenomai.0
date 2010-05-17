From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1274047063.2972.1.camel@domain.hid>
References: <181804936ABC2349BE503168465576460EBD5C0D@exchserver.basler.com>
	<1274047063.2972.1.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 17 May 2010 23:32:30 +0200
Message-ID: <1274131950.2972.41.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_task_sleep causing crashes on PowerPC
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steve Deiters <SteveDeiters@domain.hid>
Cc: xenomai@xenomai.org

On Sun, 2010-05-16 at 23:57 +0200, Philippe Gerum wrote:
> On Fri, 2010-05-14 at 19:18 -0500, Steve Deiters wrote:
> > I am running Xenomai 2.5.3, I-pipe version 2.9-00, with Linux 2.6.33.4
> > on a PowerPC MPC5121.  With small values of sleep ticks passed to
> > rt_task_sleep, I get various sorts of crashes.  Here is a simple program
> > using a delay loop that exhibits the behavior.
> 
> <snip>
> 
> > 
> > I'm not sure if I have something misconfigured or what.  I am upgrading
> > from Xenomai 2.4.10 on an older kernel and I did not have this same
> > problem.
> > 
> 
> Bug confirmed here. Your setup is not involved, I'll send a fix asap.

It turned out to be a stack overflow issue, which could happen under
very high IRQ pressure with unlocked context switch enabled. In short,
the smaller the tick passed in your example, the more likely the Xenomai
rescheduling code to accept another IRQ while switching thread contexts,
then enter a deadly recursive rescheduling loop, eating the underlying
stack space up to a complete overflow.

For that to happen, a significant (i.e. long enough) IRQ burst must hit
the system at a frequency which is higher than what the platform can
cope with, or at least close to the limit.

rt_task_sleep() is not directly involved in the bug, it just happened to
trigger the next incoming timer IRQ, but any timed service would have
caused the same issue, or any external IRQ flood leading some interrupt
handler to raise the need-to-reschedule bit continuously.
 
Please try this fix:
http://git.xenomai.org/?p=xenomai-rpm.git;a=commit;h=5f1d30a5da27b7f57c486a3a25caf3c26a709073

If you don't want to patch your tree yet, a work around for this bug is
to disable the support for unlocked context switching from the "Machine"
menu (CONFIG_XENO_HW_UNLOCKED_SWITCH).

The bad news is that all archs implementing unlocked context switching
are affected by this bug in all 2.5.x releases, meaning arm and powerpc
for now. The good news, is... Crap. There is no good news.

PS: Xenomai 2.4.x is immune to this bug (it does not have unlocked
context switching support in the first place).

-- 
Philippe.



