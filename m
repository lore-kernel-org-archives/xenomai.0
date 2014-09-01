From: Asier Tamayo <asier.tamayo@onaedm.com>
Date: Mon, 1 Sep 2014 06:32:47 +0000
Message-ID: <4F6C25B906613147991AA0B688C61D1F41FBF795@SRVEXCHANGE.ona-electroerosion.com>
References: <4F6C25B906613147991AA0B688C61D1F41FAFB78@SRVEXCHANGE.ona-electroerosion.com>
 <53FDBF06.4000502@xenomai.org>
 <4F6C25B906613147991AA0B688C61D1F41FB2C69@SRVEXCHANGE.ona-electroerosion.com>
 <540360F7.9090103@xenomai.org>
In-Reply-To: <540360F7.9090103@xenomai.org>
Content-Language: es-ES
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Migrating from Xenomai to PREEMPT_RT
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, "xenomai@xenomai.org" <xenomai@xenomai.org>

Dear Philippe,

Really, thank you very much for your fantastic last email. It has lightened=
 me many things.

I still don't know which way I'll finally take, but be sure that this last =
email will be taken into very serious consideration for the decision.
=20
> You
> can find recent benchmarks for dual kernel configurations at our web
> site, we intend to add more of them in the future:
> http://xenomai.org/knowledge-base-index/
>
Is there any benchmark for the Mercury (single-kernel) setup?

Is there a planned release date for the Xenomai 3? Should I wait until then=
 to start my migration from Xenomai 2 to Xenomai 3 with Mercury core?

Best regards,

Asier Tamayo=20
=20
=20

