Message-ID: <45FD15BD.8000702@domain.hid>
Date: Sun, 18 Mar 2007 11:34:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM and user space hardware drivers
References: <17648569.1173693688643.JavaMail.ngmail@domain.hid>
In-Reply-To: <17648569.1173693688643.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig837A434CB8CBBBE332E1319B"
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
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig837A434CB8CBBBE332E1319B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi everybody,
>=20
> the RTDM API is really very good as API for drivers.=20
> I have a real time (Xenomai) application in user space that has to acce=
ss PCI boards.
> The "classical" approach is now to use a kernel driver and to use RTDM =
as interface
> between the user space application an the kernel space driver.
> However, for performance issues, I prefer to write a pure user mode dri=
ver.
> As the memory of the PCI board can be accesses from user space (using /=
dev/mem)=20
> I want to write a pure user space driver  as this seems to me more effi=
cient (and easier to debug) than
> a kernel driver.
> Also, only one application is accessing the driver at a time, I can lin=
k the driver directly to my application.
>=20
> My questions are now:
> 1. Is it possible to use the RTDM API also for pure user space drivers?=


There is no RTDM driver API exported to user space yet, it's still just
a plan for the future.

>=20
> 2. Is there any experience concerning the performance of a user space d=
river versus a kernel space
> driver?
> In my use case, I have to write and read about 60 byte (each direction)=
 of (block) data to/from the PCI I/O system.

User space drivers can improve performance if you transfer a lot of data
and save potential user/kernel copy-steps this way (though, zero-copy
can also be realised with kernel drivers) or if you do a lot of driver
calls and the call-overhead becomes noticeable. This works fairly well
for exclusive devices (only one user process at a time). But once you
have to share/multiplex a devices, performance quickly becomes worse.

When going for a user space driver design, make sure you keep a clean
separation between driver and application. [It will be one major goal of
an RTDM for user space to support driver writers in this regard.]

Jan


--------------enig837A434CB8CBBBE332E1319B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF/RW9niDOoMHTA+kRAqyhAJ0dsmYqlkWZgoaM7q8/nk7TMQjwdwCfZzkU
DD1HETTujpbjihlxML7URqA=
=fvVg
-----END PGP SIGNATURE-----

--------------enig837A434CB8CBBBE332E1319B--

