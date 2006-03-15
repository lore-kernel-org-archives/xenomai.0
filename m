Message-ID: <4417C14A.2010900@domain.hid>
Date: Wed, 15 Mar 2006 08:24:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Synchronising TSC and periodic timer
References: <44172B67.2000609@domain.hid>
In-Reply-To: <44172B67.2000609@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3A1630478047C930E7E9A0B7"
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
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3A1630478047C930E7E9A0B7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Hi,
>=20
> for those who haven't followed the endless "RTDM and Timer functions"
> thread: we are currently discussing a way to provide high-resolution
> timestamps in periodic mode for RTDM users. It was suggested to use the=

> TSC for this, but I noted that this source will not be in sync with the=

> periodic system timer and may even be out of sync across multiple CPUs.=

>=20
> A straight-forward approach to overcome this might be to record the
> current TSC value together with the current jiffies in
> xntimer_do_tick_periodic(). This tuple (per CPU) could then be provided=

> to skin implementers in order to let them offer a high-resolution
> timestamp source even in periodic mode. Hmm, sounds too simple actually=
,
> so I'm waiting now for someone pointing out the pitfalls.

Likely too simple: The periodic IRQ seems to pop up on every CPU so that
the TSC could be recorded, but will this happen synchronously? At least
we will see (IRQ) jitters, and those jitters could already create in the
single-CPU case a non-monotonic clock...

Does anyone ever studied if and how Linux synchronises across CPUs?
There was some activity around the problematic AMD64 multicores, but I
haven't looked at the details and if it's actually solved now.

Jan


--------------enig3A1630478047C930E7E9A0B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEF8FKniDOoMHTA+kRAm1pAJ9mEJQ1wg1T1NXk+Sj70S/PrjIoPwCbB8wQ
zI3ej5xD3rFGYVuJn9Uh92M=
=C4Aa
-----END PGP SIGNATURE-----

--------------enig3A1630478047C930E7E9A0B7--

