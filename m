From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <4639D724.5010702@domain.hid>
References: <4639D724.5010702@domain.hid>
Content-Type: text/plain
Date: Thu, 03 May 2007 15:29:51 +0200
Message-Id: <1178198991.29605.54.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] Latency calculation and test
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
To: Johan Borkhuis <j.borkhuis@domain.hid>
Cc: Xenomai-help@domain.hid

On Thu, 2007-05-03 at 14:35 +0200, Johan Borkhuis wrote:
> I am quite new to Xenomai, but not to realtime and embedded development. 
> I am trying to run Xenomai on a MVME3100 board (PPC8540 processor, 
> kernel version 2.6.14, Xenomai 2.3.1).
> 
> I am trying to do latency measurements on my target, and I have some 
> questions.
> 
> As far as I understand it, the value in /proc/xenomai/latency is the 
> time needed to start a timer, and this value is subtracted from the 
> value provided to the timer. The value calculated by Xenomai on my 
> platform is 9489. All latencies reported with the latency tool are 
> negative when this value is used.

The mpc8540 is too fast for pre-defined calibration value.

> When I write 0 to this setting (to get the real values without offset) 
> and run the latency test program I see different values for the 
> different modes: user space = 3.6 usec, kernel space = 1.8 usec and IRQ 
> = 0.9 usec. What is the relation between the value calculated by Xenomai 
> and the values measured by the latency program, and what is the correct 
> way to calculate the latency setting?

None, actually. Xenomai does not calibrate the latency dynamically, but
rather use a pre-defined value listed in asm-powerpc/calibration.h.
~9500 ns is the value picked for any ppc32 board right now.

Please send back the proper calibration value for your board, we will
use it as the pre-calibrated data when MPC8540 is defined.

> 
> I also did a port of the cyclictest program to Xenomai. Instead of the 
> pthreads I used the RT-tasks, like the latency program.  The cyclictest 
> program uses signals to  trigger the task, but as I found out this does 
> not work in userspace: the applications returns to secondary mode at the 
> moment the thread waits for a signal. Is there another way to do this 
> (next to moving the whole program to kernel space)?
> 

Hard RT signals are not yet supported by Xenomai. It's on the 2.4
roadmap though. So you are right, POSIX signals are presently only
available from the regular glibc/kernel support, therefore Xenomai
threads automatically move to secondary mode to process them. Precise
timing can be achieved with the POSIX skin using the non-portable
pthread_set_periodic_np/pthread_wait_np interface.

> One option of the cyclictest program is that you can have several 
> threads running. I modified the output of the cyclictest tool somewhat, 
> to have min, max and average like the latency program.
> When running multiple threads within this program (without load) the 
> values range from -5 usec to +5 usec, with an average of around 0 usec. 
> But with more RT tasks I see a very high latency once in a while (over 
> 400 usec).
> 
> Below is the example of such a test run with 10 threads/tasks:
>  T: 0 ( 1305) P:80 I:1000 O: 0 Min:   -2.404 Avg: -0.001 Max:   1.873
>  T: 1 ( 1306) P:79 I:1000 O: 0 Min:   -3.052 Avg: -0.001 Max:   1.584
>  T: 2 ( 1307) P:78 I:1000 O: 0 Min:   -5.694 Avg:  0.000 Max:  18.282
>  T: 3 ( 1308) P:77 I:1000 O: 0 Min:   -5.166 Avg:  0.046 Max: 479.782
>  T: 4 ( 1309) P:76 I:1000 O: 0 Min:   -2.595 Avg:  0.036 Max: 368.310
>  T: 5 ( 1310) P:75 I:1000 O: 0 Min:   -1.731 Avg: -0.001 Max:   1.633
>  T: 6 ( 1311) P:74 I:1000 O: 0 Min: -481.273 Avg: -0.001 Max: 490.352
>  T: 7 ( 1312) P:73 I:1000 O: 0 Min: -273.947 Avg: -0.001 Max: 277.717
>  T: 8 ( 1313) P:72 I:1000 O: 0 Min:  -47.016 Avg: -0.001 Max:  45.789
>  T: 9 ( 1314) P:71 I:1000 O: 0 Min:  -22.968 Avg: -0.001 Max:  29.572
> (P=Priority, I=interval, O=overruns)
> 
> When looking at the detailed information, I see that the latencies occur 
> when a higher priority task is ending. Is there some specific reason for 
> this, or is there some kind of configuration problem with my setup?
> 

Confirmed here, latencies are way too high in this scenario. Could you
try running a native latency test (testsuite/latency) in parallel of a
running cyclic test? I'm interested by the maximum jitter you get there.

> Kind regards,
>     Johan Borkhuis
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
-- 
Philippe.



