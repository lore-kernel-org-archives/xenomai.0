Message-ID: <50C64F79.8070101@wanadoo.fr>
Date: Mon, 10 Dec 2012 22:09:13 +0100
From: Thierry Bultel <thierry.bultel@wanadoo.fr>
MIME-Version: 1.0
References: <50C1EF04.1090506@wanadoo.fr> <50C236B9.3030507@xenomai.org>
	<50C4EF5A.3030502@wanadoo.fr> <50C524A6.6020006@xenomai.org>
	<50C5F784.6040801@wanadoo.fr> <50C6076F.7050505@xenomai.org>
	<50C60E6A.1080307@wanadoo.fr> <50C61DF3.8030703@xenomai.org>
	<50C62B41.1060308@wanadoo.fr> <50C63069.1010607@xenomai.org>
	<50C63FF3.6040409@wanadoo.fr> <50C643DC.1080901@xenomai.org>
In-Reply-To: <50C643DC.1080901@xenomai.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] iMX6q 1Hz tick
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

Le 10/12/2012 21:19, Gilles Chanteperdrix a écrit :
> On 12/10/2012 09:02 PM, Thierry Bultel wrote:
>
>> Le 10/12/2012 19:56, Gilles Chanteperdrix a écrit :
>>> On 12/10/2012 07:34 PM, Thierry Bultel wrote:
>>>
>>>> Le 10/12/2012 18:37, Gilles Chanteperdrix a écrit :
>>>>> On 12/10/2012 05:31 PM, Thierry Bultel wrote:
>>>>>> Le 10/12/2012 17:01, Gilles Chanteperdrix a écrit :
>>>>>>> On 12/10/2012 03:53 PM, Thierry Bultel wrote:
>>>>>>>> Le 10/12/2012 00:54, Gilles Chanteperdrix a écrit :
>>>>>>>>> On 12/09/2012 09:06 PM, Thierry Bultel wrote:
>>>>>>>>>
>>>>>>>>>> Le 07/12/2012 19:34, Gilles Chanteperdrix a écrit :
>>>>>>>>>>> On 12/07/2012 02:28 PM, Thierry Bultel wrote:
>>>>>>>>>>>
>>>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> Hello Gilles,
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I have "successfully" patched a 3.0.35 kernel from Freescale with
>>>>>>>>>>>> adeos-ipipe-3.0.36-1.18.11
>>>>>>>>>>>>
>>>>>>>>>>>> I have -not- applied the adeos-ipipe-3.0.36-arm-1.18-11-pre.patch
>>>>>>>>>>>> that showed too much "revert patch detected" errors.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> The patch should apply cleanly, the question, if you get too many
>>>>>>>>>>> rejections, it is because you do not apply it to the proper branch.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Of course it was not.
>>>>>>>>>> I started with a kernel provided by the module manufacturer. I estimate
>>>>>>>>>> that this kernel is "almost" a rel_imx_3.0.35_12.09.02, I mean, that
>>>>>>>>>> I have not found a closer tag than this one.
>>>>>>>>>>
>>>>>>>>>> My first idea was to attempt to apply the patches to that kernel
>>>>>>>>>> directly. I was not expecting it would have been simple, and it was
>>>>>>>>>> actually not. But after a few hours I came to the initial result I said.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> BTW, I have understand that its purpose was mainly to upgrade to 3.0.36,
>>>>>>>>>>>> but what is actually the role of the
>>>>>>>>>>>> adeos-ipipe-3.0.36-arm-1.18-11-post.patch ? (I applied it).
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I have explained this in a previous mail.
>>>>>>>>>>
>>>>>>>>>> Ok, I will seek in the history. I would be nice if the explanation
>>>>>>>>>> was in the README.
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> I had to deal with some rejections but at least the kernel is booting
>>>>>>>>>>>> and my application running.
>>>>>>>>>>>>
>>>>>>>>>>>> But the target is very slow, and /proc/xenomai/irq shows that the
>>>>>>>>>>>> [timer] irq only comes about every 1 second.
>>>>>>>>>>>>
>>>>>>>>>>>> The /proc/interrupts shows an IRQ every 10ms, which was expected
>>>>>>>>>>>> since I have CONFIG_HZ=100
>>>>>>>>>>>>
>>>>>>>>>>>> I am pretty sure that I messed up something in the patch process,
>>>>>>>>>>>> however I do not know where to start to look for.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Apply the patches to the proper imx release, and everything should be fine.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> That is what I did, at last.
>>>>>>>>>> To do so, I have extracted the BSP from the given 'almost'
>>>>>>>>>> rel_imx_3.0.35_12.09.02 kernel,
>>>>>>>>>> taken the rel_imx_3.0.15_12.03.00, applied the patches,
>>>>>>>>>> and brought back the BSP to the patched kernel.
>>>>>>>>>
>>>>>>>>
>>>>>>>> The issues I mentionned are not also present with CONFIG_IPIPE=no,
>>>>>>>> so it is just that the 3.0.15 kernel does not have everything for my board.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> I would do what you want to do with git. Checkout the ipipe-3.0-imx6q
>>>>>>>>> branch from the ipipe-gch.git, then merge it with the vendor branch you
>>>>>>>>> want to use.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Sure it would work and would be fine with git.
>>>>>>>> But unfortunalely I do not have access to the repository of the vendor,
>>>>>>>> but only to a bz2 snapshot of their kernel.
>>>>>>>>
>>>>>>>> I wonder if the right method would be to use git to merge Ipipe to the
>>>>>>>> 3.0.35_12_09.02, and then bring back the BSP that I have isolated as a patch
>>>>>>>
>>>>>>> Yes, if the vendor BSP is based on 3.0.35_12_09.02, you should make a
>>>>>>> diff with that, and try and merge it with the ipipe-3.0-imx6q branch.
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Done. And success. Thanks. I am running your 3.0.43 kernel with my BSP.
>>>>>> no more network or reboot slowness issues.
>>>>>>
>>>>>> However, htop it saying that CPU0 is at 20% and CPU3 at 12%,
>>>>>> no application is running. The only thing that I see running is the
>>>>>> timer interrupt.
>>>>>>
>>>>>> Also, I still have
>>>>>> 87:         13          0          0          0       GIC  i.MX Timer Tick
>>>>>>
>>>>>> .. the counter increases very slowly, about 1 every 10 minutes maybe.
>>>>>>
>>>>>> That does not happen with CONFIG_IPIPE=no
>>>>>
>>>>> Do you have CONFIG_LOCALTIMER (and CONFIG_SMP) enabled?
>>>>>
>>>>>
>>>>
>>>> CONFIG_SMP yes,
>>>> You mean CONFIG_LOCAL_TIMERS ? Yes
>>>
>>>
>>> Could you post the disassembly of the mxc_timer_interrupt function?
>>>
>>
>> Hope this helps:
>>
>> 8006e93c <mxc_timer_interrupt>:
>> 8006e93c:       e3031998        movw    r1, #14744      ; 0x3998
>> 8006e940:       e92d4010        push    {r4, lr}
>> 8006e944:       e34810c7        movt    r1, #32967      ; 0x80c7
>> 8006e948:       e3020a00        movw    r0, #10752      ; 0x2a00
>> 8006e94c:       e34800c3        movt    r0, #32963      ; 0x80c3
>> 8006e950:       e3a04001        mov     r4, #1
>> 8006e954:       e5912000        ldr     r2, [r1]
>> 8006e958:       e5903000        ldr     r3, [r0]
>> 8006e95c:       e5921008        ldr     r1, [r2, #8]
>> 8006e960:       e5824008        str     r4, [r2, #8]
>> 8006e964:       e12fff33        blx     r3
>> 8006e968:       e1a00004        mov     r0, r4
>> 8006e96c:       e8bd8010        pop     {r4, pc}
>>
>> Tell me if you need more information
>>
>>
>
> Ok, this looks compiled as the sources tell us. The thing I do not
> understand is that since there is another clockevent running (the local
> timers), the mxc_timer should not be ticking at all.

but is does when CONFIG_IPIPE is NO, (I can see the counter increasing);
why is it not the case otherwise ?

If you do not encounter this issue with your board(s) , does that mean
that the problem is somewhere in my BSP ?

What does cat
> /proc/timer_list say?
>

[root@buildroot ~]# cat /proc/timer_list
Timer List Version: v0.6
HRTIMER_MAX_CLOCK_BASES: 3
now at 1470794386645 nsecs

cpu: 0
  clock 0:
   .base:       8c0084f0
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       8c008528
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       8c008560
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:
   .nohz_mode      : 1
   .idle_tick      : 1470780000000 nsecs
   .tick_stopped   : 0
   .idle_jiffies   : 117112
   .idle_calls     : 431119
   .idle_sleeps    : 103348
   .idle_entrytime : 1470792979203 nsecs
   .idle_waketime  : 1470789968751 nsecs
   .idle_exittime  : 1470790014466 nsecs
   .idle_sleeptime : 1458835547455 nsecs
   .iowait_sleeptime: 1296620167 nsecs
   .last_jiffies   : 117079
   .next_jiffies   : 117080
   .idle_expires   : 1470790000000 nsecs
jiffies: 117079

cpu: 1
  clock 0:
   .base:       8c0114f0
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       8c011528
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       8c011560
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:
   .nohz_mode      : 1
   .idle_tick      : 1470800000000 nsecs
   .tick_stopped   : 0
   .idle_jiffies   : 117079
   .idle_calls     : 26472
   .idle_sleeps    : 3777
   .idle_entrytime : 1470794091951 nsecs
   .idle_waketime  : 1470790774647 nsecs
   .idle_exittime  : 1470790779117 nsecs
   .idle_sleeptime : 1469166160233 nsecs
   .iowait_sleeptime: 208141047 nsecs
   .last_jiffies   : 117079
   .next_jiffies   : 117080
   .idle_expires   : 1504740000000 nsecs
jiffies: 117079

cpu: 2
  clock 0:
   .base:       8c01a4f0
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       8c01a528
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       8c01a560
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:
   .nohz_mode      : 1
   .idle_tick      : 1470440000000 nsecs
   .tick_stopped   : 1
   .idle_jiffies   : 117080
   .idle_calls     : 125874
   .idle_sleeps    : 32018
   .idle_entrytime : 1470460008425 nsecs
   .idle_waketime  : 1470459967346 nsecs
   .idle_exittime  : 1470430011331 nsecs
   .idle_sleeptime : 1467715834344 nsecs
   .iowait_sleeptime: 201327381 nsecs
   .last_jiffies   : 117046
   .next_jiffies   : 117243
   .idle_expires   : 1472430000000 nsecs
jiffies: 117079

cpu: 3
  clock 0:
   .base:       8c0234f0
   .index:      0
   .resolution: 10000000 nsecs
   .get_time:   ktime_get
active timers:
  clock 1:
   .base:       8c023528
   .index:      1
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_real
active timers:
  clock 2:
   .base:       8c023560
   .index:      2
   .resolution: 10000000 nsecs
   .get_time:   ktime_get_boottime
active timers:
   .nohz_mode      : 1
   .idle_tick      : 1467050000000 nsecs
   .tick_stopped   : 1
   .idle_jiffies   : 116718
   .idle_calls     : 16882
   .idle_sleeps    : 4052
   .idle_entrytime : 1468040078182 nsecs
   .idle_waketime  : 1468040068578 nsecs
   .idle_exittime  : 1467040019716 nsecs
   .idle_sleeptime : 1466208672344 nsecs
   .iowait_sleeptime: 149617863 nsecs
   .last_jiffies   : 116804
   .next_jiffies   : 1073858533
   .idle_expires   : 10738885330000000 nsecs
jiffies: 117079


Tick Device: mode:     1
Broadcast device
Clock Event Device: mxc_timer1
  max_delta_ns:   715827903888
  min_delta_ns:   42500
  mult:           25769803
  shift:          32
  mode:           3
  next_event:     9223372036854775807 nsecs
  set_next_event: v2_set_next_event
  set_mode:       mxc_set_mode
  event_handler:  tick_handle_oneshot_broadcast
  retries:        0
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: local_timer
  max_delta_ns:   21691754030
  min_delta_ns:   1000
  mult:           425201762
  shift:          31
  mode:           3
  next_event:     1470800000000 nsecs
  set_next_event: xnarch_next_htick_shot
  set_mode:       xnarch_switch_htick_mode
  event_handler:  tick_nohz_handler
  retries:        0

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: local_timer
  max_delta_ns:   21691754030
  min_delta_ns:   1000
  mult:           425201762
  shift:          31
  mode:           3
  next_event:     1470800000000 nsecs
  set_next_event: xnarch_next_htick_shot
  set_mode:       xnarch_switch_htick_mode
  event_handler:  tick_nohz_handler
  retries:        0

Tick Device: mode:     1
Per CPU device: 2
Clock Event Device: local_timer
  max_delta_ns:   21691754030
  min_delta_ns:   1000
  mult:           425201762
  shift:          31
  mode:           3
  next_event:     1472430000000 nsecs
  set_next_event: xnarch_next_htick_shot
  set_mode:       xnarch_switch_htick_mode
  event_handler:  tick_nohz_handler
  retries:        0

Tick Device: mode:     1
Per CPU device: 3
Clock Event Device: local_timer
  max_delta_ns:   21691754030
  min_delta_ns:   1000
  mult:           425201762
  shift:          31
  mode:           3
  next_event:     10738885330000000 nsecs
  set_next_event: xnarch_next_htick_shot
  set_mode:       xnarch_switch_htick_mode
  event_handler:  tick_nohz_handler
  retries:        0


> Also, you can try adding the call to __ipipe_tsc_update in
> mxc_timer_interrupt even in the SMP case. If you have a problem with the
> tsc, the "tsc" test from Xenomai testsuite should fail after some time
> when run with the "-w" argument, but normally the tsc should take a long
> time to wrap, so, there should not be immediately visible effects. But
> it is worth checking.

I keep you informed of the tests by tomorrow


