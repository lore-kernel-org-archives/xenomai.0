Message-ID: <450E6745.6050903@domain.hid>
Date: Mon, 18 Sep 2006 11:30:45 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7CF3F7E696BE8C7E0315F253"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] rare brokenness in latency output - FPU bug!
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CF3F7E696BE8C7E0315F253
Content-Type: multipart/mixed; boundary="------------010803090703020004060301"

This is a multi-part message in MIME format.
--------------010803090703020004060301
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

it's now the second box I noticed this minor quirk with SVN head:
latency (tested with -t0 only so far) sometimes gives me a broken "lat
worst" number like this:

> RTD|      15.637|      17.842|      42.750|       0|       4.601|      =
54.264
> RTT|  00:04:55  (periodic user-mode task, 100 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat=
 worst
> RTD|      14.463|      18.019|      41.907|       0|       4.601|      =
   nan
> RTD|      15.197|      17.902|      37.396|       0|       4.601|      =
54.264

I also already had weird large numbers here (>200 digits) which makes me
think that this is not an issue of gmaxj (local long variable to store
the result before output conversion), but rather something with the FPU.
Anyone any thoughts?


Uhh, wait! I just fired up switchtest on the same box:

> =3D=3D Testing FPU check routines...
> r0: 1 !=3D 2
> r1: 1 !=3D 2
> r2: 1 !=3D 2
> r3: 1 !=3D 2
> r4: 1 !=3D 2
> r5: 1 !=3D 2
> r6: 1 !=3D 2
> r7: 1 !=3D 2
> =3D=3D FPU check routines: OK.
> =3D=3D Threads: sleeper_ufps-0 rtk-1 rtk-2 rtk_fp-3 rtk_fp-4 rtk_fp_ufp=
p-5 rtk_fp_ufpp-6 rtup-7 rtup-8 rtup_ufpp-9 rtup_ufpp-10 rtus-11 rtus-12 =
rtus_ufps-13 rtus_ufps-14 rtuo-15 rtuo-16 rtuo_ufpp-17 rtuo_ufpp-18 rtuo_=
ufps-19 rtuo_ufps-20 rtuo_ufpp_ufps-21 rtuo_ufpp_ufps-22
> r0: 2147483648 !=3D 10
> r1: 2147483648 !=3D 10
> r2: 2147483648 !=3D 10
> r3: 2147483648 !=3D 10
> r4: 2147483648 !=3D 10
> r5: 2147483648 !=3D 10
> r6: 2147483648 !=3D 10
> r7: 2147483648 !=3D 10
> Error after context switch from task 8(rtup-8) to task 10(rtup_ufpp-10)=
,
> FPU registers were set to 2147483648 (maybe task ???)
> Segmentation fault

Gilles, what info do you need? It's all the latest on x86 here:
2.6.17.13 (.config attached), ipipe-1.4, SVN #1646, gcc4.1.0.

Jan

--------------010803090703020004060301
Content-Type: application/octet-stream;
 name="config-2.6.17.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="config-2.6.17.bz2"

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
f1JbgA==
--------------010803090703020004060301--

--------------enig7CF3F7E696BE8C7E0315F253
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFDmdGniDOoMHTA+kRAk+QAJ4vBxiGLq0QypNJ5jgZnfwDBkvllwCeK4Tg
yxkpkvBKXSK5YnI88V4hm3c=
=OJfx
-----END PGP SIGNATURE-----

--------------enig7CF3F7E696BE8C7E0315F253--

