From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4571BEF8.5080900@domain.hid>
References: <20061124105346.e442448d.benjamin.zores@domain.hid>
	<4566C5AF.7030107@domain.hid>
	<20061124113009.08c0a490.benjamin.zores@domain.hid>
	<4569E699.6050003@domain.hid>
	<20061127092143.e633cd91.benjamin.zores@domain.hid>
	<456ACA35.8030206@domain.hid>
	<20061127125419.3852edd9.benjamin.zores@domain.hid>
	<456AD5EB.5040901@domain.hid>
	<20061130133745.272ab4b1.benjamin.zores@domain.hid>
	<456EDA4B.3060809@domain.hid>  <1165013200.4952.177.camel@domain.hid>
	<1165014875.4952.199.camel@domain.hid>  <4571491D.502@domain.hid>
	<1165078727.4952.222.camel@domain.hid>  <4571B9DF.6010101@domain.hid>
	<1165081330.4952.228.camel@domain.hid>  <4571BEF8.5080900@domain.hid>
Content-Type: text/plain
Date: Sun, 03 Dec 2006 00:32:00 +0100
Message-Id: <1165102321.4952.331.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] I-pipe git trees
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
Cc: adeos-main@gna.org, xenomai-core <xenomai@xenomai.org>

On Sat, 2006-12-02 at 18:59 +0100, Jan Kiszka wrote:

[...Resuming the discussion on both interested lists...]

> Rough idea from my side on a potential organisation of the git trees:
> 
>  o A generic I-pipe core tree that primarily targets git head (i.e. 2.6)
>  o One branch for git head, pulls both from Linus' tree and the I-pipe
>    core

What would be the purpose of this branch?

>  o One tree for each major 2.6 version in maintenance mode, pulls from
>    related stable branch and I-pipe core (when applicable)
>  o Only if required: a generic I-pipe core tree for 2.4

It should not be needed. I-pipe for 2.4 is in deep maintenance mode, and
the latest 2.6 pipeline core is no more compatible with the 2.4 version
anyway, due to several infrastructure changes in the vanilla kernel,
e.g. genirq. So from now on, we won't backport much from the 2.6 series
to 2.4, except perhaps critical bug fixes. Most (if not all) of the
changes on those trees are much likely to be 2.4-specific, as time
passes.

>  o One tree for 2.4 head to maintain x86
>  o One tree for 2.4 ELDK to maintain PPC
> 

Yes, we definitely need those.

> Quite a lot trees... Do you this this may work?

It really depends on what we try to achieve with implementing a new
workflow. At least, I can tell why we need a new workflow, which could
give us some hint about the one we should pick.

Basically, the reason is that I don't scale anymore when it comes to
maintain the six I-pipe ports, even if for a few of them, I'm not
directly maintaining the arch-dependent parts (just reviewing), but only
the generic core. Given that the Xenomai maintenance is now
unfortunately done on my free time too, something needs to be done in
order to optimize those processes.

Now that some recurrent contributors showed up for helping with some
ports, it's time to allow the various I-pipe ports to develop at their
own pace, while still being reasonably in sync with a reference
implementation. There are quite talented people out there who know
better than me when it comes to hw platforms they are dealing with on a
daily basis, so let them tackle the issue, if they accept to.

The bottom-line:

- Not all trees are going to be cloned from mainline; some architectures
are not even mainline yet (e.g. blackfin). This is why relying on
competent people for tracking the right kernel source for any given
architecture is critical, and beyond that, people who know enough about
the technical trends going on for the Linux port in question (e.g. ppc
and arm).

- In the new workflow, I'm going to keep working on the generic I-pipe
core, and lead the maintenance for the ports which have no better
maintainer in sight.

- I want this process to add flexibility, by decoupling the evolution of
the various ports, without introducing chaos. This should be possible
with all the maintainers keeping an eye on the reference implementation
I'll be working on, and improving with their input.

- Keep it simple. I'm slow, damnit!

-- 
Philippe.



