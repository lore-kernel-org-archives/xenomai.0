Message-ID: <47373710.1030400@domain.hid>
Date: Sun, 11 Nov 2007 18:08:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D3285C8@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D3285C9@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3285C9@domain.hid>
Content-Type: multipart/mixed; boundary="------------060806030805090902070800"
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] more geode issues
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060806030805090902070800
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Steven Seeger wrote:
> Just to let everyone know, select() still locks up on me with 2.6.22.2
> and revision 3169.
>=20
> =20
>=20
> All I=92m doing is opening up a pipe in linux and select() on it for
> reading, and then opening up that pipe on the realtime side. Then, I hit
> control-C. I load the program again and it locks up when I hit control-C
> again. This won=92t happen the 2^nd time if I unload and reload the nucle=
us.
>=20

The way we were handling the poll handler was broken. Fixed in both
v2.3.x and trunk branches. The attached patch is on top of commit #3166.

--=20
Philippe.

--------------060806030805090902070800
Content-Type: text/x-patch;
 name="fix-pipe-select.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-pipe-select.patch"

Index: include/nucleus/pipe.h
===================================================================
--- include/nucleus/pipe.h	(revision 3166)
+++ include/nucleus/pipe.h	(working copy)
@@ -101,7 +101,6 @@
     struct fasync_struct *asyncq;
     wait_queue_head_t readq;		/* open/read/poll waiters */
     wait_queue_head_t syncq;		/* sync waiters */
-    unsigned int nwait;
     size_t ionrd;
 
 } xnpipe_state_t;
Index: ksrc/nucleus/pipe.c
===================================================================
--- ksrc/nucleus/pipe.c	(revision 3166)
+++ ksrc/nucleus/pipe.c	(working copy)
@@ -97,8 +97,6 @@
 		__setbits(state->status, mask);
 	}
 
-	state->nwait++;
-
 	xnlock_put_irqrestore(&nklock, s);
 }
 
@@ -135,7 +133,7 @@
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (--state->nwait == 0) {
+	if (testbits(state->status, mask)) {
 		__clrbits(state->status, mask);
 		removeq(&xnpipe_sleepq, &state->slink);
 	}
@@ -635,7 +633,6 @@
 	file->private_data = state;
 	init_waitqueue_head(&state->readq);
 	init_waitqueue_head(&state->syncq);
-	state->nwait = 0;
 
 	__clrbits(state->status,
 		  XNPIPE_USER_ALL_WAIT | XNPIPE_USER_ALL_READY | XNPIPE_USER_SIGIO);
@@ -699,12 +696,9 @@
 
 	xnlock_get_irqsave(&nklock, s);
 
-	if (testbits(state->status, XNPIPE_USER_WREAD))
-		xnpipe_dequeue_wait(state, XNPIPE_USER_WREAD);
+	if (testbits(state->status, XNPIPE_USER_WREAD|XNPIPE_USER_WSYNC))
+		xnpipe_dequeue_wait(state, XNPIPE_USER_WREAD|XNPIPE_USER_WSYNC);
 
-	if (testbits(state->status, XNPIPE_USER_WSYNC))
-		xnpipe_dequeue_wait(state, XNPIPE_USER_WSYNC);
-
 	if (testbits(state->status, XNPIPE_KERN_CONN)) {
 		int minor = xnminor_from_state(state);
 

--------------060806030805090902070800--

