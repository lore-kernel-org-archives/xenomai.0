Message-ID: <4726513D.9020308@domain.hid>
Date: Mon, 29 Oct 2007 22:31:41 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig86931DF4DE54ECB3C6035E49"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH] janitorial: remove i8253_lock conversion
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
--------------enig86931DF4DE54ECB3C6035E49
Content-Type: multipart/mixed;
 boundary="------------030606020606000009090508"

This is a multi-part message in MIME format.
--------------030606020606000009090508
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Unless I'm utterly wrong, there are practically only two use cases
regarding the PIT: Either Linux has complete hold of it for clocksource
and/or clockevent usage, or the RT domain takes it over, also
completely. In both cases the RT domain does not need to use the
i8253_lock (see Xenomai). So let's remove the hunks that harden this
lock for no good (upcoming 2.6.24 would otherwise require even
_extended_ patching). Patch addresses i386, but this cleanup should be
applicable to x86_64 likewise.

Jan

--------------030606020606000009090508
Content-Type: text/x-patch;
 name="remove-i8253_lock-conversion.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="remove-i8253_lock-conversion.patch"

---
 arch/i386/kernel/i8253.c               |    2 +-
 arch/i386/mach-voyager/voyager_basic.c |    8 ++++----
 include/asm-i386/i8253.h               |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6.23.1-xeno/arch/i386/kernel/i8253.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/arch/i386/kernel/i8253.c
+++ linux-2.6.23.1-xeno/arch/i386/kernel/i8253.c
@@ -16,7 +16,7 @@
 #include <asm/io.h>
 #include <asm/timer.h>
=20
-IPIPE_DEFINE_SPINLOCK(i8253_lock);
+DEFINE_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
=20
 /*
Index: linux-2.6.23.1-xeno/arch/i386/mach-voyager/voyager_basic.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/arch/i386/mach-voyager/voyager_basic.c
+++ linux-2.6.23.1-xeno/arch/i386/mach-voyager/voyager_basic.c
@@ -185,20 +185,20 @@ voyager_timer_interrupt(void)
 		 * pointy.  */
 		__u16 val;
=20
-		spin_lock_irqsave(&i8253_lock);
+		spin_lock(&i8253_lock);
 	=09
 		outb_p(0x00, 0x43);
 		val =3D inb_p(0x40);
 		val |=3D inb(0x40) << 8;
-		spin_unlock_irqrestore(&i8253_lock);
+		spin_unlock(&i8253_lock);
=20
 		if(val > LATCH) {
 			printk("\nVOYAGER: countdown timer value too high (%d), resetting\n\n=
", val);
-			spin_lock_irqsave(&i8253_lock);
+			spin_lock(&i8253_lock);
 			outb(0x34,0x43);
 			outb_p(LATCH & 0xff , 0x40);	/* LSB */
 			outb(LATCH >> 8 , 0x40);	/* MSB */
-			spin_unlock_irqrestore(&i8253_lock);
+			spin_unlock(&i8253_lock);
 		}
 	}
 #ifdef CONFIG_SMP
Index: linux-2.6.23.1-xeno/include/asm-i386/i8253.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.23.1-xeno.orig/include/asm-i386/i8253.h
+++ linux-2.6.23.1-xeno/include/asm-i386/i8253.h
@@ -8,7 +8,7 @@
 #define PIT_CH0			0x40
 #define PIT_CH2			0x42
=20
-extern ipipe_spinlock_t i8253_lock;
+extern spinlock_t i8253_lock;
=20
 extern struct clock_event_device *global_clock_event;
=20

--------------030606020606000009090508--

--------------enig86931DF4DE54ECB3C6035E49
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHJlE9niDOoMHTA+kRAoMmAJ0VNGYlGttO+4VkGhyGPrLQI3ZMeACfZfzD
Yrj2EXAzaBurkU5S5SBhaN8=
=SZdL
-----END PGP SIGNATURE-----

--------------enig86931DF4DE54ECB3C6035E49--

