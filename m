Message-ID: <44589824.1080204@domain.hid>
Date: Wed, 03 May 2006 13:46:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] ipipe/tracer.c compiling error
References: <AD78122AD7C05B4B936EBAD7F49738C0AB2B39@domain.hid>
In-Reply-To: <AD78122AD7C05B4B936EBAD7F49738C0AB2B39@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig261C3669FF9FCB94FF5C9D40"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Lauener Nathan <Nathan.Lauener@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig261C3669FF9FCB94FF5C9D40
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Lauener Nathan wrote:
> Hi,=20
> I just patched my adeos enhanced kernel with
> "ipipe-tracer-2.6.15-i386-1.3.0-00.patch". When compiling the kernel
> with the tracer switched on I get the following compile error:
> kernel/ipipe/tracer.c:122: error: bad syntax before "void". It seems th=
e
> compiler does not recognice "notrace". Did I miss something when
> patching the kernel?

notrace is defined in the patched linkage.h, and this one comes with
your patch revision:

--- 2.6.15/include/linux/linkage.h
+++ 2.6.15-ipipe/include/linux/linkage.h
@@ -51,4 +51,8 @@
 #define fastcall
 #endif

+#ifndef notrace
+#define notrace		__attribute__((no_instrument_function))
+#endif
+
 #endif

Moreover, just yesterday I compiled a 2.6.15.3 kernel with that revision
+ tracer but without problems... strange.

Jan


--------------enig261C3669FF9FCB94FF5C9D40
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEWJgkniDOoMHTA+kRAtk8AJ9iRxBKuBXTDJdNj9N0IgSZx3rv7ACdFuuB
Ed0umwRVZ57JRsuNSjK36WM=
=6gwM
-----END PGP SIGNATURE-----

--------------enig261C3669FF9FCB94FF5C9D40--

