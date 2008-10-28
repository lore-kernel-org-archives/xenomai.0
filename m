From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 28 Oct 2008 17:11:53 +0100
References: <200810242348.05336.niklaus.giger@domain.hid>
	<49049480.20306@domain.hid>
In-Reply-To: <49049480.20306@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_LnzBJHh5BjA23iP"
Message-Id: <200810281711.55078.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] [PATCH] solo/vxWorks: add rngLib (with testsuite)
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

--Boundary-00=_LnzBJHh5BjA23iP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag 26 Oktober 2008 17.02:08 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
> >
> > I just found the time to prepare a patch for a substitute for the vxWorks
> > rngLib library I have written quite some time ago.
<..>
Thank you for your review. Attached a corrected version of my patch.
But there a some more points, which I would like to discuss.
> Fair enough, but we would have to pin all VxWorks tasks to the same CPU on
> SMP systems; otherwise, out-of-order memory accesses would kill that code.
>
Can you do it this?

I am not familiar with this kind of problem as I am still running single 
processor boards. But I am quite sure that our next board will have two (or 
more) processore cores sitting on it. Though I have quite an interest in 
providing a correct solution.

I am not familiar with vxWorks-SMP and therefore I am not sure whether it is a 
good idea to pin all vxWorks tasks to one CPU or whether the user should be 
able to select the tasks he wants. E.g. you might want only the reader and the 
writer of a ring or list on one CPU and other ones to other CPU(s).

<..> 
> >  vxworks/Makefile.in         |   18 ++++-
> >  vxworks/rngLib.c            |  152
> > +++++++++++++++++++++++++++++++++++++++++++ vxworks/rngLib.h            |
> >   34 ++++++++++
>
> Something must be missing here. vxworks/rngLib.h should contain internal
> definitions, used by the ring buffer implementation code, and that is
> correct in your code. However, include/vxworks/rngLib.h should provide the
> interface to applications; it seems we are missing such a file.
Sorry, I forgot to do git add include/vxworks/rngLib.h, which is attached now 
and  which provides the (opaque) interface to the vxWorks users.
> Since we don't want to export the innards of a ring buffer implementation
> to applications, the interface header should only define the opaque ring
> buffer handle type (i.e. typedef intptr_t RING_ID), and the RNG routine
> prototypes.
>
<..>
> Please use the linux-c coding style, basically K&R + preposterously large
> indent tabs (8 chars)
>
Thank you for code snippets for emacs and ident (did put it into my notes as 
it is not the first time I have to deal with such problems).
> Emacs can be taught this way:
>
> (defun linux-c-mode ()
>   "C mode with adjusted defaults for use with Xenomai."
>   (interactive)
>   (c-mode)
>   (c-set-style "K&R")
>   (setq tab-width 8)
>   (setq indent-tabs-mode t)
>   (setq c-basic-offset 8))
>
> Indent will reformat almost properly with (-T should be used to teach
> indent about the known non-standard types as well):
>
> $ indent -npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1
>
> > +	ring_mem = malloc( sizeof(RING_DESCRIPTOR*) + nbytes);
>
> The sizeof() argument is wrong. Out-of-bound memory writes are knocking at
> the door.
Thanks for catching this error. The following code should be correct.
	ring_mem = xnmalloc(sizeof(RING_DESCRIPTOR) + nbytes + 1);
I need 1 additional byte to be able to use only the read/write-position. This 
allows that the reader only modifies the readPosition and ther writer only
the writePosition.

