Message-ID: <46554645.90806@domain.hid>
Date: Thu, 24 May 2007 10:01:09 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46543598.8030909@domain.hid>
In-Reply-To: <46543598.8030909@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9CD2AAA65BB4ED65C6B94A46"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Porting driver to RTDM
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9CD2AAA65BB4ED65C6B94A46
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Johan Borkhuis wrote:
> Hello,
>=20
> I am working on porting a Linux VME driver to Xenomai. I am having some=
=20
> ideas on how to do this, but I would like to have some feedback on this=
=2E
>=20
> There are 2 ways to communicate to devices on the VME bus: memory mappe=
d=20
> and using interrupts. At this moment I setup the memory mapping when th=
e=20
> system starts, and then use these mapped areas to read and write from=20
> the devices. The interrupts are processed using a standard interrupt=20
> handler, and a "Wait for interrupt" IOCTL-call is available to wait for=
=20
> a specific interrupt. The driver defines several VME devices: some=20
> control devices and some data devices.
>=20
> My plans for the new driver are to have an RTDM driver next to the=20
> standard Linux driver. I will be using the standard driver for the setu=
p=20
> of the system, like setting up the memory mapping. The RTDM driver will=
=20
> define a RT-control device to perform the interrupt handling and an RTD=
M=20
> IOCTL will be used to wait for the interrupts. This way I can have a=20
> RT-thread to process the interrupts.
>=20
> The reason for this setup are:
>=20
>     * I do not want to rewrite the current driver, as this driver
>       already has all the functionality needed, except for the
>       RT-performance.
>     * The interface to VME devices is done using memory access and no
>       other SW is needed for this. This means that during operational
>       use no driver functions will be accessed.
>     * The memory mapping is not as straight forward in RTDM as it is in=

>       standard Linux: for example there is no mmap function in the
>       device structure.

OK, noted. I will check again if we can do something about this on next
major RTDM rework. I'm considering to refactor typical non-RT entry
points of RTDM drivers anyway.

>     * I can still use drivers for VME devices that depend on the curren=
t
>       driver.
>=20
>=20
> Is this the right way to do this, or are there other ways to implement =
a=20
> driver like this one?

RTDM is not about forcing you do make abstractions if you don't want to.
You say that you already have a (basic) driver model, and so it is fine
to apply it on top of RTDM as well. When RTDM is not optimally providing
services for this, we need to recheck it.

But if you wanted to make your device interface generic, maybe portable
to other hardware of that class, then things need to be looked at from a
different angle.

Jan


--------------enig9CD2AAA65BB4ED65C6B94A46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVUZFniDOoMHTA+kRAqRvAJ4oSu246uY+eD+/UiWTdSbaBcTZLwCfRna3
pgyyhoPs4KPEHjY9/0d9+00=
=5vB3
-----END PGP SIGNATURE-----

--------------enig9CD2AAA65BB4ED65C6B94A46--

