Message-ID: <4399AE7A.2030507@domain.hid>
Date: Fri, 09 Dec 2005 17:19:06 +0100
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [bug?] set pthread stack size broken
References: <4398B958.8040705@domain.hid> <4399313A.6090004@domain.hid>
In-Reply-To: <4399313A.6090004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6CB9EC31346806ACAA9221D0"
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6CB9EC31346806ACAA9221D0
Content-Type: multipart/mixed; boundary="------------090903000305010003000809"

This is a multi-part message in MIME format.
--------------090903000305010003000809
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> something for the night: Can someone explain why normal pthreads can b=
e
>> restricted to initially use only the stack size provided via
>> pthread_attr_setstacksize() while any rt-mapped thread (posix and
>> native) refuse to accept this? For a simple test, compile the attached=

>> program one time as normal
>>
>>     gcc -lpthread -o stacksize stacksize.c
>>
>> and the other time against xeno's posix skin
>>
>>     gcc `xeno-config --posix-cflags` `xeno-config --posix-ldflags` \
>>         -o stacksize.o stacksize.c
>>
>> Then compare the memory requirements of both processes - they should
>> differ by 2M, the stack size when pthread_attr_setstacksize is not use=
d.
>> Strange - and also critical when considering larger applications...
>=20
> This has been nailed down now to be some strange linker problem: while
> the standard version of the stacksize demo calls the latest
> pthread_create (__pthread_create_2_1 in glibc-2.3.x), the wrapped
> real-time version and likely also applications linked against libnative=

> call an older pthread_create (__pthread_create_2_0). That variant
> assumes that pthread_attr_t does not yet contain things like the stack
> size and fills in the standard value again. :(
>=20
> Can anyone with another build environment than my SuSE 10 confirm this?=

>=20
>> So far I only tested against 2.1, but I don't see a reason why 2.0.x
>> should behave different. Will get checked, though.
>>
>=20
> Same behaviour on 2.0.x (SVN).
>=20
> Jan
>=20

The attached patch fixes this issue for 2.1-SVN. A similar patch should
be applied to 2.0.x as well. And maybe it also hits the UVM, but this is
something I cannot assess ATM.

Well, you know, the smaller the bug... :-/

Jan


PS: For those you are interested why we need this, read

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D145941

Found via google:"pthread_create NOTYPE" after I noticed the differences
in "readelf -s libnative.so".

--------------090903000305010003000809
Content-Type: text/plain;
 name="setstacksize.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="setstacksize.patch"

Index: src/skins/native/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/native/Makefile.am	(revision 243)
+++ src/skins/native/Makefile.am	(working copy)
@@ -1,6 +1,6 @@
 lib_LTLIBRARIES =3D libnative.la
=20
-libnative_la_LDFLAGS =3D -module -version-info 0:0:0
+libnative_la_LDFLAGS =3D -module -version-info 0:0:0 -pthread
=20
 libnative_la_SOURCES =3D \
 	alarm.c \
Index: src/skins/posix/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- src/skins/posix/Makefile.am	(revision 243)
+++ src/skins/posix/Makefile.am	(working copy)
@@ -2,7 +2,7 @@
=20
 lib_LTLIBRARIES =3D libpthread_rt.la
=20
-libpthread_rt_la_LDFLAGS =3D -module -version-info 0:0:0
+libpthread_rt_la_LDFLAGS =3D -module -version-info 0:0:0 -lpthread
=20
 libpthread_rt_la_SOURCES =3D \
 	init.c \

--------------090903000305010003000809--

--------------enig6CB9EC31346806ACAA9221D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDma56ncNeS9Q0k+IRAiHOAJ93gE6mhwIudwDs212kY18IuvnUdQCfYclX
/ErWj6P0XfisEu2I4s9jwVE=
=q9WS
-----END PGP SIGNATURE-----

--------------enig6CB9EC31346806ACAA9221D0--

