Message-ID: <45802F00.1090008@domain.hid>
Date: Wed, 13 Dec 2006 17:49:04 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7826283157D86B9FAB3C58CB"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] 2.6.19: Fix irq_disable in early start_kernel
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>, Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7826283157D86B9FAB3C58CB
Content-Type: multipart/mixed; boundary="------------020406020302030401090607"

This is a multi-part message in MIME format.
--------------020406020302030401090607
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

this was a nice bug: After applying some totally unrelated cleanup patch
that removes a few useless EXPORT_SYMBOLS from ipipe, I got this during
boot:

=2E..
Xenomai: hal/x86 started.
BUG: unable to handle kernel NULL pointer dereference at virtual address
000000f1
=2E..
EIP is at kref_get+0x9/0x43
=2E..
Call Trace:
 [<c020e077>] kobject_get+0x12/0x17
 [<c01c28ae>] sysfs_create_link+0xda/0x140
 [<c02412bb>] class_device_add+0x217/0x3dc
 [<c0241492>] class_device_register+0x12/0x15
 [<c0241519>] class_device_create+0x84/0xa5
 [<c022fe47>] misc_register+0x109/0x140
 [<c0142748>] xnheap_mount+0x9a/0xa2
 [<c03fad0c>] __xeno_sys_init+0xd9/0x15d
 [<c01004d0>] init+0x127/0x2dc
 [<c0103e97>] kernel_thread_helper+0x7/0x10

The reason: xnheap_dev.dev=3D1!? But that field is located untouched in a=

static structure, i.e. *must* be 0! Interrupting the kernel shortly
after boot already returned it as 1. Finally, after breaking at the
beginning of start_kernel, I got the expected 0 and then quickly found
the messed-up piece of code a few lines below.

Please apply attached patch, I suspect it is a typo (ipipe isn't
initialised at this point to handle such requests, so the stall bit
ended up in xnheap_dev for me - who knows what can happen on other
setups...).

Jan

--------------020406020302030401090607
Content-Type: text/plain;
 name="fix-irq_disable-in-start_kernel.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="fix-irq_disable-in-start_kernel.patch"

---
 init/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19/init/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19.orig/init/main.c
+++ linux-2.6.19/init/main.c
@@ -489,7 +489,7 @@ asmlinkage void __init start_kernel(void
 	unwind_init();
 	lockdep_init();
=20
-	local_irq_disable_head();
+	local_irq_disable_hw();
 	early_boot_irqs_off();
 	early_init_irq_lock_class();
=20

--------------020406020302030401090607--

--------------enig7826283157D86B9FAB3C58CB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFgC8AniDOoMHTA+kRAvmiAJ9PFw3GaSPxPwBmsAsa5FUfuiBFTwCeLp9T
c50e7IRPXbRZ/b6D1jECGXs=
=yrNY
-----END PGP SIGNATURE-----

--------------enig7826283157D86B9FAB3C58CB--

