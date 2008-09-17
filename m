Message-ID: <48D177B1.7000009@domain.hid>
Date: Wed, 17 Sep 2008 23:33:37 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48CE8CE7.6030209@domain.hid>
In-Reply-To: <48CE8CE7.6030209@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1262FD3B43125B1325717756"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] keyboard interrupt
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Harco Kuppens <h.kuppens@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1262FD3B43125B1325717756
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Harco Kuppens wrote:
> Hi,
>=20
> I tried to make a demo program which showed how that user space task
> waiting for an interrupt with rt_intr_wait automatically gets an
> increase in priority when the interrupt arrives so that it can be deale=
d
> with immediately.
>=20
> In my program I use the keyboard interrupt IRQ=3D1. I have a priority t=
ask
> doing spinning for 3 seconds using 100% of theCPU. During this spinning=

> I want to test if a low priority task can still get an interrupt from
> the keyboard by letting the end user type some letters on the keyboard =
when
> My program works but only  the first interrupt gets caught when the hig=
h
> priority task is running. The following interrupts are only dealed with=

> when the high priority task is done.
> Probably because linux first has to finish the first interrupt?

Exactly. You forward the IRQ to Linux, thus you reply on Linux for
dealing with the periphery (acking the IRQ there) and the final
end-of-IRQ signal.

> I thought that the adeos pipeline kept  interrupts on a hold between
> xenomai and linux, until xenomai has done its work. But in my example i=
t
> seems that the second interrupt has to wait for linux has finished
> handling the first interrupt. That is really something you don't want.
>=20
> Is my interpretation wrong, or do I something wrong in my code?

IRQ sharing between deterministic and non-deterministic code (here:
Xenomai and vanilla Linux) will never work, that's an inherent design
issue, nothing Xenomai or ipipe-specific.

Jan


--------------enig1262FD3B43125B1325717756
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjRd7EACgkQniDOoMHTA+loaQCeIKu5v7t7bZ5hcEBSFykGTMPF
yWIAn3PW6xjan1gWp2LaJ1UEAB6fXFQO
=S7J+
-----END PGP SIGNATURE-----

--------------enig1262FD3B43125B1325717756--

