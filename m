Subject: Re: Problem with cyclictest
References: <CGME20191030012837epcas1p46e9ef2156d4d609aa4b913d13374a4f6@epcas1p4.samsung.com>
 <a7ca11a1-2210-8098-fb7d-07a55f4b0fcf@samsung.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <76ef8a64-ef1f-2f58-3873-2e35b5442e23@xenomai.org>
Date: Wed, 30 Oct 2019 10:10:02 +0100
MIME-Version: 1.0
In-Reply-To: <a7ca11a1-2210-8098-fb7d-07a55f4b0fcf@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Joonyoung Shim <jy0922.shim@samsung.com>, xenomai@xenomai.org

On 10/30/19 2:32 AM, Joonyoung Shim via Xenomai wrote:
> Hi all,
> 
> I have a problem from cyclictest. The cyclictest is killed with below messages
> and i cannot see result of cyclictest when it is terminated, after the commit
> 5750102b4725 ("demo/cyclictest: turn on FIFO mode by default, detecting
> spurious relaxes") is applied.
> 
> invoked syscall, aborting.
> (enabling CONFIG_XENO_OPT_DEBUG_TRACE_RELAX may help)
> CPU time limit exceeded (core dumped)
> 
> When the cyclictest is terminated by ctrl-c or -D option, below codes in
> timerthread() are executed,
> 
>         /* switch to normal */
>         schedp.sched_priority = 0;
>         sched_setscheduler(0, SCHED_OTHER, &schedp);
> 
> and next, cyclictest is killed by sigdebug().
> 
> Because the sched_setscheduler() is linux system call, the signal reason is
> printed "invoked syscall" in sigdebug(). I think this is normal case, so i
> wonder why this is spurious relaxes and cyclictest should be killed abnormally.
> 

No valid reason for this, WARNSW should be disabled in a cleanup section.

>From 5a640014bce0aecd55079b1e7cf8d2e1fc07ccd7 Mon Sep 17 00:00:00 2001
From: Philippe Gerum <rpm@xenomai.org>
Date: Wed, 30 Oct 2019 10:03:26 +0100
Subject: [PATCH] demo/posix: cyclictest: prevent spurious WARNSW events on
 exit

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 demo/posix/cyclictest/cyclictest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/demo/posix/cyclictest/cyclictest.c b/demo/posix/cyclictest/cyclictest.c
index 76983bd02..cddc8dda8 100644
--- a/demo/posix/cyclictest/cyclictest.c
+++ b/demo/posix/cyclictest/cyclictest.c
@@ -989,6 +989,10 @@ void *timerthread(void *param)
 	}
 
 out:
+#ifdef CONFIG_XENO_COBALT
+	if (pthread_setmode_np(PTHREAD_WARNSW, 0, NULL))
+		fatal("pthread_setmode_np()");
+#endif
 	if (par->mode == MODE_CYCLIC)
 		timer_delete(timer);
 
-- 
2.21.0

-- 
Philippe.

