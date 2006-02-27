Message-ID: <4403071A.6010703@domain.hid>
Date: Mon, 27 Feb 2006 15:05:14 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Re: skin libs, libtool warnings, and -module
References: <43FF13BE.7080505@domain.hid> <43FF166A.1060508@domain.hid>
	<43FF18FF.20001@domain.hid>
In-Reply-To: <43FF18FF.20001@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig41EB18C31D32F74D4B80CADE"
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41EB18C31D32F74D4B80CADE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Philippe Gerum wrote:
>> Jan Kiszka wrote:
>>> Hi Philippe,
>>>
>>> I noticed you fixed the libtool warning during xenomai build - by
>>> linking the testsuite statically... :-/ This is just a workaround and=

>>> doesn't help external users.
>> Yes, it's clearly hacky-patchy, however, I don't see how this would
>> impact external users (yet)?
>=20
> Those who also use libtool for their apps...
>=20
>>> Isn't the reason for this warnings that "-module" in every skin
>>> Makefile.am? At least, removing it also fixes external apps. Do we ne=
ed
>>> it? I don't think so: -module is for preparing dlopen usage, but who
>>> will use it with skin libs?
>>
>> E.g. People who need to do late binding from some interpreter engine t=
o
>> the routines defined by those APIs.
>>
>=20
> Well, then we may better hack the related *.la files when installing
> them ("shouldnotlink=3Dno"). I must confess that I still don't understa=
nd
> the reason behind this, but it seems that this warning is really useles=
s
> at least on Linux.
>=20

And this is an attempt to silence them at least for the installed
libnative.la:

--- src/skins/native/Makefile.am        (revision 612)
+++ src/skins/native/Makefile.am        (working copy)
@@ -20,3 +20,9 @@
 libnative_la_CPPFLAGS =3D \
 	@XENO_USER_CFLAGS@ \
 	-I$(top_srcdir)/include
+
+install-exec-hook:
+	for la in $(lib_LTLIBRARIES); do \
+	    sed -e 's/shouldnotlink=3Dyes/shouldnotlink=3Dno/'
$(DESTDIR)$(libdir)/$$la > $(DESTDIR)$(libdir)/$$la.patched; \
+	    mv $(DESTDIR)$(libdir)/$$la.patched $(DESTDIR)$(libdir)/$$la; \
+	done

Jan


--------------enig41EB18C31D32F74D4B80CADE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEAwcaniDOoMHTA+kRAnNNAJ9zq2R3cRsp2ewaGSA8yOf3GN4LUwCfXoLs
Vy//dJMwjM7+0M4m6Q+1IrA=
=bIoI
-----END PGP SIGNATURE-----

--------------enig41EB18C31D32F74D4B80CADE--

