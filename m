Message-ID: <4635B14C.2040001@domain.hid>
Date: Mon, 30 Apr 2007 11:05:16 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1177688176.5010.135.camel@domain.hid>
	<1177686318.5010.106.camel@domain.hid>	
	<1177683592.5010.84.camel@domain.hid> <4631FF09.2000601@domain.hid>	
	<4631F925.2090100@domain.hid>
	<4850965.1177589052502.JavaMail.ngmail@domain.hid>	
	<4631E30B.6060701@domain.hid> <1177679680.5010.78.camel@domain.hid>	
	<23595872.1177680700618.JavaMail.ngmail@domain.hid>	
	<784082.1177682909759.JavaMail.ngmail@domain.hid>	
	<1646519.1177684097169.JavaMail.ngmail@domain.hid>	
	<1177685762.5010.104.camel@domain.hid>	
	<12104543.1177686610343.JavaMail.ngmail@domain.hid>
	<4548126.1177688516220.JavaMail.ngmail@domain.hid>
In-Reply-To: <4548126.1177688516220.JavaMail.ngmail@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8C8170EB92837118BD350A84"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] Xenomai and MSI enabled crashes kernel
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "M. Koehrer" <mathias_koehrer@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8C8170EB92837118BD350A84
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

M. Koehrer wrote:
> Hi Philippe,
>=20
> I have extracted that part. However this very address is not available.=

> I have placed a couple of lines before and after that address.
>=20
> Regards
>=20
> Mathias
> PS: I will continue on Monday with the tests....
>=20

If you happen to do so, please give this patch a try. It's an experiment
to include I-pipe tracer information in kernel oops reports. For this
purpose, enable CONFIG_IPIPE_TRACE_MCOUNT, CONFIG_IPIPE_TRACE_ENABLE,
and CONFIG_IPIPE_TRACE_IRQSOFF. Then trigger the oops. Maybe we get more
information about the function call history.

Thanks,
Jan

---
 arch/i386/mm/fault.c        |    5 +++++
 include/linux/ipipe_trace.h |    7 ++++++-
 kernel/ipipe/tracer.c       |    8 ++++++++
 lib/bust_spinlocks.c        |    5 +++++
 4 files changed, 24 insertions(+), 1 deletion(-)

Index: linux-2.6.20/arch/i386/mm/fault.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/arch/i386/mm/fault.c
+++ linux-2.6.20/arch/i386/mm/fault.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
+#include <linux/ipipe_trace.h>

 #include <asm/system.h>
 #include <asm/desc.h>
@@ -68,9 +69,13 @@ void bust_spinlocks(int yes)
 	int loglevel_save =3D console_loglevel;

 	if (yes) {
+		ipipe_trace_panic_freeze();
 		oops_in_progress =3D 1;
 		return;
 	}
+
+	ipipe_trace_panic_dump();
+
 #ifdef CONFIG_VT
 	unblank_screen();
 #endif
Index: linux-2.6.20/include/linux/ipipe_trace.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_trace.h
+++ linux-2.6.20/include/linux/ipipe_trace.h
@@ -39,6 +39,11 @@ int ipipe_trace_frozen_reset(void);
 void ipipe_trace_panic_freeze(void);
 void ipipe_trace_panic_dump(void);

-#endif /* CONFIG_IPIPE_TRACE */
+#else /* !CONFIG_IPIPE_TRACE */
+
+static inline void ipipe_trace_panic_freeze(void) { }
+static inline void ipipe_trace_panic_dump(void) { }
+
+#endif /* !CONFIG_IPIPE_TRACE */

 #endif	/* !__LINUX_IPIPE_H */
Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -565,6 +565,9 @@ void ipipe_trace_panic_freeze(void)
 	unsigned long flags;
 	int cpu_id;

+	if (!ipipe_trace_enable)
+		return;
+
 	ipipe_trace_enable =3D 0;
 	local_irq_save_hw_notrace(flags);

@@ -614,6 +617,9 @@ void ipipe_trace_panic_dump(void)
 	int start, pos;
 	char task_info[12];

+	if (!panic_path)
+		return;
+
 	printk("I-pipe tracer log (%d points):\n", cnt);

 	start =3D pos =3D WRAP_POINT_NO(panic_path->trace_pos-1);
@@ -667,6 +673,8 @@ void ipipe_trace_panic_dump(void)
 		}
 		pos =3D WRAP_POINT_NO(pos - 1);
 	}
+
+	panic_path =3D NULL;
 }
 EXPORT_SYMBOL(ipipe_trace_panic_dump);

Index: linux-2.6.20/lib/bust_spinlocks.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/lib/bust_spinlocks.c
+++ linux-2.6.20/lib/bust_spinlocks.c
@@ -12,14 +12,19 @@
 #include <linux/tty.h>
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
+#include <linux/ipipe_trace.h>


 void bust_spinlocks(int yes)
 {
 	if (yes) {
+		ipipe_trace_panic_freeze();
 		oops_in_progress =3D 1;
 	} else {
 		int loglevel_save =3D console_loglevel;
+
+		ipipe_trace_panic_dump();
+
 #ifdef CONFIG_VT
 		unblank_screen();
 #endif


--------------enig8C8170EB92837118BD350A84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGNbFMniDOoMHTA+kRAuSSAJ9ZeAhzLINI34r9en3tCxjE+UUxkgCfdUzH
0/+1+E8q0kvHia266CgoY7c=
=gW6o
-----END PGP SIGNATURE-----

--------------enig8C8170EB92837118BD350A84--

