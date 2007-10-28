Message-ID: <47246784.8070402@domain.hid>
Date: Sun, 28 Oct 2007 11:42:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig945B1741AABFD81C411C8BC7"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] harden MTRR access
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig945B1741AABFD81C411C8BC7
Content-Type: multipart/mixed;
 boundary="------------040801030209050203070606"

This is a multi-part message in MIME format.
--------------040801030209050203070606
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Running Xenomai's latency test while firing up X not just points out
once again long delays due to MTRR fiddling and wbinvd invocation - it
simply locks up the box! The reason is that MTRR fiddling needs hard IRQ
protection, which this patch introduces. Note: I focused on standard
MTRR, skipping the legacy CPUs (and dead MTRR code).

Jan

--------------040801030209050203070606
Content-Type: text/x-patch;
 name="harden-mtrr.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="harden-mtrr.patch"

---
 arch/i386/kernel/cpu/mtrr/generic.c |    8 ++++----
 arch/i386/kernel/cpu/mtrr/main.c    |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6.23.1-xeno/arch/i386/kernel/cpu/mtrr/generic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/cpu/mtrr/generic.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/cpu/mtrr/generic.c
@@ -392,14 +392,14 @@ static void generic_set_all(void)
 	unsigned long mask, count;
 	unsigned long flags;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	prepare_set();
=20
 	/* Actually set the state */
 	mask =3D set_mtrr_state();
=20
 	post_set();
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
=20
 	/*  Use the atomic bitops to update the global mask  */
 	for (count =3D 0; count < sizeof mask * 8; ++count) {
@@ -427,7 +427,7 @@ static void generic_set_mtrr(unsigned in
=20
 	vr =3D &mtrr_state.var_ranges[reg];
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
 	prepare_set();
=20
 	if (size =3D=3D 0) {
@@ -446,7 +446,7 @@ static void generic_set_mtrr(unsigned in
 	}
=20
 	post_set();
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 int generic_validate_add_page(unsigned long base, unsigned long size, un=
signed int type)
Index: linux-2.6.23.1-xeno/arch/i386/kernel/cpu/mtrr/main.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/cpu/mtrr/main.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/cpu/mtrr/main.c
@@ -149,7 +149,7 @@ static void ipi_handler(void *info)
 	struct set_mtrr_data *data =3D info;
 	unsigned long flags;
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	atomic_dec(&data->count);
 	while(!atomic_read(&data->gate))
@@ -167,7 +167,7 @@ static void ipi_handler(void *info)
 		cpu_relax();
=20
 	atomic_dec(&data->count);
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 #endif
@@ -237,7 +237,7 @@ static void set_mtrr(unsigned int reg, u
 	if (smp_call_function(ipi_handler, &data, 1, 0) !=3D 0)
 		panic("mtrr: timed out waiting for other CPUs\n");
=20
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	while(atomic_read(&data.count))
 		cpu_relax();
@@ -273,7 +273,7 @@ static void set_mtrr(unsigned int reg, u
 	while(atomic_read(&data.count))
 		cpu_relax();
=20
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 /**
@@ -726,11 +726,11 @@ void mtrr_ap_init(void)
 	 * 2.cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug lock to
 	 * prevent mtrr entry changes
 	 */
-	local_irq_save(flags);
+	local_irq_save_hw(flags);
=20
 	mtrr_if->set_all();
=20
-	local_irq_restore(flags);
+	local_irq_restore_hw(flags);
 }
=20
 /**

--------------040801030209050203070606--

--------------enig945B1741AABFD81C411C8BC7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJGeEniDOoMHTA+kRAp6bAJ95jNB4b8Fb1gfnKGF31x8x5jJ6YQCfWNG4
x8mWOTPgMYB/E/FCufdRkC8=
=t7IE
-----END PGP SIGNATURE-----

--------------enig945B1741AABFD81C411C8BC7--

