Message-ID: <46269641.8090005@domain.hid>
Date: Thu, 19 Apr 2007 00:05:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46265FC8.1070207@domain.hid>	<1176926837.5010.90.camel@domain.hid>	<17958.32569.506331.124185@domain.hid>	<4626888F.4010300@domain.hid>
	<17958.36330.124456.342196@domain.hid>
In-Reply-To: <17958.36330.124456.342196@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5ED7EE5A72C6E564BEE0DBF2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [BUG] target width of shifts on 64 bits
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
--------------enig5ED7EE5A72C6E564BEE0DBF2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > - the posix registry
>  > >=20
>  > > Is it enough to replace 1 << (fd % BITS_PER_LONG)=20
>  > > with 1L << (fd % BITS_PER_LONG) ?
>  > >=20
>  >=20
>  > Yes, of course!
>=20
> But ffs on x86_64 takes an int as argument, not a long. So, my best
> option is to replace BITS_PER_LONG with 32 and work with ints instead o=
f
> longs.

Or we switch to __ffs, which operates on ulong.


--------------enig5ED7EE5A72C6E564BEE0DBF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGJpZCniDOoMHTA+kRAicnAJ0U/h3el354IyUv00Gn1NtKS/hDhQCfUUqZ
v5iX9HpU3r9ZTnOwCC6aeJs=
=maaR
-----END PGP SIGNATURE-----

--------------enig5ED7EE5A72C6E564BEE0DBF2--

