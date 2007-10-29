Message-ID: <472649BF.50909@domain.hid>
Date: Mon, 29 Oct 2007 21:59:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <472630A3.7020802@domain.hid>
In-Reply-To: <472630A3.7020802@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0F1F588BAAB83092F7A66BF2"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] make xenomai/serial/16550A module error
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Dennis Nguyen <dennisnguy@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0F1F588BAAB83092F7A66BF2
Content-Type: multipart/mixed;
 boundary="------------080409080206060603070909"

This is a multi-part message in MIME format.
--------------080409080206060603070909
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dennis Nguyen wrote:
> I tried to build linux kernel 2.6.20.10 with xenomai 2.3.4 with serial =

> 16550A Module (I selected serial 16550A as a M).=20
> (adeos-ipipe-2.6.20-i386-1.10-10.patch)
>=20
> I had an error:
>    CC [M]  drivers/xenomai/serial/16550A.o
> drivers/xenomai/serial/16550A.c: In function =91rt_16550_open=92:
> drivers/xenomai/serial/16550A.c:448: error: incompatible types in assig=
nment
> make[3]: *** [drivers/xenomai/serial/16550A.o] Error 1
> make[2]: *** [drivers/xenomai/serial] Error 2
> make[1]: *** [drivers/xenomai] Error 2
> make: *** [drivers] Error 2
> [root@domain.hid linux-2.6.20.10]#
>=20
> Any suggestion please?

So far for "please use the latest patch". :-/

Some assumption of the 2.3.x branch about what is when defined became
invalid with ipipe-1.10-10, attached patch fixes it. Philippe, please app=
ly.

Jan

--------------080409080206060603070909
Content-Type: text/x-patch;
 name="fix-lock-wrapping.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="fix-lock-wrapping.patch"

Index: xenomai-2.3.x/include/asm-generic/hal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai-2.3.x/include/asm-generic/hal.h	(Revision 3130)
+++ xenomai-2.3.x/include/asm-generic/hal.h	(Arbeitskopie)
@@ -84,20 +84,27 @@
=20
 typedef struct ipipe_domain rthal_pipeline_stage_t;
=20
-#ifdef IPIPE_RW_LOCK_UNLOCKED
+#ifdef IPIPE_SPIN_LOCK_UNLOCKED
 typedef ipipe_spinlock_t rthal_spinlock_t;
 #define RTHAL_SPIN_LOCK_UNLOCKED IPIPE_SPIN_LOCK_UNLOCKED
+#else /* !IPIPE_SPIN_LOCK_UNLOCKED */
+#ifdef RAW_SPIN_LOCK_UNLOCKED
+typedef raw_spinlock_t rthal_spinlock_t;
+#define RTHAL_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
+#else /* !RAW_SPIN_LOCK_UNLOCKED */
+typedef spinlock_t rthal_spinlock_t;
+#define RTHAL_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
+#endif /* !RAW_SPIN_LOCK_UNLOCKED */
+#endif /* !IPIPE_SPIN_LOCK_UNLOCKED */
+
+#ifdef IPIPE_RW_LOCK_UNLOCKED
 typedef ipipe_rwlock_t rthal_rwlock_t;
 #define RTHAL_RW_LOCK_UNLOCKED   IPIPE_RW_LOCK_UNLOCKED
 #else /* !IPIPE_RW_LOCK_UNLOCKED */
 #ifdef RAW_RW_LOCK_UNLOCKED
-typedef raw_spinlock_t rthal_spinlock_t;
-#define RTHAL_SPIN_LOCK_UNLOCKED RAW_SPIN_LOCK_UNLOCKED
 typedef raw_rwlock_t rthal_rwlock_t;
 #define RTHAL_RW_LOCK_UNLOCKED RAW_RW_LOCK_UNLOCKED
 #else /* !RAW_RW_LOCK_UNLOCKED */
-typedef spinlock_t rthal_spinlock_t;
-#define RTHAL_SPIN_LOCK_UNLOCKED SPIN_LOCK_UNLOCKED
 typedef rwlock_t rthal_rwlock_t;
 #define RTHAL_RW_LOCK_UNLOCKED RW_LOCK_UNLOCKED
 #endif /* RAW_RW_LOCK_UNLOCKED */

--------------080409080206060603070909--

--------------enig0F1F588BAAB83092F7A66BF2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJknDniDOoMHTA+kRAmmEAJ0aEQSf18QT9mrg7CpoZZGiEdow/wCeOegL
u+0RtIatjXQQpErrjoKttmk=
=LZ/c
-----END PGP SIGNATURE-----

--------------enig0F1F588BAAB83092F7A66BF2--

