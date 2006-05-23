Message-ID: <447375CC.2010406@domain.hid>
Date: Tue, 23 May 2006 22:51:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Re: RTDM driver questions
References: <050720061514.21865.445E0ED2000D33230000556922058863609C0E0301089BD2040A969B0799@domain.hid>
	<200605212119.53330.witzel.thomas@domain.hid>
	<4472D22B.5040703@domain.hid>
	<200605232029.42503.witzel.thomas@domain.hid>
In-Reply-To: <200605232029.42503.witzel.thomas@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6A541776D5F6C8E064200248"
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
To: witzel.thomas@domain.hid
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6A541776D5F6C8E064200248
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Thomas Witzel wrote:
> On Tuesday 23 May 2006 09:13, Jan Kiszka wrote:
>> Thomas Witzel wrote:
>> Why not extending your sample buffer to some FIFO by providing more sp=
ace?
>=20
> That is exactly my thinking, but either I'm blind, or I can't see any F=
IFO=20
> functionality in rtdm. I could implement it myself, but I'm asking here=
 in=20
> case that I might not have to do this.

Probably because it's either too simple or too specific. Take a look at
this FIFO [1] e.g. It handles single network packets, with or without
locking dependent on the number of readers/writers. Would look different
again if you decide to dequeue more than one packet at a time. Further
FIFOs are contained in the 16550A driver, but I do not see urging
similarities between all of them.

Anyway, if someone drafts a generic FIFO for RTDM, I would definitely
welcome this. Would not be the first time users came up with concrete
scenarios, and we finally added a useful new feature.

Jan


[1]http://www.rts.uni-hannover.de/rtnet/lxr/source/stack/include/rtskb_fi=
fo.h?v=3DSVN


--------------enig6A541776D5F6C8E064200248
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEc3XMniDOoMHTA+kRAtmHAJ9VYGGA7ZRKlW6VyzLNGv7Yr9CF8gCfQHqv
tbpBh31mqhpfY13OFJvKawA=
=WKK8
-----END PGP SIGNATURE-----

--------------enig6A541776D5F6C8E064200248--

