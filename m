Message-ID: <4630F274.5090605@domain.hid>
Date: Thu, 26 Apr 2007 20:41:56 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC171380C08D88EAB88815843"
Sender: jan.kiszka@domain.hid
Subject: [Adeos-main] [PATCH 5/7] Introduce ipipe_base.h (i386/x86_64)
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
--------------enigC171380C08D88EAB88815843
Content-Type: multipart/mixed;
 boundary="------------060909090508000503020103"

This is a multi-part message in MIME format.
--------------060909090508000503020103
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

These patches introduce minimalistic ipipe_base.h to be included by
every header out there in the kernel without any dependencies. That is
exploited here to move all *stall_root() related prototypes out off
irqflags.h, to following patches need ipipe_base.h as well.

BTW, I started removing fastcalls with __ipipe_restore_root - as far as
I understood it's pointless now with CONFIG_REGPARM being always on.

Jan

--------------060909090508000503020103
Content-Type: text/plain;
 name="split-ipipe-header.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="split-ipipe-header.patch"

---
 include/linux/ipipe.h      |   15 +--------------
 include/linux/ipipe_base.h |   45 ++++++++++++++++++++++++++++++++++++++=
+++++++
 kernel/ipipe/core.c        |    2 +-
 3 files changed, 47 insertions(+), 15 deletions(-)

Index: linux-2.6.20/include/linux/ipipe.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/linux/ipipe.h
+++ linux-2.6.20/include/linux/ipipe.h
@@ -27,6 +27,7 @@
 #include <linux/percpu.h>
 #include <linux/mutex.h>
 #include <linux/linkage.h>
+#include <linux/ipipe_base.h>
 #include <asm/ipipe.h>
=20
 #ifdef CONFIG_IPIPE
@@ -276,10 +277,6 @@ do {						\
=20
 DECLARE_PER_CPU(struct ipipe_domain *, ipipe_percpu_domain);
=20
-extern struct ipipe_domain ipipe_root;
-
-#define ipipe_root_domain (&ipipe_root)
-
 extern unsigned __ipipe_printk_virq;
=20
 extern unsigned long __ipipe_virtual_irq_map;
@@ -315,18 +312,8 @@ void __ipipe_remove_domain_proc(struct i
=20
 void __ipipe_flush_printk(unsigned irq, void *cookie);
=20
-void __ipipe_stall_root(void);
-
-void __ipipe_unstall_root(void);
-
-unsigned long __ipipe_test_root(void);
-
-unsigned long __ipipe_test_and_stall_root(void);
-
 void fastcall __ipipe_walk_pipeline(struct list_head *pos, int cpuid);
=20
-void fastcall __ipipe_restore_root(unsigned long x);
-
 int fastcall __ipipe_schedule_irq(unsigned irq, struct list_head *head);=

=20
 int fastcall __ipipe_dispatch_event(unsigned event, void *data);
Index: linux-2.6.20/include/linux/ipipe_base.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ linux-2.6.20/include/linux/ipipe_base.h
@@ -0,0 +1,45 @@
+/* -*- linux-c -*-
+ * include/linux/ipipe.h
+ *
+ * Copyright (C) 2002-2005 Philippe Gerum.
+ *               2007 Jan Kiszka.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, Inc., 675 Mass Ave, Cambridge MA 02139,=

+ * USA; either version 2 of the License, or (at your option) any later
+ * version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,=
 USA.
+ */
+
+#ifndef __LINUX_IPIPE_BASE_H
+#define __LINUX_IPIPE_BASE_H
+
+#ifdef CONFIG_IPIPE
+
+extern struct ipipe_domain ipipe_root;
+
+#define ipipe_root_domain (&ipipe_root)
+
+
+void __ipipe_stall_root(void);
+
+void __ipipe_unstall_root(void);
+
+unsigned long __ipipe_test_root(void);
+
+unsigned long __ipipe_test_and_stall_root(void);
+
+void __ipipe_restore_root(unsigned long x);
+
+#endif	/* CONFIG_IPIPE */
+
+#endif	/* !__LINUX_IPIPE_BASE_H */
Index: linux-2.6.20/kernel/ipipe/core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/kernel/ipipe/core.c
+++ linux-2.6.20/kernel/ipipe/core.c
@@ -198,7 +198,7 @@ unsigned long __ipipe_test_and_stall_roo
 	return x;
 }
=20
-void fastcall __ipipe_restore_root(unsigned long x)
+void __ipipe_restore_root(unsigned long x)
 {
 	if (x)
 		__ipipe_stall_root();

--------------060909090508000503020103
Content-Type: text/plain;
 name="split-ipipe-header-i386.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="split-ipipe-header-i386.patch"

---
 include/asm-i386/irqflags.h |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6.20/include/asm-i386/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20.orig/include/asm-i386/irqflags.h
+++ linux-2.6.20/include/asm-i386/irqflags.h
@@ -15,18 +15,9 @@
 #else
 #ifndef __ASSEMBLY__
=20
+#include <linux/ipipe_base.h>
 #include <linux/ipipe_trace.h>
=20
-void __ipipe_stall_root(void);
-
-void __ipipe_unstall_root(void);
-
-unsigned long __ipipe_test_root(void);
-
-unsigned long __ipipe_test_and_stall_root(void);
-
-void fastcall __ipipe_restore_root(unsigned long flags);
-
 static inline unsigned long __raw_local_save_flags(void)
 {
 	unsigned long flags;

--------------060909090508000503020103
Content-Type: text/plain;
 name="split-ipipe-header-x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="split-ipipe-header-x86_64.patch"

---
 include/asm-x86_64/irqflags.h |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

Index: linux-2.6.20-x64/include/asm-x86_64/irqflags.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.20-x64.orig/include/asm-x86_64/irqflags.h
+++ linux-2.6.20-x64/include/asm-x86_64/irqflags.h
@@ -15,18 +15,9 @@
  * Interrupt control:
  */
=20
+#include <linux/ipipe_base.h>
 #include <linux/ipipe_trace.h>
=20
-void __ipipe_stall_root(void);
-
-void __ipipe_unstall_root(void);
-
-unsigned long __ipipe_test_root(void);
-
-unsigned long __ipipe_test_and_stall_root(void);
-
-void fastcall __ipipe_restore_root(unsigned long flags);
-
 static inline unsigned long __raw_local_save_flags(void)
 {
 	unsigned long flags;

--------------060909090508000503020103--

--------------enigC171380C08D88EAB88815843
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGMPJ0niDOoMHTA+kRAnqVAJ9hDuJqMPKq55Ny01AKl5Ed49/azQCggd7j
1WTsYUBxE6Md4dDjyw5Eyrk=
=Z7s2
-----END PGP SIGNATURE-----

--------------enigC171380C08D88EAB88815843--

