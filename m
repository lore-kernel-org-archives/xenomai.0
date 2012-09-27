Message-ID: <5063F0E6.4070506@knapp.com>
Date: Thu, 27 Sep 2012 08:23:34 +0200
From: Christoph Permes <christoph.permes@knapp.com>
MIME-Version: 1.0
References: <5062CCB0.7060205@knapp.com> <506321EE.5040907@knapp.com>
	<5063727D.1070801@xenomai.org>
In-Reply-To: <5063727D.1070801@xenomai.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] Xenomai: native skin init failed, code -19.
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

On 09/26/2012 11:24 PM, Gilles Chanteperdrix wrote:
> On 09/26/2012 05:40 PM, Christoph Permes wrote:
> 
>> Hi!
>>
>> Meanwhile I found out that the problem does not occur when the
>> X86_PM_TIMER option is enabled in the kernel.
>>
>> Is it OK to enable X86_PM_TIMER? The Xenomai documentation does not
>> explicitly say if this option should be enabled or disabled, but I've
>> read about some issues on the mailing list where this option caused
>> problems.
> 
> 
> Hi,
> 
> Xenomai will use a timer only if it has not been shutdown by Linux. So,
> if enabling the PM_TIMER causes the APIC to be shut down then yes, you
> should disable PM_TIMER. Though with CONFIG_SMP, there is one LAPIC
> timer whereas there is only one PM_TIMER.
> 
> What is the result of cat /proc/timer_list when the APIC was disabled?


Hi,

here is the output of /proc/timer_list when Xenomai initialization fails (X86_PM_TIMER is disabled in kernel config):
-------------------------------------------------
Timer List Version: v0.4
HRTIMER_MAX_CLOCK_BASES: 2
now at 80944922880 nsecs

cpu: 0
 clock 0:
  .base:       c258f528
  .index:      0
  .resolution: 999848 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       c258f554
  .index:      1
  .resolution: 999848 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <f6781484>, it_real_fn, S:01
 # expires at 81047650044-81047650044 nsecs [in 102727164 to 102727164 nsecs]
 #1: <f67c1f58>, hrtimer_wakeup, S:01
 # expires at 81054445300-81054495300 nsecs [in 109522420 to 109572420 nsecs]
 #2: <f6930dc4>, it_real_fn, S:01
 # expires at 81522255461-81522255461 nsecs [in 577332581 to 577332581 nsecs]
 #3: <f675bb20>, hrtimer_wakeup, S:01
 # expires at 81745900665-81746900664 nsecs [in 800977785 to 801977784 nsecs]
 #4: <f6769b20>, hrtimer_wakeup, S:01
 # expires at 81746955544-81747955543 nsecs [in 802032664 to 803032663 nsecs]
 #5: <f6737f58>, hrtimer_wakeup, S:01
 # expires at 82606181641-82606231641 nsecs [in 1661258761 to 1661308761 nsecs]
 #6: <f704fb20>, hrtimer_wakeup, S:01
 # expires at 83793455777-83798455776 nsecs [in 2848532897 to 2853532896 nsecs]
 #7: <f6735ba4>, hrtimer_wakeup, S:01
 # expires at 110000817275-110030787274 nsecs [in 29055894395 to 29085864394 nsecs]
 #8: <f66b7f58>, hrtimer_wakeup, S:01
 # expires at 113024224528-113024274528 nsecs [in 32079301648 to 32079351648 nsecs]
 #9: <f6a21ba4>, hrtimer_wakeup, S:01
 # expires at 1261288187633-1261388187633 nsecs [in 1180343264753 to 1180443264753 nsecs]
 #10: <f6781b44>, it_real_fn, S:01
 # expires at 1821923874776-1821923874776 nsecs [in 1740978951896 to 1740978951896 nsecs]
 #11: <f6579f58>, hrtimer_wakeup, S:01
 # expires at 3615984354715-3615984404715 nsecs [in 3535039431835 to 3535039481835 nsecs]
 #12: <f6755004>, it_real_fn, S:01
 # expires at 28821809203052-28821809203052 nsecs [in 28740864280172 to 28740864280172 nsecs]
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 80944877330 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 76862700602 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294748225

cpu: 1
 clock 0:
  .base:       c2599528
  .index:      0
  .resolution: 999848 nsecs
  .get_time:   ktime_get_real
  .offset:     0 nsecs
