MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="y/THTjQb6h"
Content-Transfer-Encoding: 7bit
Message-ID: <17480.58521.376174.197532@domain.hid>
Date: Fri, 21 Apr 2006 15:56:41 +0200
Subject: RE: [Xenomai-help] my tick takes a break !! 
In-Reply-To: <5B122FD931231D408AC32630D1B1F7290AC5B129@domain.hid>
References: <5B122FD931231D408AC32630D1B1F7290AC5B129@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Thomas, Brieuc (GE Healthcare)" <Brieuc.Thomas@domain.hid>
Cc: xenomai@xenomai.org


--y/THTjQb6h
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Thomas, Brieuc \(GE Healthcare\) wrote:
 > Oh no! Sorry, I mean the real-time tick counter!

Could you try the attached patch ?

-- 


					    Gilles Chanteperdrix.

--y/THTjQb6h
Content-Type: text/plain
Content-Disposition: inline;
	filename="uvm-prio.diff"
Content-Transfer-Encoding: 7bit

--- include/asm-uvm/system.h~	2006-04-05 15:08:08.000000000 +0200
+++ include/asm-uvm/system.h	2006-04-21 15:54:24.000000000 +0200
@@ -594,7 +594,7 @@ static void *xnarch_thread_trampoline (v
 	{
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);
 	param.sched_priority = sched_get_priority_min(SCHED_FIFO) + 1;
-	sched_setscheduler(0,SCHED_FIFO,&param);
+        pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 	uvm_thread_create(tcb->name,tcb,&tcb->completion,&tcb->khandle);
 	err = uvm_thread_barrier();	/* Wait for start. */
 	if (err)

--y/THTjQb6h--

