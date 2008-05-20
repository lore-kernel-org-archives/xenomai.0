MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="q2ZDQV9FBE"
Content-Transfer-Encoding: 7bit
Message-ID: <18483.10159.822828.204726@domain.hid>
Date: Tue, 20 May 2008 21:34:07 +0200
In-Reply-To: <5481.62.39.72.60.1211293804.squirrel@domain.hid>
References: <16474.81.252.86.91.1211199249.squirrel@domain.hid>
	<2ff1a98a0805190532i2fdb4267qc4566d98ab8cd57@domain.hid>
	<2ff1a98a0805190557j743680d4sb7d9f5c8e97072e@domain.hid>
	<12036.62.39.72.60.1211212126.squirrel@domain.hid>
	<2ff1a98a0805190857s1ad98139h9abe63b743dda35@domain.hid>
	<5481.62.39.72.60.1211293804.squirrel@domain.hid>
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


--q2ZDQV9FBE
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Fabien MAHOT wrote:
 > Thank you,
 > 
 > I tried to use rt_fprintf(stderr) or rt_printf(), but there is no debug
 > traces on my Screen. But when I used fprintf(stderr) or printf(), there is
 > no problem, I ve got traces on my screen.
 > Compilation is good, I don't know why it doesn't work.
 > 
 > I also checked the info->si_value.sival_ptr value and it is good.
 > 
 > My StackWrite and StackRead functions don't need a mutex. There is no
 > conflict between them.
 > 
 > Otherwise, I decided to cancel the lock use in EndTimeOut and I use a
 > semaphore to indicate the time-out end to TimeOut thread. But there is a
 > bug.
 > This test program explains it :
 > When TimeOut thread starts a time-out and waits the associated semaphore
 > (sem_wait()). When signal of time-out end arrives, TimeOut thread wakes up
 > whereas there is no sem_post(), and sem_wait returns no error.

The attached patch should fix the issue with sem_wait (or the
interruption of any system call by a posix skin signal). However, I am
unable to reproduce the crash.

-- 


					    Gilles.

--q2ZDQV9FBE
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-posix-set-xnbreak-upon-posix-signal.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/skins/posix/signal.c
===================================================================
--- ksrc/skins/posix/signal.c	(revision 3805)
+++ ksrc/skins/posix/signal.c	(working copy)
@@ -1048,7 +1048,13 @@ static void pse51_dispatch_shadow_signal
 {
 	/* Migrate to secondary mode in order to get the signals delivered by
 	   Linux. */
+	xnthread_t *cur = xnpod_current_thread();
+	int interrupted;
+
+	interrupted = xnthread_test_info(cur, XNBREAK);
 	xnshadow_relax(1);
+	if (interrupted)
+		xnthread_set_info(cur, XNBREAK | XNKICKED);
 }
 
 void pse51_signal_handle_request(pthread_t thread)

--q2ZDQV9FBE--

