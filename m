Message-ID: <44D24257.10605@domain.hid>
Date: Thu, 03 Aug 2006 20:37:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC][PATCH 4/4] shorten overrun loops of periodic
	timers
References: <44D19F3D.9060700@domain.hid>
	<17618.12731.97405.118098@domain.hid>
In-Reply-To: <17618.12731.97405.118098@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig356956FDA0A0BA00FBADA025"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig356956FDA0A0BA00FBADA025
Content-Type: multipart/mixed; boundary="------------030101070305060408020100"

This is a multi-part message in MIME format.
--------------030101070305060408020100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > A simple patch, just like suggested by Gilles, to avoid looping over=

>  > periodic xntimer handlers in case of overruns.
>  >=20
>  > It saves the current TSC on loop entry and uses this value later whe=
n
>  > forwarding the timer. Is is the overhead of re-reading the TSC on al=
l
>  > archs negligible and should we rather go that way?
>=20
>  >(...)
>  > -				xntimerh_date(&timer->aplink) +=3D
>  > -				    nkpod->htimer.interval;
>  > +				while ((xntimerh_date(&timer->aplink) +=3D
>  > +				        nkpod->htimer.interval) < now);
>=20
> I think you are patching the wrong addition, the one you are interested=

> in is most probably the one at the bottom of xntimer_do_tick_aperiodic.=

>=20

Ouch, indeed. Guess I should start reading what I patch. Here comes a
second try.

I'm still in favour of saving the TSC instead of re-reading it.
Otherwise we would have to pave the code with #ifdefs for the case
xnarch_get_cpu_tsc() is slow for a specific setup. Not that nice, is it?

Jan

--------------030101070305060408020100
Content-Type: text/x-patch;
 name="xntimer-handle-periodic-overrun-v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="xntimer-handle-periodic-overrun-v2.patch"

---
 ksrc/nucleus/timer.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: xenomai/ksrc/nucleus/timer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/ksrc/nucleus/timer.c
+++ xenomai/ksrc/nucleus/timer.c
@@ -200,12 +200,13 @@ static void xntimer_do_tick_aperiodic(vo
 	xntimerq_t *timerq =3D &sched->timerqueue;
 	xntimerh_t *holder;
 	xntimer_t *timer;
+	xnticks_t now;
=20
 	while ((holder =3D xntimerq_head(timerq)) !=3D NULL) {
 		timer =3D aplink2timer(holder);
=20
-		if (xntimerh_date(&timer->aplink) - nkschedlat >
-		    xnarch_get_cpu_tsc())
+		now =3D xnarch_get_cpu_tsc();
+		if (xntimerh_date(&timer->aplink) - nkschedlat > now)
 			/* No need to continue in aperiodic mode since timeout
 			   dates are ordered by increasing values. */
 			break;
@@ -247,7 +248,7 @@ static void xntimer_do_tick_aperiodic(vo
 			   translates into precious microsecs on low-end hw. */
 			__setbits(sched->status, XNHTICK);
=20
-		xntimerh_date(&timer->aplink) +=3D timer->interval;
+		while ((xntimerh_date(&timer->aplink) +=3D timer->interval) < now);
 		xntimer_enqueue_aperiodic(timer);
 	}
=20

--------------030101070305060408020100--

--------------enig356956FDA0A0BA00FBADA025
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFE0kJbniDOoMHTA+kRAih6AJ4lN9wcpIGMlr25O2ZUTI7LA5a1agCeOefG
H6H0OiL8Os60Z15cUC3ENo4=
=+pNo
-----END PGP SIGNATURE-----

--------------enig356956FDA0A0BA00FBADA025--

