MIME-Version: 1.0
Date: Wed, 20 May 2015 11:53:46 +0200
Message-ID: <CAD6zzEn4imLcrGfSu-Ehrs_L3Kyf3DM_Fhb4NuQREZ4xszbxpg@mail.gmail.com>
From: Marco Baracchi <cormabara@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] hrtimer negative next event
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

We are using kernel *linux 3.0.35*, branch *imx_3.0.35_4.1.0* with
patches *adeos-xenomai
2.6.4* for *mxc* on a freescale imx6 single core and we have  a problem
with hrtimer: sometimes after a couple of hour our periodic task inside
Xenomai blocks. checking inside /proc path we  found:
--------------------------------------------------------------------------------------------------------------------------------------------------------------

~$ cat /proc/timer_list
Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 23036522464643 nsecs

cpu: 0
 clock 0:
  .base:       80bac120
  .index:      0
  .resolution: 10000000 nsecs
  .get_time:   ktime_get
active timers:
 #0: <8da95ad0>, hrtimer_wakeup, S:01
* # expires at 21797170078601-21797175078598 nsecs [in -1239352386042 to
-1239347386045 nsecs]*
 #1: <8d9bbad0>, hrtimer_wakeup, S:01
* # expires at 22305508502700-22305508552700 nsecs [in -731013961943 to
-731013911943 nsecs]*
 #2: <8d9adad0>, hrtimer_wakeup, S:01
* # expires at 22306066149366-22306066711361 nsecs [in -730456315277 to
-730455753282 nsecs]*
 clock 1:
  .base:       80bac158
  .index:      1
  .resolution: 10000000 nsecs
  .get_time:   ktime_get_real
active timers:
 clock 2:
  .base:       80bac190
  .index:      2
  .resolution: 10000000 nsecs
  .get_time:   ktime_get_boottime
active timers:
  .nohz_mode      : 1
  .idle_tick      : 23940000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294939689
  .idle_calls     : 818
  .idle_sleeps    : 262
  .idle_entrytime : 23934848677 nsecs
  .idle_waketime  : 23933040680 nsecs
  .idle_exittime  : 23933071013 nsecs
  .idle_sleeptime : 5144197445 nsecs
  .iowait_sleeptime: 2999951898 nsecs
  .last_jiffies   : 4294939689
  .next_jiffies   : 4294939690
  .idle_expires   : 24000000000 nsecs
jiffies: 2149406


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: mxc_timer1
 max_delta_ns:   4294967295
 min_delta_ns:   85000
 mult:           1
 shift:          0
 mode:           3
 next_event:     21794070000000 nsecs
 set_next_event: xnarch_next_htick_shot
 set_mode:       xnarch_switch_htick_mode
 event_handler:  tick_nohz_handler
 retries:        0

--------------------------------------------------------------------------------------------------------------------------------------------------------------

seems the hrclock receive a negative next event.

Inside configuration:

CONFIG_IPIPE yes
CONFIG_SMP is not set

We check with CONFIG_HIGH_RES_TIMERS enabled and disabled but the problem
still persist


We go to check inside kernel and we found:

static int v2_set_next_event(unsigned long evt,
      struct clock_event_device *unused)
{
unsigned long tcmp;

tcmp = __raw_readl(timer_base + V2_TCN) + evt;

__raw_writel(tcmp, timer_base + V2_TCMP);

return evt < 0x7fffffff &&
(int)(tcmp - __raw_readl(timer_base + V2_TCN)) < 0 ?
-ETIME : 0;
}

in this function a negative value should already still trapped.

Can someone help us
