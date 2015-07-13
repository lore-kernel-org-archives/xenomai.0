Message-ID: <55A42E12.9080006@sigmatek.at>
Date: Mon, 13 Jul 2015 23:30:58 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <20150713140208.GC1554@hermes.click-hack.org>
 <55A3D1B2.50905@sigmatek.at>
 <e5d48b6984cbc1b098062b303b56b0db.squirrel@sourcetrek.com>
 <55A3EE26.5070802@sigmatek.at>
 <7413ead94cb8c4f3a91d1288a27103c9.squirrel@sourcetrek.com>
 <55A3F4B3.1090908@sigmatek.at> <20150713195856.GA1552@hermes.click-hack.org>
 <55A41E26.9020903@sigmatek.at> <20150713203133.GA2022@hermes.click-hack.org>
 <55A4235D.2000601@sigmatek.at> <20150713205412.GC2022@hermes.click-hack.org>
In-Reply-To: <20150713205412.GC2022@hermes.click-hack.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Subject: Re: [Xenomai] usage of rtdm_task_sleep_abs
Reply-To: johann.obermayr@sigmatek.at
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
Cc: xenomai@xenomai.org

Am 13.07.2015 um 22:54 schrieb Gilles Chanteperdrix:
> On Mon, Jul 13, 2015 at 10:45:17PM +0200, Johann Obermayr wrote:
>> Am 13.07.2015 um 22:31 schrieb Gilles Chanteperdrix:
>>> On Mon, Jul 13, 2015 at 10:23:02PM +0200, Johann Obermayr wrote:
>>>> Am 13.07.2015 um 21:58 schrieb Gilles Chanteperdrix:
>>>>> On Mon, Jul 13, 2015 at 07:26:11PM +0200, Johann Obermayr wrote:
>>>>>> Am 13.07.2015 um 19:21 schrieb Gilles Chanteperdrix:
>>>>>>> Johann Obermayr wrote:
>>>>>>>> Am 13.07.2015 um 17:24 schrieb Gilles Chanteperdrix:
>>>>>>>>> Johann Obermayr wrote:
>>>>>>>>>> without your application, there are no large latencies.
>>>>>>>>>> with your application see frozen.txt (with latency -f)
>>>>>>>>> I am confused. You mean "our application", not "your application",
>>>>>>>>> right?
>>>>>>>>> lrtdrv_monitoring_irq is not part of the code delivered by the Xe=
nomai
>>>>>>>>> project.
>>>>>>>>>
>>>>>>>>>> We see the problem only if one task (background) is accessing th=
e SRAM
>>>>>>>>>> on your PCI-Card. if we stop this task, all is ok.
>>>>>>>>> Again: the Xenomai project does not make PCI-card. So, you probab=
ly mean
>>>>>>>>> "our PCI-Card"?
>>>>>>>> yes, our PCI-Card. (sorry for my bad english)
>>>>>>>>>> So we have a higher prior task (pci-locker), that interrupt the
>>>>>>>>>> background task, so that the pci bus get free.
>>>>>>>>> I am not sure I understand your explanations. But the trace is pr=
etty
>>>>>>>>> clear:
>>>>>>>>>
>>>>>>>>> At time -658 the timer is programmed to tick at -561.
>>>>>>>>>
>>>>>>>>>> :|  # event   tick@-561   -658	  0.112  xntimer_next_local_shot+=
0xca
>>>>>>>>>> :|  + func                -651	  0.145  lrtdrv_monitoring_irq+0x4
>>>>>>>>>> [sigmatek_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
>>>>>>>>>> :|  + end     0x000000ef  -651! 641.640  apic_timer_interrupt+0x=
52
>>>>>>>>>> (<102d0254>)
>>>>>>>>> But at that point the tick is delayed for 600us. And according to=
 the
>>>>>>>>> trace, the last traced function called before that delay is the f=
unction
>>>>>>>>>
>>>>>>>>> ltdrv_monitoring_irq.
>>>>>>>>>
>>>>>>>>> So, I do not know what this irq is doing, but I would suggest hav=
ing a
>>>>>>>>> close look at it.
>>>>>>>>>
>>>>>>>>>
>>>>>>>> hello,
>>>>>>>>
>>>>>>>> i have disable our lrtdrv_monitoring_irq.
>>>>>>>> Only have this callback
>>>>>>>> static void irq_hook_handler(unsigned int irq, unsigned int state)
>>>>>>>> {
>>>>>>>>       if (fpga_interrupt =3D=3D irq && state =3D=3D 0x01)
>>>>>>>>       {
>>>>>>>>           time_fpga_irq =3D rt_timer_tsc();
>>>>>>>>       }
>>>>>>>> }
>>>>>>>> same latency
>>>>>>> Maybe, but your trace does not contain enough points to see it. The=
 trace
>>>>>>> should at least contain the "tick@" event which gets missed, so tha=
t we
>>>>>>> can see how much the interrupt is delayed, and what was happening a=
t the
>>>>>>> time.
>>>>>>>
>>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Sorry, here with more points.
>>>>> Ok, what is irq_hook_handler ?
>>>>>
>>>> Ok.  on out PCI Card there is a FPGA. This FPGA generate am Interrupt =
to the
>>>> PC. But internal in the FPGA there
>>>> are different IRQ sources. One of them is our Tick.
>>>> So we measure the time from  __ipipe_handle_irq to the  our rtdm_irq_r=
equest
>>>> handler.
>>>> In our handler we can check, if it our Tick and than we can calc the c=
orrect
>>>> time to start our pci_locker task 50us before next Tick-irq.
>>>>
>>>> It's a callback function from some irq function ipipe_raise_irq,
>>>> __ipipe_do_IRQ, __ipipe_handle_irq
>>>> for our own tracing and it save the fpga irq time.
>>>> Only __ipipe_handle_irq have state 0x01 (begin irq) & state 0x02 at th=
e end
>>>> of the function.
>>> I see two weird things in your traces:
>>> - irq_hook_handler which is taking a lot of time
>>> - or some APIC related functions taking a lot of time.
>>>
>>> Are you sure your system is not one of those which disable the APIC
>>> during idle period. Is your system UP or SMP?
>>>
>> It's a SMP (Dual core Celeron)
> Real dual core, or hyperthreaded ?
Real dual core, no hyperthreading
>
>> Kernel cmdline
>> nohlt idle=3Dpoll xeno_hal.smi=3D1 isolcpus=3D0 irqaffinity=3D1 console=
=3DttyS0,115200
>> BOOT_IMAGE=3D/bzImage FirstUsbDrive=3DE console=3D/dev/null noconsole
>> root=3D/dev/sda2 rw
> Do you have the same problem without these options ?
> nohlt idle=3Dpoll xeno_hal.smi=3D1 isolcpus=3D0 irqaffinity=3D1
>
same result. but higher cpu load.

core 0 is reserver for our highprio task (see screenshot. realtime, =

cyclic) all other on core 1 (linux & visu).
we have on old mainboard with Intel 6 / C200 series. this board run =

without ACPI.
Our new board (Intel 8 / C220 series) does not run without ACPI. so we =

have enable ACPI in the kernel .config.
We also enable MSI, because of IRQ sharing.
-------------- next part --------------
I-pipe frozen back-tracing service on 3.10.0/ipipe release #1
------------------------------------------------------------
CPU: 0, Freeze: 749274436391 cycles, Trace Points: 2000 (+10)
Calibrated minimum trace-point overhead: 0.078 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||			  |	   +- NMI noise ('N')
 |||			  |	   |
	  Type	  User Val.   Time    Delay  Function (Parent)
:|   #end     0x80000001 -1670	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1670	  0.115  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func               -1670	  0.144  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func               -1670	  0.118  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func               -1670	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1670	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1670	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1670	  0.117  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func               -1669	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1669	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1669	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1669	  0.135  wait_domain_nrt_handler+0x3 [sigmat=
ek_lrt] (__ipipe_do_sync_stage+0xff)
:    #func               -1669	  0.124  __wake_up+0x8 (wait_domain_nrt_hand=
ler+0x33 [sigmatek_lrt])
:    #func               -1669	  0.142  _raw_spin_lock_irqsave+0x5 (__wake_=
up+0x1a)
:    #func               -1669	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1668	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1668	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1668	  0.163  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1668	  0.118  __wake_up_common+0x9 (__wake_up+0x2=
e)
:    #func               -1668	  0.117  ipipe_root_only+0x5 (__wake_up_comm=
on+0x1b)
:|   #begin   0x80000001 -1668	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1668	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1667	  0.115  __ipipe_spin_unlock_debug+0x3 (__wa=
ke_up+0x35)
:    #func               -1667	  0.124  _raw_spin_unlock_irqrestore+0x4 (__=
wake_up+0x3e)
:    #func               -1667	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1667	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1667	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1667	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1667	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1667	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1666	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1666	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1666	  0.127  irq_exit+0x3 (__ipipe_do_sync_stage=
+0x104)
:    #func               -1666	  0.115  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func               -1666	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1666	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1666	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1665	  0.152  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001 -1665	  0.127  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func               -1665	  0.175  idle_cpu+0x3 (irq_exit+0x50)
:    #func               -1665	  0.121  tick_nohz_irq_exit+0x4 (irq_exit+0x=
79)
:|   #begin   0x80000001 -1665	  0.152  debug_smp_processor_id+0x36 (tick_n=
ohz_irq_exit+0x13)
:|   #end     0x80000001 -1665	  0.129  debug_smp_processor_id+0x82 (tick_n=
ohz_irq_exit+0x13)
:    #func               -1665	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_irq_exit+0x27)
:|   #begin   0x80000001 -1665	  0.151  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001 -1664	  0.130  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func               -1664	  0.154  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001 -1664	  0.152  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001 -1664	  0.145  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001 -1664	  0.154  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1664	  0.176  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001 -1663	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001 -1663	  0.193  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func               -1663	  0.135  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func               -1663	  0.152  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001 -1663	  0.142  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001 -1663	  0.133  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func               -1663	  0.136  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001 -1662	  0.142  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001 -1662	  0.129  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func               -1662	  0.114  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func               -1662	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1662	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1662	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1662	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1661	  0.127  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func               -1661	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1661	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1661	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1661	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1661	  0.121  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001 -1661	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001 -1661	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func               -1660	  0.141  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func               -1660	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1660	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1660	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1660	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1660	  0.115  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func               -1660	  0.124  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func               -1660	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1659	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1659	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1659	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1659	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1659	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1659	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1659	  0.182  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1658	  0.115  hrtimer_start+0x3 (__tick_nohz_idle=
_enter+0x2e1)
:    #func               -1658	  0.114  __hrtimer_start_range_ns+0x9 (hrtim=
er_start+0x14)
:    #func               -1658	  0.120  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func               -1658	  0.138  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1658	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1658	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1658	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1657	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1657	  0.141  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001 -1657	  0.129  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func               -1657	  0.135  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:|   #begin   0x80000001 -1657	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001 -1657	  0.138  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func               -1657	  0.117  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func               -1657	  0.146  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:    #func               -1656	  0.112  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1656	  0.126  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1656	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1656	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1656	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1656	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1656	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1655	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1655	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1655	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1655	  0.148  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001 -1655	  0.151  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001 -1655	  0.132  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func               -1655	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001 -1654	  0.152  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1654	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1654	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1654	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1654	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1654	  0.167  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1654	  0.124  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x117)
:|   #begin   0x80000000 -1654	  0.193  hard_local_irq_disable+0x17 (__ipip=
e_do_sync_stage+0x11c)
:|   +func               -1653	  0.179  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x00000051 -1653	  0.231  common_interrupt+0x51 (__ipipe_halt=
_root+0x43)
:|   +begin   0x80000001 -1653	  0.152  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1653	  0.184  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1653	  0.145  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1652	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1652	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1652	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1652	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1652	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1652	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1652	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1652	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1651	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1651	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1651	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1651	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1651	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1651	  0.133  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1651	  0.144  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1650	  0.144  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1650	  0.117  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1650	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1650	  0.123  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1650	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1650	  0.132  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1650	  0.146  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1649	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1649	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1649	  0.121  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1649	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1649	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1649	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1649	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1649	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1648	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1648	  0.118  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1648	  0.120  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1648	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1648	  0.127  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1648	  0.121  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1648	  0.144  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1647+   9.725  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1638	  0.132  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1638	  0.158  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1637	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1637	  0.121  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1637	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1637	  0.149  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1637	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1637	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1637	  0.173  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1636	  0.149  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1636	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1636	  0.139  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1636	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1636	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1538 -1636	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1636	  0.152  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1635	  0.259  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1635	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1635	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1635	  0.152  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1635	  0.313  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1634	  0.322  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1634	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1634	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1634	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1634	  0.237  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1633	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1633	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1633	  0.224  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1633	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1633	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1633	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1632	  0.351  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1632	  0.117  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1632	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1632	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1632	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1632	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1631	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1631	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1631	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1631	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1631	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1631	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1631	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1631	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1630	  0.169  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1630	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1630	  0.299  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1630	  0.221  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1630	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1629	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1629	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1629	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1629	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1629	  0.201  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1629	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1628	  0.215  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1628	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1628	  0.158  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1628	  0.146  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1628	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1628	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1627	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1627	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1627	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1627	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1627	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1627	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1627	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1626	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1626	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1626	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1626	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1626	  0.133  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1626	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1626	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1625	  0.115  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1625	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1625	  0.121  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1625	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1625	  0.133  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1625	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1625	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1625	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1624	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1624	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1624	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1624	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1624	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1624	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1624	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1623	  0.115  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1623	  0.123  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1623	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1623	  0.129  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1623	  0.121  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1623	  0.142  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1623!  84.994  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1538	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1538	  0.149  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1537	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1537	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1537	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1537	  0.139  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1537	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1537	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1537	  0.172  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1536	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1536	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1536	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1536	  0.207  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1536	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1438 -1536	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1536	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1536	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1535	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1535	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1535	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1535	  0.310  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1535	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1534	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1534	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1534	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1534	  0.216  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1534	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1533	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1533	  0.209  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1533	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1533	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1533	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1533	  0.304  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1532	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1532	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1532	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1532	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1532	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1532	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1531	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1531	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1531	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1531	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1531	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1531	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1531	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1531	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1530	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1530	  0.288  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1530	  0.218  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1530	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1530	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1529	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1529	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1529	  0.277  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1529	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1529	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1529	  0.215  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1528	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1528	  0.158  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1528	  0.148  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1528	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1528	  0.132  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1528	  0.133  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1527	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1527	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1527	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1527	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1527	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1527	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1527	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1527	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1526	  0.193  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1526	  0.121  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1526	  0.139  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1526	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1526	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1526	  0.114  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1526	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1525	  0.123  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1525	  0.145  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1525	  0.132  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1525	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1525	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1525	  0.129  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1525	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1525	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1524	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1524	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1524	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1524	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1524	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1524	  0.115  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1524	  0.120  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1523	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1523	  0.129  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1523	  0.118  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1523	  0.144  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1523!  85.187  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1438	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1438	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1437	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1437	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1437	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1437	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1437	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1437	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1437	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1436	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1436	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1436	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1436	  0.209  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1436	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1338 -1436	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1436	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1436	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1435	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1435	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1435	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1435	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1435	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1434	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1434	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1434	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1434	  0.218  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1434	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1433	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1433	  0.209  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1433	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1433	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1433	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1433	  0.302  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1432	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1432	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1432	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1432	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1432	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1432	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1431	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1431	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1431	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1431	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1431	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1431	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1431	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1431	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1430	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1430	  0.288  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1430	  0.218  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1430	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1430	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1429	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1429	  0.130  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1429	  0.277  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1429	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1429	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1429	  0.215  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1428	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1428	  0.160  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1428	  0.148  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1428	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1428	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1428	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1427	  0.141  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1427	  0.132  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1427	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1427	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1427	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1427	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1427	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1427	  0.126  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1426	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1426	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1426	  0.135  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1426	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1426	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1426	  0.114  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1426	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1425	  0.123  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1425	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1425	  0.132  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1425	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1425	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1425	  0.129  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1425	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1425	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1424	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1424	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1424	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1424	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1424	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1424	  0.115  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1424	  0.120  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1423	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1423	  0.129  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1423	  0.118  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1423	  0.142  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1423!  85.218  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1338	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1338	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1337	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1337	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1337	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1337	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1337	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1337	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1337	  0.172  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1337	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1336	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1336	  0.135  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1336	  0.198  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1336	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1238 -1336	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1336	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1336	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1335	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1335	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1335	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1335	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1335	  0.301  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1334	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1334	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1334	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1334	  0.218  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1334	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1333	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1333	  0.207  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1333	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1333	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1333	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1333	  0.304  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1332	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1332	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1332	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1332	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1332	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1332	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1332	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1331	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1331	  0.118  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1331	  0.117  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1331	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1331	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1331	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1331	  0.169  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1330	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1330	  0.291  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1330	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1330	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1330	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1329	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1329	  0.132  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1329	  0.282  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1329	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1329	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1329	  0.215  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1328	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1328	  0.158  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1328	  0.148  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1328	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1328	  0.132  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1328	  0.133  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1328	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1327	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1327	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1327	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1327	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1327	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1327	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1327	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1326	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1326	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1326	  0.135  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1326	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1326	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1326	  0.114  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1326	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1325	  0.123  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1325	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1325	  0.132  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1325	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1325	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1325	  0.129  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1325	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1325	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1324	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1324	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1324	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1324	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1324	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1324	  0.114  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1324	  0.121  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1323	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1323	  0.127  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1323	  0.120  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1323	  0.142  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1323!  85.220  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1238	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1238	  0.149  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1237	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1237	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1237	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1237	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1237	  0.169  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1237	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1237	  0.172  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1237	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1236	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1236	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1236	  0.187  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1236	  0.139  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1138 -1236	  0.114  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1236	  0.132  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1236	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1235	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1235	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1235	  0.129  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1235	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1235	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1234	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1234	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1234	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1234	  0.218  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1234	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1233	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1233	  0.207  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1233	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1233	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1233	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1233	  0.304  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1232	  0.117  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1232	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1232	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1232	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1232	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1232	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1232	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1231	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1231	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1231	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1231	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1231	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1231	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1231	  0.169  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1230	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1230	  0.135  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1230	  0.142  xntimer_next_local_shot+0x9 (__xnpo=
d_schedule+0x1d6)
:|  # event   tick@-1212 -1230	  0.114  xntimer_next_local_shot+0xca (__xnp=
od_schedule+0x1d6)
:|  # func               -1230	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1230	  0.366  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1229	  0.218  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1229	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1229	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1229	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1229	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1229	  0.282  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1228	  0.187  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1228	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1228	  0.215  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1228	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1228	  0.158  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1227	  0.148  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1227	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1227	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1227	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1227	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1227	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1227	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1227	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1226	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1226	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1226	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1226	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1226	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1226	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1226	  0.135  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1225	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1225	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1225	  0.115  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1225	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1225	  0.121  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1225	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1225	  0.130  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1224	  0.146  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1224	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1224	  0.129  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1224	  0.121  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1224	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1224	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1224	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1224	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1223	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1223	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1223	  0.114  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1223	  0.121  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1223	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1223	  0.126  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1223	  0.120  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1223	  0.144  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1222!  11.448  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1211	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1211	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1211	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1211	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1210	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1210	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1210	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1210	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1210	  0.169  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1210	  0.151  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1210	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1138 -1209	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1209	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1209	  0.268  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1209	  0.135  xnintr_host_tick+0x3 (xnintr_clock_=
handler+0x152)
:|  # func               -1209	  0.230  __ipipe_set_irq_pending+0x6 (xnarch=
_relay_tick+0x44)
:|   +func               -1209	  0.187  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1208	  0.152  __ipipe_do_sync_stage+0x9 (__ipipe_=
do_sync_pipeline+0x5e)
:|   #end     0x80000000 -1208	  0.126  hard_local_irq_enable+0x16 (__ipipe=
_do_sync_stage+0xa1)
:    #func               -1208	  0.142  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x146)
:    #func               -1208	  0.115  __ipipe_do_IRQ+0x6 (__ipipe_do_sync=
_stage+0x15c)
:    #func               -1208	  0.115  __ipipe_get_ioapic_irq_vector+0x3 (=
__ipipe_do_IRQ+0x20)
:    #func               -1208	  0.121  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_do_IRQ+0x38)
:    #func               -1208	  0.112  smp_apic_timer_interrupt+0x5 (__ipi=
pe_do_IRQ+0x58)
:    #func               -1207	  0.120  irq_enter+0x4 (smp_apic_timer_inter=
rupt+0x21)
:|   #begin   0x80000001 -1207	  0.154  debug_smp_processor_id+0x36 (irq_en=
ter+0xe)
:|   #end     0x80000001 -1207	  0.130  debug_smp_processor_id+0x82 (irq_en=
ter+0xe)
:    #func               -1207	  0.146  rcu_irq_enter+0x7 (irq_enter+0x15)
:|   #begin   0x80000001 -1207	  0.142  debug_smp_processor_id+0x36 (rcu_ir=
q_enter+0x1e)
:|   #end     0x80000001 -1207	  0.130  debug_smp_processor_id+0x82 (rcu_ir=
q_enter+0x1e)
:    #func               -1207	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_irq_enter+0x70)
:|   #begin   0x80000001 -1206	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1206	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1206	  0.115  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1206	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1206	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1206	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1206	  0.114  local_bh_disable+0x3 (irq_enter+0x3=
9)
:    #func               -1206	  0.117  add_preempt_count+0x4 (local_bh_dis=
able+0x12)
:    #func               -1205	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1205	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1205	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1205	  0.114  tick_check_idle+0x8 (irq_enter+0x40)
:    #func               -1205	  0.118  tick_check_oneshot_broadcast+0x3 (t=
ick_check_idle+0x19)
:    #func               -1205	  0.149  ktime_get+0x9 (tick_check_idle+0x31)
:    #func               -1205	  0.115  tick_nohz_stop_idle+0x4 (tick_check=
_idle+0x48)
:    #func               -1205	  0.115  update_ts_time_stats+0x9 (tick_nohz=
_stop_idle+0x20)
:    #func               -1204	  0.129  nr_iowait_cpu+0x3 (update_ts_time_s=
tats+0x31)
:|   #begin   0x80000001 -1204	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_idle+0x53)
:|   #end     0x80000001 -1204	  0.160  debug_smp_processor_id+0x82 (tick_c=
heck_idle+0x53)
:    #func               -1204	  0.117  tick_do_update_jiffies64+0x9 (tick_=
check_idle+0x84)
:    #func               -1204	  0.114  ipipe_restore_root+0x4 (tick_check_=
idle+0x97)
:    #func               -1204	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1204	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1203	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1203	  0.117  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func               -1203	  0.130  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func               -1203	  0.114  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func               -1203	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1203	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1203	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1203	  0.115  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func               -1202	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1202	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1202	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1202	  0.142  debug_smp_processor_id+0x36 (smp_ap=
ic_timer_interrupt+0x26)
:|   #end     0x80000001 -1202	  0.154  debug_smp_processor_id+0x82 (smp_ap=
ic_timer_interrupt+0x26)
:    #func               -1202	  0.124  hrtimer_interrupt+0x9 (smp_apic_tim=
er_interrupt+0x58)
:|   #begin   0x80000001 -1202	  0.152  debug_smp_processor_id+0x36 (hrtime=
r_interrupt+0x1a)
:|   #end     0x80000001 -1201	  0.133  debug_smp_processor_id+0x82 (hrtime=
r_interrupt+0x1a)
:    #func               -1201	  0.111  _raw_spin_lock+0x4 (hrtimer_interru=
pt+0x41)
:    #func               -1201	  0.124  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1201	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1201	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1201	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1201	  0.163  ktime_get_update_offsets+0x9 (hrtim=
er_interrupt+0x61)
:    #func               -1200	  0.132  __run_hrtimer+0x9 (hrtimer_interrup=
t+0x101)
:    #func               -1200	  0.164  __remove_hrtimer+0x9 (__run_hrtimer=
+0x4b)
:    #func               -1200	  0.127  _raw_spin_unlock+0x3 (__run_hrtimer=
+0x59)
:    #func               -1200	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1200	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1200	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1200	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1199	  0.117  hrtimer_wakeup+0x3 (__run_hrtimer+0=
x8e)
:    #func               -1199	  0.118  wake_up_process+0x4 (hrtimer_wakeup=
+0x1d)
:    #func               -1199	  0.112  try_to_wake_up+0x9 (wake_up_process=
+0x2e)
:    #func               -1199	  0.142  _raw_spin_lock_irqsave+0x5 (try_to_=
wake_up+0x25)
:    #func               -1199	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1199	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1199	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1199	  0.160  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1198	  0.151  task_waking_fair+0x6 (try_to_wake_u=
p+0xc7)
:    #func               -1198	  0.120  select_task_rq_fair+0x9 (select_tas=
k_rq+0x15)
:|   #begin   0x80000001 -1198	  0.151  debug_smp_processor_id+0x36 (select=
_task_rq_fair+0x1c)
:|   #end     0x80000001 -1198	  0.141  debug_smp_processor_id+0x82 (select=
_task_rq_fair+0x1c)
:    #func               -1198	  0.138  __rcu_read_lock+0x3 (select_task_rq=
_fair+0x72)
:    #func               -1198	  0.120  idle_cpu+0x3 (select_task_rq_fair+0=
x250)
:    #func               -1198	  0.139  __rcu_read_unlock+0x4 (select_task_=
rq_fair+0x4ac)
:|   #begin   0x80000001 -1197	  0.142  debug_smp_processor_id+0x36 (try_to=
_wake_up+0x106)
:|   #end     0x80000001 -1197	  0.126  debug_smp_processor_id+0x82 (try_to=
_wake_up+0x106)
:    #func               -1197	  0.120  cpus_share_cache+0x4 (try_to_wake_u=
p+0x10d)
:    #func               -1197	  0.112  _raw_spin_lock+0x4 (try_to_wake_up+=
0x15a)
:    #func               -1197	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1197	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1197	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1197	  0.163  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1196	  0.117  ttwu_do_activate.constprop.91+0x5 (=
try_to_wake_up+0x163)
:    #func               -1196	  0.121  activate_task+0x4 (ttwu_do_activate=
.constprop.91+0x2b)
:    #func               -1196	  0.115  enqueue_task+0x8 (activate_task+0x2=
1)
:    #func               -1196	  0.132  update_rq_clock+0x6 (enqueue_task+0=
x1a)
:|   #begin   0x80000001 -1196	  0.154  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1196	  0.227  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func               -1196	  0.124  enqueue_task_fair+0x9 (enqueue_task=
+0x28)
:    #func               -1195	  0.120  update_curr+0x9 (enqueue_task_fair+=
0x59)
:    #func               -1195	  0.121  place_entity+0x9 (enqueue_task_fair=
+0xa4)
:    #func               -1195	  0.118  __enqueue_entity+0x7 (enqueue_task_=
fair+0xb2)
:    #func               -1195	  0.118  hrtick_update+0x5 (enqueue_task_fai=
r+0xc7)
:    #func               -1195	  0.117  ttwu_do_wakeup+0x6 (ttwu_do_activat=
e.constprop.91+0x50)
:    #func               -1195	  0.121  check_preempt_curr+0x7 (ttwu_do_wak=
eup+0x14)
:    #func               -1195	  0.141  resched_task+0x5 (check_preempt_cur=
r+0x3c)
:|   #begin   0x80000001 -1195	  0.151  debug_smp_processor_id+0x36 (resche=
d_task+0x48)
:|   #end     0x80000001 -1194	  0.136  debug_smp_processor_id+0x82 (resche=
d_task+0x48)
:    #func               -1194	  0.130  _raw_spin_unlock+0x3 (try_to_wake_u=
p+0x16f)
:    #func               -1194	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1194	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1194	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1194	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1194	  0.115  __ipipe_spin_unlock_debug+0x3 (try_=
to_wake_up+0x177)
:    #func               -1193	  0.124  _raw_spin_unlock_irqrestore+0x4 (tr=
y_to_wake_up+0x182)
:    #func               -1193	  0.115  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1193	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1193	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1193	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1193	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1193	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1193	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1192	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1192	  0.117  _raw_spin_lock+0x4 (__run_hrtimer+0=
xc5)
:    #func               -1192	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1192	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1192	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1192	  0.163  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1192	  0.124  _raw_spin_unlock+0x3 (hrtimer_inter=
rupt+0x125)
:    #func               -1191	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1191	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1191	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1191	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1191	  0.121  tick_program_event+0x4 (hrtimer_int=
errupt+0x13d)
:    #func               -1191	  0.118  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func               -1191	  0.151  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func               -1191	  0.121  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000 -1190	  0.163  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func               -1190	  0.139  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func               -1190	  0.195  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func               -1190	  0.132  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000 -1190	  0.145  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func               -1190	  0.130  irq_exit+0x3 (smp_apic_timer_interr=
upt+0x5d)
:    #func               -1190	  0.115  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func               -1189	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1189	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1189	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1189	  0.142  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001 -1189	  0.127  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func               -1189	  0.144  idle_cpu+0x3 (irq_exit+0x50)
:    #func               -1189	  0.146  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001 -1188	  0.142  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001 -1188	  0.130  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func               -1188	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001 -1188	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1188	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1188	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1188	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1187	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1187	  0.314  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +func               -1187	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1187	  0.224  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1187	  0.144  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1186	  0.172  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1186	  0.145  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1186	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1186	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1186	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1186	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1186	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1185	  0.115  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1185	  0.123  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1185	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1185	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1185	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1185	  0.130  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1185	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1185	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1184	  0.139  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:    +func               -1184	  0.121  tick_nohz_idle_exit+0x7 (cpu_startu=
p_entry+0x148)
:|   +begin   0x80000001 -1184	  0.142  debug_smp_processor_id+0x36 (tick_n=
ohz_idle_exit+0x16)
:|   +end     0x80000001 -1184	  0.144  debug_smp_processor_id+0x82 (tick_n=
ohz_idle_exit+0x16)
:    #func               -1184	  0.148  ktime_get+0x9 (tick_nohz_idle_exit+=
0x62)
:    #func               -1184	  0.115  tick_do_update_jiffies64+0x9 (tick_=
nohz_idle_exit+0x8b)
:    #func               -1184	  0.123  update_cpu_load_nohz+0x5 (tick_nohz=
_idle_exit+0x90)
:|   #begin   0x80000001 -1183	  0.142  debug_smp_processor_id+0x36 (update=
_cpu_load_nohz+0x14)
:|   #end     0x80000001 -1183	  0.141  debug_smp_processor_id+0x82 (update=
_cpu_load_nohz+0x14)
:    #func               -1183	  0.124  _raw_spin_lock+0x4 (update_cpu_load=
_nohz+0x2d)
:    #func               -1183	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1183	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1183	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1183	  0.146  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1182	  0.136  __update_cpu_load+0x9 (update_cpu_l=
oad_nohz+0x40)
:    #func               -1182	  0.121  sched_avg_update+0x9 (__update_cpu_=
load+0xa9)
:    #func               -1182	  0.129  _raw_spin_unlock+0x3 (update_cpu_lo=
ad_nohz+0x47)
:    #func               -1182	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1182	  0.120  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1182	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1182	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1182	  0.121  calc_load_exit_idle+0x4 (tick_nohz_=
idle_exit+0x95)
:|   #begin   0x80000001 -1181	  0.141  debug_smp_processor_id+0x36 (calc_l=
oad_exit_idle+0x13)
:|   #end     0x80000001 -1181	  0.142  debug_smp_processor_id+0x82 (calc_l=
oad_exit_idle+0x13)
:    #func               -1181	  0.111  hrtimer_cancel+0x4 (tick_nohz_idle_=
exit+0xa9)
:    #func               -1181	  0.114  hrtimer_try_to_cancel+0x7 (hrtimer_=
cancel+0x12)
:    #func               -1181	  0.115  lock_hrtimer_base.isra.17+0x6 (hrti=
mer_try_to_cancel+0x1e)
:    #func               -1181	  0.142  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1181	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1181	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1180	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1180	  0.163  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1180	  0.151  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001 -1180	  0.132  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func               -1180	  0.167  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:    #func               -1180	  0.114  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1180	  0.120  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1179	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1179	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1179	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1179	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1179	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1179	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1179	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1178	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1178	  0.149  hrtimer_forward+0xc (tick_nohz_idle=
_exit+0xd2)
:    #func               -1178	  0.123  ktime_add_safe+0x6 (hrtimer_forward=
+0x103)
:    #func               -1178	  0.120  ktime_add_safe+0x6 (hrtimer_forward=
+0x11d)
:    #func               -1178	  0.115  hrtimer_start_range_ns+0x3 (hrtimer=
_start_expires.constprop.9+0x1d)
:    #func               -1178	  0.114  __hrtimer_start_range_ns+0x9 (hrtim=
er_start_range_ns+0x15)
:    #func               -1178	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func               -1178	  0.161  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1177	  0.118  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1177	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1177	  0.181  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1177	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1177	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001 -1177	  0.146  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func               -1177	  0.117  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func               -1176	  0.176  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:|   #begin   0x80000001 -1176	  0.144  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x16d)
:|   #end     0x80000001 -1176	  0.135  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x16d)
:|   #begin   0x80000001 -1176	  0.152  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x192)
:|   #end     0x80000001 -1176	  0.133  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x192)
:    #func               -1176	  0.114  tick_program_event+0x4 (__hrtimer_s=
tart_range_ns+0x20a)
:    #func               -1176	  0.120  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func               -1175	  0.149  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func               -1175	  0.118  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000 -1175	  0.154  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func               -1175	  0.126  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func               -1175	  0.181  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func               -1175	  0.132  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000 -1175	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:    #func               -1175	  0.117  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1174	  0.126  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1174	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1174	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1174	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1174	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1174	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1174	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1173	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1173	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1173	  0.115  account_idle_ticks+0x3 (tick_nohz_i=
dle_exit+0x122)
:    #func               -1173	  0.127  account_idle_time+0x6 (account_idle=
_ticks+0xd)
:|   #begin   0x80000001 -1173	  0.142  debug_smp_processor_id+0x36 (accoun=
t_idle_time+0x1c)
:|   #end     0x80000001 -1173	  0.135  debug_smp_processor_id+0x82 (accoun=
t_idle_time+0x1c)
:|   #begin   0x80000001 -1173	  0.152  debug_smp_processor_id+0x36 (accoun=
t_idle_time+0x28)
:|   #end     0x80000001 -1172	  0.130  debug_smp_processor_id+0x82 (accoun=
t_idle_time+0x28)
:    #func               -1172	  0.118  ipipe_unstall_root+0x3 (tick_nohz_i=
dle_exit+0x127)
:|   #begin   0x80000000 -1172	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1172	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1172	  0.123  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1172	  0.118  schedule_preempt_disabled+0x3 (cpu_=
startup_entry+0x14d)
:    +func               -1172	  0.114  sub_preempt_count+0x4 (schedule_pre=
empt_disabled+0x12)
:    +func               -1172	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1171	  0.172  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1171	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1171	  0.114  schedule+0x3 (schedule_preempt_disa=
bled+0x17)
:    +func               -1171	  0.115  __schedule+0x9 (schedule+0x18)
:    +func               -1171	  0.115  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func               -1171	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1171	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1171	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1170	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001 -1170	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func               -1170	  0.115  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func               -1170	  0.144  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func               -1170	  0.124  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func               -1170	  0.111  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1170	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1169	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1169	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1169	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1169	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1169	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1169	  0.118  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1169	  0.118  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001 -1169	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1168	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1168	  0.129  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func               -1168	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func               -1168	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1168	  0.173  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1168	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1168	  0.138  pre_schedule_idle+0x3 (__schedule+0=
x242)
:    #func               -1167	  0.117  put_prev_task_idle+0x3 (__schedule+=
0x275)
:    #func               -1167	  0.117  pick_next_task_fair+0x7 (__schedule=
+0x28c)
:    #func               -1167	  0.114  clear_buddies+0x5 (pick_next_task_f=
air+0x8c)
:    #func               -1167	  0.135  set_next_entity+0x6 (pick_next_task=
_fair+0x98)
:    #func               -1167	  0.120  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func               -1167	  0.145  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func               -1167	  0.118  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func               -1167	  0.124  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func               -1166	  0.173  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x8d [sigmatek_lrt])
:|   #begin   0x80000000 -1166	  0.194  __schedule+0x3a3 (schedule+0x18)
:|   #func               -1166	  0.227  __switch_to+0x9 (__schedule+0x50a)
:|   #func               -1166	  0.149  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000 -1166	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001 -1166	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001 -1165	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func               -1165	  0.121  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func               -1165	  0.124  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func               -1165	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000 -1165	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1165	  0.185  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1165	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1164	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func               -1164	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1164	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1164	  0.182  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1164	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001 -1164	  0.127  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func               -1164	  0.115  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func               -1163	  0.124  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1163	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1163	  0.179  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1163	  0.126  hrtimer_cancel+0x4 (schedule_hrtime=
out_range_clock+0x9e)
:    +func               -1163	  0.117  hrtimer_try_to_cancel+0x7 (hrtimer_=
cancel+0x12)
:    +func               -1163	  0.121  lock_hrtimer_base.isra.17+0x6 (hrti=
mer_try_to_cancel+0x1e)
:    +func               -1163	  0.148  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1163	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1162	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1162	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1162	  0.146  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1162	  0.124  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1162	  0.123  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1162	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1162	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1161	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1161	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1161	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1161	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1161	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1161	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1161	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1161	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1160	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1160	  0.325  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1160	  0.138  fget_light+0x6 (do_select+0x2aa)
:    +func               -1160	  0.155  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1160	  0.139  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1159	  0.161  sock_poll+0x5 (do_select+0x30f)
:    +func               -1159	  0.144  tcp_poll+0x6 (sock_poll+0x17)
:    +func               -1159	  0.138  fput+0x5 (do_select+0x327)
:    +func               -1159	  0.115  fget_light+0x6 (do_select+0x2aa)
:    +func               -1159	  0.146  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1159	  0.123  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1159	  0.161  sock_poll+0x5 (do_select+0x30f)
:    +func               -1158	  0.114  udp_poll+0x6 (sock_poll+0x17)
:    +func               -1158	  0.145  datagram_poll+0x6 (udp_poll+0x14)
:    +func               -1158	  0.135  fput+0x5 (do_select+0x327)
:    +func               -1158	  0.120  _cond_resched+0x3 (do_select+0x3f1)
:    +func               -1158	  0.118  poll_freewait+0x9 (do_select+0x4ab)
:    +func               -1158	  0.111  remove_wait_queue+0x6 (poll_freewai=
t+0x30)
:    +func               -1158	  0.144  _raw_spin_lock_irqsave+0x5 (remove_=
wait_queue+0x14)
:    #func               -1158	  0.123  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1157	  0.121  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1157	  0.157  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1157	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1157	  0.121  __ipipe_spin_unlock_debug+0x3 (remo=
ve_wait_queue+0x36)
:    #func               -1157	  0.121  _raw_spin_unlock_irqrestore+0x4 (re=
move_wait_queue+0x3f)
:    #func               -1157	  0.120  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1157	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1157	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1156	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1156	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1156	  0.132  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1156	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1156	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1156	  0.121  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1156	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1155	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1155	  0.136  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1155	  0.133  fput+0x5 (poll_freewait+0x38)
:    +func               -1155	  0.114  remove_wait_queue+0x6 (poll_freewai=
t+0x30)
:    +func               -1155	  0.141  _raw_spin_lock_irqsave+0x5 (remove_=
wait_queue+0x14)
:    #func               -1155	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1155	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1155	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1154	  0.148  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1154	  0.121  __ipipe_spin_unlock_debug+0x3 (remo=
ve_wait_queue+0x36)
:    #func               -1154	  0.120  _raw_spin_unlock_irqrestore+0x4 (re=
move_wait_queue+0x3f)
:    #func               -1154	  0.120  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1154	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1154	  0.167  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1154	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1153	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1153	  0.132  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1153	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1153	  0.120  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1153	  0.120  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1153	  0.123  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1153	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1152	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1152	  0.151  fput+0x5 (poll_freewait+0x38)
:    +func               -1152	  0.121  ipipe_root_only+0x5 (set_fd_set+0x1=
7)
:|   +begin   0x80000001 -1152	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1152	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1152	  0.169  __copy_to_user_ll+0x6 (set_fd_set+0=
x2d)
:    +func               -1152	  0.126  poll_select_copy_remaining+0x9 (SyS=
_select+0x90)
:    +func               -1151	  0.154  ktime_get_ts+0x9 (poll_select_copy_=
remaining+0x46)
:    +func               -1151	  0.135  set_normalized_timespec+0x4 (poll_s=
elect_copy_remaining+0x60)
:    +func               -1151	  0.120  copy_to_user+0x9 (poll_select_copy_=
remaining+0xb0)
:    +func               -1151	  0.118  ipipe_root_only+0x5 (copy_to_user+0=
x35)
:|   +begin   0x80000001 -1151	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1151	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1151	  0.711  __copy_to_user_ll+0x6 (copy_to_user=
+0x44)
:    +func               -1150	  0.130  __ipipe_syscall_root+0x5 (system_ca=
ll+0x30)
:    +func               -1150	  0.130  SyS_select+0x9 (syscall_call+0x7)
:    +func               -1150	  0.120  _copy_from_user+0x7 (SyS_select+0x3=
9)
:    +func               -1150	  0.118  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001 -1149	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1149	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1149	  0.157  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func               -1149	  0.120  poll_select_set_timeout+0x6 (SyS_se=
lect+0x60)
:    +func               -1149	  0.157  ktime_get_ts+0x9 (poll_select_set_t=
imeout+0x3a)
:    +func               -1149	  0.115  timespec_add_safe+0x9 (poll_select_=
set_timeout+0x46)
:    +func               -1149	  0.129  set_normalized_timespec+0x4 (timesp=
ec_add_safe+0x2f)
:    +func               -1148	  0.121  core_sys_select+0xc (SyS_select+0x8=
0)
:    +func               -1148	  0.114  __rcu_read_lock+0x3 (core_sys_selec=
t+0x31)
:    +func               -1148	  0.129  __rcu_read_unlock+0x4 (core_sys_sel=
ect+0x47)
:    +func               -1148	  0.114  _copy_from_user+0x7 (get_fd_set+0x1=
b)
:    +func               -1148	  0.129  ipipe_root_only+0x5 (_copy_from_use=
r+0x30)
:|   +begin   0x80000001 -1148	  0.173  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1148	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1148	  0.218  __copy_from_user_ll+0x6 (_copy_from=
_user+0x3c)
:    +func               -1147	  0.123  do_select+0xc (core_sys_select+0x12=
b)
:    +func               -1147	  0.188  __rcu_read_lock+0x3 (do_select+0x23)
:    +func               -1147	  0.123  __rcu_read_unlock+0x4 (do_select+0x=
e5)
:    +func               -1147	  0.121  poll_initwait+0x3 (do_select+0xfd)
:    +func               -1147	  0.118  select_estimate_accuracy+0x9 (do_se=
lect+0x160)
:    +func               -1147	  0.151  ktime_get_ts+0x9 (select_estimate_a=
ccuracy+0x9f)
:    +func               -1146	  0.117  set_normalized_timespec+0x4 (select=
_estimate_accuracy+0xb9)
:    +func               -1146	  0.194  task_nice+0x3 (select_estimate_accu=
racy+0x2d)
:    +func               -1146	  0.136  fget_light+0x6 (do_select+0x2aa)
:    +func               -1146	  0.133  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1146	  0.123  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1146	  0.129  sock_poll+0x5 (do_select+0x30f)
:    +func               -1146	  0.117  tcp_poll+0x6 (sock_poll+0x17)
:    +func               -1146	  0.127  __pollwait+0x7 (tcp_poll+0x3a)
:    +func               -1145	  0.120  add_wait_queue+0x6 (__pollwait+0xa2)
:    +func               -1145	  0.145  _raw_spin_lock_irqsave+0x5 (add_wai=
t_queue+0x17)
:    #func               -1145	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1145	  0.123  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1145	  0.157  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1145	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1145	  0.124  __ipipe_spin_unlock_debug+0x3 (add_=
wait_queue+0x35)
:    #func               -1144	  0.124  _raw_spin_unlock_irqrestore+0x4 (ad=
d_wait_queue+0x3e)
:    #func               -1144	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1144	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1144	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1144	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1144	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1144	  0.130  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1144	  0.190  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1143	  0.120  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1143	  0.120  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1143	  0.123  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1143	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1143	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1143	  0.130  fput+0x5 (do_select+0x327)
:    +func               -1143	  0.118  fget_light+0x6 (do_select+0x2aa)
:    +func               -1142	  0.135  __rcu_read_lock+0x3 (fget_light+0x4=
a)
:    +func               -1142	  0.123  __rcu_read_unlock+0x4 (fget_light+0=
x7b)
:    +func               -1142	  0.135  sock_poll+0x5 (do_select+0x30f)
:    +func               -1142	  0.118  udp_poll+0x6 (sock_poll+0x17)
:    +func               -1142	  0.115  datagram_poll+0x6 (udp_poll+0x14)
:    +func               -1142	  0.126  __pollwait+0x7 (datagram_poll+0x3a)
:    +func               -1142	  0.118  add_wait_queue+0x6 (__pollwait+0xa2)
:    +func               -1142	  0.166  _raw_spin_lock_irqsave+0x5 (add_wai=
t_queue+0x17)
:    #func               -1141	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1141	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1141	  0.158  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1141	  0.145  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1141	  0.123  __ipipe_spin_unlock_debug+0x3 (add_=
wait_queue+0x35)
:    #func               -1141	  0.124  _raw_spin_unlock_irqrestore+0x4 (ad=
d_wait_queue+0x3e)
:    #func               -1141	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1140	  0.121  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1140	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1140	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1140	  0.123  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1140	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1140	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1140	  0.120  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1139	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1139	  0.123  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1139	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1139	  0.160  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1139	  0.129  fput+0x5 (do_select+0x327)
:    +func               -1139	  0.126  _cond_resched+0x3 (do_select+0x3f1)
:    +func               -1139	  0.123  poll_schedule_timeout+0x6 (do_selec=
t+0x48b)
:    +func               -1139	  0.118  schedule_hrtimeout_range+0x3 (poll_=
schedule_timeout+0x3b)
:    +func               -1138	  0.121  schedule_hrtimeout_range_clock+0x9 =
(schedule_hrtimeout_range+0xf)
:    +func               -1138	  0.141  hrtimer_init+0x9 (schedule_hrtimeou=
t_range_clock+0x55)
:    +func               -1138	  0.270  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:|   +begin   0x000000ef -1138	  0.146  apic_timer_interrupt+0x3a (__ipipe_=
trace+0x40b)
:|   +func               -1138	  0.157  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1138	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1137	  0.120  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1137	  0.129  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1137	  0.146  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1137	  0.170  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1137	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1137	  0.173  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1137	  0.136  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1136	  0.123  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1136	  0.135  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1136	  0.194  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1136	  0.141  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1038 -1136	  0.114  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1136	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1136	  0.279  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1135	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1135	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1135	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1135	  0.308  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1135	  0.325  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1134	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1134	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1134	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1134	  0.242  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1134	  0.164  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1133	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1133	  0.221  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1133	  0.166  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1133	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1133	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1133	  0.372  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1132	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1132	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1132	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1132	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1132	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1132	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1131	  0.136  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1131	  0.132  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1131	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1131	  0.120  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1131	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1131	  0.227  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1131	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1130	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1130	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1130	  0.292  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1130	  0.271  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  582] TCP-Lis -1 -1130	  0.207  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1129	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1129	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1129	  0.144  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1129	  0.277  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1129	  0.187  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1129	  0.169  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1128	  0.280  apic_timer_interrupt+0x52 (__ipipe_=
trace+0x40b)
:    +func               -1128	  0.120  hrtimer_start_range_ns+0x3 (hrtimer=
_start_expires+0x1c)
:    +func               -1128	  0.117  __hrtimer_start_range_ns+0x9 (hrtim=
er_start_range_ns+0x15)
:    +func               -1128	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    +func               -1128	  0.142  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1128	  0.117  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1127	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1127	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1127	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1127	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001 -1127	  0.127  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func               -1127	  0.132  idle_cpu+0x3 (__hrtimer_start_range=
_ns+0x5f)
:    #func               -1127	  0.117  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func               -1127	  0.138  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:    #func               -1126	  0.130  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1126	  0.124  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1126	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1126	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1126	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1126	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1126	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1125	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1125	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1125	  0.117  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1125	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1125	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1125	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1125	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1124	  0.120  schedule+0x3 (schedule_hrtimeout_ra=
nge_clock+0x96)
:    +func               -1124	  0.114  __schedule+0x9 (schedule+0x18)
:    +func               -1124	  0.115  add_preempt_count+0x4 (__schedule+0=
x23)
:    +func               -1124	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1124	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1124	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1124	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x28)
:|   +end     0x80000001 -1124	  0.129  debug_smp_processor_id+0x82 (__sche=
dule+0x28)
:    +func               -1123	  0.115  rcu_note_context_switch+0x9 (__sche=
dule+0x3a)
:    +func               -1123	  0.145  rcu_sched_qs+0x3 (rcu_note_context_=
switch+0x2a)
:    #func               -1123	  0.123  rcu_preempt_qs+0x3 (rcu_note_contex=
t_switch+0x147)
:    #func               -1123	  0.111  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1123	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1123	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1123	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1123	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1122	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1122	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1122	  0.118  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1122	  0.118  ipipe_root_only+0x5 (__schedule+0x7=
3)
:|   +begin   0x80000001 -1122	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1122	  0.127  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1122	  0.129  _raw_spin_lock_irq+0x4 (__schedule+=
0xba)
:    #func               -1121	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irq+0x1a)
:    #func               -1121	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1121	  0.175  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1121	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1121	  0.118  deactivate_task+0x4 (__schedule+0x1=
0e)
:    #func               -1121	  0.114  dequeue_task+0x8 (deactivate_task+0=
x21)
:    #func               -1121	  0.133  update_rq_clock+0x6 (dequeue_task+0=
x1a)
:|   #begin   0x80000001 -1121	  0.154  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1120	  0.160  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:    #func               -1120	  0.121  dequeue_task_fair+0x9 (dequeue_task=
+0x28)
:    #func               -1120	  0.132  update_curr+0x9 (dequeue_task_fair+=
0x2f)
:    #func               -1120	  0.142  update_min_vruntime+0x9 (update_cur=
r+0x6e)
:    #func               -1120	  0.129  clear_buddies+0x5 (dequeue_task_fai=
r+0x38)
:    #func               -1120	  0.121  update_min_vruntime+0x9 (dequeue_ta=
sk_fair+0xa9)
:    #func               -1120	  0.130  hrtick_update+0x5 (dequeue_task_fai=
r+0xb7)
:    #func               -1119	  0.114  idle_balance+0x9 (__schedule+0x252)
:    #func               -1119	  0.133  _raw_spin_unlock+0x3 (idle_balance+=
0x5f)
:    #func               -1119	  0.126  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1119	  0.141  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1119	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1119	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1119	  0.124  __rcu_read_lock+0x3 (idle_balance+0=
x64)
:    #func               -1118	  0.118  load_balance+0x9 (idle_balance+0xa5)
:|   #begin   0x80000001 -1118	  0.151  debug_smp_processor_id+0x36 (load_b=
alance+0x25)
:|   #end     0x80000001 -1118	  0.166  debug_smp_processor_id+0x82 (load_b=
alance+0x25)
:    #func               -1118	  0.154  find_busiest_group+0x9 (load_balanc=
e+0x8f)
:    #func               -1118	  0.164  group_balance_cpu+0x3 (update_sd_lb=
_stats+0x8b)
:    #func               -1118	  0.121  idle_cpu+0x3 (update_sd_lb_stats+0x=
d7)
:    #func               -1118	  0.115  target_load+0x4 (update_sd_lb_stats=
+0x102)
:    #func               -1118	  0.236  idle_cpu+0x3 (update_sd_lb_stats+0x=
14e)
:    #func               -1117	  0.121  source_load+0x4 (update_sd_lb_stats=
+0x10e)
:    #func               -1117	  0.178  idle_cpu+0x3 (update_sd_lb_stats+0x=
14e)
:    #func               -1117	  0.115  msecs_to_jiffies+0x3 (idle_balance+=
0xb4)
:    #func               -1117	  0.115  __rcu_read_unlock+0x4 (idle_balance=
+0xee)
:    #func               -1117	  0.127  _raw_spin_lock+0x4 (idle_balance+0x=
f5)
:    #func               -1117	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1116	  0.124  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1116	  0.152  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1116	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1116	  0.130  put_prev_task_fair+0x6 (__schedule+=
0x275)
:    #func               -1116	  0.115  pick_next_task_fair+0x7 (__schedule=
+0x28c)
:    #func               -1116	  0.135  pick_next_task_stop+0x4 (__schedule=
+0x299)
:    #func               -1116	  0.126  pick_next_task_rt+0x5 (__schedule+0=
x299)
:    #func               -1116	  0.130  pick_next_task_fair+0x7 (__schedule=
+0x299)
:    #func               -1115	  0.129  pick_next_task_idle+0x3 (__schedule=
+0x299)
:    #func               -1115	  0.118  taskSwitchLinux+0x6 [sigmatek_lrt] =
(__schedule+0x2dc)
:    #func               -1115	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchLinux+0x32 [sigmatek_lrt])
:    #func               -1115	  0.120  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:    #func               -1115	  0.142  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x4f [sigmatek_lrt])
:    #func               -1115	  0.127  rt_task_set_mode+0x7 (taskSwitchLin=
ux+0x8d [sigmatek_lrt])
:|   #begin   0x80000000 -1115	  0.160  __schedule+0x3a3 (schedule+0x18)
:|   #func               -1115	  0.163  __switch_to+0x9 (__schedule+0x50a)
:|   #func               -1114	  0.145  __ipipe_switch_tail+0x4 (__schedule=
+0x514)
:|   #end     0x80000000 -1114	  0.126  hard_local_irq_enable+0x16 (__ipipe=
_switch_tail+0x2e)
:|   #begin   0x80000001 -1114	  0.142  debug_smp_processor_id+0x36 (__sche=
dule+0x51d)
:|   #end     0x80000001 -1114	  0.130  debug_smp_processor_id+0x82 (__sche=
dule+0x51d)
:    #func               -1114	  0.127  finish_task_switch+0x7 (__schedule+=
0x533)
:    #func               -1114	  0.123  _raw_spin_unlock_irq+0x3 (finish_ta=
sk_switch+0x4a)
:    #func               -1114	  0.123  ipipe_unstall_root+0x3 (_raw_spin_u=
nlock_irq+0x12)
:|   #begin   0x80000000 -1113	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1113	  0.185  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1113	  0.115  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1113	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock_irq+0x1c)
:    +func               -1113	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1113	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1113	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   +begin   0x80000001 -1112	  0.144  debug_smp_processor_id+0x36 (__sche=
dule+0x538)
:|   +end     0x80000001 -1112	  0.136  debug_smp_processor_id+0x82 (__sche=
dule+0x538)
:    +func               -1112	  0.141  _raw_spin_lock_irqsave+0x5 (post_sc=
hedule.part.48+0xc)
:    #func               -1112	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1112	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1112	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1112	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1111	  0.114  post_schedule_idle+0x3 (post_schedu=
le.part.48+0x22)
:    #func               -1111	  0.120  __ipipe_spin_unlock_debug+0x3 (post=
_schedule.part.48+0x29)
:    #func               -1111	  0.120  _raw_spin_unlock_irqrestore+0x4 (po=
st_schedule.part.48+0x32)
:    #func               -1111	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1111	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1111	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1111	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1111	  0.120  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1110	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1110	  0.187  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1110	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1110	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    +func               -1110	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1110	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1110	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1109	  0.120  sub_preempt_count+0x4 (__schedule+0=
x56c)
:    +func               -1109	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1109	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1109	  0.154  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1109	  0.117  add_preempt_count+0x4 (schedule_pre=
empt_disabled+0x21)
:    +func               -1109	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   +begin   0x80000001 -1109	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   +end     0x80000001 -1109	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    +func               -1108	  0.129  tick_nohz_idle_enter+0x4 (cpu_start=
up_entry+0x24)
:    +func               -1108	  0.127  set_cpu_sd_state_idle+0x4 (tick_noh=
z_idle_enter+0x37)
:|   +begin   0x80000001 -1108	  0.144  debug_smp_processor_id+0x36 (set_cp=
u_sd_state_idle+0xe)
:|   +end     0x80000001 -1108	  0.126  debug_smp_processor_id+0x82 (set_cp=
u_sd_state_idle+0xe)
:    +func               -1108	  0.118  __rcu_read_lock+0x3 (set_cpu_sd_sta=
te_idle+0x15)
:    +func               -1108	  0.136  __rcu_read_unlock+0x4 (set_cpu_sd_s=
tate_idle+0x4d)
:|   #begin   0x80000001 -1108	  0.142  debug_smp_processor_id+0x36 (tick_n=
ohz_idle_enter+0x46)
:|   #end     0x80000001 -1107	  0.129  debug_smp_processor_id+0x82 (tick_n=
ohz_idle_enter+0x46)
:    #func               -1107	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_idle_enter+0x5b)
:|   #begin   0x80000001 -1107	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001 -1107	  0.129  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func               -1107	  0.158  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001 -1107	  0.152  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001 -1107	  0.144  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001 -1106	  0.158  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1106	  0.149  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001 -1106	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001 -1106	  0.138  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func               -1106	  0.135  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func               -1106	  0.139  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001 -1106	  0.142  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001 -1105	  0.129  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func               -1105	  0.120  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001 -1105	  0.142  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001 -1105	  0.127  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func               -1105	  0.114  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func               -1105	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1105	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1105	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1104	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1104	  0.127  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func               -1104	  0.117  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1104	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1104	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1104	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1104	  0.124  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001 -1104	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001 -1103	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func               -1103	  0.149  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func               -1103	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1103	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1103	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1103	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1103	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func               -1102	  0.123  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func               -1102	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1102	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1102	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1102	  0.151  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1102	  0.115  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1102	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1102	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1101	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1101	  0.124  nohz_balance_enter_idle+0x3 (__tick=
_nohz_idle_enter+0x24a)
:    #func               -1101	  0.124  calc_load_enter_idle+0x4 (__tick_no=
hz_idle_enter+0x24f)
:|   #begin   0x80000001 -1101	  0.152  debug_smp_processor_id+0x36 (calc_l=
oad_enter_idle+0x13)
:|   #end     0x80000001 -1101	  0.132  debug_smp_processor_id+0x82 (calc_l=
oad_enter_idle+0x13)
:    #func               -1101	  0.115  hrtimer_start+0x3 (__tick_nohz_idle=
_enter+0x2e1)
:    #func               -1101	  0.114  __hrtimer_start_range_ns+0x9 (hrtim=
er_start+0x14)
:    #func               -1100	  0.114  lock_hrtimer_base.isra.17+0x6 (__hr=
timer_start_range_ns+0x23)
:    #func               -1100	  0.149  _raw_spin_lock_irqsave+0x5 (lock_hr=
timer_base.isra.17+0x1c)
:    #func               -1100	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1100	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1100	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1100	  0.163  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1100	  0.151  debug_smp_processor_id+0x36 (remove=
_hrtimer.part.15+0x1f)
:|   #end     0x80000001 -1099	  0.130  debug_smp_processor_id+0x82 (remove=
_hrtimer.part.15+0x1f)
:    #func               -1099	  0.154  __remove_hrtimer+0x9 (remove_hrtime=
r.part.15+0x3e)
:    #func               -1099	  0.136  hrtimer_force_reprogram+0x9 (__remo=
ve_hrtimer+0x64)
:    #func               -1099	  0.111  tick_program_event+0x4 (hrtimer_for=
ce_reprogram+0xc6)
:    #func               -1099	  0.121  clockevents_program_event+0x9 (tick=
_program_event+0x24)
:    #func               -1099	  0.149  ktime_get+0x9 (clockevents_program_=
event+0x7a)
:    #func               -1099	  0.118  xnarch_next_htick_shot+0x5 (clockev=
ents_program_event+0xeb)
:|   #begin   0x80000000 -1099	  0.161  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  *#func               -1098	  0.124  xntimer_start_aperiodic+0x9 (xnarch=
_next_htick_shot+0x33)
:|  *#func               -1098	  0.203  xnarch_ns_to_tsc+0x6 (xntimer_start=
_aperiodic+0x67)
:|  *#func               -1098	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|   #end     0x80000000 -1098	  0.136  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|   #begin   0x80000001 -1098	  0.142  debug_smp_processor_id+0x36 (__hrti=
mer_start_range_ns+0x46)
:|   #end     0x80000001 -1098	  0.136  debug_smp_processor_id+0x82 (__hrti=
mer_start_range_ns+0x46)
:    #func               -1097	  0.115  ktime_add_safe+0x6 (hrtimer_set_exp=
ires_range_ns+0x21)
:    #func               -1097	  0.149  enqueue_hrtimer+0x6 (__hrtimer_star=
t_range_ns+0x155)
:    #func               -1097	  0.117  __ipipe_spin_unlock_debug+0x3 (unlo=
ck_hrtimer_base.isra.18+0x10)
:    #func               -1097	  0.126  _raw_spin_unlock_irqrestore+0x4 (un=
lock_hrtimer_base.isra.18+0x1b)
:    #func               -1097	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1097	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1097	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1097	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1096	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1096	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1096	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1096	  0.167  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1096	  0.121  ipipe_unstall_root+0x3 (tick_nohz_i=
dle_enter+0x60)
:|   #begin   0x80000000 -1096	  0.146  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1096	  0.190  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1095	  0.146  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:|   +begin   0x80000001 -1095	  0.142  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1095	  0.144  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1095	  0.115  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1095	  0.114  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1095	  0.120  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1095	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1094	  0.132  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1094	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1094	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1094	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1094	  0.118  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1094	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1094	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1094	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1093	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1093	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1093	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1093	  0.115  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1093	  0.120  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1093	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1093	  0.129  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1092	  0.121  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1092	  0.144  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1092!  54.458  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x000000ef -1038	  0.129  apic_timer_interrupt+0x3a (__ipipe_=
halt_root+0x43)
:|   +func               -1038	  0.149  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1037	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1037	  0.118  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1037	  0.127  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1037	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1037	  0.169  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func               -1037	  0.130  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1037	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1036	  0.133  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1036	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1036	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99 -1036	  0.197  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1036	  0.141  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-938  -1036	  0.114  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1036	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1036	  0.258  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1035	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  582] TCP-Lis -1 -1035	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1035	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1035	  0.311  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1035	  0.322  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99 -1034	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1034	  0.124  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1034	  0.120  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1034	  0.242  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1034	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1033	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1033	  0.215  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1033	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1033	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1033	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1033	  0.317  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1032	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1032	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1032	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1032	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1032	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1032	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1031	  0.136  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1031	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1031	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1031	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1031	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1031	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1031	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1030	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99 -1030	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1030	  0.289  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1030	  0.221  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1030	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1029	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1029	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1029	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1029	  0.279  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1029	  0.188  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1029	  0.167  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +end     0x000000ef -1028	  0.224  apic_timer_interrupt+0x52 (__ipipe_=
halt_root+0x43)
:|   +begin   0x80000001 -1028	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0x2d)
:|   +end     0x80000001 -1028	  0.160  debug_smp_processor_id+0x82 (defaul=
t_idle+0x2d)
:    +func               -1028	  0.149  rcu_idle_exit+0x6 (cpu_startup_entr=
y+0x11f)
:|   #begin   0x80000001 -1028	  0.142  debug_smp_processor_id+0x36 (rcu_id=
le_exit+0x1c)
:|   #end     0x80000001 -1028	  0.130  debug_smp_processor_id+0x82 (rcu_id=
le_exit+0x1c)
:    #func               -1028	  0.136  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_idle_exit+0x73)
:|   #begin   0x80000001 -1027	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1027	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1027	  0.115  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1027	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1027	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1027	  0.129  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1027	  0.121  ipipe_unstall_root+0x3 (ipipe_resto=
re_root+0x20)
:|   #begin   0x80000000 -1026	  0.127  hard_local_irq_disable+0x17 (ipipe_=
unstall_root+0xd)
:|   #func               -1026	  0.188  ipipe_root_only+0x5 (ipipe_unstall_=
root+0x12)
:|   +end     0x80000000 -1026	  0.114  hard_local_irq_enable+0x16 (ipipe_u=
nstall_root+0x2b)
:    +func               -1026	  0.133  arch_cpu_idle_exit+0x3 (cpu_startup=
_entry+0x136)
:|   +begin   0x80000001 -1026	  0.144  debug_smp_processor_id+0x36 (cpu_st=
artup_entry+0x33)
:|   +end     0x80000001 -1026	  0.145  debug_smp_processor_id+0x82 (cpu_st=
artup_entry+0x33)
:    #func               -1026	  0.115  arch_cpu_idle_enter+0x3 (cpu_startu=
p_entry+0x59)
:    #func               -1025	  0.115  local_touch_nmi+0x3 (arch_cpu_idle_=
enter+0xd)
:    #func               -1025	  0.121  tick_check_broadcast_expired+0x3 (c=
pu_startup_entry+0x67)
:|   #begin   0x80000001 -1025	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_broadcast_expired+0xd)
:|   #end     0x80000001 -1025	  0.135  debug_smp_processor_id+0x82 (tick_c=
heck_broadcast_expired+0xd)
:    #func               -1025	  0.145  rcu_idle_enter+0x5 (cpu_startup_ent=
ry+0xd3)
:|   #begin   0x80000001 -1025	  0.141  debug_smp_processor_id+0x36 (rcu_id=
le_enter+0x1b)
:|   #end     0x80000001 -1025	  0.132  debug_smp_processor_id+0x82 (rcu_id=
le_enter+0x1b)
:    #func               -1025	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_idle_enter+0x76)
:|   #begin   0x80000001 -1024	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1024	  0.139  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1024	  0.112  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1024	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1024	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1024	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1024	  0.114  arch_cpu_idle+0x3 (cpu_startup_entr=
y+0xd8)
:    #func               -1023	  0.120  default_idle+0x3 (arch_cpu_idle+0xe)
:|   #begin   0x80000001 -1023	  0.142  debug_smp_processor_id+0x36 (defaul=
t_idle+0xd)
:|   #end     0x80000001 -1023	  0.129  debug_smp_processor_id+0x82 (defaul=
t_idle+0xd)
:    #func               -1023	  0.120  __ipipe_halt_root+0x3 (default_idle=
+0x28)
:|   #begin   0x80000000 -1023	  0.142  hard_local_irq_disable+0x17 (__ipip=
e_halt_root+0xd)
:|   +end     0x8000000e -1023!  44.987  __ipipe_halt_root+0x41 (default_id=
le+0x28)
:|   +begin   0x00000051  -978	  0.142  common_interrupt+0x39 (__ipipe_halt=
_root+0x43)
:|   +func                -978	  0.145  __ipipe_handle_irq+0x7 (common_inte=
rrupt+0x40)
:|   +func                -978	  0.145  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func                -977	  0.142  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func                -977	  0.132  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x26)
:|   +func                -977	  0.132  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x216)
:|   +func                -977	  0.124  __ipipe_ack_fasteoi_irq+0x3 (__ipip=
e_dispatch_irq+0xa9)
:|   +func                -977	  0.127  hold_ioapic_irq+0x4 (__ipipe_ack_fa=
steoi_irq+0x10)
:|   +func                -977	  0.127  io_apic_modify_irq.isra.9+0x7 (hold=
_ioapic_irq+0x41)
:|   +func                -977	  0.112  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|   +func                -977+   1.369  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|   +func                -975	  0.112  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|   +func                -975	  0.130  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|   +func                -975	  0.142  io_apic_sync+0x3 (io_apic_modify_ir=
q.isra.9+0x41)
:|   +func                -975+   1.162  io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func                -974	  0.187  ack_apic_level+0x5 (hold_ioapic_irq=
+0x50)
:|   +func                -973	  0.187  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func                -973	  0.126  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -973	  0.144  xnintr_irq_handler+0x9 (__ipipe_dis=
patch_irq+0x182)
:|  # func                -973	  0.141  irqhandler_fpga+0x9 [sigmatek_lrt] =
(xnintr_irq_handler+0x78)
:|  # func                -973+   6.102  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func                -967	  0.148  xnarch_get_cpu_time+0x4 (irqhandler=
_fpga+0x132 [sigmatek_lrt])
:|  # func                -967	  0.121  xnarch_tsc_to_ns+0x6 (xnarch_get_cp=
u_time+0x13)
:|  # func                -966	  0.120  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x14c [sigmatek_lrt])
:|  # func                -966	  0.130  period_update+0x4 [sigmatek_lrt] (i=
rqhandler_fpga+0x163 [sigmatek_lrt])
:|  # func                -966	  0.154  lrtdrv_monitoring_start_timed+0x4 [=
sigmatek_lrt] (period_update+0x1f [sigmatek_lrt])
:|  # func                -966	  0.207  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func                -966	  0.227  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func                -966	  0.144  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func                -965	  0.239  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func                -965	  0.149  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func                -965	  0.161  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func                -965	  0.138  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  607] realtim 95  -965	  0.239  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -965	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func                -964	  0.167  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func                -964	  0.209  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  512] VARAN_T 30  -964	  0.222  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -964	  0.138  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  605] cyclic: 30  -964	  0.163  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -963	  0.138  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  603] Loader: 29  -963	  0.152  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -963	  0.206  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  609] backgrou 0  -963	  0.234  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -963	  0.114  ipipe_raise_irq+0x8 (period_update+=
0x10f [sigmatek_lrt])
:|  # func                -963	  0.115  irq_hook_handler+0x3 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|  # func                -963	  0.139  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|  # func                -962	  0.115  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  # func                -962	  0.141  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  # func                -962	  0.112  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x1db)
:|  # func                -962	  0.187  __ipipe_set_irq_pending+0x6 (__ipip=
e_dispatch_irq+0x1e4)
:|  # func                -962	  0.176  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  # func                -962+   1.655  ___xnpod_unlock_sched+0x3 (__xnpod=
_unlock_sched+0x19 [sigmatek_lrt])
:|  # func                -960+   1.676  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func                -958	  0.178  ___xnpod_unlock_sched+0x3 (__xnpod_=
unlock_sched+0x19 [sigmatek_lrt])
:|  # func                -958	  0.114  rthal_irq_end+0x5 (xnintr_irq_handl=
er+0x14d)
:|  # func                -958	  0.132  irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  # func                -958	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  # func                -958	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  # func                -958	  0.115  __ipipe_end_fasteoi_irq+0x3 (rthal_=
irq_end+0x38)
:|  # func                -958	  0.115  release_ioapic_irq+0x5 (__ipipe_end=
_fasteoi_irq+0x16)
:|  # func                -957	  0.151  __ipipe_spin_lock_irqsave+0x6 (rele=
ase_ioapic_irq+0x17)
:|  # func                -957	  0.114  io_apic_modify_irq.isra.9+0x7 (rele=
ase_ioapic_irq+0x29)
:|  # func                -957	  0.114  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|  # func                -957+   1.349  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|  # func                -956	  0.112  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|  # func                -956	  0.132  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|  # func                -955	  0.204  __ipipe_spin_unlock_irqrestore+0x4 =
(release_ioapic_irq+0x35)
:|  # func                -955	  0.175  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1  -955	  0.145  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -955	  0.151  ipipe_send_ipi+0x6 (__xnpod_schedul=
e+0x7d)
:|  # func                -955	  0.197  default_send_IPI_mask_logical+0x6 (=
ipipe_send_ipi+0x40)
:|  # func                -955	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -954	  0.316  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func                -954	  0.311  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  607] realtim 95  -954	  0.212  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -954	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -953	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -953	  0.345  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -953	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -953	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func                -953	  0.117  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func                -953	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -952	  0.124  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -952	  0.302  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001  -952	  0.181  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -952	  0.152  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -952	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -952!  13.796  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:|  + begin   0x000000ef  -938	  0.155  apic_timer_interrupt+0x3a (<080ac8f=
b>)
:|  + func                -938	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -937	  0.130  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -937	  0.124  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -937	  0.129  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -937	  0.144  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -937	  0.161  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func                -937	  0.117  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -937	  0.219  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -936	  0.141  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -936	  0.123  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -936	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99  -936	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -936	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-838   -936	  0.114  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -936	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -935	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -935	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  607] realtim 95  -935	  0.135  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -935	  0.384  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -934	  0.408  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99  -934	  0.207  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -934	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -934	  0.145  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -934	  0.250  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -933	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -933	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -933	  0.209  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -933	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -933	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -933	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -932	  0.317  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -932	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -932	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -932	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -932	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -931	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -931	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -931	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -931	  0.132  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -931	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -931	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -931	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -931	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -930	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -930	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99  -930	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -930	  0.304  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -930	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  607] realtim 95  -929	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -929	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -929	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -929	  0.276  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -929	  0.144  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + end     0x000000ef  -929+   5.305  apic_timer_interrupt+0x52 (<080ac8=
fb>)
:   + func                -923	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -923	  0.132  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -923	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -923	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -923	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -923	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -922	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -922	  0.172  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -922	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func                -922	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func                -922	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000  -922	  0.273  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func                -921	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -921	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -921	  0.142  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001  -921	  0.144  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func                -921	  0.118  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func                -921	  0.158  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func                -921	  0.179  pci_locker_signal_stop+0x3 [sigmate=
k_lrt] (lrt_ioctl_work+0x768 [sigmatek_lrt])
:|  + begin   0x80000001  -920	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -920	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -920	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -920	  0.429  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -920	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -919	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -919	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -919	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -919	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -919	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -919	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -919	  0.142  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -918	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func                -918	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func                -918	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000  -918	  0.204  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func                -918	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -918	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -918	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001  -918	  0.126  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func                -917	  0.118  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func                -917	  0.120  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func                -917	  0.167  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func                -917	  0.117  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func                -917	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -917	  0.121  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -917	  0.123  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001  -917	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001  -916	  0.129  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func                -916	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func                -916	  0.121  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000  -916	  0.209  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func                -916	  0.161  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func                -916	  0.179  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func                -915	  0.191  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  607] realtim 95  -915	  0.115  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -915	  0.314  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -915	  0.406  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  605] cyclic: 30  -914	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -914	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -914	  0.141  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -914	  0.323  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -914	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -913	  0.158  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func                -913	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func                -913	  0.118  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -913	  0.124  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -913	  0.231  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001  -913	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -913	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -912	  0.169  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -912!  74.275  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:|  + begin   0x000000ef  -838	  0.132  apic_timer_interrupt+0x3a (<102d024=
a>)
:|  + func                -838	  0.154  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -838	  0.118  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -838	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -837	  0.142  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -837	  0.138  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -837	  0.155  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func                -837	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -837	  0.250  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -837	  0.138  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -837	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -836	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99  -836	  0.204  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -836	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-738   -836	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -836	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -836	  0.258  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -835	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  605] cyclic: 30  -835	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -835	  0.378  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -835	  0.403  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99  -834	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -834	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -834	  0.139  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -834	  0.249  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -834	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -833	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -833	  0.190  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -833	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -833	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -833	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -833	  0.308  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -832	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -832	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -832	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -832	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -832	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -832	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -832	  0.152  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -831	  0.136  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -831	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -831	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -831	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -831	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -831	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -831	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99  -830	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -830	  0.302  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -830	  0.305  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  605] cyclic: 30  -830	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -830	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -829	  0.123  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -829	  0.259  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -829	  0.146  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + end     0x000000ef  -829!  90.866  apic_timer_interrupt+0x52 (<102d02=
4a>)
:|  + begin   0x000000ef  -738	  0.130  apic_timer_interrupt+0x3a (<102d025=
4>)
:|  + func                -738	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -738	  0.117  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -738	  0.118  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -737	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -737	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -737	  0.154  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func                -737	  0.115  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -737	  0.218  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -737	  0.136  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -737	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -736	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99  -736	  0.201  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -736	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-638   -736	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -736	  0.135  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -736	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -735	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  605] cyclic: 30  -735	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -735	  0.325  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -735	  0.397  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99  -734	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -734	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -734	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -734	  0.212  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -734	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -734	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -734	  0.185  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -733	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -733	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -733	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -733	  0.305  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -733	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -732	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -732	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -732	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -732	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -732	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -732	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -732	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -731	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -731	  0.117  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -731	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -731	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -731	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -731	  0.169  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  624] -<?>-   99  -731	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -731	  0.301  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -730	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  605] cyclic: 30  -730	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -730	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -730	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -729	  0.259  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -729	  0.145  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + end     0x000000ef  -729!  65.687  apic_timer_interrupt+0x52 (<102d02=
54>)
:|  + begin   0x000000fd  -663	  0.155  reschedule_interrupt+0x3a (<1013cb6=
3>)
:|  + func                -663	  0.167  __ipipe_handle_irq+0x7 (reschedule_=
interrupt+0x41)
:|  + func                -663	  0.124  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -663	  0.170  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -663	  0.154  __ipipe_ack_apic+0x3 (__ipipe_dispa=
tch_irq+0xa9)
:|  + func                -663	  0.114  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x1db)
:|  + func                -663	  0.212  __ipipe_set_irq_pending+0x6 (__ipip=
e_dispatch_irq+0x1e4)
:|  + func                -662	  0.142  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + end     0x000000fd  -662! 653.327  reschedule_interrupt+0x52 (<1013cb=
63>)
:|  + begin   0x000000ef    -9	  0.164  apic_timer_interrupt+0x3a (<080ac95=
1>)
:|  + func                  -9	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                  -9	  0.117  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                  -8	  0.118  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                  -8	  0.136  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                  -8	  0.138  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                  -8	  0.152  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  # func                  -8	  0.127  irq_hook_handler+0x3 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                  -8	  0.219  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                  -8	  0.148  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                  -7	  0.127  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                  -7	  0.142  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  624] -<?>-   99    -7	  0.288  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                  -7	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@60       -7	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                  -7	  0.135  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                  -6	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                  -6	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  605] cyclic: 30    -6	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                  -6	  0.323  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                  -6	  0.399  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  624] -<?>-   99    -5	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                  -5	  0.126  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                  -5	  0.142  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                  -5	  0.230  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                  -4	  0.244  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                  -4	  0.142  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000    -4	  0.206  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001    -4	  0.191  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001    -4	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000    -4	  0.172  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000    -3	  0.824  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                  -3	  0.141  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                  -2	  0.129  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001    -2	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001    -2	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                  -2	  0.121  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001    -2	  0.164  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001    -2	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                  -2	  0.279  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                  -1	  0.342  xnshadow_sys_trace+0x6 (hisyscall_e=
vent+0x129)
:   + func                  -1	  0.212  ipipe_trace_frozen_reset+0x5 (xnsha=
dow_sys_trace+0x5e)
:   + func                  -1	  0.130  __ipipe_global_path_lock+0x7 (ipipe=
_trace_frozen_reset+0x14)
:   + func                  -1	  0.135  __ipipe_spin_lock_irqsave+0x6 (__ip=
ipe_global_path_lock+0x16)
:|  + begin   0x80000001     0	  0.634  hard_local_irq_save+0x16 (__ipipe_s=
pin_lock_irqsave+0x12)
:|  # func                   0	  0.148  __ipipe_spin_unlock_irqcomplete+0x4=
 (__ipipe_global_path_unlock+0x5f)
:|  + end     0x80000001     0	  0.154  hard_local_irq_restore+0x15 (__ipip=
e_spin_unlock_irqcomplete+0x25)
<   + freeze  0x0009a3b7     0	  0.172  xnshadow_sys_trace+0x67 (hisyscall_=
event+0x129)
 |  + begin   0x80000001     0	  0.190  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
 |  + end     0x80000001     0	  0.141  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
 |  + begin   0x80000000     0	  0.181  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
 |  + end     0x80000000     0	  0.200  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
    + func                   0	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
    + func                   1	  0.132  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
 |  + begin   0x80000001     1	  0.176  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
 |  + end     0x80000001     1	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
    + func                   1	  0.126  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
 |  + begin   0x80000001     1	  0.000  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
