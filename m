Message-ID: <483BFF5C.20600@domain.hid>
Date: Tue, 27 May 2008 14:32:28 +0200
From: Sebastian Smolorz <smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050603070903090102020200"
Subject: [Xenomai-core] [PATCH] rt_pipe_receive documentation
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

This is a multi-part message in MIME format.
--------------050603070903090102020200
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

rt_pipe_receive() doesn't return -EIDRM any more. The patches for trunk 
and v2.4.x correct the API documentation in this regard.

-- 
Sebastian

--------------050603070903090102020200
Content-Type: text/plain;
 name="rt_pipe.patch-trunk"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_pipe.patch-trunk"

Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 3887)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,9 @@
+2008-05-27  Sebastian Smolorz  <sesmo@domain.hid>
+
+	* ksrc/skins/native/pipe.c (rt_pipe_receive): Fix documentation
+	for the return values of the function. -EIDRM is no valid return
+	value any more.
+
 2008-05-25  Wolfgang Grandegger  <wg@domain.hid>
 
 	* ksrc/drivers/can/mscan/rtcan_mscan.c (rtcan_mscan_exit): Fix
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(Revision 3887)
+++ ksrc/skins/native/pipe.c	(Arbeitskopie)
@@ -441,8 +441,6 @@
  *
  * - -EINVAL is returned if @a pipe is not a pipe descriptor.
  *
- * - -EIDRM is returned if @a pipe was closed while reading.
- *
  * - -ENODEV or -EBADF are returned if @a pipe is scrambled.
  *
  * - -ETIMEDOUT is returned if @a timeout is different from

--------------050603070903090102020200
Content-Type: text/plain;
 name="rt_pipe.patch-v2.4.x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt_pipe.patch-v2.4.x"

Index: ChangeLog
===================================================================
--- ChangeLog	(Revision 3887)
+++ ChangeLog	(Arbeitskopie)
@@ -1,3 +1,9 @@
+2008-05-27  Sebastian Smolorz  <sesmo@domain.hid>
+
+	* ksrc/skins/native/pipe.c (rt_pipe_receive): Fix documentation
+	for the return values of the function. -EIDRM is no valid return
+	value any more.
+
 2008-05-25  Roland Stigge  <stigge@domain.hid>
 
 	* doc/man/*: Add new manual pages.
Index: ksrc/skins/native/pipe.c
===================================================================
--- ksrc/skins/native/pipe.c	(Revision 3887)
+++ ksrc/skins/native/pipe.c	(Arbeitskopie)
@@ -441,8 +441,6 @@
  *
  * - -EINVAL is returned if @a pipe is not a pipe descriptor.
  *
- * - -EIDRM is returned if @a pipe was closed while reading.
- *
  * - -ENODEV or -EBADF are returned if @a pipe is scrambled.
  *
  * - -ETIMEDOUT is returned if @a timeout is different from

--------------050603070903090102020200--

