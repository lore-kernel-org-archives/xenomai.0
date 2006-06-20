Message-ID: <4497DF78.7020508@domain.hid>
Date: Tue, 20 Jun 2006 13:43:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] User-space DMA transfer and I/O access from Xenomai
	API
References: <923F5E294B7B194EA41B7B11DAE5330B1A9F3990@domain.hid>	<4497D7F2.9090001@domain.hid>
	<17559.56387.507326.790229@domain.hid>
In-Reply-To: <17559.56387.507326.790229@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC485ABAD381090AB78E58F70"
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC485ABAD381090AB78E58F70
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>  > Merilainen, Jussi (GE Healthcare) wrote:
>  > > =20
>  > >=20
>  > > I'm porting a PCI driver for a custom board from VxWorks to Xenoma=
i/Linux. My goal is to keep the driver as much as possible in user-space.=
 Implementing the HW interrupt handler should be quite straight forward a=
s presented in 'Writing user-space device drivers' in Native-API-Tour man=
ual.
>  > > My concern is the PCI DMA transfer. Does the Xenomai API provide a=
ny support for this in user-space? Does anyone have experience on this su=
bject?
>  >=20
>  > Actually, this need not be a Xenomai-specific issue. User space devi=
ce
>  > drivers are of increasing common interest in the Linux community. I =
only
>  > collected some projects so far, I did not dig into the APIs:
>  >=20
>  > - libpci as part of the pciutils provides ways to access device
>  >   information, don't know if it also allows to map DMA memory to use=
r
>  >   space.
>=20
> libpci allow user-space to retrieve the bus addresses of memory
> regions of each PCI device. Mmaping this memory may be done using
> /dev/mem. But usually, PCI devices do DMA the other way around: they ar=
e
> passed the physical address of some RAM, become bus-master and write
> directly to this RAM. So what is needed is:
> - to map some physically contiguous RAM region to user-space;
> - get the physical addres of this region in order to pass it to the PCI=

>   device to program the DMA.
>=20
> Xenomai allow you to map to user-space some physically contiguous RAM
> region (using either native heaps or posix shared memory smaller than
> 128K), but does not provide accessors to the RAM physical
> address. Is it what you need ?
>=20

I think we are primarily looking for some user space
dma_map_*/dma_unmap_* support here - which also has to be RT-safe.

Jan


--------------enigC485ABAD381090AB78E58F70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEl994niDOoMHTA+kRAifzAJ9Qvgo4LeicER2P9LE72XHEc6LjigCfeeDn
+28WM2n0HmlR6aL2JmAqH4E=
=I3HM
-----END PGP SIGNATURE-----

--------------enigC485ABAD381090AB78E58F70--