active timers:
 clock 1:
  .base:       c2599554
  .index:      1
  .resolution: 999848 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <f6627f58>, hrtimer_wakeup, S:01
 # expires at 82658893878-82658943878 nsecs [in 1713970998 to 1714020998 nsecs]
 #1: <f6565f58>, hrtimer_wakeup, S:01
 # expires at 1818226965404-1818227015404 nsecs [in 1737282042524 to 1737282092524 nsecs]
  .expires_next   : 9223372036854775807 nsecs
  .hres_active    : 0
  .nr_events      : 0
  .nohz_mode      : 0
  .idle_tick      : 0 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 0
  .idle_calls     : 0
  .idle_sleeps    : 0
  .idle_entrytime : 80943919723 nsecs
  .idle_waketime  : 0 nsecs
  .idle_exittime  : 0 nsecs
  .idle_sleeptime : 74631298472 nsecs
  .last_jiffies   : 0
  .next_jiffies   : 0
  .idle_expires   : 0 nsecs
jiffies: 4294748225


Tick Device: mode:     0
Broadcast device
Clock Event Device: hpet
 max_delta_ns:   2147483647
 min_delta_ns:   5000
 mult:           61496114
 shift:          32
 mode:           2
 next_event:     9223372036854775807 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  tick_handle_periodic_broadcast
tick_broadcast_mask: 00000003
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     0
Per CPU device: 0
Clock Event Device: lapic
 max_delta_ns:   41676707
 min_delta_ns:   1000
 mult:           864482703
 shift:          32
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: lapic_next_event
 set_mode:       lapic_timer_setup
 event_handler:  tick_handle_periodic

Tick Device: mode:     0
Per CPU device: 1
Clock Event Device: lapic
 max_delta_ns:   41676707
 min_delta_ns:   1000
 mult:           864482703
 shift:          32
 mode:           1
 next_event:     9223372036854775807 nsecs
 set_next_event: lapic_next_event
 set_mode:       lapic_timer_setup
 event_handler:  tick_handle_periodic
-------------------------------------------------


When Xenomai initialization succeeds (same kernel config, X86_PM_TIMER disabled):
-------------------------------------------------
Timer List Version: v0.4
HRTIMER_MAX_CLOCK_BASES: 2
now at 57553062056 nsecs

cpu: 0
 clock 0:
  .base:       c258f528
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1348724879564140093 nsecs
active timers:
 clock 1:
  .base:       c258f554
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <f583fe94>, hrtimer_wakeup, S:01
 # expires at 57553563307-57553613307 nsecs [in 501251 to 551251 nsecs]
 #1: <c258f5a4>, tick_sched_timer, S:01
 # expires at 57554000000-57554000000 nsecs [in 937944 to 937944 nsecs]
 #2: <f67abb20>, hrtimer_wakeup, S:01
 # expires at 57564409295-57565409294 nsecs [in 11347239 to 12347238 nsecs]
 #3: <f67adb20>, hrtimer_wakeup, S:01
 # expires at 57565519502-57566519501 nsecs [in 12457446 to 13457445 nsecs]
 #4: <f580bf58>, hrtimer_wakeup, S:01
 # expires at 57879321042-57879371042 nsecs [in 326258986 to 326308986 nsecs]
 #5: <c1553b70>, sched_rt_period_timer, S:01
 # expires at 58000000000-58000000000 nsecs [in 446937944 to 446937944 nsecs]
 #6: <f583db20>, hrtimer_wakeup, S:01
 # expires at 58537556617-58538556616 nsecs [in 984494561 to 985494560 nsecs]
 #7: <f67ffb20>, hrtimer_wakeup, S:01
 # expires at 58537779492-58538779491 nsecs [in 984717436 to 985717435 nsecs]
 #8: <f67b1e94>, hrtimer_wakeup, S:01
 # expires at 63535908687-63535958687 nsecs [in 5982846631 to 5982896631 nsecs]
 #9: <f5847f58>, hrtimer_wakeup, S:01
 # expires at 65794140684-65794190684 nsecs [in 8241078628 to 8241128628 nsecs]
 #10: <f66e1ba4>, hrtimer_wakeup, S:01
 # expires at 324110267368-324210267368 nsecs [in 266557205312 to 266657205312 nsecs]
 #11: <f6573f58>, hrtimer_wakeup, S:01
 # expires at 1821150153313-1821150203313 nsecs [in 1763597091257 to 1763597141257 nsecs]
 #12: <f6627f58>, hrtimer_wakeup, S:01
 # expires at 3613699676328-3613699726328 nsecs [in 3556146614272 to 3556146664272 nsecs]
 #13: <f677b484>, it_real_fn, S:01
 # expires at 28827061142043-28827061142043 nsecs [in 28769508079987 to 28769508079987 nsecs]
  .expires_next   : 57553613307 nsecs
  .hres_active    : 1
  .nr_events      : 56852
  .nohz_mode      : 2
  .idle_tick      : 57551000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294724846
  .idle_calls     : 57659
  .idle_sleeps    : 45681
  .idle_entrytime : 57553005841 nsecs
  .idle_waketime  : 57551493164 nsecs
  .idle_exittime  : 57551495340 nsecs
  .idle_sleeptime : 51022894612 nsecs
  .last_jiffies   : 4294724849
  .next_jiffies   : 4294725347
  .idle_expires   : 58500000000 nsecs
