Message-ID: <43BFB26F.8020409@domain.hid>
Date: Sat, 07 Jan 2006 13:22:07 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig560C81C31063708633623930"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] move RTDM headers
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig560C81C31063708633623930
Content-Type: multipart/mixed; boundary="------------040305000506050709080206"

This is a multi-part message in MIME format.
--------------040305000506050709080206
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi Philippe,

this patches cleans up the include/rtdm folder by moving internal
headers to ksrc/skins/rtdm, leaving only rtdm.h, rtdm_driver.h, the two
profile headers, and syscall.h there. The latter is still only needed
for building Xenomai itself, thus it will not be installed. Successfully
built for 2.4 and 2.6. Additionally, I compiled latest RTnet SVN against
it without problems (x86, PPC is currently being fixed by Wolfgang).

Please apply/move the involved headers and run bootstrap.

Jan


--------------040305000506050709080206
Content-Type: text/x-patch;
 name="rtdm_headers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtdm_headers.patch"

Index: include/rtdm/device.h
===================================================================
--- include/rtdm/device.h	(Revision 380)
+++ include/rtdm/device.h	(Arbeitskopie)
@@ -1,60 +0,0 @@
-/*
- * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
- * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#ifndef _RTDM_DEVICE_H
-#define _RTDM_DEVICE_H
-
-#include <xenomai/nucleus/pod.h>
-#include <xenomai/rtdm/rtdm_driver.h>
-#include <linux/sem.h>
-
-
-#define DEF_DEVNAME_HASHTAB_SIZE    256 /* entries in name hash table */
-#define DEF_PROTO_HASHTAB_SIZE      256 /* entries in protocol hash table */
-
-
-extern struct semaphore nrt_dev_lock;
-extern xnlock_t         rt_dev_lock;
-
-extern unsigned int     devname_hashtab_size;
-extern unsigned int     protocol_hashtab_size;
-
-extern struct list_head *rtdm_named_devices;
-extern struct list_head *rtdm_protocol_devices;
-
-
-int rtdm_no_support(void);
-
-struct rtdm_device *get_named_device(const char *name);
-struct rtdm_device *get_protocol_device(int protocol_family, int socket_type);
-
-static inline void rtdm_dereference_device(struct rtdm_device *device)
-{
-    atomic_dec(&device->reserved.refcount);
-}
-
-int __init rtdm_dev_init(void);
-
-static inline void rtdm_dev_cleanup(void)
-{
-    kfree(rtdm_named_devices);
-    kfree(rtdm_protocol_devices);
-}
-
-#endif /* _RTDM_DEVICE_H */
Index: include/rtdm/Makefile.am
===================================================================
--- include/rtdm/Makefile.am	(Revision 380)
+++ include/rtdm/Makefile.am	(Arbeitskopie)
@@ -1,11 +1,10 @@
 includedir = $(prefix)/include/rtdm
 
+noinst_HEADERS = \
+	syscall.h
+
 include_HEADERS = \
-	core.h \
-	device.h \
-	proc.h \
 	rtdm.h \
 	rtdm_driver.h \
 	rtserial.h \
-	syscall.h \
 	rtbenchmark.h
Index: include/rtdm/proc.h
===================================================================
--- include/rtdm/proc.h	(Revision 380)
+++ include/rtdm/proc.h	(Arbeitskopie)
@@ -1,32 +0,0 @@
-/*
- * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
- * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#ifndef _RTDM_PROC_H
-#define _RTDM_PROC_H
-
-extern struct proc_dir_entry *rtdm_proc_root;
-
-
-int rtdm_proc_register_device(struct rtdm_device* device);
-
-int __init rtdm_proc_init(void);
-
-void rtdm_proc_cleanup(void);
-
-#endif /* _RTDM_PROC_H */
Index: include/rtdm/core.h
===================================================================
--- include/rtdm/core.h	(Revision 380)
+++ include/rtdm/core.h	(Arbeitskopie)
@@ -1,52 +0,0 @@
-/*
- * Copyright (C) 2005 Jan Kiszka <jan.kiszka@domain.hid>.
- * Copyright (C) 2005 Joerg Langenberg <joerg.langenberg@domain.hid>.
- *
- * Xenomai is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * Xenomai is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with Xenomai; if not, write to the Free Software Foundation,
- * Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
- */
-
-#ifndef _RTDM_CORE_H
-#define _RTDM_CORE_H
-
-#include <xenomai/nucleus/pod.h>
-#include <xenomai/rtdm/rtdm_driver.h>
-
-
-#define DEF_FILDES_COUNT    64  /* default number of file descriptors */
-
-
-struct rtdm_fildes {
-    struct rtdm_fildes                  *next;
-    volatile struct rtdm_dev_context    *context;
-};
-
-
-#ifdef CONFIG_SMP
-extern xnlock_t             rt_fildes_lock;
-#endif /* CONFIG_SMP */
-
-extern unsigned int         fd_count;
-extern struct rtdm_fildes   *fildes_table;
-extern int                  open_fildes;
-
-
-int __init rtdm_core_init(void);
-
-static inline void rtdm_core_cleanup(void)
-{
-    kfree(fildes_table);
-}
-
-#endif /* _RTDM_CORE_H */
Index: ksrc/skins/rtdm/device.c
===================================================================
--- ksrc/skins/rtdm/device.c	(Revision 380)
+++ ksrc/skins/rtdm/device.c	(Arbeitskopie)
@@ -28,8 +28,8 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 
-#include <xenomai/rtdm/device.h>
-#include <xenomai/rtdm/proc.h>
+#include "device.h"
+#include "proc.h"
 
 
 #define SET_DEFAULT_OP(device, operation)                               \
