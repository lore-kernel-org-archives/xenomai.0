Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1bcdb8054ee593a62d4b.1480428239@devws148.be.alcatel-lucent.com>
Date: Tue, 29 Nov 2016 15:03:59 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH v2] psos.h: remove dependency on tunables.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The psos.h file pollutes the application's namespace with defines
of the boilerplate code because the tunables.h is included. In our
application we already have a definition of the list_entry macro,
resulting in a redefinition. The psos.h should be kept clean.

Following small test program clearly shows the issue:

#include <psos/psos.h>
#define list_entry
int main(int argc, char * const argv[])
{
  return 0;
}

When compiling the code above a warning is generated:

simple_test.c:3:1: warning: "list_entry" redefined
In file included from boilerplate/list.h:24,
                 from boilerplate/setup.h:21,
                 from boilerplate/tunables.h:22,
                 from psos/psos.h:28,
                 from simple_test.c:1:
boilerplate/shared-list.h:233:1: warning: this is the location of the previous definition

This patch resolves the issue by moving the tunable related functionality in
a seperate header file.

diff --git a/include/psos/Makefile.am b/include/psos/Makefile.am
--- a/include/psos/Makefile.am
+++ b/include/psos/Makefile.am
@@ -1,3 +1,5 @@
 includesubdir = $(includedir)/psos
 
-includesub_HEADERS = psos.h
+includesub_HEADERS = \
+		psos.h \
+		tunables.h
diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -25,7 +25,6 @@
 #define _XENOMAI_PSOS_PSOS_H
 
 #include <sys/types.h>
-#include <boilerplate/tunables.h>
 
 #ifndef SUCCESS
 #define SUCCESS 0
@@ -370,18 +369,6 @@ int psos_task_normalize_priority(u_long 
 
 u_long psos_task_denormalize_priority(int core_prio);
 
-extern int psos_long_names;
-
-static inline define_config_tunable(long_names, int, on)
-{
-	psos_long_names = on;
-}
-
-static inline read_config_tunable(long_names, int)
-{
-	return psos_long_names;
-}
-
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/include/psos/tunables.h b/include/psos/tunables.h
new file mode 100644
--- /dev/null
+++ b/include/psos/tunables.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (C) 2001-2010 Philippe Gerum <rpm@xenomai.org>.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ *
+ * This file satisfies the references within the emulator code
+ * mimicking a pSOS-like API built upon the copperplate library.
+ *
+ * pSOS and pSOS+ are registered trademarks of Wind River Systems, Inc.
+ */
+
+#ifndef _XENOMAI_PSOS_TUNABLES_H
+#define _XENOMAI_PSOS_TUNABLES_H
+
+#include <boilerplate/tunables.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* __cplusplus */
+
+extern int psos_long_names;
+
+static inline define_config_tunable(long_names, int, on)
+{
+	psos_long_names = on;
+}
+
+static inline read_config_tunable(long_names, int)
+{
+	return psos_long_names;
+}
+
+#ifdef __cplusplus
+}
+#endif /* __cplusplus */
+
+#endif /* !_XENOMAI_PSOS_TUNABLES_H */