jiffies: 4294724849

cpu: 1
 clock 0:
  .base:       c2599528
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1348724879564140093 nsecs
active timers:
 clock 1:
  .base:       c2599554
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c25995a4>, tick_sched_timer, S:01
 # expires at 57553250000-57553250000 nsecs [in 187944 to 187944 nsecs]
 #1: <f67fdf58>, hrtimer_wakeup, S:01
 # expires at 57558574546-57558624546 nsecs [in 5512490 to 5562490 nsecs]
 #2: <f5807f68>, hrtimer_wakeup, S:01
 # expires at 57584999157-57584999157 nsecs [in 31937101 to 31937101 nsecs]
 #3: <f67d1f58>, hrtimer_wakeup, S:01
 # expires at 57597183550-57597233550 nsecs [in 44121494 to 44171494 nsecs]
 #4: <f580ff58>, hrtimer_wakeup, S:01
 # expires at 57597429279-57597479279 nsecs [in 44367223 to 44417223 nsecs]
 #5: <f675fb20>, hrtimer_wakeup, S:01
 # expires at 57947081600-57947581393 nsecs [in 394019544 to 394519337 nsecs]
 #6: <f6765b20>, hrtimer_wakeup, S:01
 # expires at 58051793643-58052293642 nsecs [in 498731587 to 499231586 nsecs]
 #7: <f6699004>, it_real_fn, S:01
 # expires at 58216964179-58216964179 nsecs [in 663902123 to 663902123 nsecs]
 #8: <f67bbba4>, hrtimer_wakeup, S:01
 # expires at 58317423878-58318203877 nsecs [in 764361822 to 765141821 nsecs]
 #9: <f70856c4>, it_real_fn, S:01
 # expires at 60436874623-60436874623 nsecs [in 2883812567 to 2883812567 nsecs]
 #10: <f704fb20>, hrtimer_wakeup, S:01
 # expires at 60786407150-60791407149 nsecs [in 3233345094 to 3238345093 nsecs]
 #11: <f6985f58>, hrtimer_wakeup, S:01
 # expires at 63733791703-63733841703 nsecs [in 6180729647 to 6180779647 nsecs]
 #12: <f67fbb20>, hrtimer_wakeup, S:01
 # expires at 64825393532-64835393531 nsecs [in 7272331476 to 7282331475 nsecs]
 #13: <f581bf58>, hrtimer_wakeup, S:01
 # expires at 65829053397-65829103397 nsecs [in 8275991341 to 8276041341 nsecs]
 #14: <f6759ba4>, hrtimer_wakeup, S:01
 # expires at 83000621191-83030615190 nsecs [in 25447559135 to 25477553134 nsecs]
 #15: <f67bdf58>, hrtimer_wakeup, S:01
 # expires at 86679651247-86679701247 nsecs [in 29126589191 to 29126639191 nsecs]
 #16: <f6467ba4>, hrtimer_wakeup, S:01
 # expires at 1257341180172-1257441180172 nsecs [in 1199788118116 to 1199888118116 nsecs]
 #17: <f67f96c4>, it_real_fn, S:01
 # expires at 1824847474961-1824847474961 nsecs [in 1767294412905 to 1767294412905 nsecs]
  .expires_next   : 57553250000 nsecs
  .hres_active    : 1
  .nr_events      : 98324
  .nohz_mode      : 2
  .idle_tick      : 57552250000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294724847
  .idle_calls     : 98107
  .idle_sleeps    : 80637
  .idle_entrytime : 57552253273 nsecs
  .idle_waketime  : 57551854713 nsecs
  .idle_exittime  : 57552007034 nsecs
  .idle_sleeptime : 51416628764 nsecs
  .last_jiffies   : 4294724848
  .next_jiffies   : 4294725000
  .idle_expires   : 57704000000 nsecs
