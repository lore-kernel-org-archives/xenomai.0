Message-ID: <48201296.50905@domain.hid>
Date: Tue, 06 May 2008 10:11:02 +0200
From: Benjamin ZORES <benjamin.zores@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Timing Issues on x86_32 SMP
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I'm currently running an x86_32 SMP system and facing some issues with 
periodic tasks.
I'd like to get a bit more information on a few assumptions I've made.

Quick sum-up of my setup:
- adeos-ipipe-2.6.23-i386-1.12-03
- xenomai-2.4.3.patch
- Core 2 Duo x86_32 running in SMP
- Linux 2.6.23.17
- Timer frequency: 1000 Hz
- Tick-less mode activated (CONFIG_NO_HZ)
- Xenomai Periodic Timing enabled (CONFIG_XENO_OPT_TIMING_PERIODIC)
- tasks are kernel-based.

I'm trying to schedule a periodic task each 8ms and I'm running into 
period miss
(loosing from 5 up to 75, which is quite A LOT). The problem however 
doesn't appear
on UP system (or at least when booting the kernel with maxcpus=1 ).

I'd like to have more information regarding timer handling.

First, I create my 8ms periodic task, the following way:

    SRTIME ticks;
    int period = 8;

    /* need to feed with nano-seconds, then convert to CPU ticks */
    ticks = rt_timer_ns2ticks(1000000 * period);
    rt_task_set_periodic (task, TM_NOW, ticks);

Is it the correct way to do ?
It seems the rt_timer_ns2ticks() function is useless, i.e. it seems that 
1 tick = 1 ns,
which sees weird to me.

Also, what does the rt_timer_read() function really return in my context ?
Jiffies ? Nanoseconds ? Clock ticks ?
 From the different headers and documentation pieces I've read, none 
seem to be really
explicit regarding the returned value.

Any help, is really appreciated.

Ben




