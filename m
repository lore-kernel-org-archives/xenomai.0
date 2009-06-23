From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4A40A273.1050505@domain.hid>
References: <1243526358.898.21.camel@domain.hid>
	<1243529533.22173.6.camel@domain.hid> <1243533530.898.36.camel@domain.hid>
	<1243547223.22173.54.camel@domain.hid> <1245677021.9238.6.camel@domain.hid>
	<1245749419.3986.165.camel@domain.hid>  <4A40A273.1050505@domain.hid>
Content-Type: text/plain
Date: Tue, 23 Jun 2009 12:23:37 +0200
Message-Id: <1245752617.3986.166.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Running out of stack memory in kernel-space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org, Andreas Glatz <AndreasGlatz@domain.hid>

On Tue, 2009-06-23 at 11:37 +0200, Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
> > On Mon, 2009-06-22 at 09:23 -0400, Andreas Glatz wrote:
> >> 1) In the legacy code I am porting, critical sections are
> >> protected by disabling/enabling ALL interrupts (like
> >> sti/cli in kernel-space). This method is much faster than
> >> locking a mutex, which might put a task to sleep.
> > 
> > Usually yes, but at the expense of wrecking the priority-based model of
> > the RTOS when misused.
> > 
> >>  Are there
> >> similar, portable functions available under Xenomai or IPIPE?
> > 
> > You should never rely directly on I-pipe features, using a Xenomai
> > interface is the way to go.
> > 
> > If writing driver code based on RTDM (the recommended way), see there:
> > http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__rtdmsync.html
> > 
> > Otherwise, if you are writing ad hoc application code in kernel space,
> > which is asking for trouble (yeah, I can't help it, sorry), you will
> > have to resort to core services from the Xenomai nucleus directly: see
> > splhigh(), splexit(), xnlock_get[irqsave], xnlock_put[_irqrestore].
> > Regarding the second form, you may notice a pre-defined lock called
> > "nklock", which is used by the nucleus internally. You may use it at
> > your own risk (basically introducing more latency if misused), but you
> > may also define your own RT spinlock based on the xnlock_t type, taking
> > care of possible locking order issues with the nklock.
> > see include/asm-generic/system.h.
> 
> The rule of thumb is: if you need to reschedule while holding an xnlock,
> then this xnlock must be the nklock. Otherwise, you will be in trouble.

Actually, the real rule of thumb is: do not call into any Xenomai
services holding this lock, unless you really know what you are doing.

> 
-- 
Philippe.



