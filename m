Message-ID: <43E46EDA.7060304@domain.hid>
Date: Sat, 04 Feb 2006 10:07:38 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM mmap alternative
References: <20060203192739.87567.qmail@domain.hid>
In-Reply-To: <20060203192739.87567.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig37BDB405C7E8588EC7396D01"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig37BDB405C7E8588EC7396D01
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan, I'm back on this discussion.
>=20
> At the time I asked you, you told me to do the mmap on driver
> initialization.
>=20
> But now, I realized that, since I'll be using RTDM, how could I use
> mmap from RTDM, even if in a non RT-context?

Which mapping step are you now referring to, the one to get the large
physical DMA area inside the kernel address space or the one to map
kernel addresses to user space? Already checked the related LDD3 chapter
for this?

>=20
> I'm a bit confusing...
>=20
> What would be others alternatives for avoid copying the video frames
> in a RTDM driver?

Either map or copy, there is no third way. The point is just which
mapping functions to use and when.

Jan


--------------enig37BDB405C7E8588EC7396D01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD5G7aniDOoMHTA+kRAp1gAJ4zlwC4Io2EWmTKLvqjasjZmYMC1QCeOHji
rlx0g9o4yp4R7lzKKHPlaZg=
=0XDg
-----END PGP SIGNATURE-----

--------------enig37BDB405C7E8588EC7396D01--

