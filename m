From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 24 Oct 2008 23:48:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810242348.05336.niklaus.giger@domain.hid>
Subject: [Xenomai-core] [PATCH] solo/vxWorks: add rngLib (with testsuite)
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

Hi

I just found the time to prepare a patch for a substitute for the vxWorks
rngLib library I have written quite some time ago.

The remark from the vxWorks description applies here too
"In particular, ring buffers by themselves provide no task synchronization or mutual exclusion."
(http://www.slac.stanford.edu/exp/glast/flight/sw/vxdocs/vxworks/ref/rngLib.html)

Therefore this library is only good were there is exactly one writer an one reader
envolved.

It would be nice if it could find a place in the xenomai-solo. I am willing to
address any criticism/nitpicking needed to get it into a good shape.

Best regards

Signed-off-by: Niklaus Giger <niklaus.giger@domain.hid>
---
 include/vxworks/Makefile.am |    1 +
 include/vxworks/Makefile.in |    1 +
 vxworks/Makefile.am         |    2 +
 vxworks/Makefile.in         |   18 ++++-
 vxworks/rngLib.c            |  152 +++++++++++++++++++++++++++++++++++++++++++
 vxworks/rngLib.h            |   34 ++++++++++
 vxworks/testsuite/Makefile  |    2 +-
 vxworks/testsuite/rng-1.c   |  118 +++++++++++++++++++++++++++++++++
 8 files changed, 323 insertions(+), 5 deletions(-)
 create mode 100644 vxworks/rngLib.c
 create mode 100644 vxworks/rngLib.h
 create mode 100644 vxworks/testsuite/rng-1.c

diff --git a/include/vxworks/Makefile.am b/include/vxworks/Makefile.am
index 06dcab2..0c20861 100644
--- a/include/vxworks/Makefile.am
+++ b/include/vxworks/Makefile.am
@@ -7,6 +7,7 @@ includesub_HEADERS =	\
 	lstLib.h	\
 	memPartLib.h	\
 	msgQLib.h	\
+	rngLib.h	\
 	semLib.h	\
 	sysLib.h	\
 	taskInfo.h	\
diff --git a/include/vxworks/Makefile.in b/include/vxworks/Makefile.in
index 0fdc3c4..ad10fd1 100644
--- a/include/vxworks/Makefile.in
+++ b/include/vxworks/Makefile.in
@@ -205,6 +205,7 @@ includesub_HEADERS = \
 	lstLib.h	\
 	memPartLib.h	\
 	msgQLib.h	\
+	rngLib.h	\
 	semLib.h	\
 	sysLib.h	\
 	taskInfo.h	\
diff --git a/vxworks/Makefile.am b/vxworks/Makefile.am
index 08e7cc8..a64141e 100644
--- a/vxworks/Makefile.am
+++ b/vxworks/Makefile.am
@@ -11,6 +11,8 @@ libvxworks_la_SOURCES = \
 	memPartLib.h	\
 	msgQLib.c	\
 	msgQLib.h	\
+	rngLib.c	\
+	rngLib.h	\
 	semLib.c	\
 	semLib.h	\
 	taskLib.c	\
diff --git a/vxworks/Makefile.in b/vxworks/Makefile.in
index b8d0ce7..2d08bbd 100644
--- a/vxworks/Makefile.in
+++ b/vxworks/Makefile.in
@@ -57,10 +57,10 @@ libvxworks_la_LIBADD =
 am_libvxworks_la_OBJECTS = libvxworks_la-errnoLib.lo \
 	libvxworks_la-intLib.lo libvxworks_la-kernelLib.lo \
 	libvxworks_la-lstLib.lo libvxworks_la-memPartLib.lo \
-	libvxworks_la-msgQLib.lo libvxworks_la-semLib.lo \
-	libvxworks_la-taskLib.lo libvxworks_la-taskInfo.lo \
-	libvxworks_la-tickLib.lo libvxworks_la-wdLib.lo \
-	libvxworks_la-sysLib.lo
+	libvxworks_la-msgQLib.lo libvxworks_la-rngLib.lo \
+	libvxworks_la-semLib.lo libvxworks_la-taskLib.lo \
+	libvxworks_la-taskInfo.lo libvxworks_la-tickLib.lo \
+	libvxworks_la-wdLib.lo libvxworks_la-sysLib.lo
 libvxworks_la_OBJECTS = $(am_libvxworks_la_OBJECTS)
 libvxworks_la_LINK = $(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) \
 	$(LIBTOOLFLAGS) --mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
@@ -232,6 +232,8 @@ libvxworks_la_SOURCES = \
 	memPartLib.h	\
 	msgQLib.c	\
 	msgQLib.h	\
+	rngLib.c	\
+	rngLib.h	\
 	semLib.c	\
 	semLib.h	\
 	taskLib.c	\
@@ -324,6 +326,7 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
+@AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@
@@ -394,6 +397,13 @@ libvxworks_la-msgQLib.lo: msgQLib.c
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=compile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxworks_la_CPPFLAGS) 
$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o libvxworks_la-msgQLib.lo `test -f 'msgQLib.c' || echo '$(srcdir)/'`msgQLib.c

