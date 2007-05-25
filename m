Message-ID: <46570185.3030406@domain.hid>
Date: Fri, 25 May 2007 17:32:21 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4656E62F.3090603@domain.hid>
	<4656E887.7040406@domain.hid>	<4656EABD.60601@domain.hid>
	<1180102373.20410.103.camel@domain.hid> <4656F037.4040704@domain.hid>
	<DD39B5C3F4963040ADC9768BE7E430CB01F547BA@is-hdq-exchange.marel.net>
In-Reply-To: <DD39B5C3F4963040ADC9768BE7E430CB01F547BA@is-hdq-exchange.marel.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5686BF666C9CB03B3B872B54"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] recursive fault on cyclictest termination
 --	scalable sched?
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Schnell <daniel.schnell@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5686BF666C9CB03B3B872B54
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Schnell wrote:
> Well, that may be related to the bug I am seeing when I am ending cycli=
ctest with Ctrl-C, Recursive kernel Ooops and this is on plain 2.3.1
>=20

2.3.1 is definitely affected by this bug as well, as it also gained the
prio-coupling rework. But you have to have SCALABLE_SCHED enabled.

I got it. It is - as usual - a trivial one-liner:

--- xenomai.orig/ksrc/nucleus/shadow.c
+++ xenomai/ksrc/nucleus/shadow.c
@@ -186,7 +186,7 @@ static inline void rpi_init(void)
=20
 static inline void rpi_init_gk(struct __gatekeeper *gk)
 {
-	sched_initpq(&gk->rpislot.threadq, xnqueue_down, XNCORE_NR_PRIO);
+	sched_initpq(&gk->rpislot.threadq, xnqueue_down, XNCORE_MAX_PRIO);
 }
=20
 static inline void rpi_none(xnthread_t *thread)


Happy weekend, =3D8)

Jan


PS: The maximum priority level has initialised to a wrong value, causing
threads with prio 0 to be placed out of the queue array.


--------------enig5686BF666C9CB03B3B872B54
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVwGFniDOoMHTA+kRAjNiAJ9z1fmMK/MN9GVDX5OZGTQWPE7FcwCgg8Fv
ov/TEfvwav52pqmNg2CXXjk=
=hQUh
-----END PGP SIGNATURE-----

--------------enig5686BF666C9CB03B3B872B54--

