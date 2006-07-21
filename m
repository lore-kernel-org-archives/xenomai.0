Message-ID: <44C0D0BE.5020500@domain.hid>
Date: Fri, 21 Jul 2006 15:03:58 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Priority inversion
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210E1A@EINT11.einet.ad.eivd.ch>	<FDBBB5CC70676540B3EF7CFE83FD94E05B4564@domain.hid>
	<20060721145159.5a87453c@domain.hid>
In-Reply-To: <20060721145159.5a87453c@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig000868D4172622A4EE0D6A1B"
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
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig000868D4172622A4EE0D6A1B
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Fri, 21 Jul 2006 14:12:47 +0200
> "ROSSIER Daniel" <Daniel.Rossier@domain.hid> wrote:
>=20
>> but it might be at the spin() level.
>=20
> I have observed that the behaviour of rt_timer_spin() does not fit with=

> the expected behaviour as described in the doxygened comment: its actua=
l
> awakening time do not increase when it is preempted.=20
>=20
> According to the code in timer.c (using 2.1.2) the wakening time seems
> to be computed once for all at the beginning of the function call.
>=20
> Am I right?

Partially. The doc doesn't claim that the time during preemption will
get added to your requested spin time. Depending on how long you got
preempted, the delay /may/ be longer (until the preemption actually
ends). Anyway, this could explain some misunderstandings in this tricky
scenario here.

[There is actually one undocumented issue of rt_timer_spin: if the task
is migrated to another CPU during spin, the end time will not match the
new timebase. So, one should not forget to pin such spinning tasks to
one CPU first when running on SMP.]

Jan


--------------enig000868D4172622A4EE0D6A1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEwNC+niDOoMHTA+kRApDnAJ909j+9vqzfPK/27EyfyVuVIGOy5wCcC4nR
lrASZkROOQJwpxGevYs3A4k=
=Zoe1
-----END PGP SIGNATURE-----

--------------enig000868D4172622A4EE0D6A1B--

