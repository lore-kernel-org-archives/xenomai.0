Message-ID: <44BFFC62.8030601@domain.hid>
Date: Thu, 20 Jul 2006 23:57:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Xenomai v2.2
References: <1153227929.5029.25.camel@domain.hid>
	<44BE8ECF.2050608@domain.hid>	<44BE943E.80302@domain.hid>
	<44BEA974.40708@domain.hid> <44BFC5FA.6080608@domain.hid>
In-Reply-To: <44BFC5FA.6080608@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3761A4D1387C8C4D352C063C"
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
To: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3761A4D1387C8C4D352C063C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hannes Mayer wrote:
> Jan Kiszka wrote:
>> Hannes Mayer wrote:
>>> ...out of curiosity and to test an older example, I compiled
>>> in periodic timer support, recompiled and then it oopses
>>> at boot. Screenshot:
>>> http://www.captain.at/tmp/dsc05081.jpg
>>> *shrugs*
>>
>> .config please. And it would also be more helpful if you could switch =
on
>> debug symbols so that the oopses tell us where they happened. So this
>> happened during boot or when running your test?
>=20
> debug symbols ? Can't find anything else the debug option in "kernel
> hacking" and in "xeno->nucleus". Just enabled both, but no more info
> at the oops. Oops at booting, BTW.

Hmm, 2.4 limitation. There used to by some tool called ksymoops for
this. Please give it a try.

> .config later

Looking forward. Meanwhile I actually have a 2.4 kernel running here
(and found two compilation quirks in my code at this chance). Though I
switched on periodic mode, no oops here. And xeno_16550A loads fine as we=
ll.

Jan


--------------enig3761A4D1387C8C4D352C063C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEv/xmniDOoMHTA+kRAk85AJoDQY+sbCijLKIQQghqWz3XpqezcwCeKQup
83iSVPbusLmGy9zVpwb9j4A=
=YtD3
-----END PGP SIGNATURE-----

--------------enig3761A4D1387C8C4D352C063C--

