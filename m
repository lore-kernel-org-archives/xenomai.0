Message-ID: <45D896FC.9030407@domain.hid>
Date: Sun, 18 Feb 2007 19:12:12 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <45D6C4B6.7010302@domain.hid> <1171714345.18347.25.camel@domain.hid>
In-Reply-To: <1171714345.18347.25.camel@domain.hid>
Content-Type: multipart/mixed; boundary="------------010804040708050904040706"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [RFC][PATCH 1/2] real-time print library
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

This is a multi-part message in MIME format.
--------------010804040708050904040706
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
> ubarrier.h is redundant. include/asm-*/atomic.h is already there for
> such purpose.

Here comes version 2 of the patch, getting rid of ubarrier.h

Jan

--------------010804040708050904040706
Content-Type: text/x-patch;
 name="librtprint-v2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="librtprint-v2.patch"

---
 configure.in              |    1 
 examples/native/Makefile  |    8 +
 examples/native/rtprint.c |   48 ++++++++
 include/Makefile.am       |    5 
 include/asm-i386/atomic.h |    4 
 include/rtprint.h         |   59 +++++++++
 src/Makefile.am           |    2 
 src/rtprint/Makefile.am   |   12 ++
 src/rtprint/api.c         |  273 ++++++++++++++++++++++++++++++++++++++++++++++
 src/rtprint/init.c        |   75 ++++++++++++
 src/rtprint/internal.h    |   69 +++++++++++
 src/rtprint/output.c      |   96 ++++++++++++++++
 12 files changed, 650 insertions(+), 2 deletions(-)

Index: xenomai/configure.in
===================================================================
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
===================================================================
--- xenomai.orig/examples/native/Makefile
+++ xenomai/examples/native/Makefile
@@ -1,7 +1,7 @@
 ###### CONFIGURATION ######
 
 ### List of applications to be build
-APPLICATIONS = trivial-periodic sigxcpu
+APPLICATIONS = trivial-periodic sigxcpu rtprint
 
 ### Note: to override the search path for the xeno-config script, use "make XENO=..."
 
@@ -44,6 +44,12 @@ endif
 
 
 
+###### SPECIAL TARGET RULES ######
+rtprint: rtprint.c
+	$(CC) $(CFLAGS) $? $(LDFLAGS) -lrtprint -o $@
+
+
+
 ###### KERNEL MODULE BUILD (no change required normally) ######
 ifneq ($(MODULES),)
 
Index: xenomai/examples/native/rtprint.c
===================================================================
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
+	int i = 0;
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
+	int i = 0;
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
===================================================================
--- xenomai.orig/include/Makefile.am
+++ xenomai/include/Makefile.am
@@ -1,3 +1,8 @@
+includedir = $(prefix)/include
+
+include_HEADERS = \
+	rtprint.h
+
 nodist_include_HEADERS=$(CONFIG_HEADER)
 
 SUBDIRS = \
Index: xenomai/include/rtprint.h
===================================================================
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#ifndef _RTPRINT_H
+#define _RTPRINT_H
+
+#ifdef __KERNEL__
+
+#define rt_printf(format, ...)	printk(format __VA_ARGS__)
+
+static inline int rt_print_init(size_t buffer_size, const char *buffer_name)
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
===================================================================
--- xenomai.orig/src/Makefile.am
+++ xenomai/src/Makefile.am
@@ -1,2 +1,2 @@
 
