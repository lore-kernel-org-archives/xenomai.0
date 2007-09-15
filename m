Message-ID: <46EB8FF1.7070408@domain.hid>
Date: Sat, 15 Sep 2007 09:55:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig67CDCA31375CC3611EFE143F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [Resent][PATCH] allow hibernation of I-pipe kernels
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
--------------enig67CDCA31375CC3611EFE143F
Content-Type: multipart/mixed;
 boundary="------------050002090908030204090100"

This is a multi-part message in MIME format.
--------------050002090908030204090100
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I'm using this patch since ages on my notebook. Would be nice to have
this available by default.

Jan

--------------050002090908030204090100
Content-Type: text/x-patch;
 name="hard-irq-disable-on-suspend-resume.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="hard-irq-disable-on-suspend-resume.patch"

---
 kernel/power/swsusp.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.22-ipipe/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-ipipe.orig/kernel/power/swsusp.c
+++ linux-2.6.22-ipipe/kernel/power/swsusp.c
@@ -278,6 +278,7 @@ int swsusp_suspend(void)
 		return error;
=20
 	local_irq_disable();
+	local_irq_disable_hw_cond();
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* device_power_down() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
@@ -299,6 +300,7 @@ int swsusp_suspend(void)
 	 */
 	device_power_up();
  Enable_irqs:
+	local_irq_enable_hw_cond();
 	local_irq_enable();
 	return error;
 }
@@ -308,6 +310,7 @@ int swsusp_resume(void)
 	int error;
=20
 	local_irq_disable();
+	local_irq_disable_hw_cond();
 	/* NOTE:  device_power_down() is just a suspend() with irqs off;
 	 * it has no special "power things down" semantics
 	 */
@@ -334,6 +337,7 @@ int swsusp_resume(void)
 	restore_processor_state();
 	touch_softlockup_watchdog();
 	device_power_up();
+	local_irq_enable_hw_cond();
 	local_irq_enable();
 	return error;
 }

--------------050002090908030204090100--

--------------enig67CDCA31375CC3611EFE143F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFG64/xniDOoMHTA+kRAj6SAJ9+mk2n3NSjk10kk90Pg6E9yDjy5ACfaTkr
vQ8qWz2NHJu4zn0wSqovfoA=
=62ka
-----END PGP SIGNATURE-----

--------------enig67CDCA31375CC3611EFE143F--

