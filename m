From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4651C70E.8080908@domain.hid>
References: <465099CE.2010004@domain.hid>  <4651AFF9.5030402@domain.hid>
	<1179763621.473.145.camel@domain.hid>  <4651C70E.8080908@domain.hid>
Content-Type: text/plain
Date: Mon, 21 May 2007 18:51:50 +0200
Message-Id: <1179766310.473.168.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-core] [BUG] module_put called over non-root domain
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2007-05-21 at 18:21 +0200, Jan Kiszka wrote:
> > 
> > This code has to work with an awful lot of runtime situations, including
> > those raised by ptracing/GDB, and thread signaling in general, so test
> > harnessing is key here.
> 
> Well, what about listing those scenarios and their requirements in a
> comment if this is so critical?

Eh, because I'm likely lazy as you are? :o>

>  That may make /me feel better as I could
> more easily go through them and check changes like those of today
> against them.
> 

Those situations have been encountered when debugging, there is no
limited set of golden rules to document, I'm afraid, this would have
been far too easy. The entire signal handling wrt ptracing is a terrible
mess - somebody must have endured a very bad Karma to implement this the
way it is (long life utrace). The ChangeLog might be a good start for
comments related to fixes in shadow.c/unmap and various head banging
sessions I went through regarding this (2.4/2.6).

> > 
> >>  and I'm furthermore
> >> not sure of the old code was handling SMP scenarios safely (What if the
> >> thread to be unmapped was running on different CPU than xnshadow_unmap?
> >> How to ensure test-atomicity then?).
> >>
> > 
> > This wakeup call is there to release emerging shadows waiting on their
> > start barrier that get killed before start. Other regular cases imply
> > that either the current thread is exiting - in which case this is a no
> > brainer, or it has been sent a group kill signal, in which case it has
> > to wake up anyway.
> 
> I didn't _removed_ cases where the wakeup takes place, I _added_ some
> more my removing the test.
> 

In the light of what I have just written, you would only cause useless
wakeups doing so.

> > 
> >> Well, this thing seems to work,
> > 
> > It does, actually.
> > 
> >>  but it doesn't leave me with a good
> >> feeling. IMHO, there are far too many cleanup cases with all the
> >> combinations of non-shadow termination, shadow self-termination,
> >> termination on task exit, various SMP scenarios, etc.
> >>  Moreover, quite a
> >> lot of stuff is executed in atomic scheduling hooks (namely on cleanup).
> >> At least for shadow threads, I don't think all of this is necessary.
> >> Actually, deferring most of the uncritical cleanup work into Linux
> >> context would make things more regular, easier to review, and likely
> >> less disturbing for overall system latencies. I know that atomic
> >> scheduling hooks are required to implement certain skins, but I don't
> >> see why janitor work should be done there as well. And we also still
> >> have that tiny uncleanness on shadow threads termination around TCB
> >> release vs. hook execution.
> > 
> > Talking about xnshadow_unmap, and as your patch illustrates, what you
> > could postpone is basically the first part of the routine, which updates
> > the reference counts. The rest _must_ run over the deletion hook in
> > atomic context (already runs fine all Linux debug switches on). The
> 
> rpi_pop()? No chance to call it before entering the scheduler and then
> the hooks?

What do you have in mind precisely?

> 
> > latency hit is certainly not seen there; the real issues are left in the
> > native and POSIX skin thread deletion routines (heap management and
> > other housekeeping calls under nklock and so on).
> 
> That's surely true. Besides RPI manipulation, there is really no
> problematic code left here latency-wise. Other hooks are trickier. But
> my point is that we first need some infrastructure to provide an
> alternative cleanup context before we can start moving things. My patch
> today is a hack...err...workaround from this perspective.
> 

I don't see it this way. This code is very specific, in the sense it
lays on the inter-domain boundary between Linux and Xenomai's primary
mode for a critical operation like thread deletion, this is what make
things a bit confusing. What's below and above this layer has to be as
seamless as possible, this code in particular can't.

> > 
> >> As we are already at it: LO_MAX_REQUESTS is a hidden limitation that
> >> may (theoretically) bite large setups when e.g. too many threads gets
> >> killed from the "wrong" context. At least some overflow detection is
> >> required here to warn the unfortunate user that he reached hard-coded
> >> scalability limits.
> > 
> > Yes.
> 
> CONFIG_XENO_OPT_DEBUG[_NUCLEUS] or unconditionally (error return code)?
> 

Making it depend on the debug switch looks good. People who are serious
about making production software do want to activate this switch once in
a while while developing it, really.

> Jan
> 
-- 
Philippe.