+libvxworks_la-rngLib.lo: rngLib.c
+@am__fastdepCC_TRUE@	$(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=compile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxworks_la_CPPFLAGS) 
$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT libvxworks_la-rngLib.lo -MD -MP -MF $(DEPDIR)/libvxworks_la-rngLib.Tpo -c -o libvxworks_la-rngLib.lo `test -f 'rngLib.c' || echo 
'$(srcdir)/'`rngLib.c
+@am__fastdepCC_TRUE@	mv -f $(DEPDIR)/libvxworks_la-rngLib.Tpo $(DEPDIR)/libvxworks_la-rngLib.Plo
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='rngLib.c' object='libvxworks_la-rngLib.lo' libtool=yes @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE) $(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=compile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxworks_la_CPPFLAGS) 
$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o libvxworks_la-rngLib.lo `test -f 'rngLib.c' || echo '$(srcdir)/'`rngLib.c
+
 libvxworks_la-semLib.lo: semLib.c
 @am__fastdepCC_TRUE@	$(LIBTOOL) --tag=CC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=compile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxworks_la_CPPFLAGS) 
$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT libvxworks_la-semLib.lo -MD -MP -MF $(DEPDIR)/libvxworks_la-semLib.Tpo -c -o libvxworks_la-semLib.lo `test -f 'semLib.c' || echo 
'$(srcdir)/'`semLib.c
 @am__fastdepCC_TRUE@	mv -f $(DEPDIR)/libvxworks_la-semLib.Tpo $(DEPDIR)/libvxworks_la-semLib.Plo