> -----Mensaje original-----
> De: Philippe Gerum [mailto:rpm@xenomai.org]
> Enviado el: domingo, 31 de agosto de 2014 19:53
> Para: Asier Tamayo; xenomai@xenomai.org
> Asunto: Re: [Xenomai] Migrating from Xenomai to PREEMPT_RT
>=20
> On 08/28/2014 11:57 AM, Asier Tamayo wrote:
> > Dear Philippe,
> >
> > Thank you for your support.
> >
> >> - moving to Yocto means changing the whole environment, unless you go
> >> for Denx's ELDK, which is Yocto-based _and_ Xenomai-enabled, in which
> >> case you would not have to port your application.
> >>
> > Sadly, ELDK doesn't have x86 among its support architectures. Surely,
> they can add it, but at a cost.
>=20
> Any option will have a cost, it just depends where you want to invest
> the money in. An intermediate option would be to build your x86 image
> from Yocto's poky integration environment you would have extended with a
> couple of additional recipes for Xenomai. There are recipes/meta already
> floating around for this (I never tested them though).
>=20
> >
> >> - moving to straight preempt-rt means changing your programming model
> >> from dual kernel to single kernel, porting your application from
> >> Xenomai's "native" API to POSIX, and porting your drivers to a single
> >> kernel system. A native incarnation of RTDM does exist, but we did not
> >> receive any feedback since it was released (many) years ago, so rough
> >> edges may exist.
> >>
> > Which are the "philosophical" changes in changing my programming model
> from dual kernel to single kernel?
>=20
> Moving from "I may only trust a small set of real-time capable
> APIs served by 1% of the embedded kernel code base" to "I have to trust
> the common set of libc calls served by an undefined though certainly
> much larger percentage of the embedded kernel code base". The 1% is
> fully dedicated to real-time, the other percentage is part of a
> multi-purpose kernel dealing with real-time issues among other things.
> This has to change the way you consider which API and drivers are safe
> with respect to real-time behavior.
>=20
> > Should I expect many problems in porting the native API to POSIX?
>=20
> The original intent of the "native" API (now called "alchemy" in Xenomai
> 3.x) was to provide services which looked familiar to users of
> traditional RTOS APIs (i.e. non-POSIX). For this reason, it provides
> constructs and mechanisms you won't find in POSIX. For instance:
>=20
> - specifying the queuing policy (i.e. FIFO/PRIO) for waiting on
> resources is not available with POSIX, actually the standard explicitly
> says that it's wrong to do so, and enforces wait by priority always. So
> if your application only uses the PRIO mode, then ok. If it depends on
> the FIFO mode on purpose, then the application logic has to be revisited.
>=20
> - you won't find any support for forcibly suspending/resuming a thread
> in POSIX, the mechanism based on signals is process-scoped. Although
> depending on such feature is not recommended (for the same reason than
> async thread cancellation should not be used), some legacy apps may need
> it. YMMV.
>=20
> - the ugly "scheduler lock" feature is not present in POSIX, by design.
> Once again, it's present in the native Xenomai 2.x API to cope with
> legacy constructs used by applications ported from traditional RTOSes.
>=20
> - some IPCs won't be there, like event flag groups or buffers. Instead,
> POSIX gives you mutexes and condvars basically for building whatever
> synchronization mechanism you may think of. But you have to build them
> by yourself.
>=20
> Many applications based on the native API can be ported to POSIX easily,
> some will require more thought. It boils down to how much an application
> depends on ... non-POSIX constructs, obviously. But only you can assess
> this.
>=20
> The reason Xenomai 3.x has a complete implementation of the former
> native 2.x API which also works over a single kernel configuration, is
> precisely to deal with those dependencies in a generic way, without
> switching APIs.
>=20
> > Should I try another solution instead of using the native incarnation
> of RTDM in preempt-rt? Which one?
>=20
> I don't think anyone but you can reasonably answer this question, there
> is no recipe. If you don't go for the upcoming RTDM native, then you
> will have to convert your RTDM-based drivers to regular linux drivers.
>=20
> >
> >> - upgrading Elinos to Xenomai 2.6.x means updating your kernel - which
> >> is something you have to do for other reasons anyway - and building a
> >> drop in replacement of the Xenomai libraries and tools in user-space,
> >> for replacing the legacy ones shipped with Elinos. Kernel-wise, the
> >> requirement is to have an I-pipe patch available for your kernel
> version
> >> of choice. The upcoming Xenomai 2.6.4 supports kernel 3.14.
> >>
> > If I'm not confused, applying the I-pipe patch to the ELinOS kernel
> would add the Xenomai support, but I'm not sure if the ELK tool (Embedded
> Linux Konfigurator) will show me that option. I'll ask Sysgo about this.
> While they answer, has anyone got any experience doing something similar?
> >
> >> Mercury (i.e. single kernel Xenomai 3 configuration) would allow you t=
o
> >> move to preempt-rt without having to switch APIs from Xenomai 2.x
> >> "native" to POSIX.
> >>
> > Is the real-time performance (latency, jitter...) different in the
> single and in the double kernel approaches?
>=20
> Yes the figures are different depending on the hardware capabilities.
> The dual kernel involves less overhead to deliver real-time, but the
> single kernel scales better with more CPUs thanks to a finer locking
> model. In short, the co-kernel only deals with real-time issues with no
> interaction with the host kernel in the time-critical paths, which is
> simpler and usually faster. Once the interrupt pipeline is in place, the
> dual kernel only has to cope with hardware latencies for the most part
> (e.g. cache effects, bus locking etc). On the other hand, a single
> kernel configuration still has to cope with both software-generated and
> hardware-generated latencies (e.g. solving priority inversions due to
> the ongoing non-rt work, in addition to hardware latencies).
>=20
> This said, the higher the hardware capabilities you have (more efficient
> cores, faster caches, faster DDR, faster buses etc), the better the
> figures in single kernel configuration despite the extra overhead, up to
> the point where dual kernel has no real upside over single kernel with
> preempt-rt for a large class of applications and requirements on high
> end platforms.
>=20
> On the other hand, on low end up to mid-range hardware in the embedded
> space, a dual-kernel generally performs significantly better at a
> smaller cost. x86 is special: modern x86 platforms are often on the
> highest end of the embedded space, there the difference between single
> and dual kernel performances may not be large. Again, it only depends on
> your requirements with respect to the acceptable latency.
>=20
> Many questions, answered by many options. There is no one-fits-it-all
> solution I'm afraid. I'm certainly beating a dead horse, but the
> conversation should start with the real-time requirements.
>=20
> > If the performance depends on the RT approach (i.e., preempt-rt
> performance in the Mercury architecture and Xenomai v2 performance in
> the Cobalt one), are there any benchmarks comparisons between them? The
> ones I have found are quite outdated.
>=20
> The Cobalt implementation differs significantly from Xenomai 2
> in many aspects, although they do share the dual kernel approach. You
> can find recent benchmarks for dual kernel configurations at our web
> site, we intend to add more of them in the future:
> http://xenomai.org/knowledge-base-index/
>=20
> You can compare the "latency" (-t0, user-space) test by running this
> same program unmodified in a Mercury setup, or implement your own test
> if you want to be free from any supposed Xenomai interaction (actually,
> there is none with this test for Mercury).
>=20
> >
> > If I use the Mercury architecture, do I need to patch my ELinOS
> distribution (already with PREEMPT_RT patch) in any way? From the
> documentation, I assume I don't have to, but I need to be sure about this
> point.
>=20
> Correct, you don't need any I-pipe patch for Mercury, since the former
> is a dual kernel enabling layer.
>=20
> >
> > Best regards,
> >
> > Asier Tamayo
> >
> >
> >> -----Mensaje original-----
> >> De: Philippe Gerum [mailto:rpm@xenomai.org]
> >> Enviado el: mi=E9rcoles, 27 de agosto de 2014 13:15
> >> Para: Asier Tamayo; xenomai@xenomai.org
> >> Asunto: Re: [Xenomai] Migrating from Xenomai to PREEMPT_RT
> >>
> >> On 08/27/2014 10:45 AM, Asier Tamayo wrote:
> >>
> >>> Full story:
> >>> I have been using Xenomai for some time and must say I am really happ=
y
> >> with the results (latencies, ease of programming, clear separation
> between
> >> the RT and non-RT parts...). My board is an Atom N270 based one, and
> runs
> >> a kernel 2.6.34 compiled with Sysgo's ELinOS 5.2 tool. I have mainly
> used
> >> the native skin, as well as some RTDM drivers.
> >>>
> >>> Now, I have to start using a new AMD G-Series T52R based board, and
> >> kernel 2.6.34 shows some problems with it. Therefore, I have to update
> the
> >> kernel to a newer one, but ELinOS has dropped the Xenomai support. As
> far
> >> as I can think, I now have three options: try to install Xenomai in
> ELinOS
> >> by myself, start using another tool or leave Xenomai and use the
> >> PREEMPT_RT patch. The first option may be very error prone (in fact, I
> >> have already updated once the Xenomai version in ELinOS, but the tool
> had
> >> Xenomai support integrated previously in it). The second solution woul=
d
> >> surely put me in the Yocto path, which I think can be the correct one,
> but
> >> the learning step might require too much time from me.
> >>>
> >>
> >> Actually, updating your Elinos base to Xenomai 2.6.x would likely be
> >> much less error prone than any other option, although I agree that
> >> moving to Yocto is likely the best long term option.
> >>
> >> Looking at the involved components:
> >>
> >> - moving to Yocto means changing the whole environment, unless you go
> >> for Denx's ELDK, which is Yocto-based _and_ Xenomai-enabled, in which
> >> case you would not have to port your application.
> >>
> >> - moving to straight preempt-rt means changing your programming model
> >> from dual kernel to single kernel, porting your application from
> >> Xenomai's "native" API to POSIX, and porting your drivers to a single
> >> kernel system. A native incarnation of RTDM does exist, but we did not
> >> receive any feedback since it was released (many) years ago, so rough
> >> edges may exist.
> >>
> >> - upgrading Elinos to Xenomai 2.6.x means updating your kernel - which
> >> is something you have to do for other reasons anyway - and building a
> >> drop in replacement of the Xenomai libraries and tools in user-space,
> >> for replacing the legacy ones shipped with Elinos. Kernel-wise, the
> >> requirement is to have an I-pipe patch available for your kernel
> version
> >> of choice. The upcoming Xenomai 2.6.4 supports kernel 3.14.
> >>
> >>> So, maybe the right solution would be to leave Xenomai and embrace th=
e
> >> PREEMPT_RT patch, which is already supported by ELinOS. Has anyone got
> any
> >> experience with it? Which difficulties should I expect to find in the
> >> migration process? Any special problems with RTDM, shared memory...?
> >>>
> >>> Has anyone got information about latencies and performance comparison
> >> between Xenomai and PREEMPT_RT patch? I have found some in
> >> https://www.osadl.org/fileadmin/dam/rtlws/12/Brown.pdf, but would like
> to
> >> have as much as possible to make the choice.
> >>>
> >>> Is Xenomai 3 changing my situation in any way? Maybe using the Mercur=
y
> >> architecture, in which I do not need to patch the kernel?
> >>
> >> Mercury (i.e. single kernel Xenomai 3 configuration) would allow you t=
o
> >> move to preempt-rt without having to switch APIs from Xenomai 2.x
> >> "native" to POSIX.
> >>
> >>>
> >>> What do you think about the issue?
> >>>
> >>> [From Xenomai 3 FAQ - http://xenomai.org/introducing-xenomai-3/:
> >>>     Q: I can run POSIX based applications directly over a PREEMPT_RT
> >> kernel on my target system, so what is the point of running Xenomai 3?
> >>>     A: If your application is already fully POSIXish, and the
> >> performances requirements are met, then there is likely no point.(...)=
]
> >>>
> >>
> >> This is fairly straightforward:
> >>
> >> Xenomai 3 can either supplement the host kernel with a small co-kernel
> >> for delivering real-time performances (aka "Cobalt" configuration), or
> >> fully rely on the underlying kernel if it is deemed real-time already
> >> (aka "Mercury").
> >>
> >> In the latter case, if preempt-rt is available on your hardware/kernel
> >> combo, meets your real-time performance requirements, then you do not
> >> need Xenomai 3 to write POSIX apps, since the glibc provides for this
> API.
> >>
> >> However, if your app is not POSIXish but based on an API Xenomai
> >> emulates/implements, then you may want to use Xenomai 3 compared to
> >> converting this app to POSIX, which is quite often an error prone
> >> process. Xenomai 2.x "native" API is available with Xenomai 3,
> including
> >> for a single kernel configuration (e.g. preempt-rt).
> >>
> >> --
> >> Philippe.
> >
>=20
>=20
> --
> Philippe.
>=20
>=20
>=20
>=20