Index: ksrc/skins/rtdm/proc.c
===================================================================
--- ksrc/skins/rtdm/proc.c	(Revision 380)
+++ ksrc/skins/rtdm/proc.c	(Arbeitskopie)
@@ -22,10 +22,11 @@
 #ifdef CONFIG_PROC_FS
 
 #include <linux/proc_fs.h>
-#include <xenomai/rtdm/core.h>
-#include <xenomai/rtdm/device.h>
 
+#include "core.h"
+#include "device.h"
 
+
 /* Derived from Erwin Rol's rtai_proc_fs.h.
    Assumes that output fits into the provided buffer. */
 
Index: ksrc/skins/rtdm/module.c
===================================================================
--- ksrc/skins/rtdm/module.c	(Revision 380)
+++ ksrc/skins/rtdm/module.c	(Arbeitskopie)
@@ -45,10 +45,12 @@
 #include <xenomai/nucleus/core.h>
 #include <xenomai/rtdm/syscall.h>
 #endif /* __KERNEL__ */
-#include <xenomai/rtdm/core.h>
-#include <xenomai/rtdm/device.h>
-#include <xenomai/rtdm/proc.h>
 
+#include "core.h"
+#include "device.h"
+#include "proc.h"
+
+
 MODULE_DESCRIPTION("Real-Time Driver Model");
 MODULE_AUTHOR("jan.kiszka@domain.hid");
 MODULE_LICENSE("GPL");
Index: ksrc/skins/rtdm/core.c
===================================================================
--- ksrc/skins/rtdm/core.c	(Revision 380)
+++ ksrc/skins/rtdm/core.c	(Arbeitskopie)
@@ -30,12 +30,13 @@
 
 #include <xenomai/nucleus/pod.h>
 #include <xenomai/nucleus/heap.h>
+#include <xenomai/rtdm/syscall.h>
 #include <xenomai/rtdm/rtdm_driver.h>
-#include <xenomai/rtdm/core.h>
-#include <xenomai/rtdm/device.h>
-#include <xenomai/rtdm/syscall.h>
 
+#include "core.h"
+#include "device.h"
 
+
 unsigned int                fd_count = DEF_FILDES_COUNT;
 module_param(fd_count, uint, 0400);
 MODULE_PARM_DESC(fd_count, "Maximum number of file descriptors");
Index: ksrc/skins/rtdm/syscall.c
===================================================================
--- ksrc/skins/rtdm/syscall.c	(Revision 380)
+++ ksrc/skins/rtdm/syscall.c	(Arbeitskopie)
@@ -19,10 +19,11 @@
 
 #include <xenomai/nucleus/shadow.h>
 #include <xenomai/rtdm/rtdm_driver.h>
-#include <xenomai/rtdm/core.h>
 #include <xenomai/rtdm/syscall.h>
 
+#include "core.h"
 
+
 int __rtdm_muxid;
 
 


--------------040305000506050709080206--

--------------enig560C81C31063708633623930
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDv7JvniDOoMHTA+kRAnMsAJ93D3HdJ+Njk3vKfFWUAuv80RKGXQCfTHpD
OB/KCdQFd+TB+gdPTAJ+dN4=
=gK05
-----END PGP SIGNATURE-----

--------------enig560C81C31063708633623930--

