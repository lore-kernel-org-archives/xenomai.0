Message-ID: <4656E8EC.5020803@domain.hid>
Date: Fri, 25 May 2007 15:47:24 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26E53746F5828338DDCECA1F"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 2/2] Disable context checks
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main <adeos-main@gna.org>
Cc: Philippe Gerum <rpm@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26E53746F5828338DDCECA1F
Content-Type: multipart/mixed;
 boundary="------------040507050206060406030400"

This is a multi-part message in MIME format.
--------------040507050206060406030400
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Introduce ipipe_disable_check_context and use it when dumping panic
traces. This avoids triggering the alarm while actually dumping a
different fault.

Jan

--------------040507050206060406030400
Content-Type: text/plain;
 name="disable-context-check.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="disable-context-check.patch"

---
 include/linux/ipipe_base.h |   11 +++++++++++
 kernel/ipipe/core.c        |    9 +++++----
 kernel/ipipe/tracer.c      |    2 ++
 3 files changed, 18 insertions(+), 4 deletions(-)

Index: linux-2.6.20/include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe_base.h
+++ linux-2.6.20/include/linux/ipipe_base.h
@@ -76,9 +76,20 @@ void __ipipe_unstall_root(void);
 void __ipipe_restore_root(unsigned long x);
=20
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+
 void ipipe_check_context(struct ipipe_domain *border_ipd);
+
+static inline void ipipe_disable_context_check(void)
+{
+	extern int __ipipe_context_check_enabled;
+	__ipipe_context_check_enabled =3D 0;
+}
+
 #else /* !CONFIG_IPIPE_DEBUG_CONTEXT */
+
 static inline void ipipe_check_context(struct ipipe_domain *border_ipd) =
{ }
+static inline void ipipe_disable_context_check(void) { }
+
 #endif /* !CONFIG_IPIPE_DEBUG_CONTEXT */
=20
 #else /* !CONFIG_IPIPE */
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -1385,15 +1385,16 @@ void __init ipipe_init_proc(void)
 #endif	/* CONFIG_PROC_FS */
=20
 #ifdef CONFIG_IPIPE_DEBUG_CONTEXT
+
+int __ipipe_context_check_enabled =3D 1;
+
 void ipipe_check_context(struct ipipe_domain *border_ipd)
 {
-	static int check_hit;
-
 	if (likely(ipipe_current_domain->priority <=3D border_ipd->priority) ||=

-	    check_hit)
+	    !__ipipe_context_check_enabled)
 		return;
=20
-	check_hit =3D 1;
+	__ipipe_context_check_enabled =3D 0;
=20
 	ipipe_trace_panic_freeze();
 	ipipe_set_printk_sync(ipipe_current_domain);
Index: linux-2.6.20/kernel/ipipe/tracer.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/tracer.c
+++ linux-2.6.20/kernel/ipipe/tracer.c
@@ -625,6 +625,8 @@ void ipipe_trace_panic_dump(void)
 	if (!panic_path)
 		return;
=20
+	ipipe_disable_context_check();
+
 	printk("I-pipe tracer log (%d points):\n", cnt);
=20
 	start =3D pos =3D WRAP_POINT_NO(panic_path->trace_pos-1);

--------------040507050206060406030400--

--------------enig26E53746F5828338DDCECA1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGVujsniDOoMHTA+kRAhIoAJ9Djz0CxvdHoQ2Zc62kamAPFKJX7wCeKv7p
IKzAPAqByLIttCLVUddzWVM=
=avga
-----END PGP SIGNATURE-----

--------------enig26E53746F5828338DDCECA1F--