jiffies: 4294724849


Tick Device: mode:     1
Broadcast device
Clock Event Device: hpet
 max_delta_ns:   2147483647
 min_delta_ns:   5000
 mult:           61496114
 shift:          32
 mode:           3
 next_event:     9223372036854775807 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  tick_handle_oneshot_broadcast
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: lapic
 max_delta_ns:   4294967295
 min_delta_ns:   1199
 mult:           1
 shift:          0
 mode:           3
 next_event:     57553613307 nsecs
 set_next_event: xnarch_next_htick_shot
 set_mode:       xnarch_switch_htick_mode
 event_handler:  hrtimer_interrupt

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: lapic
 max_delta_ns:   4294967295
 min_delta_ns:   1199
 mult:           1
 shift:          0
 mode:           3
 next_event:     57553250000 nsecs
 set_next_event: xnarch_next_htick_shot
 set_mode:       xnarch_switch_htick_mode
 event_handler:  hrtimer_interrupt
-------------------------------------------------


And finally with X86_PM_TIMER enabled (Xenomai works always here):
-------------------------------------------------
Timer List Version: v0.4
HRTIMER_MAX_CLOCK_BASES: 2
now at 164310592952 nsecs

cpu: 0
 clock 0:
  .base:       c2591528
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1348724596815428478 nsecs
active timers:
 clock 1:
  .base:       c2591554
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c25915a4>, tick_sched_timer, S:01
 # expires at 164311000000-164311000000 nsecs [in 407048 to 407048 nsecs]
 #1: <f581fe94>, hrtimer_wakeup, S:01
 # expires at 164311099892-164311149892 nsecs [in 506940 to 556940 nsecs]
 #2: <f67d9f58>, hrtimer_wakeup, S:01
 # expires at 164313296348-164313346348 nsecs [in 2703396 to 2753396 nsecs]
 #3: <f5815f58>, hrtimer_wakeup, S:01
 # expires at 164315162728-164315212728 nsecs [in 4569776 to 4619776 nsecs]
 #4: <f6a1b484>, it_real_fn, S:01
 # expires at 164328803554-164328803554 nsecs [in 18210602 to 18210602 nsecs]
 #5: <f6b37484>, it_real_fn, S:01
 # expires at 164405264143-164405264143 nsecs [in 94671191 to 94671191 nsecs]
 #6: <f6793b20>, hrtimer_wakeup, S:01
 # expires at 164543127233-164544127232 nsecs [in 232534281 to 233534280 nsecs]
 #7: <f6795b20>, hrtimer_wakeup, S:01
 # expires at 164548454021-164549454020 nsecs [in 237861069 to 238861068 nsecs]
 #8: <f5813ba4>, hrtimer_wakeup, S:01
 # expires at 164572900180-164573322179 nsecs [in 262307228 to 262729227 nsecs]
 #9: <f65f9f58>, hrtimer_wakeup, S:01
 # expires at 165000826052-165000876052 nsecs [in 690233100 to 690283100 nsecs]
 #10: <f67a9b20>, hrtimer_wakeup, S:01
 # expires at 165052536679-165062536678 nsecs [in 741943727 to 751943726 nsecs]
 #11: <f580df58>, hrtimer_wakeup, S:01
 # expires at 165167649887-165167699887 nsecs [in 857056935 to 857106935 nsecs]
 #12: <f704fb20>, hrtimer_wakeup, S:01
 # expires at 166113719313-166118719312 nsecs [in 1803126361 to 1808126360 nsecs]
 #13: <f58bff58>, hrtimer_wakeup, S:01
 # expires at 166257186877-166257236877 nsecs [in 1946593925 to 1946643925 nsecs]
 #14: <f67c0dc4>, it_real_fn, S:01
 # expires at 173185585337-173185585337 nsecs [in 8874992385 to 8874992385 nsecs]
 #15: <f67abf58>, hrtimer_wakeup, S:01
 # expires at 173267956629-173268006629 nsecs [in 8957363677 to 8957413677 nsecs]
 #16: <f6b1fba4>, hrtimer_wakeup, S:01
 # expires at 324094738215-324194738215 nsecs [in 159784145263 to 159884145263 nsecs]
 #17: <f6798b84>, it_real_fn, S:01
 # expires at 1824994153704-1824994153704 nsecs [in 1660683560752 to 1660683560752 nsecs]
 #18: <f662ff58>, hrtimer_wakeup, S:01
 # expires at 3613956674176-3613956724176 nsecs [in 3449646081224 to 3449646131224 nsecs]
 #19: <f6698284>, it_real_fn, S:01
 # expires at 28827248345590-28827248345590 nsecs [in 28662937752638 to 28662937752638 nsecs]
  .expires_next   : 164311000000 nsecs
  .hres_active    : 1
  .nr_events      : 235336
  .nohz_mode      : 2
  .idle_tick      : 164308000000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294831603
  .idle_calls     : 242326
  .idle_sleeps    : 216230
  .idle_entrytime : 164307983191 nsecs
  .idle_waketime  : 164307977306 nsecs
  .idle_exittime  : 164308359155 nsecs
  .idle_sleeptime : 154521685001 nsecs
  .last_jiffies   : 4294831603
  .next_jiffies   : 4294831796
  .idle_expires   : 164500000000 nsecs
