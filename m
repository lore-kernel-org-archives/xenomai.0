Message-ID: <440F7B35.1050107@domain.hid>
Date: Thu, 09 Mar 2006 01:47:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai vs. RTLinux
References: <440F5F23.7000703@domain.hid>
In-Reply-To: <440F5F23.7000703@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig61E807D934EA3E1227625162"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Webb <jeff.webb@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig61E807D934EA3E1227625162
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jeff Webb wrote:
> Xenomai developers and users,
>=20
> Our company is looking at the possibility of porting our
> hardware-in-the-loop (HWIL) simulations from RTLinuxFree to a new
> real-time operating system.  We are currently considering Xenomai and
> RTLinuxPro as possible options.  I am personally biased towards free
> software, but our customers do not necessarily share this bias.  I am
> attempting to put together a presentation comparing the advantages and
> disadvantages of the two systems  as they would be used in our HWIL
> simulations.  Any comments you have would be appreciated.
>=20
> We are currently using RTLinuxFree-3.2-pre3 running on Fedora Core 1
> (2.4.22 linux kernel) for our in-house HWIL simulations on rack-mounted=

> x86 PC hardware.  We have been satisfied with the functionality of
> RTLinuxFree over the past few years, although we have been disappointed=

> by the lack of maintenance and development that has occurred since the
> primary developers focused their efforts on developing RTLinuxPro.=20
> Because there is no RTLinuxFree release that supports the 2.6 kernel,

Well, I'm not following this in every details, but there is something
now for RTLinux/GPL (the independent community RTLinux). Anyway, the
maintenance situation is not significantly better there - too few users,
too few developers.

> even more than two years after it's release, it looks like we will be
> forced to abandon this platform, or be stuck with the almost unsupporte=
d
> Fedora Core 1 for the foreseeable future.
>=20
> Over the past week or so, I have installed Xenomai (2.1-rc3 and 2.1-rc4=
)
> and written a couple of test applications.  My experience was very
> good.  I will send an email with some feedback shortly.

You are welcome - oh, I see you already did!

>=20
> I wrote some simple test programs to compare the scheduling jitter and
> interrupt latency for RTLinuxFree, Xenomai-kernel-space, and
> Xenomai-user-space applications.  My tests are not rigorous by any
> means, but it seems that the worst-case measurements are pretty
> similar.  Xenomai *may* be slightly better from the limited data I have=

> taken.  Does anyone care to share their own observations?

Would surprises me. From what I know of RTLinux/GPL (RTAI is similar
here, BTW), the critical paths are involving less code than Xenomai.
That's due to the different IRQ redirection layers, the nucleus
abstraction of Xenomai, maybe also to some yet missing optimisations.
Anyway, Xenomai is favouring flexibility and maintainability here over
the last microsecond.

>=20
> The worst-case scheduling latency for the xenomai user-space applicatio=
n
> was only a few microseconds worse than the kernel-space version.  Is
> this what you would expect?

Well, I guess it takes more information about your tests to comment on
this. The hardware of the test system would be important, as well as the
load scenario and the test duration.

>=20
> I did not do a very thorough test with my interrupt handler, but the
> results seemed similar to what I described above for the scheduler.  Is=

> there a big penalty in terms of worst-case latency for user-space
> interrupt handlers that I may not have seen?  I'm just looking for any
> major problems that I might encounter if we port our real-time
> applications to user-space.

A good impression of the major differences may give the latency test
tool of Xenomai when being run in its different modes: userspace task,
kernelspace task, timer handler (IRQ context). Specifically, when you
load your systems with various non-RT IRQs (disk, network, ...), the
worst case scenario of all those IRQ stubs hitting you between the RT
IRQ event and the scheduled RT task execution can make a difference of
some 10 us (depending on the architecture). You have to wait a bit to
let this happen. Analysing the worst case result with the Ipipe latency
tracer is a recommended to see if all possible IRQ actually already hit y=
ou.

