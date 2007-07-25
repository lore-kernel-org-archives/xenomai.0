Message-ID: <46A736CB.1080502@domain.hid>
Date: Wed, 25 Jul 2007 13:40:59 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <16123805.1184916759093.JavaMail.ngmail@domain.hid>	
	<1184890451.28303.356.camel@domain.hid>
	<1184852543.28303.67.camel@domain.hid>	
	<24703926.1184851660664.JavaMail.ngmail@domain.hid>	
	<32098568.1184853156077.JavaMail.ngmail@domain.hid>	
	<25782679.1184932464850.JavaMail.ngmail@domain.hid>	
	<1184933771.5998.3.camel@domain.hid>
	<1185202908.5998.271.camel@domain.hid>
In-Reply-To: <1185202908.5998.271.camel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] RPI is good for you
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: "M. Koehrer" <mathias_koehrer@domain.hid>, xenomai@xenomai.org

Philippe Gerum schrieb:
> On Fri, 2007-07-20 at 14:16 +0200, Philippe Gerum wrote: 
>> On Fri, 2007-07-20 at 13:54 +0200, M. Koehrer wrote:
>>> Hi Philippe,
>>> I left my test running for a couple of hours - no freeze so far... 
>>>
>>> However, I have to do some other stuff on this machine, I have to stop the test now...
>>>
>> Ok, thanks for the feedback. I will send an extended patch later today,
>> so that you could test it on a longer period when you see fit.
> 
> It took me a bit longer than expected, but here is a patch which
> addresses all the pending issues with RPI, hopefully (applies against
> 2.3.1 stock).
> 
> The good thing about Jan grumbling at me, is that this usually makes me
> look at the big picture anew. And the RPI picture was not that nice,
> that's a fact.
> 
> Beside the locking sequence issue, the ex-aequo #1 problem was that CPU
> migration of Linux tasks causing a RPI boost had some very nasty
> side-effects on RPI management, and would create all sort of funky
> situations I'm too shameful to talk about, except under the generic term
> of "horrendous mess".
> 
> Now, regarding the deadlock issue, suppressing the RPI-specific locking
> entirely would have been the best solution, but unfortunately, the
> migration scheme makes this out of reach, at least without resorting to
> some hairy and likely unreliable implementation. Therefore, the solution
> I came with consists of making the RPI lock a per-cpu thing, so that
> most RPI routines are actually grabbing a _local_ lock wrt the current
> CPU, those routines being allowed hold the nklock as they wish. When
> some per-CPU RPI lock is accessed from a remote CPU, it is guaranteed
> that _no nklock_ may be held nested. Actually, the remote case only
> occurs once, in rpi_clear_remote(), and all its callers are guaranteed
> to be nklock-free (a debug assertion even enforces that).

Yeah, it is actually safe against deadlocks now. Still, I wonder why we 
can't design xnshadow_rpi_check like this:

	...
	int need_renice = 0;

	xnlock_get_irqsave(&rpislot->lock, s);

	if (sched_emptypq_p(&rpislot->threadq) &&
	    xnpod_root_priority() != XNCORE_IDLE_PRIO)
		need_renice = 1;

	xnlock_put_irqrestore(&rpislot->lock, s);

	if (need_renice)
		xnpod_renice_root(XNCORE_IDLE_PRIO);


If we can avoid nesting (even if it's safe), we should do so. Or does 
this pattern here introduce new, ugly race possibility?

Jan

