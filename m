Message-ID: <46A0C4B6.5070706@domain.hid>
Date: Fri, 20 Jul 2007 16:20:38 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <469BF43D.1040704@domain.hid>
	<46973753.6010206@domain.hid>	<4694ED98.6000000@domain.hid>	<46937E70.10903@domain.hid>	<469345EB.6060302@domain.hid>	<22554361.1184054457326.JavaMail.ngmail@domain.hid>	<2026261.1184070574283.JavaMail.ngmail@domain.hid>	<1982070.1184078400928.JavaMail.ngmail@domain.hid>	<4693A702.1010604@domain.hid>	<913919.1184311634860.JavaMail.ngmail@domain.hid>	<21969019.1184569651818.JavaMail.ngmail@domain.hid>	<29054475.1184842736562.JavaMail.ngmail@domain.hid>	<469F4A98.3080307@domain.hid>
	<1184847549.28303.46.camel@domain.hid>	<469F5BA5.1030407@domain.hid>
	<1184858093.28303.85.camel@domain.hid>	<469F84B3.6070104@domain.hid>
	<1184861035.28303.108.camel@domain.hid>	<469F9CE2.9080603@domain.hid>
	<1184869450.28303.155.camel@domain.hid>	<469FC65E.7070508@domain.hid>
	<1184880955.28303.235.camel@domain.hid>
In-Reply-To: <1184880955.28303.235.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig44245097D1A68CDD4F7C5DB3"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-help] Sporadic PC freeze
	after	rt_task_start
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
Cc: mathias_koehrer@domain.hid, xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig44245097D1A68CDD4F7C5DB3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
=2E..
> Read my mail, without listening to your own grumble at the same time,
> you should see that this is not a matter of being right or wrong, it is=

> a matter of who needs what, and how one will use Xenomai. Your grumble
> does not prove anything unfortunately, otherwise everything would be
> fixed since many moons.

Why things are unfixed has something to do with their complexity. RPI is
a complex thing AND it is a separate mechanism to the core (that's why I
was suggesting to reuse PI code if possible - something that is already
integrated for many moons).

> What I'm suggesting now, so that you can't tell the rest of the world
> that I'm such an old and deaf cranky meatball, is that we do place RPI
> under strict observation until the latest 2.4-rc is out, and we would
> decide at this point whether we should change the default value for the=

> skins for which it makes sense (both for v2.3.x and 2.4). Obviously,
> this would only make sense if key users actually give hell to the 2.4
> testing releases (Mathias, the world is watching you).

OK, let's go through this another time, this time under the motto "get
the locking right". As a start (and a help for myself), here comes an
overview of the scheme the final version may expose - as long as there
are separate locks:

gatekeeper_thread / xnshadow_relax:
	rpilock, followed by nklock
	(while xnshadow_relax puts both under irqsave...)

xnshadow_unmap:
	nklock, then rpilock nested

xnshadow_start:
	rpilock, followed by nklock

xnshadow_renice:
	nklock, then rpilock nested

schedule_event:
	only rpilock

setsched_event:
	nklock, followed by rpilock, followed by nklock again

And then there is xnshadow_rpi_check which has to be fixed to:
	nklock, followed by rpilock (here was our lock-up bug)

That's a scheme which /should/ be safe. Unfortunately, I see no way to
get rid of the remaining nestings.

And I still doubt we are gaining much by the lock split-up on SMP (it's
pointless for UP due to xnshadow_relax). In case there is heavy
migration activity on multiple cores/CPUs, we now regularly content for
two locks in the hot paths instead of just the one everyone has to go
through anyway. And while we obviously don't win a dime for the worst
case, the average reduction of spinning times trades off against more
atomic (cache-line bouncing) operations. Were you able to measure some
improvement?

Jan


--------------enig44245097D1A68CDD4F7C5DB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGoMS2niDOoMHTA+kRAtpAAJ9Whkrh8TG7k8Vbb8zhbLLncKSznwCfUlY6
Ex3fUSSUR7tMkwgrVvd1euQ=
=rgon
-----END PGP SIGNATURE-----

--------------enig44245097D1A68CDD4F7C5DB3--

