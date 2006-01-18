Message-ID: <43CE895B.9060506@domain.hid>
Date: Wed, 18 Jan 2006 19:30:51 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43CD16C8.4000009@domain.hid>
	<17357.6643.403829.486469@domain.hid>
In-Reply-To: <17357.6643.403829.486469@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig29B0E945C86745ECE32BF71B"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: --enable-linux-build
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig29B0E945C86745ECE32BF71B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Hi Gilles,
>  >=20
>  > I just tested your new build option. Maybe I'm using it the wrong wa=
y,
>  > but I stumbled over two quirks:
>  >=20
>  >  o "make install-nodev" fails as it tries to install the kernel with=
out
>  >    being root. Actually, I only wanted to install the user space par=
t,
>  >    how can I do this separately? Or is this rather a use-case for th=
e
>  >    standard build?
>=20
> I did not think about this case. Any idea of what would be better ? Not=

> installing kernel when running "make install-nodev" ? Creating=20
> install-nokernel and install-nokernel-nodev targets ?

I would suggest "make install-user" instead of "make install-nodev",
combining both -nodev and -nokernel, i.e. excluding everything that
requires root permissions.

>=20
>  >=20
>  >  o On every "make", the prepare-kernel script is executed -
>  >    intentionally? Maybe it would be better to provide a dedicated ma=
ke
>  >    target to trigger the update.
>=20
> prepare-kernel should be executed whenever any file or directory is
> added in the ksrc and include dirs. On my own machine, prepare-kernel i=
s
> much shorter than the kernel build. So, I did not see this as an issue,=

> but I am ready to accept any better solution. Maybe it could depend on
> maintainer mode ? Since the user-space will work automatically when
> adding a file or directory only if maintainer mode is enabled.
>=20

Yes, this looks good - as long as it is still run on the first make or
during configure.

The point is that I have a non-developer use-case for your build mode in
mind were you do not constantly add files to the xeno code base, but
reconfigure your kernel from time to time: We have mini distribution
here which can optionally be build from source. In that case, you could
soon decide to build
 ( ) Vanilla kernel
 (*) Xenomai-extended kernel and libraries
instead of
 ( ) Vanilla kernel
 (*) Xenomai-extended kernel
   [*] Xenomai libraries
(not to speak about what currently happens in the background...)

Could make life of the maintainer and users here a bit easier.

Thanks for caring,
Jan


--------------enig29B0E945C86745ECE32BF71B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDzolbniDOoMHTA+kRAjNCAJ9g1Y1S5nyLem1k56tYcvnIc4/OsgCfb41h
Xcb8gTp7I1Har4ptVinB1WE=
=yQ3E
-----END PGP SIGNATURE-----

--------------enig29B0E945C86745ECE32BF71B--