jiffies: 4294831606

cpu: 1
 clock 0:
  .base:       c259b528
  .index:      0
  .resolution: 1 nsecs
  .get_time:   ktime_get_real
  .offset:     1348724596815428478 nsecs
active timers:
 clock 1:
  .base:       c259b554
  .index:      1
  .resolution: 1 nsecs
  .get_time:   ktime_get
  .offset:     0 nsecs
active timers:
 #0: <c259b5a4>, tick_sched_timer, S:01
 # expires at 164311250000-164311250000 nsecs [in 657048 to 657048 nsecs]
 #1: <f67bff58>, hrtimer_wakeup, S:01
 # expires at 164313239481-164313289481 nsecs [in 2646529 to 2696529 nsecs]
 #2: <f5809f58>, hrtimer_wakeup, S:01
 # expires at 164388464763-164388514763 nsecs [in 77871811 to 77921811 nsecs]
 #3: <f582bb20>, hrtimer_wakeup, S:01
 # expires at 165151038108-165152038107 nsecs [in 840445156 to 841445155 nsecs]
 #4: <f5817b20>, hrtimer_wakeup, S:01
 # expires at 165151282618-165152282617 nsecs [in 840689666 to 841689665 nsecs]
 #5: <f67c3f58>, hrtimer_wakeup, S:01
 # expires at 165862570795-165862620795 nsecs [in 1551977843 to 1552027843 nsecs]
 #6: <f5811e94>, hrtimer_wakeup, S:01
 # expires at 170149348016-170149398016 nsecs [in 5838755064 to 5838805064 nsecs]
 #7: <f68f1ba4>, hrtimer_wakeup, S:01
 # expires at 173000605682-173030575681 nsecs [in 8690012730 to 8719982729 nsecs]
 #8: <f67c8944>, it_real_fn, S:01
 # expires at 325827909486-325827909486 nsecs [in 161517316534 to 161517316534 nsecs]
 #9: <f667bba4>, hrtimer_wakeup, S:01
 # expires at 1363953914633-1364053914633 nsecs [in 1199643321681 to 1199743321681 nsecs]
 #10: <f659df58>, hrtimer_wakeup, S:01
 # expires at 1821098452072-1821098502072 nsecs [in 1656787859120 to 1656787909120 nsecs]
  .expires_next   : 164311250000 nsecs
  .hres_active    : 1
  .nr_events      : 376650
  .nohz_mode      : 2
  .idle_tick      : 164308250000 nsecs
  .tick_stopped   : 0
  .idle_jiffies   : 4294831604
  .idle_calls     : 380283
  .idle_sleeps    : 346006
  .idle_entrytime : 164308359380 nsecs
  .idle_waketime  : 164308293549 nsecs
  .idle_exittime  : 164308324122 nsecs
  .idle_sleeptime : 153459239441 nsecs
  .last_jiffies   : 4294831604
  .next_jiffies   : 4294831750
  .idle_expires   : 164344000000 nsecs