-SUBDIRS = include skins testsuite utils
+SUBDIRS = include rtprint skins testsuite utils
Index: xenomai/src/rtprint/Makefile.am
===================================================================
--- /dev/null
+++ xenomai/src/rtprint/Makefile.am
@@ -0,0 +1,12 @@
+lib_LTLIBRARIES = librtprint.la
+
+librtprint_la_LDFLAGS = -version-info 0:0:0 -lpthread
+
+librtprint_la_SOURCES = \
+	init.c \
+	output.c \
+	api.c
+
+librtprint_la_CPPFLAGS = \
+	@XENO_USER_CFLAGS@ \
+	-I$(top_srcdir)/include
Index: xenomai/src/rtprint/api.c
===================================================================
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <errno.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <rtprint.h>
+#include <asm/xenomai/atomic.h>
+
+#include "internal.h"
+
+int rt_vfprintf(FILE *stream, const char *format, va_list args)
+{
+	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
+	off_t write_pos, read_pos;
+	struct entry_head *head;
+	int len;
+	int res;
+
+	if (!buffer) {
+		res = 0;
+		if (__auto_init)
+			res = rt_print_init(0, NULL);
+		else
+			res = EIO;
+
+		if (res) {
+			errno = res;
+			return -1;
+		}
+		buffer = pthread_getspecific(__buffer_key);
+	}
+
+	/* Take a snapshot of the ring buffer state */
+	write_pos = buffer->write_pos;
+	read_pos = buffer->read_pos;
+	xnarch_read_memory_barrier();
+
+	/* Is our write limit the end of the ring buffer? */
+	if (write_pos >= read_pos) {
+		/* Keep a savety margin to the end for at least an empty entry */
+		len = buffer->size - write_pos - sizeof(struct entry_head);
+
+		/* Special case: We were stuck at the end of the ring buffer
+		   with space left there only for one empty entry. Now
+		   read_pos was moved forward and we can wrap around. */
+		if (len == 0 && read_pos > sizeof(struct entry_head)) {
+			/* Write out empty entry */
+			head = buffer->ring + write_pos;
+			head->seq_no = __seq_no;
+			head->text[0] = 0;
+
+			/* Forward to the ring buffer start */
+			write_pos = 0;
+			len = read_pos - 1;
+		}
+	} else {
+		/* Our limit is the read_pos ahead of our write_pos. One byte
+		   margin is required to detect a full ring. */
+		len = read_pos - write_pos - 1;
+	}
+
+	/* Account for head length */
+	len -= sizeof(struct entry_head);
+	if (len < 0)
+		len = 0;
+
+	head = buffer->ring + write_pos;
+
+	res = vsnprintf(head->text, len, format, args);
+
+	if (res < len) {
+		/* Text was written completely, res contains its length */
+		len = res;
+	} else {
+		/* Text was truncated, remove closing \0 that entry_head
+		   already includes */
+		len--;
+	}
+
+	/* If we were able to write some text, finalise the entry */
+	if (len > 0) {
+		head->seq_no = ++__seq_no;
+		head->dest = stream;
+
+		/* Move forward by text and head length */
+		write_pos += len + sizeof(struct entry_head);
+	}
+
+	/* Wrap around early if there is more space on the other side */
+	if (write_pos >= buffer->size - RT_PRINT_LINE_BREAK &&
+	    read_pos <= write_pos && read_pos > buffer->size - write_pos) {
+		/* An empty entry marks the wrap-around */
+		head = buffer->ring + write_pos;
+		head->seq_no = __seq_no;
+		head->text[0] = 0;
+
+		write_pos = 0;
+	}
+
+	/* All entry data must be written before we can update write_pos */
+	xnarch_write_memory_barrier();
+
+	buffer->write_pos = write_pos;
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
+	n = rt_vfprintf(stream, format, args);
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
+	n = rt_vfprintf(stdout, format, args);
+	va_end(args);
+
+	return n;
+}
+
+static void set_buffer_name(struct print_buffer *buffer, const char *name)
+{
+	int n;
+
+	n = sprintf(buffer->name, "%08lx", (unsigned long)pthread_self());
+	if (name) {
+		buffer->name[n++] = ' ';
+		strncpy(buffer->name+n, name, sizeof(buffer->name)-n-1);
+		buffer->name[sizeof(buffer->name)-1] = 0;
+	}
+}
+
+int rt_print_init(size_t buffer_size, const char *buffer_name)
+{
+	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
+	size_t size = buffer_size;
+
+	if (!size)
+		size = __default_buffer_size;
+	else if (size < RT_PRINT_LINE_BREAK)
+		return EINVAL;
+
+	if (buffer) {
+		/* Only set name if buffer size is unchanged or default */
+		if (size == buffer->size || !buffer_size) {
+			set_buffer_name(buffer, buffer_name);
+			return 0;
+		}
+		__cleanup_buffer(buffer);
+	}
+
+	buffer = malloc(sizeof(*buffer));
+	if (!buffer)
+		return ENOMEM;
+
+	buffer->ring = malloc(size);
+	if (!buffer->ring) {
+		free(buffer);
+		return ENOMEM;
+	}
+	memset(buffer->ring, 0, size);
+
+	buffer->read_pos  = 0;
+	buffer->write_pos = 0;
+
+	buffer->size = size;
+
+	set_buffer_name(buffer, buffer_name);
+
+	buffer->prev = NULL;
+
+	pthread_mutex_lock(&__buffer_lock);
+
+	buffer->next = __first_buffer;
+	if (__first_buffer)
+		__first_buffer->prev = buffer;
+	__first_buffer = buffer;
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
+	__auto_init = enable;
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
+	prev = buffer->prev;
+	next = buffer->next;
+
+	if (prev)
+		prev->next = next;
+	else
+		__first_buffer = next;
+	if (next)
+		next->prev = prev;
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
+	struct print_buffer *buffer = pthread_getspecific(__buffer_key);
+
+	if (!buffer) {
+		int res = -1;
+
+		if (__auto_init)
+			res = rt_print_init(0, NULL);
+
+		if (res)
+			return NULL;
+
+		buffer = pthread_getspecific(__buffer_key);
+	}
+
+	return buffer->name;
+}
Index: xenomai/src/rtprint/init.c
===================================================================
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
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
+	__first_buffer = NULL;
+	__seq_no = 0;
+	__auto_init = 0;
+
+	__default_buffer_size = RT_PRINT_DEFAULT_BUFFER;
+	value_str = getenv(RT_PRINT_BUFFER_ENV);
+	if (value_str) {
+		errno = 0;
+		__default_buffer_size = strtol(value_str, NULL, 10);
+		if (errno || __default_buffer_size < RT_PRINT_LINE_BREAK) {
+			fprintf(stderr, "Invalid %s\n", RT_PRINT_BUFFER_ENV);
+			exit(1);
+		}
+	}
+
+	period = RT_PRINT_DEFAULT_PERIOD;
+	value_str = getenv(RT_PRINT_PERIOD_ENV);
+	if (value_str) {
+		errno = 0;
+		period = strtoll(value_str, NULL, 10);
+		if (errno) {
+			fprintf(stderr, "Invalid %s\n", RT_PRINT_PERIOD_ENV);
+			exit(1);
+		}
+	}
+	__print_period.tv_sec  = period / 1000;
+	__print_period.tv_nsec = (period % 1000) * 1000000;
+
+	pthread_mutex_init(&__buffer_lock, NULL);
+	pthread_key_create(&__buffer_key, (void (*)(void*))__cleanup_buffer);
+
+	pthread_attr_init(&thattr);
+	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+	pthread_create(&thread, &thattr, __printer_thread, NULL);
+}
Index: xenomai/src/rtprint/internal.h
===================================================================
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
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
===================================================================
--- /dev/null
+++ xenomai/src/rtprint/output.c
@@ -0,0 +1,96 @@
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <time.h>
+#include <asm/xenomai/atomic.h>
+
+#include "internal.h"
+
+static inline uint32_t get_next_seq_no(struct print_buffer *buffer)
+{
+	struct entry_head *head = buffer->ring + buffer->read_pos;
+	return head->seq_no;
+}
+
+static struct print_buffer *get_next_buffer(void)
+{
+	struct print_buffer *pos = __first_buffer;
+	struct print_buffer *buffer = NULL;
+	uint32_t next_seq_no;
+
+	while (pos) {
+		if (pos->read_pos != pos->write_pos &&
+		    (!buffer || get_next_seq_no(pos) < next_seq_no)) {
+			buffer = pos;
+			next_seq_no = get_next_seq_no(pos);
+		}
+		pos = pos->next;
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
+		buffer = get_next_buffer();
+		if (!buffer)
+			break;
+
+		read_pos = buffer->read_pos;
+		head = buffer->ring + read_pos;
+		len = strlen(head->text);
+
+		if (len) {
+			/* Print out non-empty entry and proceed */
+			fprintf(head->dest, "%s", head->text);
+			read_pos += sizeof(*head) + len;
+		} else {
+			/* Emptry entries mark the wrap-around */
+			read_pos = 0;
+		}
+
+		/* Make sure we have read the entry competely before
+		   forwarding read_pos */
+		xnarch_read_memory_barrier();
+		buffer->read_pos = read_pos;
+
+		/* Enforce the read_pos update before proceeding */
+		xnarch_write_memory_barrier();
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
Index: xenomai/include/asm-i386/atomic.h
===================================================================
--- xenomai.orig/include/asm-i386/atomic.h
+++ xenomai/include/asm-i386/atomic.h
@@ -63,6 +63,10 @@ static inline unsigned long xnarch_atomi
 
 #define xnarch_memory_barrier()  __asm__ __volatile__("": : :"memory")
 
+#define xnarch_read_memory_barrier() \
+	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#define xnarch_write_memory_barrier()	xnarch_memory_barrier()
+
 #endif /* __KERNEL__ */
 
 typedef unsigned long atomic_flags_t;

--------------010804040708050904040706--

