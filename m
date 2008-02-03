MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WhJoRt1hbF"
Content-Transfer-Encoding: 7bit
Message-ID: <18342.2341.145336.903743@domain.hid>
Date: Sun, 3 Feb 2008 19:34:13 +0100
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D3768AD@slcmail.slc.mew.int>
References: <51CAD0CE1504444DBE77CBBE51A0135D3768AD@slcmail.slc.mew.int>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] periodic task question
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


--WhJoRt1hbF
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Steven Seeger wrote:
 > If I want a periodic task to wait on a condition variable whose purpose
 > is to wait until the task is needed again, should I set it non-periodic
 > first and then set it periodic again after it wakes up?
 > 
 >  
 > 
 > If I am running in periodic timebase mode, I notice weird behavior
 > without this behavior. It seems ok in aperiodic mode, however.

Could you reduce your code to a minimal example showing this behaviour?

 > Also, if I set the native skin to periodic mode, the latency default
 > setting of 4200 doesn't change tick types, therefore it causes all my
 > calls to rt_task_set_periodic() fail with jiffies less than this.

Try the attached patch. It looks like a condition got negated when
replacing the test by a predicate.

-- 


					    Gilles Chanteperdrix.

--WhJoRt1hbF
Content-Type: text/plain
Content-Disposition: inline;
	filename="xeno-set_thread_periodic-lart-negate-condition.diff"
Content-Transfer-Encoding: 7bit

Index: ksrc/nucleus/pod.c
===================================================================
--- ksrc/nucleus/pod.c	(revision 3460)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -3305,7 +3305,8 @@ int xnpod_set_thread_periodic(xnthread_t
 			xntimer_stop(&thread->ptimer);
 
 		goto unlock_and_exit;
-	} else if (xntbase_periodic_p(xnthread_time_base(thread)) && period < nklatency) {
+	} else if (!xntbase_periodic_p(xnthread_time_base(thread))
+		   && period < nklatency) {
 		/* LART: detect periods which are shorter than the
 		 * intrinsic latency figure; this must be a joke... */
 		err = -EINVAL;

--WhJoRt1hbF--

