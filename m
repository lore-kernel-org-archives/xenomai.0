Message-ID: <45CDC5AE.5010903@domain.hid>
Date: Sat, 10 Feb 2007 14:16:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45CDAA95.1070900@domain.hid>
In-Reply-To: <45CDAA95.1070900@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9C7D13A0211B8AFA7ED1E0D0"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] Re: tracer broken on 2.6.20-i386
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9C7D13A0211B8AFA7ED1E0D0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:

> Philippe,
>
> have you had to adopt any tracer-related code while switching to 2.6.20=
?
> The same .config that worked fine for 2.6.19 doesn't boot here on
> 2.6.20. The kernel hangs during or after decompression. Disabling the
> tracer resolves this.
>  =20

I had a look at latest -rt and found some new change (which turned out
to be a hack). Playing with it, I understood its motivation (avoid
instrumentation of the decompressor). Here comes a cleaner variant for
2.6.20 (all archs). Tracer boots fine again. :)

Jan


Index: linux-2.6.20/arch/i386/boot/compressed/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/boot/compressed/Makefile
+++ linux-2.6.20/arch/i386/boot/compressed/Makefile
@@ -9,6 +9,7 @@ targets		:=3D vmlinux vmlinux.bin vmlinux.
 EXTRA_AFLAGS	:=3D -traditional
=20
 LDFLAGS_vmlinux :=3D -T
+CFLAGS :=3D $(subst -pg,,$(CFLAGS))
 CFLAGS_misc.o +=3D -fPIC
 hostprogs-y	:=3D relocs
=20



--------------enig9C7D13A0211B8AFA7ED1E0D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFzcWuniDOoMHTA+kRAoqSAJ9vppidFmio8o70+zNbshYRkPEIYgCfS969
85NH8tqKxPsbwa7i6+gq1bc=
=t/cM
-----END PGP SIGNATURE-----

--------------enig9C7D13A0211B8AFA7ED1E0D0--

