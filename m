MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="QPZAJVoumL"
Content-Transfer-Encoding: 7bit
Message-ID: <18491.29266.196753.611570@domain.hid>
Date: Tue, 27 May 2008 04:30:42 +0200
In-Reply-To: <5871.81.252.86.91.1211789666.squirrel@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
	<18483.10408.141546.420660@domain.hid>
	<2336.81.252.86.91.1211379896.squirrel@domain.hid>
	<2ff1a98a0805210733u39894a17tca5420ae8f7ce5ca@domain.hid>
	<15059.81.252.86.91.1211386718.squirrel@domain.hid>
	<18484.28025.505865.374746@domain.hid>
	<12142.81.252.86.91.1211467896.squirrel@domain.hid>
	<2ff1a98a0805220819i8d73166w4c9a06d9734d0e0c@domain.hid>
	<2405.81.252.86.91.1211549465.squirrel@domain.hid>
	<2ff1a98a0805230655j35009227h75c63566373ece43@domain.hid>
	<5871.81.252.86.91.1211789666.squirrel@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] Problem with time-out ends
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Fabien MAHOT <fabien.mahot@domain.hid>
Cc: xenomai@xenomai.org


--QPZAJVoumL
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Fabien MAHOT wrote:
 > Ok , I corrected all your remarks. Do you have results with my test
 > program?  do you have a system crash with the same error message ?

Here comes a second attempt of fixing the posix shadow signals issue.

-- 


					    Gilles.

--QPZAJVoumL
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-fix-shadow-signal.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/posix/signal.c
===================================================================
--- ksrc/skins/posix/signal.c	(revision 3883)
+++ ksrc/skins/posix/signal.c	(working copy)
@@ -301,7 +301,7 @@ int sigismember(const sigset_t * set, in
 	return ismember(pse51_set, sig);
 }
 
-/* Must be called with nklock lock, irqs off, may reschedule. */
+/* Must be called with nklock lock, irqs off. */
 int pse51_sigqueue_inner(pthread_t thread, pse51_siginfo_t * si)
 {
 	unsigned prio;
@@ -327,8 +327,19 @@ int pse51_sigqueue_inner(pthread_t threa
 	}
 
 #ifdef CONFIG_XENO_OPT_PERVASIVE
-	if (testbits(thread->threadbase.state, XNSHADOW))
+	if (xnthread_test_state(&thread->threadbase, XNSHADOW)) {
 		pse51_schedule_lostage(PSE51_LO_SIGNAL_REQ, thread, 0);
+		if (xnthread_test_state(&thread->threadbase,
+					XNDELAY|XNPEND|XNSUSP|XNRELAX)) {
+			/* Thread is suspended in a syscall, or already relaxed,
+			   we do not need to run the signal dispatcher, the
+			   signal APC will cause the sigwake_event to be
+			   generated, which will kick the thread. */
+			thread->threadbase.signals = 0;
+			return 0;
+		} else
+			return thread == pse51_current_thread();
+	}
 #endif /* CONFIG_XENO_OPT_PERVASIVE */
 
 	return thread == pse51_current_thread()

--QPZAJVoumL--

