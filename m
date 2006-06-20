Message-ID: <4497D7F2.9090001@domain.hid>
Date: Tue, 20 Jun 2006 13:11:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] User-space DMA transfer and I/O access from Xenomai
	API
References: <923F5E294B7B194EA41B7B11DAE5330B1A9F3990@domain.hid>
In-Reply-To: <923F5E294B7B194EA41B7B11DAE5330B1A9F3990@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F61762A270E33EC36227001"
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
To: "Merilainen, Jussi (GE Healthcare)" <jussi.merilainen@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6F61762A270E33EC36227001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Merilainen, Jussi (GE Healthcare) wrote:
> =20
>=20
> I'm porting a PCI driver for a custom board from VxWorks to Xenomai/Lin=
ux. My goal is to keep the driver as much as possible in user-space. Impl=
ementing the HW interrupt handler should be quite straight forward as pre=
sented in 'Writing user-space device drivers' in Native-API-Tour manual.
> My concern is the PCI DMA transfer. Does the Xenomai API provide any su=
pport for this in user-space? Does anyone have experience on this subject=
?

Actually, this need not be a Xenomai-specific issue. User space device
drivers are of increasing common interest in the Linux community. I only
collected some projects so far, I did not dig into the APIs:

- libpci as part of the pciutils provides ways to access device
  information, don't know if it also allows to map DMA memory to user
  space.

- The Gelato project [1] developed some libs and kernel patches for user
  level drivers.

- Don't know if it is related to the former, but this research project
  [2] implemented user-level drivers as well.

- David Schleef's usddk [3] is another user space driver development
  lib, but it looks a bit premature.

Why am I listing these? Xenomai is not providing PCI access functions,
and I'm not sure yet if it actually has to do this on its own (in user
space, in kernel definitely not). All init/cleanup work can perfectly
use standard Linux infrastructure - if there is one of course. Only
services which may need rescheduling in time-critical contexts (IRQ
handlers, RT tasks) have to be mapped on the Xenomai infrastructure.

Nevertheless, user space support for RTDM, Xenomai's driver model, is
planned, so I'm already collecting input on what services are
additionally required and may have to be provided by RTDM itself (and
not some third-party lib). So, if you find some solution or anyone else
has ideas, please let me know.

> Another thing is the Device I/O handling from user-space. Simple questi=
on: how do I perform read/write operations? In VxWorks, I have for exampl=
e following function for reading an I/O register of the board:
> ...

On x86, iopl() or ioperm() opens in/out to a user space process. Memory
mapped I/O should be accessible via /dev/mem on any arch.

Jan


[1] http://www.gelato.unsw.edu.au/IA64wiki/UserLevelDrivers
[2] http://www.ertos.nicta.com.au/research/uldd/
[3] http://www.schleef.org/usddk/


--------------enig6F61762A270E33EC36227001
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEl9f2niDOoMHTA+kRAp69AJ0QRa1uJHxCurOI4/+U6gzm4v7utwCfVGIP
WrNuSP+6UEqn39D9qj3byM0=
=8AAr
-----END PGP SIGNATURE-----

--------------enig6F61762A270E33EC36227001--

