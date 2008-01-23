Message-ID: <2ff1a98a0801230953m2a67e614s6c921b3b6ec77c3c@domain.hid>
Date: Wed, 23 Jan 2008 18:53:43 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <47977DE1.8060207@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2ff1a98a0801020231k19be7d89k1a6f04b7d497cc34@domain.hid>
	<18315.63245.160672.547658@domain.hid>
	<18326.21480.397736.413726@domain.hid>
	<47977DE1.8060207@domain.hid>
Subject: Re: [Xenomai-core] High latencies on ARM.
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
Cc: xenomai-core <xenomai@xenomai.org>

On Jan 23, 2008 6:48 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> Gilles Chanteperdrix wrote:
> > Gilles Chanteperdrix wrote:
> >  > Please find attached a patch implementing these ideas. This adds some
> >  > clutter, which I would be happy to reduce. Better ideas are welcome.
> >  >
> >
> > Ok. New version of the patch, this time split in two parts, should
> > hopefully make it more readable.
> >
>
> Ack. I'd suggest the following:
>
> - let's have a rate limiter when walking the zombie queue in
> __xnpod_finalize_zombies. We hold the superlock here, and what the patch
> also introduces is the potential for flushing more than a single TCB at
> a time, which might not always be a cheap operation, depending on which
> cra^H^Hode runs on behalf of the deletion hooks for instance. We may
> take for granted that no sane code would continuously create more
> threads than we would be able to finalize in a given time frame anyway.

The maximum number of zombies in the queue is
1 + XNARCH_WANT_UNLOCKED_CTXSW, since a zombie is added to the queue
only if a deleted thread is xnpod_current_thread(), or if the XNLOCKSW
bit is armed.

>
> - We could move most of the code depending on XNARCH_WANT_UNLOCKED_CTXSW
>  to conditional inlines in pod.h. This would reduce the visual pollution
> a lot.

Ok, will try that, especially since the code added to the 4 places
where a scheduling tail takes place is pretty repetitive.

-- 
                                               Gilles Chanteperdrix

