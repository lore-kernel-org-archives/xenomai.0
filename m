Message-ID: <43FF18FF.20001@domain.hid>
Date: Fri, 24 Feb 2006 15:32:31 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43FF13BE.7080505@domain.hid> <43FF166A.1060508@domain.hid>
In-Reply-To: <43FF166A.1060508@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig092A998BE37E3721193A291D"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: skin libs, libtool warnings, and -module
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig092A998BE37E3721193A291D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi Philippe,
>>
>> I noticed you fixed the libtool warning during xenomai build - by
>> linking the testsuite statically... :-/ This is just a workaround and
>> doesn't help external users.
>=20
> Yes, it's clearly hacky-patchy, however, I don't see how this would
> impact external users (yet)?

Those who also use libtool for their apps...

>=20
>>
>> Isn't the reason for this warnings that "-module" in every skin
>> Makefile.am? At least, removing it also fixes external apps. Do we nee=
d
>> it? I don't think so: -module is for preparing dlopen usage, but who
>> will use it with skin libs?
>=20
>=20
> E.g. People who need to do late binding from some interpreter engine to=

> the routines defined by those APIs.
>=20

Well, then we may better hack the related *.la files when installing
them ("shouldnotlink=3Dno"). I must confess that I still don't understand=

the reason behind this, but it seems that this warning is really useless
at least on Linux.

Jan


--------------enig092A998BE37E3721193A291D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD/xj/niDOoMHTA+kRAoaiAJ46f/g3YzQbLEaDaRfP5VoFVrTiBwCeNlzu
05TuFNVGa63qwA8/uhy2LvM=
=k5Sb
-----END PGP SIGNATURE-----

--------------enig092A998BE37E3721193A291D--

