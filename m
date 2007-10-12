Message-ID: <470FD0AC.6040700@domain.hid>
Date: Fri, 12 Oct 2007 21:53:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <470E8BFE.4070804@domain.hid>
	<1192179524.5149.23.camel@domain.hid>	<470F3B03.1040501@domain.hid>
	<20071012110054.GA26325@domain.hid>
In-Reply-To: <20071012110054.GA26325@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF6CD9E4FB2A9ABEE0C6148FF"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] fix hw-timer setup/cleanup for i386
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stelian Pop <stelian@domain.hid>
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6CD9E4FB2A9ABEE0C6148FF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Stelian Pop wrote:
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.22.9-xeno
> # Fri Oct 12 11:45:32 2007
> #
=2E..
> # CONFIG_X86_UP_APIC is not set

As long as APIC is off...

> CONFIG_HPET_TIMER=3Dy

=2E..HPET_TIMER must be off as well. Otherwise, Linux may actually pick u=
p
the HPET which block the PIT for Xenomai usage.

Philippe, can we merge my patch to detect this conflict?

Jan


--------------enigF6CD9E4FB2A9ABEE0C6148FF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFHD9CwniDOoMHTA+kRAuITAJ4sIkNalyT6XItQq3WWO5mzSlZzxgCcCBEu
HWCV8fXYNIdbxTsRuuIjlpY=
=eruF
-----END PGP SIGNATURE-----

--------------enigF6CD9E4FB2A9ABEE0C6148FF--

