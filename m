Message-ID: <4838AC7A.7030609@domain.hid>
Date: Sat, 24 May 2008 20:02:02 -0400
From: Tomas Kalibera <kalibera@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] rt_intr_wait takes 10ms
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@domain.hid>


Hi,

I've measured interrupt latencies using irqbench and extended it a bit 
to measure also latencies of a user space task that uses "rt_intr_wait", 
as opposed to the specialized ioctl call used presently by the benchmark.

I found out that when the call to rt_intr_wait does not block (there is 
already an interrupt pending), the latency is nice, i.e. 20us. However, 
when rt_intr_wait blocks, the latency is 10ms (the whole quantum).

I thought that once the interrupt arrives and the kernel space header 
signals the interrupt, the Xenomai scheduler should be invoked and 
should preempt any presently running thread and immediately wake up the 
thread blocked in rt_intr_wait. Is this correct ?

The thread blocked in rt_intr_wait had maximum priority (99) and was in 
primary mode.

Interestingly, when I run the original version of the irqbench 
benchmark, even the user space version (-t 0, default) that waits for 
the interrupt using the specialized ioctl call, had nice latencies about 
20us. Any ideas why the rt_intr_wait does not behave equally well ?

Thanks,
Tomas



