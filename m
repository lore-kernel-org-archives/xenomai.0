Message-ID: <4603E145.3000909@domain.hid>
Date: Fri, 23 Mar 2007 15:16:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] New install of Xenomai 2.3 for 2.6.17 kernel....
	Various problems
References: <032320071404.24123.4603DE73000D814600005E3B2216557996070E0301020A98@domain.hid>
In-Reply-To: <032320071404.24123.4603DE73000D814600005E3B2216557996070E0301020A98@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8A6D9CBCC80DF34E89A5D4F0"
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
To: xenomai@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8A6D9CBCC80DF34E89A5D4F0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

xenomai@domain.hid wrote:
> Hello,
>=20
> I have been working on trying to find the optimal linux kernel
> configuration and have noticed a couple problems.  No matter what I
> do it seems that while cpu #2 is detected, nothing gets scheduled on

Sounds like some bug that was fixed in 2.3.1. Are you already using that
version? If not: highly recommended.

> it.  Also, there is always a modprobe process running at 100%cpu that
> I can't kill.  The command that is showed in top is "modprobe -s ac".

Probably due to SMI being disable. Don't know what that module precisely
does when it loops, but it may wait on SMI-backed activity of the
hardware that is now disabled. Try to switch off CONFIG_ACPI_AC in your
config.

> If I run it from the command line it hangs as well.  Latencies are
> however very acceptable when running xeno-test.  I do however see
> some negative values in the test output.
>=20
> The config file that I am using currently is the same as the one
> below just with CONFIG_XENO_HW_SMI_ALL.  This seems to give me the
> best latencies.
>=20
> Mike
>=20

Jan


--------------enig8A6D9CBCC80DF34E89A5D4F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGA+FFniDOoMHTA+kRAhkzAJ9k3zWSG7rP61NEZ+Y3TkSLv3gd1QCeMQha
T39vLdWN3DT8xKCWrEh1Yxg=
=8mYO
-----END PGP SIGNATURE-----

--------------enig8A6D9CBCC80DF34E89A5D4F0--