diff --git a/vxworks/rngLib.c b/vxworks/rngLib.c
new file mode 100644
index 0000000..d033db9
--- /dev/null
+++ b/vxworks/rngLib.c
@@ -0,0 +1,152 @@
+/*
+ * Copyright (C) 2008 Niklaus Giger <niklaus.giger@domain.hid>.
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
+#include <stdlib.h>
+#include <vxworks/errnoLib.h>
+#include "rngLib.h"
+
+#define WIND_RING_MAGIC 0x5432affe
+
+RING_ID rngCreate(int nbytes)
+{
+	RING_DESCRIPTOR *ring;
+	void *ring_mem;
+
+	if ( nbytes<=0) { errnoSet(S_memLib_NOT_ENOUGH_MEMORY); return 0; }
+	ring_mem = malloc( sizeof(RING_DESCRIPTOR*) + nbytes);
+	if ( ring_mem == 0) { errno = errnoSet(S_memLib_NOT_ENOUGH_MEMORY); return 0; }
+
+	ring = (RING_DESCRIPTOR *) ring_mem;
+	ring->magic = WIND_RING_MAGIC;
+	ring->bufSize = nbytes;
+	ring->readPos = 0;
+	ring->writePos = 0;
+	return (RING_ID) ring_mem;
+}
+
+
+void rngDelete(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return;
+	ring->magic = 0;
+	free(ring);
+}
+
+
+void rngFlush(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return;
+	ring->readPos = 0;
+	ring->writePos = 0;
+}
+
+
+int rngBufGet(RING_ID ring_id,
+	char *  buffer,
+	int     maxbytes)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	int j, bytesRead=0;
+	unsigned int savedWritePos = ring->writePos;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	for (j=0; j < maxbytes; j++)
+	{
+		if ((ring->readPos) % (ring->bufSize + 1) == savedWritePos)
+		{
+			break;
+		}
+		buffer[j] = ring->buffer[ring->readPos];
+		++bytesRead;
+		ring->readPos = (ring->readPos + 1) % (ring->bufSize + 1);
+	}
+	return bytesRead;
+}
+
+
+int rngBufPut(RING_ID ring_id,
+	char *  buffer,
+	int     nbytes)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	int j, bytesWritten=0;
+	unsigned int savedReadPos = ring->readPos;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	for (j=0; j < nbytes; j++)
+	{
+		if ((ring->writePos + 1) % (ring->bufSize + 1) == savedReadPos)
+		{
+			break;
+		}
+		ring->buffer[ring->writePos] = buffer[j];
+		++bytesWritten;
+		ring->writePos = (ring->writePos + 1) % (ring->bufSize + 1);
+	}
+	return bytesWritten;
+}
+
+
+BOOL rngIsEmpty(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	return rngFreeBytes(ring_id) == (int) ring->bufSize;
+}
+
+
+BOOL rngIsFull(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	return rngFreeBytes(ring_id) == 0;
+}
+
+
+int rngFreeBytes(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	return ((ring->bufSize - (ring->writePos - ring->readPos)) % (ring->bufSize+1));
+}
+
+
+int rngNBytes(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
+	return ring->bufSize - rngFreeBytes(ring_id);
+}
+
+void rngPutAhead(RING_ID ring_id,
+	char    byte,
+	int     offset)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return;
+	return;
+}
+
+
+void rngMoveAhead(RING_ID ring_id,
+	int     n)
+{
+	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
+	if (ring->magic != WIND_RING_MAGIC) return;
+	return;
+}
diff --git a/vxworks/rngLib.h b/vxworks/rngLib.h
new file mode 100644
index 0000000..d646614
--- /dev/null
+++ b/vxworks/rngLib.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) 2008 Philippe Gerum <rpm@xenomai.org>.
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
+#ifndef _VXWORKS_RNGLIB_H
+#define _VXWORKS_RNGLIB_H
+
+#include <xenomai/syncobj.h>
+#include <xenomai/heapobj.h>
+#include <vxworks/rngLib.h>
+
+typedef struct  {
+	unsigned int magic;
+	unsigned int bufSize;
+	unsigned int readPos;
+	unsigned int writePos;
+	char buffer[];
+} RING_DESCRIPTOR ;
+
+#endif /* _VXWORKS_RNGLIB_H */
diff --git a/vxworks/testsuite/Makefile b/vxworks/testsuite/Makefile
index d1ce203..d391406 100644
--- a/vxworks/testsuite/Makefile
+++ b/vxworks/testsuite/Makefile
@@ -5,7 +5,7 @@ ifeq ($(prefix),)
 $(error Please add <xenomai-install-path>/bin to your PATH variable)
 endif

-TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1
+TESTS := task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4 lst-1 rng-1

 CFLAGS := $(shell $(XENO_CONFIG) --cflags) -g
 LDFLAGS := -lvxworks $(shell $(XENO_CONFIG) --ldflags)
