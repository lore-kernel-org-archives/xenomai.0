Message-ID: <441E65DB.6080106@domain.hid>
Date: Mon, 20 Mar 2006 09:20:43 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] yet another test tool
References: <441DD89A.4000501@domain.hid>
In-Reply-To: <441DD89A.4000501@domain.hid>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Hi,
> 
> as I already mentioned, I experimented with the cyclictest-0.5 by Thomas
> Gleixner (http://www.tglx.de/projects/misc/cyclictest), one of the
> PREEMPT_RT developers. The attached patch fixes the scheduling policy
> setup and locks the whole test into memory.
> 
> This tool is quite handy for running more than one timed thread, and for
> basic testing of the POSIX skin. As Xenomai does not support hard-RT
> signal delivery yet, the only relevant mode is -n, i.e. delaying via
> clock_nanosleep. From the bugs I fixed I would say that not every
> feature may work yet, but running with -n, -p 99 (highest priority
> used), and -t 10 (create e.g. 10 cascading threads) looks fine to me.
> 
> What do you think, is it worth including as a POSIX counterpart for
> testsuite/latency?

Yes indeed, e.g. testsuite/cyclic.

> 
> Jan
> 
> 
> ------------------------------------------------------------------------
> 
> --- cyclictest.c.orig	2005-11-24 13:33:21.000000000 +0100
> +++ cyclictest.c	2006-03-17 10:50:26.000000000 +0100
> @@ -24,12 +24,14 @@
>  #include <string.h>
>  #include <time.h>
>  #include <unistd.h>
> +#include <limits.h>
>  
>  #include <linux/unistd.h>
>  
>  #include <sys/stat.h>
>  #include <sys/types.h>
>  #include <sys/time.h>
> +#include <sys/mman.h>
>  
>  /* Ugly, but .... */
>  #define gettid() syscall(__NR_gettid)
> @@ -158,7 +160,7 @@ void *timerthread(void *param)
>  
>  	memset(&schedp, 0, sizeof(schedp));
>  	schedp.sched_priority = par->prio;
> -	sched_setscheduler(0, policy, &schedp);
> +	pthread_setschedparam(pthread_self(), policy, &schedp);
>  
>  	/* Get current time */
>  	clock_gettime(par->clock, &now);
> @@ -265,7 +267,7 @@ out:		
>  
>  	/* switch to normal */
>  	schedp.sched_priority = 0;
> -	sched_setscheduler(0, SCHED_OTHER, &schedp);	
> +	pthread_setschedparam(pthread_self(), SCHED_OTHER, &schedp);
>  
>  	stat->threadstarted = -1;
>  
> @@ -396,6 +398,7 @@ int main(int argc, char **argv)
>  	int mode;
>  	struct thread_param *par;
>  	struct thread_stat *stat;
> +	pthread_attr_t thattr;
>  	int i, ret = -1;
>  
>  	if (geteuid()) {
> @@ -403,6 +406,8 @@ int main(int argc, char **argv)
>  		exit(-1);
>  	}
>  
> +	mlockall(MCL_CURRENT | MCL_FUTURE);
> +
>  	process_options(argc, argv);
>  
>  	mode = use_nanosleep + use_system;
> @@ -442,7 +447,9 @@ int main(int argc, char **argv)
>  		par[i].stats = &stat[i];
>  		stat[i].min = 1000000;
>  		stat[i].max = -1000000;
> -		pthread_create(&stat[i].thread, NULL, timerthread, &par[i]);
> +		pthread_attr_init(&thattr);
> +		pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
> +		pthread_create(&stat[i].thread, &thattr, timerthread, &par[i]);
>  		stat[i].threadstarted = 1;
>  	}
>  	
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 

Philippe.

