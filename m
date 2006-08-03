Message-ID: <44D26C50.20000@domain.hid>
Date: Thu, 03 Aug 2006 23:36:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Interrupt Problem.
References: <20060803154437.90346.qmail@domain.hid>
In-Reply-To: <20060803154437.90346.qmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB498F8A27111BC0A6109B6AE"
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
To: shailesh joshi <zoshi_s@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB498F8A27111BC0A6109B6AE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

shailesh joshi wrote:
> Hello,
>   =20
>   I am trying to interfce a DAQ board to a PC via a PCI card. I am faci=
ng the following problem:
>   =20
>   I am trying to send an interrupt from the Board to the PC. However, t=
he interrupt is only registered in the PCI cards internal registers and n=
ot by Xenomai, ie.  the /proc/xenomai/ interface registers interrupt 10 i=
n the list (namely, handler is being installed) but the count for both cp=
us remains at 0.=20
>   =20
>   To give a hint of the code, i am using a modified version of the RTDM=
 driver example from captain.at. The only parts i haven't incorporated ar=
e those for MMAP, else the code is fast the same. Could anyone suggest wh=
at i might be doing wrong here??

Do you happen to have some standard Linux driver for your DAQ board?
Does it work on your target? Are you sure you correctly initialise and
enable IRQ delivery on the board?

BTW, already tried the irqbench the comes with recent Xenomai? Does it
work on your box (yet another IRQ delivery test, and it's RTDM based)?

Jan


--------------enigB498F8A27111BC0A6109B6AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFE0mxQniDOoMHTA+kRArlwAJ4u6Hl98mZpDSdLUyIt2TOh5Mo8OwCeLSL/
dQ8yb6ifKAtSx5VkSe7mNk4=
=JD3J
-----END PGP SIGNATURE-----

--------------enigB498F8A27111BC0A6109B6AE--

