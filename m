From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <46F60EF1.9030009@domain.hid>
References: <46F0E315.10306@domain.hid> <1190235866.9745.21.camel@domain.hid>
	<46F60EF1.9030009@domain.hid>
Content-Type: text/plain
Date: Sun, 23 Sep 2007 10:13:43 +0200
Message-Id: <1190535223.6125.35.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Adeos-main] [PATCH] fix irq statistics
Reply-To: rpm@xenomai.org
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: adeos-main@gna.org

On Sun, 2007-09-23 at 09:00 +0200, Jan Kiszka wrote:
> Philippe Gerum wrote:
> > On Wed, 2007-09-19 at 10:51 +0200, Jan Kiszka wrote:
> >> Hi,
> >>
> >> IRQ hit counters are broken in latest I-pipe 1.10-x for the wired path. 
> >> This patch moves the counter maintenance out of __ipipe_set_irq_pending 
> >> and instead makes it explicit at the required spots.
> > 
> > I would rather add the missing accounting code as below. Marking an
> > interrupt as pending using the __ipipe_set_irq_pending() interface
> > should implicitely be paired with proper accounting.
> 
> My original intention was to keep __ipipe_dispatch_wired compact.

Yes, but my intention in moving this code out of line is to gather
bitmap management and accounting.

> 
> But thinking about this again, I wonder if the whole thing makes sense
> as it is implemented right now: Given that I-pipe users like Xenomai now
> use this irqall counter as high-level hit counter, I'm not that sure we
> should also account for IRQ events on locked lines or in case of stalled
> receiver domains. Only _delivery_, ie. handler invocation, should be
> counted IMO (=>__ipipe_run_isr). What do you think?
> 

Now that the interrupt log is flat, we do not have any pending IRQ
counter anymore. So the only way to determine how many interrupts are
actually waiting for being processed is to substract the irq_all value
from a private dispatch counter maintained by the client code from its
own handlers. So regardless of what Xenomai does now, I would rather
keep this option open, so that domains may compute this information on
their own.

> Jan
> 
-- 
Philippe.