>
> Also, please use xnmalloc(). This call will pull memory from the allocator
> selected at built time for the SOLO stack, either TLSF, or standard
> malloc(). --enable-malloc is false by default (i.e. TLSF enabled).
> > +	if ( ring_mem == 0) { errno = errnoSet(S_memLib_NOT_ENOUGH_MEMORY);
> > return 0; } +
Ack.
>
> Please compare pointers to NULL (and return null pointers the same way),
> that gives a better hint about the pointerness of the data involved.
>
Ack.
> > +	ring = (RING_DESCRIPTOR *) ring_mem;
>
> Cast is useless; let's remove visual clutter as much as we can. Actually,
> ring_mem is useless as well; you could optimally work only using the ring
> variable directly. Reducing the number of variable hops allows people to
> work late at night with half a brain.
Ack.
>
> > +	ring->magic = WIND_RING_MAGIC;
> > +	ring->bufSize = nbytes;
> > +	ring->readPos = 0;
> > +	ring->writePos = 0;
>
> Nitpicking alert: line-feed please. It is visually easier to locate the
> main return value.
Ack.
>
> > +	return (RING_ID) ring_mem;
> > +}
> > +
> > +
> > +void rngDelete(RING_ID ring_id)
> > +{
> > +	RING_DESCRIPTOR *ring = (RING_DESCRIPTOR *) ring_id;
> > +	if (ring->magic != WIND_RING_MAGIC) return;
>
Ack.
> K&R
>
> > +	ring->magic = 0;
> > +	free(ring);
>
> xnfree() is the converse call for xnmalloc().
Ack.
>
<..>
> linefeed please. Splitting declarations and pure executable statements
> makes it easier for the eyes as well.
Ack.
>
> > +	if (ring->magic != WIND_RING_MAGIC) return -ENOSYS;
>
> Mm, I guess VxWorks is not even checking there, right? If it does not, then
> I would rather raise an assertion when a bad magic is detected, that would
> only trigger with --enable-debug/--enable-assert.

It is true, that vxWorks does not use a magic. 

What is your prefered way to raise an exception? 

> > +	for (j=0; j < maxbytes; j++)
> > +	{
> > +		if ((ring->readPos) % (ring->bufSize + 1) == savedWritePos)
>
> ring->readPos should never be out of bounds anyway. Do we actually need to
> constrain the value to bufSize again?
Yes, we do. It happens if you want to get/put more characters from the ring 
buffer, than there are available.
> > +		{
>
> Single statement, save energy spent typing, no brace needed.
Ack.
<..>
> Same remarks as for rngBufGet().
>
> More generally, I see off-by-one errors in both rngGet() and rngPut(), the
> way they determine the next readable/writable byte index. In the following
> scenario for instance, we would write two bytes to the ring buffer at
> indices #0 et #1, albeit we only have space for a single character.
>
> rngCreate(1);
> rngPut(rng, buf, 1);
> rngGet(rng, buf, 1);
> rngPut(rng, buf, 1);
See my answer for rngCreate. BufferSize is one bigger than bufSize. But you 
really have a sharp eye to find corner cases! Added them to my unit test.

> Dynamically maintaining a count of free bytes in the ring would allow easy
> watermark checks in rngPut() and rngGet(), while providing a
> straigthforward implementation for rngIsEmpy(), rngIsFull() and
> rngFreeBytes().
See discussion above. I want any additional dependency on a variable shared 
between the reader and the writer thread.
<..>
> Missing code in the following routines?
>
Thanks for spotting them. I never used them, therefore they were very low on 
my priority list. But for the sake of completeness I added them with their 
corresponding test case.

All testcases were run on my vxWorks board.

> > +void rngPutAhead(RING_ID ring_id,
<..>

Best regards

Niklaus

--Boundary-00=_LnzBJHh5BjA23iP
Content-Type: text/x-patch;
  charset="iso-8859-1";
  name="0001-SOLO-Add-vxworks-rngLib-replacement.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-SOLO-Add-vxworks-rngLib-replacement.patch"

=46rom f7eea15b94af58602eef2d5f9c84a69743c94fe8 Mon Sep 17 00:00:00 2001
=46rom: Niklaus Giger <niklaus.giger@domain.hid>
Date: Tue, 28 Oct 2008 17:09:35 +0100
Subject: [PATCH] SOLO: Add vxworks rngLib replacement

=2D--
 include/vxworks/Makefile.am |    1 +
 include/vxworks/Makefile.in |    1 +
 include/vxworks/rngLib.h    |   56 +++++++++++
 vxworks/Makefile.am         |    2 +
 vxworks/Makefile.in         |   18 +++-
 vxworks/rngLib.c            |  168 +++++++++++++++++++++++++++++++++
 vxworks/rngLib.h            |   34 +++++++
 vxworks/testsuite/Makefile  |    2 +-
 vxworks/testsuite/rng-1.c   |  215 +++++++++++++++++++++++++++++++++++++++=
++++
 9 files changed, 492 insertions(+), 5 deletions(-)
 create mode 100644 include/vxworks/rngLib.h
 create mode 100644 vxworks/rngLib.c
 create mode 100644 vxworks/rngLib.h
 create mode 100644 vxworks/testsuite/rng-1.c

diff --git a/include/vxworks/Makefile.am b/include/vxworks/Makefile.am
index 06dcab2..0c20861 100644
=2D-- a/include/vxworks/Makefile.am
+++ b/include/vxworks/Makefile.am
@@ -7,6 +7,7 @@ includesub_HEADERS =3D	\
 	lstLib.h	\
 	memPartLib.h	\
 	msgQLib.h	\
+	rngLib.h	\
 	semLib.h	\
 	sysLib.h	\
 	taskInfo.h	\
diff --git a/include/vxworks/Makefile.in b/include/vxworks/Makefile.in
index 0fdc3c4..ad10fd1 100644
=2D-- a/include/vxworks/Makefile.in
+++ b/include/vxworks/Makefile.in
@@ -205,6 +205,7 @@ includesub_HEADERS =3D \
 	lstLib.h	\
 	memPartLib.h	\
 	msgQLib.h	\
+	rngLib.h	\
 	semLib.h	\
 	sysLib.h	\
 	taskInfo.h	\
diff --git a/include/vxworks/rngLib.h b/include/vxworks/rngLib.h
new file mode 100644
index 0000000..d2bc8fe
=2D-- /dev/null
+++ b/include/vxworks/rngLib.h
@@ -0,0 +1,56 @@
+/*
+ *  * Copyright (C) 2008 Niklaus Giger <niklaus.giger@domain.hid>.
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA.
+ *
+ * This file satisfies the references within the emulator code
+ * mimicking a VxWorks-like API built upon the Xenomai/SOLO core.
+ *
+ * VxWorks is a registered trademark of Wind River Systems, Inc.
+ */
+
+#ifndef _XENOMAI_VXWORKS_RNGLIB_H
+#define _XENOMAI_VXWORKS_RNGLIB_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+	typedef int *RING_ID;
+
+	RING_ID rngCreate(int nbytes);
+
+	void rngDelete(RING_ID ringId);
+
+	void rngFlush(RING_ID ringId);
+
+	int rngBufGet(RING_ID rngId, char *buffer, int maxbytes);
+
+	int rngBufPut(RING_ID rngId, char *buffer, int nbytes);
+
+	BOOL rngIsEmpty(RING_ID ringId);
+
+	BOOL rngIsFull(RING_ID ringId);
+
+	int rngFreeBytes(RING_ID ringId);
+
+	int rngNBytes(RING_ID ringId);
+	void rngPutAhead(RING_ID ringId, char byte, int offset);
+	void rngMoveAhead(RING_ID ringId, int n);
+
+#ifdef __cplusplus
+}
+#endif
+#endif				/* !_XENOMAI_VXWORKS_RNGLIB_H */
diff --git a/vxworks/Makefile.am b/vxworks/Makefile.am
index 08e7cc8..a64141e 100644
=2D-- a/vxworks/Makefile.am
+++ b/vxworks/Makefile.am
@@ -11,6 +11,8 @@ libvxworks_la_SOURCES =3D \
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
=2D-- a/vxworks/Makefile.in
+++ b/vxworks/Makefile.in
@@ -57,10 +57,10 @@ libvxworks_la_LIBADD =3D
 am_libvxworks_la_OBJECTS =3D libvxworks_la-errnoLib.lo \
 	libvxworks_la-intLib.lo libvxworks_la-kernelLib.lo \
 	libvxworks_la-lstLib.lo libvxworks_la-memPartLib.lo \
=2D	libvxworks_la-msgQLib.lo libvxworks_la-semLib.lo \
=2D	libvxworks_la-taskLib.lo libvxworks_la-taskInfo.lo \
=2D	libvxworks_la-tickLib.lo libvxworks_la-wdLib.lo \
=2D	libvxworks_la-sysLib.lo
+	libvxworks_la-msgQLib.lo libvxworks_la-rngLib.lo \
+	libvxworks_la-semLib.lo libvxworks_la-taskLib.lo \
+	libvxworks_la-taskInfo.lo libvxworks_la-tickLib.lo \
+	libvxworks_la-wdLib.lo libvxworks_la-sysLib.lo
 libvxworks_la_OBJECTS =3D $(am_libvxworks_la_OBJECTS)
 libvxworks_la_LINK =3D $(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) \
 	$(LIBTOOLFLAGS) --mode=3Dlink $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
@@ -232,6 +232,8 @@ libvxworks_la_SOURCES =3D \
 	memPartLib.h	\
 	msgQLib.c	\
 	msgQLib.h	\
+	rngLib.c	\
+	rngLib.h	\
 	semLib.c	\
 	semLib.h	\
 	taskLib.c	\
@@ -324,6 +326,7 @@ distclean-compile:
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@=
am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid.=
Plo@domain.hid@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid=
@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@domain.hid@=
am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@=
am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid@=
am__quote@
 @AMDEP_TRUE@@am__include@ @am__quote@domain.hid=
o@domain.hid@
@@ -394,6 +397,13 @@ libvxworks_la-msgQLib.lo: msgQLib.c
 @AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=3D$(DEPDIR) $(CCDEPMODE) $(depcom=
p) @AMDEPBACKSLASH@
 @am__fastdepCC_FALSE@	$(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) $(LIBTOOLFL=
AGS) --mode=3Dcompile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvx=
works_la_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o libvxworks_la-m=
sgQLib.lo `test -f 'msgQLib.c' || echo '$(srcdir)/'`msgQLib.c
=20
+libvxworks_la-rngLib.lo: rngLib.c
+@am__fastdepCC_TRUE@	$(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLA=
GS) --mode=3Dcompile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxw=
orks_la_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT libvxworks_la-rngL=
ib.lo -MD -MP -MF $(DEPDIR)/libvxworks_la-rngLib.Tpo -c -o libvxworks_la-rn=
gLib.lo `test -f 'rngLib.c' || echo '$(srcdir)/'`rngLib.c
+@am__fastdepCC_TRUE@	mv -f $(DEPDIR)/libvxworks_la-rngLib.Tpo $(DEPDIR)/li=
bvxworks_la-rngLib.Plo
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source=3D'rngLib.c' object=3D'libvxworks=
_la-rngLib.lo' libtool=3Dyes @AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=3D$(DEPDIR) $(CCDEPMODE) $(depcom=
p) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) $(LIBTOOLFL=
AGS) --mode=3Dcompile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvx=
works_la_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -c -o libvxworks_la-r=
ngLib.lo `test -f 'rngLib.c' || echo '$(srcdir)/'`rngLib.c
+
 libvxworks_la-semLib.lo: semLib.c
 @am__fastdepCC_TRUE@	$(LIBTOOL) --tag=3DCC $(AM_LIBTOOLFLAGS) $(LIBTOOLFLA=
GS) --mode=3Dcompile $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(libvxw=
orks_la_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS) -MT libvxworks_la-semL=
ib.lo -MD -MP -MF $(DEPDIR)/libvxworks_la-semLib.Tpo -c -o libvxworks_la-se=
mLib.lo `test -f 'semLib.c' || echo '$(srcdir)/'`semLib.c
 @am__fastdepCC_TRUE@	mv -f $(DEPDIR)/libvxworks_la-semLib.Tpo $(DEPDIR)/li=
bvxworks_la-semLib.Plo
diff --git a/vxworks/rngLib.c b/vxworks/rngLib.c
new file mode 100644
index 0000000..19144b4
=2D-- /dev/null
+++ b/vxworks/rngLib.c
@@ -0,0 +1,168 @@
+/*
+* Copyright (C) 2008 Niklaus Giger <niklaus.giger@domain.hid>.
+*
+* This library is free software; you can redistribute it and/or
+* modify it under the terms of the GNU Lesser General Public
+* License as published by the Free Software Foundation; either
+* version 2 of the License, or (at your option) any later version.
+*
+* This library is distributed in the hope that it will be useful,
+* but WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+* Lesser General Public License for more details.
+
+* You should have received a copy of the GNU Lesser General Public
+* License along with this library; if not, write to the Free Software
+* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  US=
A.
+*/
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
+	if (nbytes <=3D 0) {
+		errnoSet(S_memLib_NOT_ENOUGH_MEMORY);
+		return 0;
+	}
+	ring_mem =3D xnmalloc(sizeof(RING_DESCRIPTOR) + nbytes + 1);
+	if (ring_mem =3D=3D NULL) {
+		errno =3D errnoSet(S_memLib_NOT_ENOUGH_MEMORY);
+		return 0;
+	}
+
+	ring =3D (RING_DESCRIPTOR *) ring_mem;
+	ring->magic =3D WIND_RING_MAGIC;
+	ring->bufSize =3D nbytes;
+	ring->readPos =3D 0;
+	ring->writePos =3D 0;
+
+	return (RING_ID) ring_mem;
+}
+
+void rngDelete(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return;
+	ring->magic =3D 0;
+	xnfree(ring);
+}
+
+void rngFlush(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return;
+	ring->readPos =3D 0;
+	ring->writePos =3D 0;
+}
+
+int rngBufGet(RING_ID ring_id, char *buffer, int maxbytes)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+	int j, bytesRead =3D 0;
+	unsigned int savedWritePos =3D ring->writePos;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return -ENOSYS;
+	for (j =3D 0; j < maxbytes; j++) {
+		if ((ring->readPos) % (ring->bufSize + 1) =3D=3D savedWritePos) {
+			break;
+		}
+		buffer[j] =3D ring->buffer[ring->readPos];
+		++bytesRead;
+		ring->readPos =3D (ring->readPos + 1) % (ring->bufSize + 1);
+	}
+
+	return bytesRead;
+}
+
+int rngBufPut(RING_ID ring_id, char *buffer, int nbytes)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+	int j, bytesWritten =3D 0;
+	unsigned int savedReadPos =3D ring->readPos;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return ERROR;
+	for (j =3D 0; j < nbytes; j++) {
+		if ((ring->writePos + 1) % (ring->bufSize + 1) =3D=3D savedReadPos) {
+			break;
+		}
+		ring->buffer[ring->writePos] =3D buffer[j];
+		++bytesWritten;
+		ring->writePos =3D (ring->writePos + 1) % (ring->bufSize + 1);
+	}
+
+	return bytesWritten;
+}
+
+BOOL rngIsEmpty(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return -ENOSYS;
+	return rngFreeBytes(ring_id) =3D=3D (int)ring->bufSize;
+}
+
+BOOL rngIsFull(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return -ENOSYS;
+	return rngFreeBytes(ring_id) =3D=3D 0;
+}
+
+int rngFreeBytes(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return -ENOSYS;
+
+	return ((ring->bufSize -
+		 (ring->writePos - ring->readPos)) % (ring->bufSize + 1));
+}
+
+int rngNBytes(RING_ID ring_id)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return -ENOSYS;
+
+	return ring->bufSize - rngFreeBytes(ring_id);
+}
+
+void rngPutAhead(RING_ID ring_id, char byte, int offset)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+	int where;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return;
+	where =3D (ring->writePos + offset) % (ring->bufSize + 1);
+	ring->buffer[where] =3D byte;
+}
+
+void rngMoveAhead(RING_ID ring_id, int n)
+{
+	RING_DESCRIPTOR *ring =3D (RING_DESCRIPTOR *) ring_id;
+
+	if (ring->magic !=3D WIND_RING_MAGIC)
+		return;
+	/* ring->writePos =3D (ring->writePos + n) % (ring->bufSize + 1); */
+	ring->writePos +=3D n;
+	ring->writePos %=3D (ring->bufSize + 1);
+}
diff --git a/vxworks/rngLib.h b/vxworks/rngLib.h
new file mode 100644
index 0000000..eeb324c
=2D-- /dev/null
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  U=
SA.
+ */
+
+#ifndef _VXWORKS_RNGLIB_H
+#define _VXWORKS_RNGLIB_H
+
+#include <xenomai/syncobj.h>
+#include <xenomai/heapobj.h>
+#include <vxworks/rngLib.h>
+
+typedef struct {
+	unsigned int magic;
+	unsigned int bufSize;
+	unsigned int readPos;
+	unsigned int writePos;
+	unsigned char buffer[];
+} RING_DESCRIPTOR;
+
+#endif /* _VXWORKS_RNGLIB_H */
diff --git a/vxworks/testsuite/Makefile b/vxworks/testsuite/Makefile
index d1ce203..d391406 100644
=2D-- a/vxworks/testsuite/Makefile
+++ b/vxworks/testsuite/Makefile
@@ -5,7 +5,7 @@ ifeq ($(prefix),)
 $(error Please add <xenomai-install-path>/bin to your PATH variable)
 endif
