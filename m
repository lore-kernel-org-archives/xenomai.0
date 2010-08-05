From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20100805151932.GA25701@domain.hid>
References: <1276880276.12743.73.camel@domain.hid>
	<4C1BA6F7.9080004@domain.hid>
	<20100805125828.GA22855@domain.hid>
	<1281016845.1706.0.camel@domain.hid>
	<4C5AC77F.1040508@domain.hid>
	<20100805151932.GA25701@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Aug 2010 18:51:37 +0200
Message-ID: <1281027097.1706.96.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Tschaeche IT-Services <services@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2010-08-05 at 17:19 +0200, Tschaeche IT-Services wrote:
> On Thu, Aug 05, 2010 at 04:15:27PM +0200, Gilles Chanteperdrix wrote:
> > Philippe Gerum wrote:
> > > On Thu, 2010-08-05 at 14:58 +0200, Tschaeche IT-Services wrote:
> > >> On Fri, Jun 18, 2010 at 07:03:51PM +0200, Gilles Chanteperdrix wrote:
> > >>> Philippe Gerum wrote:
> > >>>> Recovery from runaway loops in primary mode is introduced by the mayday
> > >>>> patch series; the faulty thread gets relaxed, instead of being killed,
> > >>>> when the nucleus watchdog triggers.
> > >> just adapted to Xenomai 2.5.4 with a simple patch,
> > >> exporting the xnshadow_call_mayday() symbol from nucleus,
> > >> so that we can call it from our watchdog driver.
> > >>
> > >> Should we call xnshadow_call_mayday() in another (official) way?
> > > 
> > > xnshadow_call_mayday() is already exported to modules in 2.5.4.
> > 
> > It is exported to GPL modules, maybe that is the issue?
> 
> yes. EXPORT_SYMBOL_GPL requires the callee to be GPL too, right?

It's a strong hint to tell users that the intent of the author of that
code is to provide such service to GPL code. Any other use leaves the
user on his own, with respect to the interpretation of the kernel
license.

> may we GPL patch kernel/xenomai/skin/native/task.c with something like:
> 
> 	int rt_task_shadow_mayday(RTASK *t)
> 	{
> 		return xnshadow_call_mayday(t->thread_base, WATCHDOG_SIGXCPU);
> 	}
> 	EXPORT_SYMBOL(rt_task_shadow_mayday)
> 
> Native API does not require GPL callees.
> BTW: why are there different licenses?
> 

Why do you see different licenses? The nucleus is GPL, as is GPL each
and every bit of the Xenomai kernel code. Only userland libs are LGPL.

The decision to give the EXPORT_GPL hint now to in-kernel users is
precisely there to make this even more clear, and I will extend this to
all in-kernel interfaces in Xenomai 2.6. The reason why I did not push
this change to the 2.5.x series is because some legacy Xenomai-based
apps implemented as non-GPL kernel modules might qualify for the "gray
area" set, as described in this post:
http://marc.info/?l=linux-kernel&m=107049625920022&w=2

However, the days when using a dual-kernel system meant running
application code to kernel land are long gone; we did work quite hard to
provide flexibility, reliability and good performances in userland over
time. Therefore, Xenomai 2.6 will strongly advise users to run
applications in user-space only, and Xenomai 3.x won't export any kernel
space API to kernel-based applications at all (Of course, RTDM will
still export an API to build drivers, and to interface with other
drivers).

If the issue is about driver code, and not application code, then it is
even simpler: driving peripherals is part of the Linux kernel
business's, so the GPL rules. If, for any valid or paranoid reason, some
of the code driving the peripheral could not be disclosed, then there
are options to move it partly or entirely to userland where LGPL
applies, even if that may not be the best technical approach.

The bottom line for the Xenomai licensing policy is quite
straightforward:

- We built our house on the foundations passed on by others, they gave
us the Linux kernel code, we do abide by their license because we are
part of their kernel, so our kernel-based code is licensed under the
terms of the Linux kernel license. People who want to interpret that
license to fit their licensing requirements are on their own. We did not
invent the license, we are simply using it and passing it on our own
users.

- In userland, we provide LGPL interfaces to applications to call our
real-time nucleus services, the same way the glibc provides LGPL
interfaces to applications to call standard Linux services.

> did not clarify yet, if our driver code may be open source.
> i think, it would be appreciated if not.
> 

We can't help in this area, we simply provide some code under a given
license. Whether the license fits your requirements depends on your
assessment of the situation only.

> thx,
> 
> 	Olli
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



