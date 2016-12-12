From: Marco Baracchi <cormabara@yandex.com>
In-Reply-To: <mailman.3.1481540401.18213.xenomai@xenomai.org>
References: <mailman.3.1481540401.18213.xenomai@xenomai.org>
Message-Id: <68551481553062@web16j.yandex.ru>
Date: Mon, 12 Dec 2016 15:31:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: Re: [Xenomai] Long time system slow down on imx6
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Content-Transfer-Encoding: 8bit
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

   Sorry I hope this is the correct way to add a mail to this thread
   inside mailing list:

   Â

   What you mean with "lost wakeup problem" ?

   Â

   What we are checking is a timer tick missing:

   Â

   root@deimo-staubli ~$ cat /proc/timer_list

   Timer List Version: v0.6

   HRTIMER_MAX_CLOCK_BASES: 3

   now at 158072087097365 nsecs

   Â

   cpu: 0

   clock 0:

   Â  .base:Â Â Â Â Â Â  80ba8380

   Â  .index:Â Â Â Â Â  0

   Â  .resolution: 1 nsecs

   Â  .get_time:Â Â  ktime_get

   Â  .offset:Â Â Â Â  0 nsecs

   active timers:

   #0: <80ba88a0>, tick_sched_timer, S:01

   # expires at 158034760000000-158034760000000 nsecs [in -37327097365 to
   -37327097365 nsecs]

   #1: <8fb57f40>, hrtimer_wakeup, S:01

   # expires at 158034782298842-158034782348842 nsecs [in -37304798523 to
   -37304748523 nsecs]

   #2: <8f201ad0>, hrtimer_wakeup, S:01

   # expires at 159434496114473-159434496164473 nsecs [in 1362409017108 to
   1362409067108 nsecs]

   #3: <8f20bad0>, hrtimer_wakeup, S:01

   # expires at 159439053136473-159439057697464 nsecs [in 1366966039108 to
   1366970600099 nsecs]

   clock 1:

   Â  .base:Â Â Â Â Â Â  80ba83b8

   Â  .index:Â Â Â Â Â  1

   Â  .resolution: 1 nsecs

   Â  .get_time:Â Â  ktime_get_real

   Â  .offset:Â Â Â Â  1481376344107425663 nsecs

   active timers:

   clock 2:

   Â  .base:Â Â Â Â Â Â  80ba83f0

   Â  .index:Â Â Â Â Â  2

   Â  .resolution: 1 nsecs

   Â  .get_time:Â Â  ktime_get_boottime

   Â  .offset:Â Â Â Â  0 nsecs

   active timers:

   Â  .expires_nextÂ Â  : 158034760000000 nsecs

   Â  .hres_activeÂ Â Â  : 1

   Â  .nr_eventsÂ Â Â Â Â  : 22078740

   Â  .nr_retriesÂ Â Â Â  : 51929

   Â  .nr_hangsÂ Â Â Â Â Â  : 0

   Â  .max_hang_timeÂ  : 0 nsecs

   Â  .nohz_modeÂ Â Â Â Â  : 0

   Â  .idle_tickÂ Â Â Â Â  : 0 nsecs

   Â  .tick_stoppedÂ Â  : 0

   Â  .idle_jiffiesÂ Â  : 0

   Â  .idle_callsÂ Â Â Â  : 0

   Â  .idle_sleepsÂ Â Â  : 0

   Â  .idle_entrytime : 0 nsecs

   Â  .idle_waketimeÂ  : 0 nsecs

   Â  .idle_exittimeÂ  : 0 nsecs

   Â  .idle_sleeptime : 0 nsecs

   Â  .iowait_sleeptime: 0 nsecs

   Â  .last_jiffiesÂ Â  : 0

   Â  .next_jiffiesÂ Â  : 0

   Â  .idle_expiresÂ Â  : 0 nsecs

   jiffies: 15773475

   Â

   Â

   Tick Device: mode:Â Â Â Â  1

   Per CPU device: 0

   Clock Event Device: mxc_timer1

   max_delta_ns:Â Â  4294967295

   min_delta_ns:Â Â  85000

   mult:Â Â Â Â Â Â Â Â Â Â  1

   shift:Â Â Â Â Â Â Â Â Â  0

   mode:Â Â Â Â Â Â Â Â Â Â  3

   next_event:Â Â Â Â  158034760000000 nsecs

   set_next_event: xnarch_next_htick_shot

   set_mode:Â Â Â Â Â Â  xnarch_switch_htick_mode

   event_handler:Â  hrtimer_interrupt

   retries:Â Â Â Â Â Â Â  0

   As you can see the next event is in the past, timer mxc_timer1 seems to
   have missed a tick.

   Â

   You mean your system is locked into a SELECT system call ?

   1ms is the period of your periodic thread ?

   Â

   Â

   12.12.2016, 12:00, "xenomai-request@xenomai.org"
   <xenomai-request@xenomai.org>:

     Send Xenomai mailing list submissions to
     Â Â Â Â Â Â Â Â [1]xenomai@xenomai.org
     To subscribe or unsubscribe via the World Wide Web, visit
     Â Â Â Â Â Â Â Â [2]https://xenomai.org/mailman/listinfo/xenomai
     or, via email, send a message with subject or body 'help' to
     Â Â Â Â Â Â Â Â [3]xenomai-request@xenomai.org
     You can reach the person managing the list at
     Â Â Â Â Â Â Â Â [4]xenomai-owner@xenomai.org
     When replying, please edit your Subject line so it is more specific
     than "Re: Contents of Xenomai digest..."
     Today's Topics:
     Â Â Â 1. Re: Long time system slow down on imx6 (Johann Obermayr)
     --------------------------------------------------------------------
     --
     Message: 1
     Date: Mon, 12 Dec 2016 11:16:33 +0100
     From: Johann Obermayr <[5]johann.obermayr@sigmatek.at>
     To: [6]Xenomai@xenomai.org
     Subject: Re: [Xenomai] Long time system slow down on imx6
     Message-ID: <[7]f07822d2-e30a-d394-bae6-bdf776c0f03a@sigmatek.at>
     Content-Type: text/plain; charset=utf-8; format=flowed
     Am 09.12.2016 um 23:42 schrieb Marco:

     Â Â Â Â Â We are notice a very strange problem on a imx6 with kernel
     Â Â Â Â Â Linux3.0.35-4.1.0 + xenomai_2.6.4. After machine runs for
     8 - 10 hours
     Â Â Â Â Â we found the system blocked in may different ways (user
     interface
     Â Â Â Â Â tcp/ip interface ecc..)
     Â Â Â Â Â ?
     Â Â Â Â Â We check into /proc/timer_list and we found the next event
     was
     Â Â Â Â Â scheduled in the past.
     Â Â Â Â Â ?
     Â Â Â Â Â We found some items about timer blocked but all the
     patches indicated
     Â Â Â Â Â was already applied.
     Â Â Â Â Â ?
     Â Â Â Â Â Maybe someone have seen a similar problem ?
     Â _______________________________________________
     Â Xenomai mailing list
     Â [8]Xenomai@xenomai.org
     Â [9]https://xenomai.org/mailman/listinfo/xenomai

     Hello,
     i don't known if it is the same problem.
     But we search a lost wakeup problem with "select" and a short
     timeout. (1ms)
     Regards
     Â Â Â Johann
     ------------------------------
     Subject: Digest Footer
     _______________________________________________
     Xenomai mailing list
     [10]Xenomai@xenomai.org
     [11]https://xenomai.org/mailman/listinfo/xenomai
     ------------------------------
     End of Xenomai Digest, Vol 56, Issue 11
     ***************************************

References

   1. mailto:xenomai@xenomai.org
   2. https://xenomai.org/mailman/listinfo/xenomai
   3. mailto:xenomai-request@xenomai.org
   4. mailto:xenomai-owner@xenomai.org
   5. mailto:johann.obermayr@sigmatek.at
   6. mailto:Xenomai@xenomai.org
   7. mailto:f07822d2-e30a-d394-bae6-bdf776c0f03a@sigmatek.at
   8. mailto:Xenomai@xenomai.org
   9. https://xenomai.org/mailman/listinfo/xenomai
  10. mailto:Xenomai@xenomai.org
  11. https://xenomai.org/mailman/listinfo/xenomai
