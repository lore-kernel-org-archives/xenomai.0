Message-ID: <45D6C4B6.7010302@domain.hid>
Date: Sat, 17 Feb 2007 10:02:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6542B1ABB455123FD8D58A4"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [RFC][PATCH 1/2] real-time print library
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
--------------enigC6542B1ABB455123FD8D58A4
Content-Type: multipart/mixed; boundary="------------080400060409000407080500"

This is a multi-part message in MIME format.
--------------080400060409000407080500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This is a stand-alone real-time library for printf services. It is
embedded into the Xenomai user space part but actually doesn't depend
on any Xenomai service, just using plain Linux POSIX.

The librtprint API looks much like the printf(3) man page:

rt_vfprintf
rt_vprintf
rt_fprintf
rt_printf

Moreover it provides a few setup/cleanup services as you can grab from
the code and the included example.

The basic idea of librtprint is to keep the print side as cheap as
possible: no locks, no syscalls at all. Each thread that uses rt_printf
& friends has its own local ring buffer. A central (per process) non-RT
output thread takes care of forwarding the content of all thread ring
buffers to the output streams. The message order is preserved loosely by
a global sequence counter (arch-dependent CPU-wide or system-wide
atomic_inc_return might be used in the future). The output thread uses
periodic polling (default: 10 Hz) to avoid the need for special
signalling mechanisms.

Further features:
 o Explicit or on-demand thread buffer creation
 o Override of default buffer size and polling period via environment
   variables ("RT_PRINT_BUFFER" and "RT_PRINT_PERIOD")
 o Support for buffer names (useful for the following patch e.g.)
 o Target output stream can be specified for each print invocation
 o Breaks all builds except for x86 (missing ubarrier.h headers) :o)

The code is stuffed into src/rtprint for now as patch 2/2 will need this
lib to be built before the skin libraries. Better suggestions are
welcome though.

Jan

--------------080400060409000407080500
Content-Type: text/x-patch;
 name="librtprint.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="librtprint.patch"

---
 configure.in                 |    1=20
 examples/native/Makefile     |    8 +
 examples/native/rtprint.c    |   48 +++++++
 include/Makefile.am          |    5=20
 include/asm-i386/Makefile.am |    2=20
 include/asm-i386/ubarrier.h  |   26 ++++
 include/rtprint.h            |   59 +++++++++
 src/Makefile.am              |    2=20
 src/rtprint/Makefile.am      |   12 +
 src/rtprint/api.c            |  273 ++++++++++++++++++++++++++++++++++++=
+++++++
 src/rtprint/init.c           |   75 +++++++++++
 src/rtprint/internal.h       |   69 ++++++++++
 src/rtprint/output.c         |   92 ++++++++++++++
 13 files changed, 669 insertions(+), 3 deletions(-)