=20
=2DTESTS :=3D task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem=
=2D4 lst-1
+TESTS :=3D task-1 task-2 msgQ-1 msgQ-2 msgQ-3 wd-1 sem-1 sem-2 sem-3 sem-4=
 lst-1 rng-1
=20
 CFLAGS :=3D $(shell $(XENO_CONFIG) --cflags) -g
 LDFLAGS :=3D -lvxworks $(shell $(XENO_CONFIG) --ldflags)
diff --git a/vxworks/testsuite/rng-1.c b/vxworks/testsuite/rng-1.c
new file mode 100644
index 0000000..48a2d72
=2D-- /dev/null
+++ b/vxworks/testsuite/rng-1.c
@@ -0,0 +1,215 @@
+#include <stdlib.h>
+#include <string.h>
+#include <stdio.h>
+#include <xenomai/traceobj.h>
+#include <vxworks/errnoLib.h>
+#include <vxworks/taskLib.h>
+#include <vxworks/rngLib.h>
+
+static struct traceobj trobj;
+
+#define ADD_CONTENT(buffer,bytes,counter)				\
+	{								\
+		char	*bufPtr =3D buffer;				\
+		for (k=3D0; k<bytes; k++) { 				\
+			*bufPtr =3D counter; 				\
+			counter ++; 					\
+			bufPtr ++; 					\
+		}							\
+	}
+
+#define CHECK_CONTENT(buffer,bytes,counter) 				\
+	{								\
+		unsigned char	*bufPtr =3D buffer;			\
+		for (k=3D0; k<bytes; k++) { 				\
+			traceobj_assert(&trobj, *bufPtr =3D=3D (unsigned char)counter);	\
+			counter ++; 					\
+			bufPtr ++;					\
+		}							\
+	}
+
+void rootTask(long a0, long a1, long a2, long a3, long a4,
+	      long a5, long a6, long a7, long a8, long a9)
+{
+	RING_ID ring;
+
+	int j, res, k, chunks;
+	const int putBytes =3D 10;
+	const int nrChunks =3D 3;
+	const int rngBytes =3D putBytes * nrChunks;
+	char buffer[putBytes];
+	char bigBuffer[putBytes * 2 * nrChunks];
+	int bytesPut;
+	int bytesGot;
+	int expectedCounter =3D 0;
+	int checkCounter =3D 0;
+	RING_ID rng;
+	char not_a_ring[32];
+
+	traceobj_enter(&trobj);
+	ADD_CONTENT(buffer, sizeof(buffer), expectedCounter);
+	rng =3D rngCreate(1);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	memset(buffer, 0, sizeof(buffer));
+	buffer[0] =3D 17;
+	rngBufPut(rng, buffer, 1);
+	traceobj_assert(&trobj, rngIsFull(rng));
+	rngBufGet(rng, buffer, 1);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	buffer[0] =3D 34;
+	rngBufPut(rng, buffer, 1);
+	traceobj_assert(&trobj, rngIsFull(rng));
+	expectedCounter =3D 0;
+	rngDelete(rng);
+
+	/* Here real vxWorks 6.6 just return ERROR */
+	memset(not_a_ring, 0, sizeof(not_a_ring));
+	errnoSet(0);
+	res =3D rngBufPut((RING_ID) & not_a_ring[0], buffer, 1);
+	traceobj_assert(&trobj, res =3D=3D ERROR);
+
+/*	rng =3D rngCreate(1 * 1024 * 1024 * 1024);
+	traceobj_assert(&trobj, res =3D=3D ERROR);
+	traceobj_assert(&trobj, errnoGet() =3D=3D S_memLib_NOT_ENOUGH_MEMORY);
+ */
+	rng =3D rngCreate(rngBytes);
+	traceobj_assert(&trobj, rng !=3D 0);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+
+	/* Fill a few chunks */
+	for (chunks =3D 0; chunks < nrChunks; chunks++) {
+		traceobj_assert(&trobj,
+				rngNBytes(rng) =3D=3D chunks * (int)sizeof(buffer));
+		traceobj_assert(&trobj,
+				rngFreeBytes(rng) =3D=3D
+				rngBytes - chunks * (int)sizeof(buffer));
+		for (j =3D 0; j < (int)sizeof(buffer); j++) {
+			buffer[j] =3D (char)j + (int)sizeof(buffer) * chunks;
+		}
+		ADD_CONTENT(buffer, sizeof(buffer), checkCounter);
+		bytesPut =3D rngBufPut(rng, &buffer[0], sizeof(buffer));
+		traceobj_assert(&trobj, bytesPut =3D=3D sizeof(buffer));
+		traceobj_assert(&trobj, !rngIsEmpty(rng));
+		traceobj_assert(&trobj,
+				rngIsFull(rng) =3D=3D (nrChunks - 1 =3D=3D chunks));
+		traceobj_assert(&trobj,
+				rngFreeBytes(rng) =3D=3D
+				rngBytes - bytesPut * (chunks + 1));
+		traceobj_assert(&trobj,
+				rngNBytes(rng) =3D=3D
+				(chunks + 1) * (int)sizeof(buffer));
+	}
+	traceobj_assert(&trobj, rngIsFull(rng));
+	ADD_CONTENT(buffer, sizeof(buffer), checkCounter);
+	bytesPut =3D rngBufPut(rng, &buffer[0], sizeof(buffer));
+	traceobj_assert(&trobj, bytesPut =3D=3D 0);
+	traceobj_assert(&trobj, rngIsFull(rng));
+
+	/* Read chunks back and check content */
+	for (chunks =3D 0; chunks < nrChunks; chunks++) {
+		memset(buffer, 0, sizeof(buffer));
+		traceobj_assert(&trobj,
+				rngNBytes(rng) =3D=3D
+				(nrChunks - chunks) * (int)sizeof(buffer));
+		traceobj_assert(&trobj,
+				rngFreeBytes(rng) =3D=3D
+				chunks * (int)sizeof(buffer));
+		bytesGot =3D rngBufGet(rng, &buffer[0], sizeof(buffer));
+		traceobj_assert(&trobj, bytesGot =3D=3D (int)sizeof(buffer));
+		CHECK_CONTENT(buffer, (unsigned int)bytesGot, expectedCounter);
+		traceobj_assert(&trobj, !rngIsFull(rng));
+		traceobj_assert(&trobj,
+				rngIsEmpty(rng) =3D=3D (chunks =3D=3D nrChunks - 1));
+
+		traceobj_assert(&trobj,
+				rngFreeBytes(rng) =3D=3D
+				(chunks + 1) * (int)sizeof(buffer));
+		traceobj_assert(&trobj,
+				rngNBytes(rng) =3D=3D
+				(nrChunks - chunks - 1) * (int)sizeof(buffer));
+	}
+
+	/* Testing filling too many */
+	ADD_CONTENT(bigBuffer, sizeof(bigBuffer), checkCounter)
+	bytesPut =3D rngBufPut(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesPut =3D=3D rngBytes);
+	traceobj_assert(&trobj, !rngIsEmpty(rng));
+	traceobj_assert(&trobj, rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) =3D=3D 0);
+	traceobj_assert(&trobj, rngNBytes(rng) =3D=3D rngBytes);
+
+	/* Getting too many */
+	memset(bigBuffer, 0, sizeof(bigBuffer));
+	bytesGot =3D rngBufGet(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesGot =3D=3D rngBytes);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) =3D=3D rngBytes);
+	traceobj_assert(&trobj, rngNBytes(rng) =3D=3D 0);
+
+	/* Now we need to adjust our expectedCounter */
+	expectedCounter +=3D sizeof(buffer);
+
+	CHECK_CONTENT(bigBuffer, (unsigned int)bytesGot, expectedCounter);
+
+	ADD_CONTENT(bigBuffer, sizeof(bigBuffer), checkCounter);
+	bytesPut =3D rngBufPut(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesPut =3D=3D rngBytes);
+	rngFlush(rng);
+	traceobj_assert(&trobj, rngIsEmpty(rng));
+	traceobj_assert(&trobj, !rngIsFull(rng));
+	traceobj_assert(&trobj, rngFreeBytes(rng) =3D=3D rngBytes);
+	traceobj_assert(&trobj, rngNBytes(rng) =3D=3D 0);
+	while (bytesGot > 0) {
+		bytesGot =3D rngBufGet(rng, &bigBuffer[0], sizeof(bigBuffer));
+		CHECK_CONTENT(bigBuffer, (unsigned int)bytesGot,
+			      expectedCounter);
+	}
+	rngDelete(rng);
+
+	chunks =3D 10;
+	rng =3D rngCreate(chunks);
+	bytesPut =3D 5;
+	traceobj_assert(&trobj, rngFreeBytes(rng) > bytesPut);
+	checkCounter =3D 0xaa;
+	expectedCounter =3D checkCounter;
+	for (j =3D 0; j < bytesPut; j++) {
+		rngPutAhead(rng, checkCounter, j);
+		checkCounter++;
+	}
+	rngMoveAhead(rng, bytesPut);
+	bytesGot =3D rngBufGet(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesGot =3D=3D bytesPut);
+	CHECK_CONTENT(bigBuffer, (unsigned int)bytesGot, expectedCounter);
+
+	/* Check also wrap-around */
+	bytesPut =3D chunks -2;
+	traceobj_assert(&trobj, rngFreeBytes(rng) > bytesPut);
+	checkCounter =3D 0xaa;
+	expectedCounter =3D checkCounter;
+	for (j =3D 0; j < bytesPut; j++) {
+		rngPutAhead(rng, checkCounter, j);
+		checkCounter++;
+	}
+	rngMoveAhead(rng, bytesPut);
+	bytesGot =3D rngBufGet(rng, &bigBuffer[0], sizeof(bigBuffer));
+	traceobj_assert(&trobj, bytesGot =3D=3D bytesPut);
+	CHECK_CONTENT(bigBuffer, (unsigned int)bytesGot, expectedCounter);
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
+	ret =3D kernelInit(rootTask, argc, argv);
+	traceobj_assert(&trobj, ret =3D=3D OK);
+
+	traceobj_join(&trobj);
+	exit(0);
+}
=2D-=20
1.6.0.2


--Boundary-00=_LnzBJHh5BjA23iP--