diff --git a/vxworks/testsuite/rng-1.c b/vxworks/testsuite/rng-1.c
new file mode 100644
index 0000000..fab36ab
--- /dev/null
+++ b/vxworks/testsuite/rng-1.c
@@ -0,0 +1,118 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <xenomai/traceobj.h>
+#include <vxworks/errnoLib.h>
+#include <vxworks/taskLib.h>
+#include <vxworks/rngLib.h>
+
+static struct traceobj trobj;
+
+void rootTask(long a0, long a1, long a2, long a3, long a4,
+	      long a5, long a6, long a7, long a8, long a9)
+{
+	RING_ID ring;
+
+	int j, chunks;
+	const int putBytes = 10;
+	const int nrChunks = 3;
+	const int rngBytes = putBytes * nrChunks;
+	char buffer[putBytes];
+	char bigBuffer[putBytes*2*nrChunks];
+	int bytesPut;
+	int bytesGot;
+	traceobj_enter(&trobj);
+
+	RING_ID rng = rngCreate(rngBytes);
+
+	traceobj_assert(&trobj, rng != 0);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+
+	/* Fill a few chunks */
+	for (chunks=0; chunks < nrChunks; chunks++) {
+		traceobj_assert(&trobj, rngNBytes(rng) == chunks*(int)sizeof(buffer));
+		traceobj_assert(&trobj, rngFreeBytes(rng) == rngBytes - chunks*(int)sizeof(buffer));
+		for (j=0; j < (int)sizeof(buffer); j++) {
+			buffer[j] = (char)j+(int)sizeof(buffer)*chunks;
+		}
+		bytesPut = rngBufPut(rng, &buffer[0], sizeof(buffer));
+		traceobj_assert(&trobj, bytesPut == sizeof(buffer));
+		traceobj_assert(&trobj, !rngIsEmpty(rng));
+		traceobj_assert(&trobj, rngIsFull(rng) == (nrChunks - 1 == chunks));
+		traceobj_assert(&trobj, rngFreeBytes(rng) == rngBytes-bytesPut*(chunks+1));
+		traceobj_assert(&trobj, rngNBytes(rng) == (chunks + 1)*(int)sizeof(buffer));
+	}
+	traceobj_assert(&trobj, rngIsFull(rng));
+	bytesPut = rngBufPut(rng, &buffer[0], sizeof(buffer));
+	traceobj_assert(&trobj, bytesPut ==0);
+	traceobj_assert(&trobj, rngIsFull(rng));
+
+	/* Read chunks back and check content */
+	for (chunks=0; chunks < nrChunks; chunks++)
+	{
+		for (j=0; j < (int)sizeof(buffer); j++) {
+			buffer[j] = 0;
+		}
+		traceobj_assert(&trobj, rngNBytes(rng) == (nrChunks - chunks)*(int)sizeof(buffer));
+		traceobj_assert(&trobj, rngFreeBytes(rng) == chunks*(int)sizeof(buffer));
+		bytesGot = rngBufGet(rng, &buffer[0], sizeof(buffer));
+		traceobj_assert(&trobj, bytesGot == (int)sizeof(buffer));
+		for (j=0; j < (int)sizeof(buffer); j++) {
+			traceobj_assert(&trobj, buffer[j] == (char)j + sizeof(buffer)*chunks);
+		}
+		traceobj_assert(&trobj, !rngIsFull(rng));
+		traceobj_assert(&trobj, rngIsEmpty(rng) == (chunks == nrChunks -1));
+
+		traceobj_assert(&trobj, rngFreeBytes(rng) == (chunks + 1)*(int)sizeof(buffer));
+		traceobj_assert(&trobj, rngNBytes(rng) == (nrChunks - chunks - 1)*(int)sizeof(buffer));
+	}
+
+	/* Testing filling too many */
+	for (j=0; j < (int)sizeof(bigBuffer); j++) {
+		bigBuffer[j] = 32+j;
+	}
+	bytesPut = rngBufPut(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesPut == rngBytes);
+	traceobj_assert(&trobj, !rngIsEmpty(rng));
+	traceobj_assert(&trobj, rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) == 0);
+	traceobj_assert(&trobj, rngNBytes(rng) == rngBytes);
+
+	/* Getting too many */
+	for (j=0; j < (int)sizeof(bigBuffer); j++) {
+		bigBuffer[j] = 0;
+	}
+	bytesGot = rngBufGet(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesGot == rngBytes);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) == rngBytes);
+	traceobj_assert(&trobj, rngNBytes(rng) == 0);
+	for (j=0; j <rngBytes; j++) {
+		traceobj_assert(&trobj, bigBuffer[j] == (char)32+j);
+	}
+
+	bytesPut = rngBufPut(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesPut == rngBytes);
+	rngFlush(rng);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) == rngBytes);
+	traceobj_assert(&trobj, rngNBytes(rng) == 0);
+	rngDelete(rng);
+
+	traceobj_exit(&trobj);
+}
+
+int main(int argc, char *argv[])
+{
+	int ret;
+
+	traceobj_init(&trobj, argv[0], 0);
+
+	ret = kernelInit(rootTask, argc, argv);
+	traceobj_assert(&trobj, ret == OK);
+
+	traceobj_join(&trobj);
+	exit(0);
+}
+
--
1.6.0.2



