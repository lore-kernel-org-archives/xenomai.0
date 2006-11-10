Message-ID: <45548032.9040400@domain.hid>
Date: Fri, 10 Nov 2006 14:35:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai Kernel limits
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB0154E621@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig147ECCAF55665B7101C9341C"
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
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig147ECCAF55665B7101C9341C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

I'm not replying to all questions (time is short...):

Daniel Schnell wrote:
> Hi,
> =20
> I am still struggling with problems under Xenomai and POSIX skin. You
> remember maybe I was posting a Kernel Oops some days ago.
> I realized that a basic test (not with our large app. but with a little=

> test program) of clock_nanosleep() shows, that this function - if teste=
d
> alone - works as expected. Strangely in our application the behaviour o=
f
> clock_nanosleep() changes and then suddenly (before crashing) it return=
s
> only after 1/4 of the supposed time. Bear in mind: if I compile the app=
=2E
> against POSIX NPTL glibc, everything works as expected.

Maybe that bug is a symptom of some other scalability issue.

> =20
> The Kernel oops went away if I replace clock_nanosleep() with the Linux=

> select() facility (!). This is only a short term workaround as then we
> do not have realtime capabiliy. But at least I can continue with portin=
g
> our application.=20
> Meanwhile we got MSCAN running and I could run the application with
> Xenomai and select() instead of clock_nanosleep() over night. When
> checking the /proc/xenomai entries this morning, however we got the
> impression that we might overuse kernel resources:
> =20
> =20
> +++
> bash-2.05b# cat /proc/heap
> size=3D131072:used=3D134400:pagesz=3D512
> +++
> =20
> This looks odd. Either the output is misleading or we have used more
> resources than possible. But then I would expect that the Xenomai
> initialization routines (e.g. pthread_create(), rt_dev_open(), etc.)
> should return with an error. Either should be fixed, I suppose.

Every services that allocates memory from the real-time heap should fail
now. If it doesn't (pthread_create is a good test candidate here), we
"only" face a statistics bug. Can you confirm that starting further
applications only increases the used counter but otherwise works?

> =20
> I configured Xenomai in the Kernel with the following values, but pleas=
e
> bear in mind that was after I thought about a resource shortage:
> =20
> CONFIG_XENO_OPT_PIPE_NRDEV=3D320

This looks exceptional. Do you really use pipes that heavily?

> CONFIG_XENO_OPT_REGISTRY_NRSLOTS=3D2560

Do you every have so many registered objects active in parallel? Should
be no problem, but I wonder if it is needed.

=2E..
> - I realized that when setting CONFIG_XENO_DRIVERS_RTCAN_RXBUF_SIZE to
> 131072, my application does not run. Which are the upper limits I can
> set for all the configurable Xenomai parameters ?

That buffer is part of each CAN socket instance which is allocated via
kmalloc - hence the 132K limit here. But you shouldn't normally need
such large intermediate buffers when no CAN receiver gets delayed
unreasonably long.

> - We are using 40+ Tasks, 265+ Condition variables, 200+ Mutexes, and 2=

> MSCAN ports. Additionally we use Linux sockets, files, etc. What is you=
r
> proposed setting to reasonable values inside the Xenomai Kernel config =
?

We are running similar task loads over the native skin with only the
heap size raised to 512k. We do not have so many active mutexes and no
condition variables, but a lot of RTDM sockets (still smaller than the
default limit of 128). All fine here.

It melts down that you will have to try to isolate the reason(s) for
unexpected behaviours. I suspect some internal buffer overrun that
causes all those ugly side effects.

Can you try to scale your app down, remove features/service calls so
that subsystems can be excluded systematically?

Jan


--------------enig147ECCAF55665B7101C9341C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFVIAyniDOoMHTA+kRAm8wAJ9Y18j9VJXg35flDwcMkPnmUXyoswCfU3t1
3DaJXSSFImhqxP0bttNDT7A=
=uDXj
-----END PGP SIGNATURE-----

--------------enig147ECCAF55665B7101C9341C--

