Message-ID: <44B13AB9.1050306@domain.hid>
Date: Sun, 09 Jul 2006 19:19:53 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3197E24AC0B7C2F9E2889A9F"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] suspend your real-time system
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
--------------enig3197E24AC0B7C2F9E2889A9F
Content-Type: multipart/mixed; boundary="------------030006010902010408090600"

This is a multi-part message in MIME format.
--------------030006010902010408090600
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

it's a bit crazy but it seems to work: This tiny patch against an I-pipe
kernel really allows suspend to disk/ram for a *running* Xenomai system.
Just the TSC-based timers are skewed up after resume so that, e.g., the
latency test takes a longer pause then. But a serious use-case would
rather include a real-time application shutdown before suspend anyway.

Jan



--------------030006010902010408090600
Content-Type: text/x-patch;
 name="hard-irq-disable-on-suspend-resume.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="hard-irq-disable-on-suspend-resume.patch"

---
 kernel/power/swsusp.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6.17-ipipe/kernel/power/swsusp.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17-ipipe.orig/kernel/power/swsusp.c
+++ linux-2.6.17-ipipe/kernel/power/swsusp.c
@@ -217,6 +217,7 @@ int swsusp_suspend(void)
 	if ((error =3D arch_prepare_suspend()))
 		return error;
 	local_irq_disable();
+	local_irq_disable_hw();
 	/* At this point, device_suspend() has been called, but *not*
 	 * device_power_down(). We *must* device_power_down() now.
 	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
@@ -242,6 +243,7 @@ Restore_highmem:
 	restore_highmem();
 	device_power_up();
 Enable_irqs:
+	local_irq_enable_hw();
 	local_irq_enable();
 	return error;
 }
@@ -250,6 +252,7 @@ int swsusp_resume(void)
 {
 	int error;
 	local_irq_disable();
+	local_irq_disable_hw();
 	if (device_power_down(PMSG_FREEZE))
 		printk(KERN_ERR "Some devices failed to power down, very bad\n");
 	/* We'll ignore saved state, but this gets preempt count (etc) right */=

@@ -268,6 +271,7 @@ int swsusp_resume(void)
 	restore_highmem();
 	touch_softlockup_watchdog();
 	device_power_up();
+	local_irq_enable_hw();
 	local_irq_enable();
 	return error;
 }



--------------030006010902010408090600--

--------------enig3197E24AC0B7C2F9E2889A9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFEsTq5niDOoMHTA+kRAq+KAJ4l4CJ/O3HVJ9cruByZnJDkzKOkzwCfU4+t
MgtiggPyLjoo/yMn7bLWqlo=
=H5jt
-----END PGP SIGNATURE-----

--------------enig3197E24AC0B7C2F9E2889A9F--

