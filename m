Message-ID: <4F646AA9.1010809@domain.hid>
Date: Sat, 17 Mar 2012 11:42:49 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
In-Reply-To: <CAMJ=MEcVJCdP4wukwhqL83Ejorprnz32PB3vbpOK584GT1mkvg@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] xenomai-forge: round-robin scheduling in pSOS
 skin
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: Xenomai-core@domain.hid

On 03/08/2012 03:30 PM, Ronny Meeus wrote:
> Hello
>
> I'm are using the xenomai-forge pSOS skin (Mercury).
> My application is running on a P4040 (Freescale PPC with 4 cores).
> Some code snippets are put in this mail but the complete testcode is
> also attached.
>
> I have a test task that just consumes the CPU:
>
> int run_test = 1;
> static void perform_work(u_long counter,u_long b,u_long c,u_long d)
> {
>    int i;
>    while (run_test) {
>      for (i=0;i<100000;i++);
>      (*(unsigned long*)counter)++;
>    }
>    while (1) tm_wkafter(1000);
> }
>
> If I create 2 instances of this task with the T_SLICE option set:
>
>      t_create("WORK",10,0,0,0,&tid);
>      t_start(tid,T_TSLICE, perform_work, args);
>
>
> I see that only 1 task is consuming CPU.
>
> # taskset 1 ./roundrobin.exe&
> #    0"000.543| [main] SCHED_RT priorities =>  [1 .. 99]
>     0"000.656| [main] SCHED_RT.99 reserved for IRQ emulation
>     0"000.692| [main] SCHED_RT.98 reserved for scheduler-lock emulation
> 0 ->  6602
> 1 ->  0
>
> If I adapt the code so that I call in my init the threadobj_start_rr
> function, I see that the load is equally distributed over the 2
> threads:
>
> # taskset 1 ./roundrobin.exe&
> #    0"000.557| [main] SCHED_RT priorities =>  [1 .. 99]
>     0"000.672| [main] SCHED_RT.99 reserved for IRQ emulation
>     0"000.708| [main] SCHED_RT.98 reserved for scheduler-lock emulation
> 0 ->  3290
> 1 ->  3291
>
> Here are the questions:
> - why is the threadobj_start_rr function not called from the context
> of the init of the psos layer.

Because threadobj_start_rr() was originally designed to activate 
round-robin for all threads (some RTOS like VxWorks expose that kind of 
API), not on a per-thread basis. This is not what pSOS wants.

The round-robin API is in state of flux for mercury, only the cobalt one 
is stable. This is why RR is not yet activated despite T_SLICE is 
recognized.

> - why is the roundrobin implemented in this way? If the tasks would be
> mapped on the SCHED_RR instead of the SCHED_FF the Linux scheduler
> would take care of this.

Nope. We need per-thread RR intervals, to manage multiple priority 
groups concurrently, and we also want to define that interval as we see 
fit for proper RTOS emulation. POSIX does not define anything like 
sched_set_rr_interval(), and the linux kernel applies a default fixed 
interval to all threads from the SCHED_RR class (100ms IIRC).

So we have to emulate SCHED_RR over SCHED_FIFO plus a per-thread virtual 
timer.

> On the other hand, once the threadobj_start_rr function is called from
> my init, and I create the tasks in T_NOTSLICE mode, the time-slicing
> is still done.

Because you called threadobj_start_rr().

>
> Thanks.
>
> ---
> Ronny
>
>
>
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core


-- 
Philippe.

