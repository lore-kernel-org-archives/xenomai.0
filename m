Subject: Re: [Xenomai-help] Timer problemm with 2.2.4 release
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45409310.5070504@domain.hid>
References: <200610261227.29595.s.zimmermann@domain.hid>
	<45409310.5070504@domain.hid>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 20:12:09 +0200
Message-Id: <1161972729.4983.21.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

On Thu, 2006-10-26 at 12:50 +0200, Jan Kiszka wrote:
> Stephan Zimmermann wrote:
> > Hello list,
> > I recently switched from 2.2.0 on Kernel 2.6.17.6 to more actual 2.2.4  on 
> > Kernel 2.6.17.14.
> > After upgrading my periodic tasks won't work at all (task_wait and 
> > set_periodic functions return errors). I wrote a little testprogram to verify 
> > it's not a problem with my Software. The code runs fine on my Notebook, still 
> > under 2.2.0/2.6.17.6, but won't work on my Desktop (AMD X2 / VIA K8T800) with 
> > the all-new Kernel/Xenomai installation. Maybe there is some config-thing i 
> > have overseen?
> > 
> > #include <iostream>
> > #include <sys/mman.h>
> > 
> > #include "native/task.h"
> > #include "native/timer.h"
> > 
> > RT_TASK maintask;
> > 
> > int main(void){
> > 	std::cout << "xenomai 2.2.4 timer-test" << std::endl;
> > 	mlockall(MCL_CURRENT | MCL_FUTURE);
> > 	
> > 	int err;
> > 	unsigned long overrun = 0; 
> > 	
> > 	err = rt_task_shadow (&maintask,"maintask",10,0);
> > 	std::cout << "task shadow:" << err << std::endl;
> > 	
> > 	err = rt_timer_set_mode(1000000);
> > 	std::cout << "timer set mode:" << err << std::endl;
> > 	
> > 	err = rt_task_sleep(1000);
> > 	std::cout << "task sleep:" << err << std::endl;
> > 	
> > 	err = rt_task_set_periodic(NULL,TM_NOW,1000);  
> > 	std::cout << "task set periodic:" << err << std::endl;
> > 	
> > 	for(int i  = 0; i < 3; i++){
> > 		err = rt_task_wait_period(&overrun);
> > 		std::cout << "task wait period:" << err << " overrunns:" << overrun << 
> > std::endl;
> > 	}
> > 	
> > 	return 0;
> > }
> > 
> > Output on my Workstation:
> > ----------------------------------------------
> > xenomai 2.2.4 timer-test
> > task shadow:0
> > timer set mode:0
> > task sleep:0
> > task set periodic:-22
> > task wait period:-11 overrunns:0
> > task wait period:-11 overrunns:0
> > task wait period:-11 overrunns:0
> > 
> > Output on my Notebook:
> > ----------------------------------------------
> > xenomai 2.2.4 timer-test
> 
> I guess this is a typo (2.2.0?).
> 
> > task shadow:0
> > timer set mode:0
> > task sleep:0
> > task set periodic:0
> > task wait period:0 overrunns:0
> > task wait period:0 overrunns:0
> > task wait period:0 overrunns:0
> > 
> 
> Looks like we have a bug here:
> 
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/nucleus/pod.c#L3408
> 
> That new LART check doesn't consider the periodic mode where period does
> not have the same unit as nkschedlat. Something like this might be
> needed (quick hack alarm!):
> 
> --- ksrc/nucleus/pod.c  (revision 1747)
> +++ ksrc/nucleus/pod.c  (working copy)
> @@ -3413,7 +3413,7 @@ int xnpod_set_thread_periodic(xnthread_t
>                         xntimer_stop(&thread->ptimer);
> 
>                 goto unlock_and_exit;
> -       } else if (period < nkschedlat) {
> +       } else if (nkpod->tickvalue == 1 && period < nkschedlat) {
>                 /* LART: detect periods which are shorter than the
>                  * intrinsic latency figure; this must be a joke... */
>                 err = -EINVAL;

Good catch. Here is the similar fix I'm going to apply.

--- ksrc/nucleus/pod.c	(revision 1759)
+++ ksrc/nucleus/pod.c	(working copy)
@@ -3415,7 +3415,7 @@
 			xntimer_stop(&thread->ptimer);
 
 		goto unlock_and_exit;
-	} else if (period < nkschedlat) {
+	} else if (!testbits(nkpod->status, XNTMPER) && period < nkschedlat) {
 		/* LART: detect periods which are shorter than the
 		 * intrinsic latency figure; this must be a joke... */
 		err = -EINVAL;
-- 
Philippe.



