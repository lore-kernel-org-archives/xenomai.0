From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4pJrremZTV"
Content-Transfer-Encoding: 7bit
Message-ID: <17376.43570.396834.405041@domain.hid>
Date: Wed, 1 Feb 2006 13:31:46 +0100
Subject: Re: [Xenomai-core] [PATCH] fix pthread cancellation in native skin
In-Reply-To: <17373.63969.941760.677529@domain.hid>
References: <43DB3AB1.5090004@domain.hid>
	<17373.63969.941760.677529@domain.hid>
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


--4pJrremZTV
Content-Type: text/plain; charset=us-ascii
Content-Description: message body text
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
 > This is not the only situation where a thread with a nucleus suspens=
ion
 > bit need to run shortly in secondary mode: it also occurs when
 > suspending with xnpod=5Fsuspend=5Fthread() a thread running in secon=
dary
 > mode; the thread receives the SIGCHLD signal and need to execute sho=
rtly
 > with the suspension bit set in order to cause a migration to primary=

 > mode.
 >=20
 > So, the only case when we are sure that a user-space thread can not =
be
 > scheduled by Linux seems to be when this thread does not have the
 > XNRELAX bit.

=46rom all the bits in XNTHREAD=5FBLOCK=5FBITS, only when the XNPEND bit =
is
set, a thread can not be running in secondary mode. Hence the proposed
patch.

--=20


=09=09=09=09=09    Gilles Chanteperdrix.

--4pJrremZTV
Content-Type: text/plain
Content-Disposition: inline;
	filename="fatal.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/shadow.c
===================================================================
--- ksrc/nucleus/shadow.c	(revision 507)
+++ ksrc/nucleus/shadow.c	(working copy)
@@ -1543,14 +1543,25 @@
 
 #ifdef CONFIG_XENO_OPT_DEBUG
 	{
-	xnflags_t status = threadin->status & ~XNRELAX;
+	xnflags_t status = threadin->status;
 	int sigpending = signal_pending(next);
 
-        if (!(next->ptrace & PT_PTRACED) &&
+        if (!testbits(status, XNRELAX))
+            {
+            show_stack(xnthread_user_task(threadin),NULL);
+            xnpod_fatal("Hardened thread %s[%d] running in Linux domain?! (status=0x%lx, sig=%d, prev=%s[%d])",
+			threadin->name,
+			next->pid,
+			status,
+			sigpending,
+			prev->comm,
+			prev->pid);
+	    }
+        else if (!(next->ptrace & PT_PTRACED) &&
 	    /* Allow ptraced threads to run shortly in order to
 	       properly recover from a stopped state. */
 	    testbits(status,XNSTARTED) &&
-	    testbits(status,XNTHREAD_BLOCK_BITS))
+	    testbits(status,XNPEND))
 	    {
 	    show_stack(xnthread_user_task(threadin),NULL);
             xnpod_fatal("blocked thread %s[%d] rescheduled?! (status=0x%lx, sig=%d, prev=%s[%d])",

--4pJrremZTV--

