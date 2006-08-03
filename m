Subject: Re: [Xenomai-core] Future of Xenomai's RTDM driver repository
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <44D07C4E.4040200@domain.hid>
References: <44D07C4E.4040200@domain.hid>
Content-Type: text/plain
Date: Thu, 03 Aug 2006 17:14:58 +0200
Message-Id: <1154618098.5010.42.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Wed, 2006-08-02 at 12:19 +0200, Jan Kiszka wrote:
> Hi,
> 
> instead of replying directly to Wolfgang's announcement of their great
> CAN stack I take the chance to start a generic thread on the future of
> RTDM drivers *within* Xenomai.
> 
> If you look at the real-time Linux scene now and in the past, you may
> find it fairly scattered. Specifically precious Open Source drivers are
> hard to find, not always up-to-date, or not ported to your favourite
> kernel/RT-patch. Just check how many CAN driver projects for how many RT
> APIs are out there. There are even a few hardware vendors providing
> driver packages for real-time Linux, others offer at least some kind of
> "reference code", but many nothing at all. Sad but true for _many_ years.
> 
> RTDM came into play to provide a common ground for real-time driver
> development under Linux. It is already utilised by quite a few
> stand-alone driver projects and even vendor drivers. But as resources
> are limited, maintenance is tricky, and testers are rare, we should
> consider concentrating driver development efforts more intensively. I'm
> convinced such concentration should primarily happen within the Xenomai
> driver repository.
> 
> Xenomai has the unique potential to provide a real-time framework for
> both the co-scheduling approach and for the native RT-Linux environment
> that Preempt-RT will probably push into mainline one day. And Xenomai is
> also a sound foundation for the tricky 2.4/2.6 support scenario.
> 
> Here are the concrete advantages I see in maintaining drivers *inside*
> Xenomai:
> 
>  o Better visibility (did you know that there is a working FireWire
>    stack for Xenomai?)
>  o Better testing, also across architectures, due to more users (this
>    applies to the drivers, but also to RTDM and Xenomai in all)
>  o Closer to the latest RTDM development
>  o Wrapping environments for changing kernel interfaces (2.4/2.6 etc.)
>  o In-kernel build
>  o Simpler build system (look at RTnet...)
>  o Single, integrated package, thus less breakages due to version
>    mismatches
> 

And above all, integration is the key issue, which includes device
drivers. This has a maintenance cost, but much lower than breakages due
to endemic discrepancies between the out-of-tree modules (whatever
"modules" means here) and the core framework.

> Of course, there are also certain critical topics that need to be
> resolved first:
> 
>  o Clear acceptance rules
>     - Maintenance commitment: "dump-and-run" will not scale. Unless
>       there is already a community behind it, complex drivers need
>       people to look after them. Dead/unused drivers should get moved in
>       some corner after a while.

It's the common Xenomai policy since day #1 (i.e. no dead/unmaintained
code), so there should be no problem keeping it this way, provided this
policy is explicitely stated. However, finding committed
contributors will always be the main issue.

>     - Coding style: Should simply be kernel style (though I personally
>       hate tabs).

So do I, but fact is that implementing anything else than the strict
kernel coding guidelines for kernel-based code raises the barrier on
reviewing and even acceptance from the kernel people, so there is no
need to fight for such details, imho. This is kernel code, let's use
kernel coding conventions.

>     - Documentation: New RTDM profiles as well as the drivers themselves
>       must contain "some words" (surely a more softish requirement).
>     - Test cases, test conformance: Drivers should provide some simple
>       tests or, if once available, conform to existing tests for their
>       RTDM profiles.
>  o Repository organisation
>     - Where to keep utilities (Wolfgang raised this as well)? Should a
>       "rtcanconfig" come with Xenomai, as a separate package of
>       rt-utils, or as package of its own?

I tend to think that self-contained packages are always simpler to deal
with from the user standpoint, therefore CAN utilities should be part of
the CAN driver package. Regarding any <rtdriver>config script, maybe we
could extend xeno-config in the future to accept external configuration
frags, so that we keep a single front-end which would accept additional
options dynamically, but this should not be a requirement ATM.

> 
>     - Where to put test cases? Distribute them separately?
>     - Where to collect usage examples? This is actually a generic
>       question, also for the skins (I think the current situation is
>       a bit unsatisfactory).

Test cases and usage examples do not usually belong to any particular
Xenomai/driver version, so they should be gathered in a separate
package. This would also allow to enrich them with end-user
contributions with lower constraints on coding style etc.

> 
>  o Support organisation
>       Simple drivers can certainly be managed via xenomai-help, existing
>       communities will continue to use their own forums, but what about
>       new subsystems? I could imagine introducing some
>       xenomai-SUBSYSTEM@gna.org lists for them, Philippe suggested
>       simply xenomai-drivers which is likely already sufficient.

I guess so, since other major subsystems would probably need their own
list when they appear.

> 
> Now I would suggest to look at RTCAN (or what it will be called in the
> end) and to discuss on this first concrete example how we can proceed
> towards the sketched goal.
> 
> Looking forward to your feedback!
> 
> Jan
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



