Message-ID: <4BF189BA.6060303@domain.hid>
Date: Mon, 17 May 2010 20:23:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2319761F7FA0D1479BA77EC2E0A8E7BCE3D6E7@domain.hid><245373446233674495BCA5CA2FC1EB17378D01593B@RCexchangeSVR1.ruggedcom.local>	<4BED2910.6020105@domain.hid>	<181804936ABC2349BE503168465576460EBD6239@domain.hid>	<4BF17464.5090100@domain.hid>	<181804936ABC2349BE503168465576460EBD62C8@domain.hid>,
	<4BF1794A.6050207@domain.hid>
	<843773D242212C4882D4EDFFBF665F7F0C9F71BAFF@FW-SBS.fw.local>
In-Reply-To: <843773D242212C4882D4EDFFBF665F7F0C9F71BAFF@FW-SBS.fw.local>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig838B6F1216617BB503DB2F9C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Question about getting system time
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Josh Karch <JKarch@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "Mauerer,
	Wolfgang" <wolfgang.mauerer@domain.hid>, Andreas Glatz <AndreasGlatz@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig838B6F1216617BB503DB2F9C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

[please avoid top posting]

Josh Karch wrote:
> Jan, =20
>=20
> If no ntp server updates are made to the Linux clock,  we have noticed =
over a week's period a drift of ten or so seconds difference between the =
Linux clock and the Xenomai get time function and often have to reboot ou=
r machine to resynchronize the Xenomai and Linux clocks back to less than=
 a couple seconds difference.  I was wondering if you might explain why t=
hat might happen?

I assume you are talking about an x86 platform: Normally, Linux should
run on the TSC clocksource, just like Xenomai does. To ensure that the
hardware isn't broken, Linux continuously performs runtime checks. The
preemption by Xenomai tasks my fool this check an make Linux switch to a
different clocksource. Now you have unsynchronized sources that usually
drift.

I haven't tried this with Xenomai yet but I could imagine it works just
like it does in virtual machines: Pass tsc=3Dreliable on the kernel
command line. This disables the runtime checks, thus should take away
any reason Linux may want to switch to anything else than TSC.

Jan


--------------enig838B6F1216617BB503DB2F9C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvxib4ACgkQitSsb3rl5xT0gQCfat4HbguDrNLg4cntTn+TVkFY
4EMAoO6fh1KnG3JqOVXGIaL2MypDwwvs
=/Oef
-----END PGP SIGNATURE-----

--------------enig838B6F1216617BB503DB2F9C--