Index: xenomai/configure.in
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/configure.in
+++ xenomai/configure.in
@@ -611,6 +611,7 @@ AC_CONFIG_FILES([ \
 	scripts/xeno-load \
 	scripts/xeno-test \
 	src/Makefile \
+	src/rtprint/Makefile \
 	src/skins/Makefile \
        	src/skins/posix/Makefile \
        	src/skins/native/Makefile \
Index: xenomai/examples/native/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/examples/native/Makefile
+++ xenomai/examples/native/Makefile
@@ -1,7 +1,7 @@
 ###### CONFIGURATION ######
=20
 ### List of applications to be build
-APPLICATIONS =3D trivial-periodic sigxcpu
+APPLICATIONS =3D trivial-periodic sigxcpu rtprint
=20
 ### Note: to override the search path for the xeno-config script, use "m=
ake XENO=3D..."
=20
@@ -44,6 +44,12 @@ endif
=20
=20
=20
+###### SPECIAL TARGET RULES ######
+rtprint: rtprint.c
+	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtprint -o $@
+
+
+
 ###### KERNEL MODULE BUILD (no change required normally) ######
 ifneq ($(MODULES),)
=20
Index: xenomai/examples/native/rtprint.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/examples/native/rtprint.c
@@ -0,0 +1,48 @@
+#include <stdio.h>
+#include <sys/mman.h>
+#include <native/task.h>
+#include <rtprint.h>
+
+void task2_func(void *arg)
+{
+	int i =3D 0;
+
+	rt_printf("This triggers auto-init of rt_print for the "
+		  "calling thread.\n"
+		  "A last switch to secondary mode can occure here, "
+		  "but future invocations of rt_printf are safe.\n");
+
+	rt_task_set_mode(0, T_WARNSW, NULL);
+
+	while (1) {
+		rt_task_sleep(3333333LL);
+		rt_fprintf(stderr, "%s: #%d Yet another RT printer - "
+			   "but to stderr.\n", rt_print_buffer_name(), ++i);
+	}
+}
+
+int main(int argc, char **argv)
+{
+	RT_TASK task1, task2;
+	int i =3D 0;
+
+	mlockall(MCL_CURRENT|MCL_FUTURE);
+
+	/* Perform auto-init of rt_print buffers if the task doesn't do so */
+	rt_print_auto_init(1);
+
+	/* Initialise the rt_print buffer for this task explicitly */
+	rt_print_init(4096, "Task 1");
+
+	rt_task_shadow(&task1, "Task 1", 10, 0);
+	rt_task_spawn(&task2, "Task 2", 0, 11, 0, task2_func, NULL);
+
+	/* To demonstrate that rt_printf is safe */
+	rt_task_set_mode(0, T_WARNSW, NULL);
+
+	while (1) {
+		rt_task_sleep(5000000LL);
+		rt_printf("%s: #%d Hello RT world!\n",
+			  rt_print_buffer_name(), ++i);
+	}
+}
Index: xenomai/include/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/Makefile.am
+++ xenomai/include/Makefile.am
@@ -1,3 +1,8 @@
+includedir =3D $(prefix)/include
+
+include_HEADERS =3D \
+	rtprint.h
+
 nodist_include_HEADERS=3D$(CONFIG_HEADER)
=20
 SUBDIRS =3D \
Index: xenomai/include/asm-i386/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/include/asm-i386/Makefile.am
+++ xenomai/include/asm-i386/Makefile.am
@@ -1,6 +1,6 @@
 includedir =3D $(prefix)/include/asm-i386
=20
 include_HEADERS =3D atomic.h calibration.h features.h \
-		hal.h smi.h syscall.h system.h wrappers.h fptest.h
+		hal.h smi.h syscall.h system.h wrappers.h fptest.h ubarrier.h
=20
 SUBDIRS =3D bits
Index: xenomai/include/asm-i386/ubarrier.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/include/asm-i386/ubarrier.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
+ *
+ * Xenomai is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License,
+ * or (at your option) any later version.
+ *
+ * Xenomai is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with Xenomai; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#ifndef _XENO_ASM_I386_UBARRIER_H
+#define _XENO_ASM_I386_UBARRIER_H
+
+#define rmb()	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory=
")
+#define wmb()	__asm__ __volatile__ ("": : :"memory")
+
+#endif /* _XENO_ASM_I386_UBARRIER_H */
Index: xenomai/include/rtprint.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/include/rtprint.h
@@ -0,0 +1,59 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#ifndef _RTPRINT_H
+#define _RTPRINT_H
+
+#ifdef __KERNEL__
+
+#define rt_printf(format, ...)	printk(format __VA_ARGS__)
+
+static inline int rt_print_init(size_t buffer_size, const char *buffer_n=
ame)
+{
+	return 0;
+}
+
+#define rt_print_cleanup()	do { } while (0)
+
+static inline void rt_print_auto_init(int enable)
+{
+}
+
+static inline const char *rt_print_buffer_name(void)
+{
+	return "<unknown>";
+}
+
+#else /* !__KERNEL__ */
+
+#include <stdio.h>
+#include <stdarg.h>
+
+int rt_vfprintf(FILE *stream, const char *format, va_list args);
+int rt_vprintf(const char *format, va_list args);
+int rt_fprintf(FILE *stream, const char *format, ...);
+int rt_printf(const char *format, ...);
+
+int rt_print_init(size_t buffer_size, const char *name);
+void rt_print_cleanup(void);
+void rt_print_auto_init(int enable);
+const char *rt_print_buffer_name(void);
+
+#endif /* !KERNEL */
+
+#endif /* !_RTPRINT_H */
Index: xenomai/src/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- xenomai.orig/src/Makefile.am
+++ xenomai/src/Makefile.am
@@ -1,2 +1,2 @@
=20
-SUBDIRS =3D include skins testsuite utils
+SUBDIRS =3D include rtprint skins testsuite utils
Index: xenomai/src/rtprint/Makefile.am
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/rtprint/Makefile.am
@@ -0,0 +1,12 @@
+lib_LTLIBRARIES =3D librtprint.la
+
+librtprint_la_LDFLAGS =3D -version-info 0:0:0 -lpthread
+
+librtprint_la_SOURCES =3D \
+	init.c \
+	output.c \
+	api.c
+
+librtprint_la_CPPFLAGS =3D \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
Index: xenomai/src/rtprint/api.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/rtprint/api.c
@@ -0,0 +1,273 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <rtprint.h>
+#include <asm/xenomai/ubarrier.h>
+
+#include "internal.h"
+
+int rt_vfprintf(FILE *stream, const char *format, va_list args)
+{
+	struct print_buffer *buffer =3D pthread_getspecific(__buffer_key);
+	off_t write_pos, read_pos;
+	struct entry_head *head;
+	int len;
+	int res;
+
+	if (!buffer) {
+		res =3D 0;
+		if (__auto_init)
+			res =3D rt_print_init(0, NULL);
+		else
+			res =3D EIO;
+
+		if (res) {
+			errno =3D res;
+			return -1;
+		}
+		buffer =3D pthread_getspecific(__buffer_key);
+	}
+
+	/* Take a snapshot of the ring buffer state */
+	write_pos =3D buffer->write_pos;
+	read_pos =3D buffer->read_pos;
+	rmb();
+
+	/* Is our write limit the end of the ring buffer? */
+	if (write_pos >=3D read_pos) {
+		/* Keep a savety margin to the end for at least an empty entry */
+		len =3D buffer->size - write_pos - sizeof(struct entry_head);
+
+		/* Special case: We were stuck at the end of the ring buffer
+		   with space left there only for one empty entry. Now
+		   read_pos was moved forward and we can wrap around. */
+		if (len =3D=3D 0 && read_pos > sizeof(struct entry_head)) {
+			/* Write out empty entry */
+			head =3D buffer->ring + write_pos;
+			head->seq_no =3D __seq_no;
+			head->text[0] =3D 0;
+
+			/* Forward to the ring buffer start */
+			write_pos =3D 0;
+			len =3D read_pos - 1;
+		}
+	} else {
+		/* Our limit is the read_pos ahead of our write_pos. One byte
+		   margin is required to detect a full ring. */
+		len =3D read_pos - write_pos - 1;
+	}
+
+	/* Account for head length */
+	len -=3D sizeof(struct entry_head);
+	if (len < 0)
+		len =3D 0;
+
+	head =3D buffer->ring + write_pos;
+
+	res =3D vsnprintf(head->text, len, format, args);
+
+	if (res < len) {
+		/* Text was written completely, res contains its length */
+		len =3D res;
+	} else {
+		/* Text was truncated, remove closing \0 that entry_head
+		   already includes */
+		len--;
+	}
+
+	/* If we were able to write some text, finalise the entry */
+	if (len > 0) {
+		head->seq_no =3D ++__seq_no;
+		head->dest =3D stream;
+
+		/* Move forward by text and head length */
+		write_pos +=3D len + sizeof(struct entry_head);
+	}
+
+	/* Wrap around early if there is more space on the other side */
+	if (write_pos >=3D buffer->size - RT_PRINT_LINE_BREAK &&
+	    read_pos <=3D write_pos && read_pos > buffer->size - write_pos) {
+		/* An empty entry marks the wrap-around */
+		head =3D buffer->ring + write_pos;
+		head->seq_no =3D __seq_no;
+		head->text[0] =3D 0;
+
+		write_pos =3D 0;
+	}
+
+	/* All entry data must be written before we can update write_pos */
+	wmb();
+
+	buffer->write_pos =3D write_pos;
+
+	return res;
+}
+
+int rt_vprintf(const char *format, va_list args)
+{
+	return rt_vfprintf(stdout, format, args);
+}
+
+int rt_fprintf(FILE *stream, const char *format, ...)
+{
+	va_list args;
+	int n;
+
+	va_start(args, format);
+	n =3D rt_vfprintf(stream, format, args);
+	va_end(args);
+
+	return n;
+}
+
+int rt_printf(const char *format, ...)
+{
+	va_list args;
+	int n;
+
+	va_start(args, format);
+	n =3D rt_vfprintf(stdout, format, args);
+	va_end(args);
+
+	return n;
+}
+
+static void set_buffer_name(struct print_buffer *buffer, const char *nam=
e)
+{
+	int n;
+
+	n =3D sprintf(buffer->name, "%08lx", (unsigned long)pthread_self());
+	if (name) {
+		buffer->name[n++] =3D ' ';
+		strncpy(buffer->name+n, name, sizeof(buffer->name)-n-1);
+		buffer->name[sizeof(buffer->name)-1] =3D 0;
+	}
+}
+
+int rt_print_init(size_t buffer_size, const char *buffer_name)
+{
+	struct print_buffer *buffer =3D pthread_getspecific(__buffer_key);
+	size_t size =3D buffer_size;
+
+	if (!size)
+		size =3D __default_buffer_size;
+	else if (size < RT_PRINT_LINE_BREAK)
+		return EINVAL;
+
+	if (buffer) {
+		/* Only set name if buffer size is unchanged or default */
+		if (size =3D=3D buffer->size || !buffer_size) {
+			set_buffer_name(buffer, buffer_name);
+			return 0;
+		}
+		__cleanup_buffer(buffer);
+	}
+
+	buffer =3D malloc(sizeof(*buffer));
+	if (!buffer)
+		return ENOMEM;
+
+	buffer->ring =3D malloc(size);
+	if (!buffer->ring) {
+		free(buffer);
+		return ENOMEM;
+	}
+	memset(buffer->ring, 0, size);
+
+	buffer->read_pos  =3D 0;
+	buffer->write_pos =3D 0;
+
+	buffer->size =3D size;
+
+	set_buffer_name(buffer, buffer_name);
+
+	buffer->prev =3D NULL;
+
+	pthread_mutex_lock(&__buffer_lock);
+
+	buffer->next =3D __first_buffer;
+	if (__first_buffer)
+		__first_buffer->prev =3D buffer;
+	__first_buffer =3D buffer;
+
+	pthread_mutex_unlock(&__buffer_lock);
+
+	pthread_setspecific(__buffer_key, buffer);
+
+	return 0;
+}
+
+void rt_print_auto_init(int enable)
+{
+	__auto_init =3D enable;
+}
+
+void __cleanup_buffer(struct print_buffer *buffer)
+{
+	struct print_buffer *prev, *next;
+
+	pthread_setspecific(__buffer_key, NULL);
+
+	pthread_mutex_lock(&__buffer_lock);
+
+	__print_buffers();
+
+	prev =3D buffer->prev;
+	next =3D buffer->next;
+
+	if (prev)
+		prev->next =3D next;
+	else
+		__first_buffer =3D next;
+	if (next)
+		next->prev =3D prev;
+
+	pthread_mutex_unlock(&__buffer_lock);
+
+	free(buffer->ring);
+	free(buffer);
+}
+
+void rt_print_cleanup(void)
+{
+	__cleanup_buffer(pthread_getspecific(__buffer_key));
+}
+
+const char *rt_print_buffer_name(void)
+{
+	struct print_buffer *buffer =3D pthread_getspecific(__buffer_key);
+
+	if (!buffer) {
+		int res =3D -1;
+
+		if (__auto_init)
+			res =3D rt_print_init(0, NULL);
+
+		if (res)
+			return NULL;
+
+		buffer =3D pthread_getspecific(__buffer_key);
+	}
+
+	return buffer->name;
+}
Index: xenomai/src/rtprint/init.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/rtprint/init.c
@@ -0,0 +1,75 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "internal.h"
+
+struct print_buffer *__first_buffer;
+uint32_t __seq_no;
+size_t __default_buffer_size;
+struct timespec __print_period;
+int __auto_init;
+pthread_mutex_t __buffer_lock;
+pthread_key_t __buffer_key;
+
+static __attribute__ ((constructor)) void __init_rtprint(void)
+{
+	pthread_t thread;
+	pthread_attr_t thattr;
+	const char *value_str;
+	unsigned long long period;
+
+	__first_buffer =3D NULL;
+	__seq_no =3D 0;
+	__auto_init =3D 0;
+
+	__default_buffer_size =3D RT_PRINT_DEFAULT_BUFFER;
+	value_str =3D getenv(RT_PRINT_BUFFER_ENV);
+	if (value_str) {
+		errno =3D 0;
+		__default_buffer_size =3D strtol(value_str, NULL, 10);
+		if (errno || __default_buffer_size < RT_PRINT_LINE_BREAK) {
+			fprintf(stderr, "Invalid %s\n", RT_PRINT_BUFFER_ENV);
+			exit(1);
+		}
+	}
+
+	period =3D RT_PRINT_DEFAULT_PERIOD;
+	value_str =3D getenv(RT_PRINT_PERIOD_ENV);
+	if (value_str) {
+		errno =3D 0;
+		period =3D strtoll(value_str, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "Invalid %s\n", RT_PRINT_PERIOD_ENV);
+			exit(1);
+		}
+	}
+	__print_period.tv_sec  =3D period / 1000;
+	__print_period.tv_nsec =3D (period % 1000) * 1000000;
+
+	pthread_mutex_init(&__buffer_lock, NULL);
+	pthread_key_create(&__buffer_key, (void (*)(void*))__cleanup_buffer);
+
+	pthread_attr_init(&thattr);
+	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+	pthread_create(&thread, &thattr, __printer_thread, NULL);
+}
Index: xenomai/src/rtprint/internal.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/rtprint/internal.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#ifndef _RTPRINT_INTERNAL_H
+#define _RTPRINT_INTERNAL_H
+
+#include <pthread.h>
+#include <inttypes.h>
+#include <unistd.h>
+
+#define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
+#define RT_PRINT_DEFAULT_BUFFER		16*1024
+
+#define RT_PRINT_PERIOD_ENV		"RT_PRINT_PERIOD"
+#define RT_PRINT_DEFAULT_PERIOD		100 /* ms */
+
+#define RT_PRINT_LINE_BREAK		256
+
+struct entry_head {
+	FILE *dest;
+	uint32_t seq_no;
+	char text[1];
+} __attribute__((packed));
+
+struct print_buffer {
+	off_t write_pos;
+
+	struct print_buffer *next, *prev;
+
+	void *ring;
+	size_t size;
+
+	char name[32];
+
+	/*
+	 * Keep read_pos separated from write_pos to optimise write
+	 * caching on SMP.
+	 */
+	off_t read_pos;
+};
+
+extern struct print_buffer *__first_buffer;
+extern uint32_t __seq_no;
+extern int __auto_init;
+extern size_t __default_buffer_size;
+extern struct timespec __print_period;
+extern pthread_mutex_t __buffer_lock;
+extern pthread_key_t __buffer_key;
+
+void __cleanup_buffer(struct print_buffer *buffer);
+void __print_buffers(void);
+void *__printer_thread(void *arg);
+
+#endif /* !_RTPRINT_INTERNAL_H */
Index: xenomai/src/rtprint/output.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ xenomai/src/rtprint/output.c
@@ -0,0 +1,92 @@
+/*
+ * Copyright (C) 2007 Jan Kiszka <jan.kiszka@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 =
 USA.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <asm/xenomai/ubarrier.h>
+
+#include "internal.h"
+
+static inline uint32_t get_next_seq_no(struct print_buffer *buffer)
+{
+	struct entry_head *head =3D buffer->ring + buffer->read_pos;
+	return head->seq_no;
+}
+
+static struct print_buffer *get_next_buffer(void)
+{
+	struct print_buffer *pos =3D __first_buffer;
+	struct print_buffer *buffer =3D NULL;
+	uint32_t next_seq_no;
+
+	while (pos) {
+		if (pos->read_pos !=3D pos->write_pos &&
+		    (!buffer || get_next_seq_no(pos) < next_seq_no)) {
+			buffer =3D pos;
+			next_seq_no =3D get_next_seq_no(pos);
+		}
+		pos =3D pos->next;
+	}
+
+	return buffer;
+}
+
+void __print_buffers(void)
+{
+	struct print_buffer *buffer;
+	struct entry_head *head;
+	off_t read_pos;
+	int len;
+
+	while (1) {
+		buffer =3D get_next_buffer();
+		if (!buffer)
+			break;
+
+		read_pos =3D buffer->read_pos;
+		head =3D buffer->ring + read_pos;
+		len =3D strlen(head->text);
+
+		if (len) {
+			/* Print out non-empty entry and proceed */
+			fprintf(head->dest, "%s", head->text);
+			read_pos +=3D sizeof(*head) + len;
+		} else {
+			/* Emptry entries mark the wrap-around */
+			read_pos =3D 0;
+		}
+
+		rmb();
+		buffer->read_pos =3D read_pos;
+		wmb();
+	}
+}
+
+void *__printer_thread(void *arg)
+{
+	while (1) {
+		nanosleep(&__print_period, NULL);
+
+		pthread_mutex_lock(&__buffer_lock);
+
+		__print_buffers();
+
+		pthread_mutex_unlock(&__buffer_lock);
+	}
+}


--------------080400060409000407080500--

--------------enigC6542B1ABB455123FD8D58A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFF1sS2niDOoMHTA+kRAlXrAJ94dyY/Xpk0IO1XGqU3rZswQ7hXNQCcDDX0
OTU19nMdTRrp46+ZCKm01cs=
=/Nwd
-----END PGP SIGNATURE-----

--------------enigC6542B1ABB455123FD8D58A4--