BTW, smart people on this list already started discussing how to improve
this scenario even more: mask out non-RT IRQs when in RT context.

>=20
> Is RTLinuxPro's PSDD (user-space) development environment similar to
> xenomai's user-space real-time threads?  Any known
> advantages/disadvantages to either system?

That's proprietary, err, stuff. I guess not many people from the
community ever had the "chance" to look at it. And I don't want to
compare anything here based on marketing brochures.

Only so much: Xenomai has a very advanced Linux integration, so advanced
that signals are delivered to your RT-threads (not in RT though),
invoking Linux services will let them run with raised priority (as far
as possible), and debugging works smoothly.

>=20
> We currently use C and FORTRAN in our RTLinuxFree modules, and would
> like to be able to add C++ and FORTRAN as well.  Are there any problems=

> you see with using these languages in xenomai user-space real-time
> programs?

Based on the design of the userspace skins, there are no problems to
expect. If minor compilation issues still pop up (I'm not aware of any),
they will be easy to fix. There is even an ongoing effort to create a
native skin class library for Xenomai: xeno-- (see xenomm at gna.org).

>=20
> Is there planned support for native AMD x86_64 support?  We have severa=
l
> of these machines on our desktops and would like to upgrade our HWIL
> machines as well.

On my personal wish list, this is also of increasing importance. But I'm
not aware of currently ongoing efforts. There were some activity around
RTAI to work on Adeos for AMD64, what would also be the first step for a
Xenomai port, but that one is outdated (old Adeos design, not yet
Ipipe). Takes someone to push this...

>=20
> We are also concerned about "future-proofing" as someone else put it th=
e
> other day.  I hope that xenomai will not suffer the fate of RTLinuxFree=

> in a few years.  Of course, I understand there are no guarantees.  Do
> you see any advantages to xenomai over RTLinuxPro in this respect?

No vendor-lock: Who knows what the future business concept of FSMLabs
will (have to) be? Think of TimeSys, they also already had to change
their product portfolio. Whatever projects will provide hard/soft RT for
Linux in the future, they all will definitely be open source - my strong
believe.

>=20
> Another issue is technical support and documentation.  The xenomai
> documentation seems good enough to me, although it sounds like
> RTLinuxPro is quite a bit more substantial.  It also looks like the
> developers on this list are very responsive and helpful, but I don't
> know how that compares to what we would get from FSMLabs.  Any input on=

> these topics?

Again, this can only be answered by people with knowledge about the
commercial product.

>=20
> It appears that xenomai is released under the LGPL and can be used with=

> proprietary applications.  Although our simulations are just for

Roughly: It's GPL for the kernel code and LGPL for userspace libs.

> internal use, and I would always advocate releasing free software, I wa=
s
> wondering if xenomai is subject to the RTLinux patent, or if it uses a
> different process.

Well, someone with good knowledge of RTLinux recently explained to me
that even FSMLabs are no longer actively using their own patent for
latest versions. It is simply irrelevant these days, specifically for
Xenomai with Adeos/Ipipe, which is cleanly implementing scientific
concepts pre-dating this patent.

>=20
> My first impression of xenomai is very positive.  I like the clean API,=

> and the user-space real-time would make life *much* nicer for me.  I'm
> glad there is a such nice piece of free software available for real-tim=
e
> programming under GNU/Linux.  Thanks!
>=20
> Thank you for taking the time to read these questions and comments.  An=
y
> comments or testimonies regarding xenomai or RTLinuxPro would be
> appreciated.

Maybe other users with RTLinux migration experiences are listening and
can contribute more direct comparisons than I'm able to.

>=20
> Thanks again,
>=20
> Jeff Webb
>=20

Jan


--------------enig61E807D934EA3E1227625162
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFED3s1niDOoMHTA+kRAl9LAJ9F2MUk+jIM/ZAH2Io7hXdMJvspWwCfWdra
DtDsebd9h3y/P/7kx+mq3Hk=
=2q40
-----END PGP SIGNATURE-----

--------------enig61E807D934EA3E1227625162--

