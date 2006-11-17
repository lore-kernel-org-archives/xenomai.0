Message-ID: <455E025B.5030906@domain.hid>
Date: Fri, 17 Nov 2006 19:41:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <DD39B5C3F4963040ADC9768BE7E430CB0154E8D7@domain.hid>
	<1163784779.4980.47.camel@domain.hid>
In-Reply-To: <1163784779.4980.47.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig40E236C0044256E34E846F39"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] XENO_OPT_DEBUG impact (was: exception 768)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig40E236C0044256E34E846F39
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> ...
> Disable CONFIG_XENO_OPT_DEBUG from your kernel configuration, this is
> the source of the PTE misses you are seeing now on ppc. This is not to
> say that those errors are normal, and this issue still remains to be
> fixed, but unless you want to debug the Xenomai nucleus, you don't need=

> this option on (additionally, it adds a large overhead which translates=

> in significantly augmented jitter).

CONFIG_XENO_OPT_DEBUG should not add large jitters - that's what e.g.
CONFIG_XENO_OPT_DEBUG_QUEUES is now for.

I'm currently seeing two potential "misuses" of the common switch:

 - the posix skin (Gilles, how heavy-weighted are those checks?)
   =3D> CONFIG_XENO_OPT_DEBUG_POSIX

 - CONFIG_XENO_SPINLOCK_DEBUG =3D> CONFIG_XENO_OPT_DEBUG_SPINLOCK

Both should be explicitly controllable in Kconfig.

Gilles, is CONFIG_XENO_OPT_DEBUG_BHEAP used in any way? Doesn't seem so.

Jan


--------------enig40E236C0044256E34E846F39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFXgJbniDOoMHTA+kRAtgyAJ9gbxMLiXJiEvM6Wt8F+2S3jufLLwCZAblZ
p/+XtLqb97EH89qjK9IhmcQ=
=I9tP
-----END PGP SIGNATURE-----

--------------enig40E236C0044256E34E846F39--

