References: <1523454871.2312.15.camel@smigroup.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e0a935b3-8f75-484f-5324-9c5694476bfc@xenomai.org>
Date: Wed, 11 Apr 2018 16:20:18 +0200
MIME-Version: 1.0
In-Reply-To: <1523454871.2312.15.camel@smigroup.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rt_task_wait_period() does not return -EWOULDBLOCK
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mauro Salvini <mauro.salvini@smigroup.net>, xenomai <xenomai@xenomai.org>

On 04/11/2018 03:54 PM, Mauro Salvini wrote:
> Hi,
> 
> I'm facing an unexpected behavior of rt_task_wait_period().
> 
> xenomai: 3.0.3
> ipipe: 4.1.18-arm-9 on kernel 4.1.36 from NXP
> arch: ARM
> SOC: iMX6sx
> 
> Running simple attached program (compiled and linked using "xeno-config 
> --alchemy --cflags" and "xeno-config --alchemy --ldflags"),
> rt_task_wait_period() never returns (instead return -EWOULDBLOCK) if
> rt_task_set_period() not called.
> 
> Output with SET_PERIOD defined:
> Main 0
> WAIT PERIOD DONE!
> WAIT PERIOD DONE!
> Main 2
> WAIT PERIOD DONE!
> WAIT PERIOD DONE!
> Main 4
> WAIT PERIOD DONE!
> WAIT PERIOD DONE!
> Main 6
> ...
> 
> Output with SET_PERIOD not defined:
> Main 0
> Main 0
> Main 0
> Main 0
> Main 0
> ...
> 
> Tested also with xenomai 3.0.6 from git on latest commit (on same ipipe
> and kernel).
> 
> Am I wrong somewhere?

Please try this and let me know if the situation gets any better:

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index cde15485a..d9e9267c9 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1625,25 +1625,28 @@ int threadobj_set_periodic(struct threadobj *thobj,
 {				/* thobj->lock held */
 	struct itimerspec its;
 	struct sigevent sev;
+	timer_t timer;
 	int ret;
 
 	__threadobj_check_locked(thobj);
 
-	if (thobj->periodic_timer == NULL) {
+	timer = thobj->periodic_timer;
+	if (timer == NULL) {
 		memset(&sev, 0, sizeof(sev));
 		sev.sigev_signo = SIGPERIOD;
 		sev.sigev_notify = SIGEV_SIGNAL|SIGEV_THREAD_ID;
 		sev.sigev_notify_thread_id = threadobj_get_pid(thobj);
-		ret = __RT(timer_create(CLOCK_COPPERPLATE, &sev,
-					&thobj->periodic_timer));
+		ret = __RT(timer_create(CLOCK_COPPERPLATE, &sev, &timer));
 		if (ret)
 			return __bt(-errno);
-	}
+		thobj->periodic_timer = timer;
+	} else if (!timespec_scalar(idate) && !timespec_scalar(period))
+		thobj->periodic_timer = NULL;
 
 	its.it_value = *idate;
 	its.it_interval = *period;
 
-	ret = __RT(timer_settime(thobj->periodic_timer, TIMER_ABSTIME, &its, NULL));
+	ret = __RT(timer_settime(timer, TIMER_ABSTIME, &its, NULL));
 	if (ret)
 		return __bt(-errno);
 
@@ -1656,6 +1659,9 @@ int threadobj_wait_period(unsigned long *overruns_r)
 	siginfo_t si;
 	int sig;
 
+	if (current->periodic_timer == NULL)
+		return -EWOULDBLOCK;
+
 	for (;;) {
 		current->run_state = __THREAD_S_DELAYED;
 		sig = __RT(sigwaitinfo(&sigperiod_set, &si));

-- 
Philippe.