jiffies: 4294831606


Tick Device: mode:     1
Broadcast device
Clock Event Device: hpet
 max_delta_ns:   2147483647
 min_delta_ns:   5000
 mult:           61496114
 shift:          32
 mode:           3
 next_event:     9223372036854775807 nsecs
 set_next_event: hpet_legacy_next_event
 set_mode:       hpet_legacy_set_mode
 event_handler:  tick_handle_oneshot_broadcast
tick_broadcast_mask: 00000000
tick_broadcast_oneshot_mask: 00000000


Tick Device: mode:     1
Per CPU device: 0
Clock Event Device: lapic
 max_delta_ns:   4294967295
 min_delta_ns:   1199
 mult:           1
 shift:          0
 mode:           3
 next_event:     164311000000 nsecs
 set_next_event: xnarch_next_htick_shot
 set_mode:       xnarch_switch_htick_mode
 event_handler:  hrtimer_interrupt

Tick Device: mode:     1
Per CPU device: 1
Clock Event Device: lapic
 max_delta_ns:   4294967295
 min_delta_ns:   1199
 mult:           1
 shift:          0
 mode:           3
 next_event:     164311250000 nsecs
 set_next_event: xnarch_next_htick_shot
 set_mode:       xnarch_switch_htick_mode
 event_handler:  hrtimer_interrupt
-------------------------------------------------


I have also turned on APIC debugging with apic=debug to see whats going on:

Thats the output where everything is fine:
[    0.026300] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
[    0.026466] Using local APIC timer interrupts.
[    0.026467] calibrating APIC timer ...
[    0.026995] ... lapic delta = 1249983
[    0.026995] ..... delta 1249983
[    0.026995] ..... mult: 53694522
[    0.026995] ..... calibration result: 199997
[    0.026995] ..... CPU clock speed is 1899.0974 MHz.
[    0.026995] ..... host bus clock speed is 199.0997 MHz.
[    0.026995] ... verify APIC timer
[    0.128395] ... jiffies delta = 100
[    0.128454] ... jiffies result ok
[    0.128602] Booting processor 1 APIC 0x1 ip 0x6000

And here is the output where Xenomai fails to initialize (note the value of jiffies delta):
[    0.026300] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
[    0.026466] Using local APIC timer interrupts.
[    0.026467] calibrating APIC timer ...
[    0.026995] ... lapic delta = 20124747
[    0.026995] ..... delta 20124747
[    0.026995] ..... mult: 864482703
[    0.026995] ..... calibration result: 3219959
[    0.026995] ..... CPU clock speed is -12360.-057 MHz.
[    0.026995] ..... host bus clock speed is 3219.0959 MHz.
[    0.026995] ... verify APIC timer
[    1.668621] ... jiffies delta = 1610
[    1.668680] APIC timer disabled due to verification failure
[    1.669089] Booting processor 1 APIC 0x1 ip 0x6000

With X86_PM_TIMER enabled in kernel the APIC timer verification seems to be skipped,
I got no failure in this constellation anymore:
[    0.026305] CPU0: Intel Celeron(R) Dual-Core CPU       T3100  @ 1.90GHz stepping 0a
[    0.026472] Using local APIC timer interrupts.
[    0.026473] calibrating APIC timer ...
[    0.026995] ... lapic delta = 1249983
[    0.026995] ... PM timer delta = 357950
[    0.026995] ... PM timer result ok
[    0.026995] ..... delta 1249983
[    0.026995] ..... mult: 53694522
[    0.026995] ..... calibration result: 199997
[    0.026995] ..... CPU clock speed is 1899.0975 MHz.
[    0.026995] ..... host bus clock speed is 199.0997 MHz.
[    0.026995] Booting processor 1 APIC 0x1 ip 0x6000



Thanks,
  Christoph

