Message-ID: <55A3D1B2.50905@sigmatek.at>
Date: Mon, 13 Jul 2015 16:56:50 +0200
From: Johann Obermayr <johann.obermayr@sigmatek.at>
MIME-Version: 1.0
References: <559E65FB.8080904@sigmatek.at>
 <20150709141922.GG20176@hermes.click-hack.org> <559E9687.6020109@sigmatek.at>
 <20150709155115.GK20176@hermes.click-hack.org> <559F91C3.8090005@sigmatek.at>
 <20150710094655.GS20176@hermes.click-hack.org> <559FA1D1.6060602@sigmatek.at>
 <20150710104957.GT20176@hermes.click-hack.org> <55A3C023.5070000@sigmatek.at>
 <20150713140208.GC1554@hermes.click-hack.org>
In-Reply-To: <20150713140208.GC1554@hermes.click-hack.org>
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
To: Xenomai@xenomai.org

Am 13.07.2015 um 16:02 schrieb Gilles Chanteperdrix:
> On Mon, Jul 13, 2015 at 03:41:55PM +0200, Johann Obermayr wrote:
>> Am 10.07.2015 um 12:49 schrieb Gilles Chanteperdrix:
>>> On Fri, Jul 10, 2015 at 12:43:29PM +0200, Johann Obermayr wrote:
>>>> Am 10.07.2015 um 11:46 schrieb Gilles Chanteperdrix:
>>>>> On Fri, Jul 10, 2015 at 11:34:59AM +0200, Johann Obermayr wrote:
>>>>>> Am 09.07.2015 um 17:51 schrieb Gilles Chanteperdrix:
>>>>>>> On Thu, Jul 09, 2015 at 05:43:03PM +0200, Johann Obermayr wrote:
>>>>>>>> Am 09.07.2015 um 16:19 schrieb Gilles Chanteperdrix:
>>>>>>>>> On Thu, Jul 09, 2015 at 02:15:55PM +0200, Johann Obermayr wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> we have follow situation
>>>>>>>>>>
>>>>>>>>>> u64 lrtdrv_time_of_irq_ns ;
>>>>>>>>>> void worker_task()
>>>>>>>>>> {
>>>>>>>>>> while(1)
>>>>>>>>>>      {
>>>>>>>>>>      rtdm_task_sleep_abs(lrtdrv_time_of_irq_ns + 950000ull,
>>>>>>>>>> RTDM_TIMERMODE_ABSOLUTE);
>>>>>>>>>>      do_something();
>>>>>>>>>>      }
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> _kernel_rtdm_irq_handler()
>>>>>>>>>> {
>>>>>>>>>>      lrtdrv_time_of_irq_ns =3D rtdm_clock_read_monotonic();
>>>>>>>>>> }
>>>>>>>>>>
>>>>>>>>>> the  _kernel_irq_callback() is called every 1ms.
>>>>>>>>>> we will , that the worker_task begin 50us before next irq
>>>>>>>>>>
>>>>>>>>>> But sometime, the worker task start ~50us after irq. Why ?
>>>>>>>>> Best way to know, enable the I-pipe tracer, setup sufficient back
>>>>>>>>> trace points, and when the wrong wake up happens, trigger an I-pi=
pe
>>>>>>>>> trace.
>>>>>>>>>
>>>>>>>> i will enable i-pipe tracer.
>>>>>>>> found out, that
>>>>>>>>
>>>>>>>> rtdm_task_sleep_abs(xxx, RTDM_TIMERMODE_ABSOLUTE);
>>>>>>>> u64 calc =3D rtdm_clock_read_monotonic();
>>>>>>>>
>>>>>>>> sometime the diff between xxx & calc is biger than 61000ns.
>>>>>>> This is called "kernel task scheduling latency". It can be measured=
 by
>>>>>>> the latency -t 1 test.
>>>>>> Ok, i will test it with this test.
>>>>>> Here a simple list of measure from  rtdm_task_sleep_abs(xxx) calc =
=3D
>>>>>> rtdm_clock_read_monotonic
>>>>> Yeah, latency -t 1 does that too. Only much better.
>>>>>
>>>> Result a) only latency -t 1
>>>> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
>>>> RTH|----lat min|----lat avg|----lat max|-overrun|---msw|---lat best|--=
lat
>>>> worst
>>>> RTD|     -2.618|     -2.481|     -2.384|       0|     0| -2.618|     -=
2.384
>>>> RTD|     -2.506|     -2.477|     -2.301|       0|     0| -2.618|     -=
2.301
>>>> RTD|     -2.590|     -2.479|     -2.192|       0|     0| -2.618|     -=
2.192
>>>> RTD|     -2.517|     -2.489|     -2.324|       0|     0| -2.618|     -=
2.192
>>>> RTD|     -2.612|     -2.490|     -2.335|       0|     0| -2.618|     -=
2.192
>>>> RTD|     -2.723|     -2.490|     -2.300|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.521|     -2.491|     -2.332|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.624|     -2.492|     -2.346|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.520|     -2.490|     -2.341|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.584|     -2.490|     -2.353|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.521|     -2.487|     -2.333|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.521|     -2.490|     -2.329|       0|     0| -2.723|     -=
2.192
>>>> RTD|     -2.519|     -2.488|     -1.946|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.521|     -2.490|     -2.353|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.605|     -2.490|     -2.343|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.521|     -2.490|     -2.328|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.568|     -2.489|     -2.337|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.520|     -2.490|     -2.329|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.553|     -2.491|     -2.337|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.521|     -2.491|     -2.325|       0|     0| -2.723|     -=
1.946
>>>> RTD|     -2.521|     -2.490|     -2.341|       0|     0| -2.723|     -=
1.946
>>>>
>>>> Result b) with our application, that copy with a releaxed task from/to=
 a
>>>> SRAM on a PCI Card.
>>>> RTT|  00:00:01  (in-kernel periodic task, 100 us period, priority 99)
>>>> RTH|---lat min|---lat avg|----lat max|-overrun|---msw|---lat best|--lat
>>>> worst
>>>> RTD|     -2.680|     -1.537|    716.496|       38|     0| -2.680|    7=
16.496
>>>> RTD|     -2.680|     -1.414|    691.232|       81|     0| -2.680|    7=
16.496
>>>> RTD|     -3.051|     -0.877|    739.939|     120|     0| -3.051|    73=
9.939
>>>> RTD|     -2.662|     -1.422|    738.747|     160|     0| -3.051|    73=
9.939
>>>> RTD|     -2.713|     -1.637|    726.880|     191|     0| -3.051|    73=
9.939
>>>> RTD|     -2.656|     -1.044|    675.880|     218|     0| -3.051|    73=
9.939
>>>> RTD|     -2.655|     -1.269|    753.354|     251|     0| -3.051|    75=
3.354
>>>> RTD|     -2.661|     -1.344|    633.684|     301|     0| -3.051|    75=
3.354
>>>> RTD|     -2.663|     -1.626|    698.008|     333|     0| -3.051|    75=
3.354
>>>> RTD|     -2.662|     -0.579|    751.352|     379|     0| -3.051|    75=
3.354
>>>> RTD|     -2.669|     -1.455|    733.275|     410|     0| -3.051|    75=
3.354
>>>> RTD|     -2.758|     -1.670|    629.569|     434|     0| -3.051|    75=
3.354
>>>> RTD|     -2.760|     -1.686|    690.451|     445|     0| -3.051|    75=
3.354
>>>> RTD|     -2.668|     -1.032|    753.099|     483|     0| -3.051|    75=
3.354
>>>> RTD|     -2.661|     -1.476|    735.519|     518|     0| -3.051|    75=
3.354
>>>> RTD|     -2.660|     -1.647|    725.828|     552|     0| -3.051|    75=
3.354
>>>> RTD|     -2.661|     -1.236|    250.879|     556|     0| -3.051|    75=
3.354
>>> Your application (and more probably driver) has a problem, it
>>> probably creates large interrupts masking section. Once again, to
>>> understand what the problem is, I suggest using the I-pipe tracer.
>>>
>> Hello,
>>
>> i have add a ipipe trace. But i don't understand it.
>>
>> the function lrtdrv_monitoring_irq has no mutex, only a atomic funtion a=
nd
>> write result into a ring buffer.
>> (see your trace screen. red lines)
>>
>> http://www.pic-upload.de/view-27670244/Trace001.png.html
> Neither do I. We do not know when the interrupt was expected, so we
> basically can not say how much it is late.
>
> So, please:
> 1- run the latency test but generate load with the dohell script
> instead of running your application.
>
> If you get large latencies, then it is probable that the issue does
> not come from your application
>
> 2- Enable the I-pipe tracer, and run the latency test with the -f
> argument, generating with whatever load (dohell script, or your
> application) which causes high latencies.
>
> Regards.
>
without your application, there are no large latencies.
with your application see frozen.txt (with latency -f)
We see the problem only if one task (background) is accessing the SRAM =

on your PCI-Card. if we stop this task, all is ok.
So we have a higher prior task (pci-locker), that interrupt the =

background task, so that the pci bus get free.

regards
   Johann

-------------- next part --------------
I-pipe frozen back-tracing service on 3.10.0/ipipe release #1
------------------------------------------------------------
CPU: 0, Freeze: 1619507745620 cycles, Trace Points: 2000 (+10)
Calibrated minimum trace-point overhead: 0.078 us

 +----- Hard IRQs ('|': locked)
 |+-- Xenomai
 ||+- Linux ('*': domain stalled, '+': current, '#': current+stalled)
 |||			  +---------- Delay flag ('+': > 1 us, '!': > 10 us)
 |||			  |	   +- NMI noise ('N')
 |||			  |	   |
	  Type	  User Val.   Time    Delay  Function (Parent)
:|  + end     0x80000001 -2589	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -2589	  0.117  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -2589	  0.136  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -2589	  0.124  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  + begin   0x80000001 -2589	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  + end     0x80000001 -2588	  0.129  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:   + func               -2588	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -2588	  0.120  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -2588	  0.155  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -2588	  0.157  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -2588	  0.142  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -2588	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  602] Loader: 29 -2588	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2587	  0.277  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2587	  0.322  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2587	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2587	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2586	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2586	  0.149  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2586	  0.314  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2586	  0.191  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2586	  0.157  __ipipe_do_sync_stage+0x9 (__ipipe_=
do_sync_pipeline+0x5e)
:|   #end     0x80000000 -2586	  0.115  hard_local_irq_enable+0x16 (__ipipe=
_do_sync_stage+0xa1)
:    #func               -2585	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0xe4)
:    #func               -2585	  0.127  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:    #func               -2585	  0.120  irq_enter+0x4 (__ipipe_do_sync_stag=
e+0xe9)
:|   #begin   0x80000001 -2585	  0.142  debug_smp_processor_id+0x36 (irq_en=
ter+0xe)
:|   #end     0x80000001 -2585	  0.127  debug_smp_processor_id+0x82 (irq_en=
ter+0xe)
:    #func               -2585	  0.146  rcu_irq_enter+0x7 (irq_enter+0x15)
:|   #begin   0x80000001 -2585	  0.141  debug_smp_processor_id+0x36 (rcu_ir=
q_enter+0x1e)
:|   #end     0x80000001 -2585	  0.135  debug_smp_processor_id+0x82 (rcu_ir=
q_enter+0x1e)
:    #func               -2584	  0.135  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_irq_enter+0x70)
:|   #begin   0x80000001 -2584	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -2584	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -2584	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -2584	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -2584	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2584	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2583	  0.114  local_bh_disable+0x3 (irq_enter+0x3=
9)
:    #func               -2583	  0.115  add_preempt_count+0x4 (local_bh_dis=
able+0x12)
:    #func               -2583	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2583	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2583	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2583	  0.114  tick_check_idle+0x8 (irq_enter+0x40)
:    #func               -2583	  0.151  tick_check_oneshot_broadcast+0x3 (t=
ick_check_idle+0x19)
:    #func               -2583	  0.219  ktime_get+0x9 (tick_check_idle+0x31)
:    #func               -2582	  0.115  tick_nohz_stop_idle+0x4 (tick_check=
_idle+0x48)
:    #func               -2582	  0.115  update_ts_time_stats+0x9 (tick_nohz=
_stop_idle+0x20)
:    #func               -2582	  0.149  nr_iowait_cpu+0x3 (update_ts_time_s=
tats+0x31)
:|   #begin   0x80000001 -2582	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_idle+0x53)
:|   #end     0x80000001 -2582	  0.158  debug_smp_processor_id+0x82 (tick_c=
heck_idle+0x53)
:    #func               -2582	  0.144  tick_do_update_jiffies64+0x9 (tick_=
check_idle+0x84)
:    #func               -2581	  0.112  ipipe_restore_root+0x4 (tick_check_=
idle+0x97)
:    #func               -2581	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -2581	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2581	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2581	  0.117  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func               -2581	  0.149  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func               -2581	  0.112  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func               -2581	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2580	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2580	  0.141  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2580	  0.117  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func               -2580	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2580	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2580	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2580	  0.133  wait_domain_nrt_handler+0x3 [sigmat=
ek_lrt] (__ipipe_do_sync_stage+0xff)
:    #func               -2579	  0.133  __wake_up+0x8 (wait_domain_nrt_hand=
ler+0x33 [sigmatek_lrt])
:    #func               -2579	  0.144  _raw_spin_lock_irqsave+0x5 (__wake_=
up+0x1a)
:    #func               -2579	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -2579	  0.120  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2579	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2579	  0.169  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2579	  0.117  __wake_up_common+0x9 (__wake_up+0x2=
e)
:    #func               -2578	  0.118  ipipe_root_only+0x5 (__wake_up_comm=
on+0x1b)
:|   #begin   0x80000001 -2578	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2578	  0.135  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2578	  0.123  __ipipe_spin_unlock_debug+0x3 (__wa=
ke_up+0x35)
:    #func               -2578	  0.124  _raw_spin_unlock_irqrestore+0x4 (__=
wake_up+0x3e)
:    #func               -2578	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -2578	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -2578	  0.166  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2577	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2577	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -2577	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2577	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2577	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2577	  0.129  irq_exit+0x3 (__ipipe_do_sync_stage=
+0x104)
:    #func               -2577	  0.114  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func               -2577	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2576	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2576	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -2576	  0.142  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001 -2576	  0.127  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func               -2576	  0.123  idle_cpu+0x3 (irq_exit+0x50)
:    #func               -2576	  0.118  tick_nohz_irq_exit+0x4 (irq_exit+0x=
79)
:|   #begin   0x80000001 -2576	  0.142  debug_smp_processor_id+0x36 (tick_n=
ohz_irq_exit+0x13)
:|   #end     0x80000001 -2575	  0.129  debug_smp_processor_id+0x82 (tick_n=
ohz_irq_exit+0x13)
:    #func               -2575	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_irq_exit+0x27)
:|   #begin   0x80000001 -2575	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001 -2575	  0.127  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func               -2575	  0.155  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001 -2575	  0.152  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001 -2575	  0.146  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001 -2574	  0.149  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -2574	  0.151  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001 -2574	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001 -2574	  0.188  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func               -2574	  0.135  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func               -2574	  0.146  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001 -2574	  0.141  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001 -2573	  0.133  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func               -2573	  0.120  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001 -2573	  0.141  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001 -2573	  0.129  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func               -2573	  0.115  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func               -2573	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -2573	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2573	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2572	  0.146  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2572	  0.126  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func               -2572	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -2572	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2572	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2572	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2572	  0.121  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001 -2571	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001 -2571	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func               -2571	  0.142  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func               -2571	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -2571	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2571	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2571	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2570	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func               -2570	  0.123  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func               -2570	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -2570	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -2570	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2570	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2570	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -2570	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -2569	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2569	  0.149  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2569	  0.151  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001 -2569	  0.141  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001 -2569	  0.130  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func               -2569	  0.120  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001 -2569	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -2568	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -2568	  0.120  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -2568	  0.118  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -2568	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -2568	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -2568	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x117)
:    #func               -2568	  0.124  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #begin   0x80000000 -2568	  0.198  hard_local_irq_disable+0x17 (__ipip=
e_do_sync_stage+0x11c)
:|   +func               -2567	  0.120  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2567	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x00000051 -2567+   6.297  common_interrupt+0x51 (need_resche=
d+0x1)
:|   +begin   0x000000ef -2561	  0.141  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func               -2561	  0.152  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2560	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2560	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2560	  0.123  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2560	  0.127  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2560	  0.151  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2560	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2560	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2560	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2559	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2559	  0.172  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2559	  0.142  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2559	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2559	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2559	  0.170  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2559	  0.123  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-2461 -2558	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2558	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2558	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2558	  0.179  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2558	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2558	  0.148  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2557	  0.319  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2557	  0.332  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2557	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2557	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2557	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2556	  0.231  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2556	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2556	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2556	  0.195  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2556	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2555	  0.145  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2555	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2555	  0.331  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2555	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2555	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2555	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2554	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2554	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2554	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2554	  0.124  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2554	  0.136  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2554	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2554	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2554	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2553	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2553	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2553	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2553	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2553	  0.298  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2553	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2552	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2552	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2552	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2552	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2552	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2551	  0.187  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2551	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2551	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2551!  90.277  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x000000ef -2461	  0.185  apic_timer_interrupt+0x3a (cpu_star=
tup_entry+0x91)
:|   +func               -2461	  0.181  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2460	  0.121  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2460	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2460	  0.129  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2460	  0.133  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2460	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2460	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2460	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2459	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2459	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2459	  0.169  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2459	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2459	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2459	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2459	  0.195  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2458	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-2361 -2458	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2458	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2458	  0.256  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2458	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2458	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2457	  0.126  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2457	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2457	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2457	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2457	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2456	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2456	  0.234  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2456	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2456	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2456	  0.181  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2456	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2455	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2455	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2455	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2455	  0.123  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2455	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2455	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2454	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2454	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2454	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2454	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2454	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2454	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2454	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2454	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2453	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2453	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2453	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2453	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2453	  0.301  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2453	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2452	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2452	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2452	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2452	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2452	  0.279  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2451	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2451	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2451	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2451!  90.259  apic_timer_interrupt+0x52 (cpu_sta=
rtup_entry+0x91)
:|   +begin   0x000000ef -2361	  0.185  apic_timer_interrupt+0x3a (cpu_star=
tup_entry+0x91)
:|   +func               -2361	  0.179  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2360	  0.126  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2360	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2360	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2360	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2360	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2360	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2360	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2359	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2359	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2359	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2359	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2359	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2359	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2359	  0.195  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2358	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-2261 -2358	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2358	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2358	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2358	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2358	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2357	  0.126  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2357	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2357	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2357	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2357	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2356	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2356	  0.234  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2356	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2356	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2356	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2356	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2355	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2355	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2355	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2355	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2355	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2355	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2354	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2354	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2354	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2354	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2354	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2354	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2354	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2354	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2353	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2353	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2353	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2353	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2353	  0.286  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2353	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2352	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2352	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2352	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2352	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2352	  0.283  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2351	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2351	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2351	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2351!  90.268  apic_timer_interrupt+0x52 (cpu_sta=
rtup_entry+0x91)
:|   +begin   0x000000ef -2261	  0.175  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func               -2261	  0.173  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2260	  0.121  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2260	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2260	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2260	  0.146  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2260	  0.139  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2260	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2260	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2259	  0.130  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2259	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2259	  0.218  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2259	  0.133  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2259	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2259	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2259	  0.175  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2258	  0.123  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-2161 -2258	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2258	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2258	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2258	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2258	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2257	  0.126  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2257	  0.328  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2257	  0.301  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2257	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2257	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2256	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2256	  0.227  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2256	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2256	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2256	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2256	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2255	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2255	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2255	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2255	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2255	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2255	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2254	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2254	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2254	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2254	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2254	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2254	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2254	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2253	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2253	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2253	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2253	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2253	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2253	  0.285  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2252	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2252	  0.198  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2252	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2252	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2252	  0.130  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2252	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2251	  0.188  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2251	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2251	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2251!  90.245  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x000000ef -2161	  0.181  apic_timer_interrupt+0x3a (cpu_star=
tup_entry+0x91)
:|   +func               -2161	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2160	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2160	  0.148  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2160	  0.114  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2160	  0.146  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2160	  0.139  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2160	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2160	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2159	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2159	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2159	  0.215  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2159	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2159	  0.117  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2159	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2159	  0.197  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2158	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-2061 -2158	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2158	  0.132  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2158	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2158	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2158	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2157	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2157	  0.365  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2157	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2157	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2156	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2156	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2156	  0.256  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2156	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2156	  0.139  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2156	  0.181  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2155	  0.172  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2155	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2155	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2155	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2155	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2155	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2154	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2154	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2154	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2154	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2154	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2154	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2154	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2153	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2153	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2153	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2153	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2153	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2153	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2153	  0.308  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2152	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2152	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2152	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2152	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2152	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2152	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2151	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2151	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2151	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2151!  90.098  apic_timer_interrupt+0x52 (cpu_sta=
rtup_entry+0x91)
:|   +begin   0x000000ef -2061	  0.176  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func               -2061	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -2060	  0.123  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -2060	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -2060	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -2060	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -2060	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -2060	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -2060	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2059	  0.127  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -2059	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -2059	  0.173  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -2059	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -2059	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -2059	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -2059	  0.198  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -2058	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1961 -2058	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -2058	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -2058	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -2058	  0.179  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -2058	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2057	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2057	  0.305  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -2057	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -2057	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2057	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2056	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2056	  0.216  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2056	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -2056	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -2056	  0.182  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -2056	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -2055	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -2055	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -2055	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -2055	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -2055	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -2055	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -2054	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -2054	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -2054	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -2054	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -2054	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -2054	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -2054	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -2054	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -2053	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -2053	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -2053	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -2053	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -2053	  0.288  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -2053	  0.221  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -2052	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -2052	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -2052	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -2052	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -2052	  0.279  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -2051	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -2051	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -2051	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -2051!  90.282  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x000000ef -1961	  0.184  apic_timer_interrupt+0x3a (cpu_star=
tup_entry+0x91)
:|   +func               -1961	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1960	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1960	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1960	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1960	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1960	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1960	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1960	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1959	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1959	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1959	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1959	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1959	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1959	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1959	  0.195  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1958	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1861 -1958	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1958	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1958	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1958	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1958	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1957	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1957	  0.307  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1957	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1957	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1957	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1956	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1956	  0.218  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1956	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1956	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1956	  0.181  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1956	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1955	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1955	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1955	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1955	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1955	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1955	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1954	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1954	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1954	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1954	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1954	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1954	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1954	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1954	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1953	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1953	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1953	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1953	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1953	  0.285  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1953	  0.221  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1952	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1952	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1952	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1952	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1952	  0.282  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1951	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1951	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1951	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -1951!  71.920  apic_timer_interrupt+0x52 (cpu_sta=
rtup_entry+0x91)
:|   +begin   0x00000051 -1879	  0.182  common_interrupt+0x39 (cpu_startup_=
entry+0x91)
:|   +func               -1879	  0.144  __ipipe_handle_irq+0x7 (common_inte=
rrupt+0x40)
:|   +func               -1879	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1879	  0.160  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1878	  0.124  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1878	  0.135  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x26)
:|   +func               -1878	  0.149  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x216)
:|   +func               -1878	  0.118  __ipipe_ack_fasteoi_irq+0x3 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1878	  0.120  hold_ioapic_irq+0x4 (__ipipe_ack_fa=
steoi_irq+0x10)
:|   +func               -1878	  0.135  io_apic_modify_irq.isra.9+0x7 (hold=
_ioapic_irq+0x41)
:|   +func               -1878	  0.117  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|   +func               -1878+   1.355  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|   +func               -1876	  0.111  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|   +func               -1876	  0.133  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|   +func               -1876	  0.130  io_apic_sync+0x3 (io_apic_modify_ir=
q.isra.9+0x41)
:|   +func               -1876+   1.165  io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func               -1875	  0.166  ack_apic_level+0x5 (hold_ioapic_irq=
+0x50)
:|   +func               -1875	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1874	  0.188  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1874	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1874	  0.141  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1874	  0.138  xnintr_irq_handler+0x9 (__ipipe_dis=
patch_irq+0x182)
:|  # func               -1874	  0.118  irqhandler_fpga+0x9 [sigmatek_lrt] =
(xnintr_irq_handler+0x78)
:|  # func               -1874	  0.136  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x5a [sigmatek_lrt])
:|  # func               -1874+   1.655  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func               -1872	  0.130  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func               -1872+   4.561  lrtdrv_monitoring_irq+0x4 [sigmate=
k_lrt] (irqhandler_fpga+0x13d [sigmatek_lrt])
:|  # func               -1867	  0.117  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1a4 [sigmatek_lrt])
:|  # func               -1867	  0.154  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1d2 [sigmatek_lrt])
:|  # func               -1867	  0.118  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x1e8 [sigmatek_lrt])
:|  # func               -1867	  0.118  xnarch_get_cpu_time+0x4 (irqhandler=
_fpga+0x225 [sigmatek_lrt])
:|  # func               -1867	  0.120  xnarch_tsc_to_ns+0x6 (xnarch_get_cp=
u_time+0x13)
:|  # func               -1867	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x245 [sigmatek_lrt])
:|  # func               -1866	  0.120  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x25b [sigmatek_lrt])
:|  # func               -1866	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x280 [sigmatek_lrt])
:|  # func               -1866	  0.114  period_update+0x4 [sigmatek_lrt] (i=
rqhandler_fpga+0x287 [sigmatek_lrt])
:|  # func               -1866	  0.146  lrtdrv_monitoring_start_timed+0x4 [=
sigmatek_lrt] (period_update+0x1f [sigmatek_lrt])
:|  # func               -1866	  0.212  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func               -1866	  0.227  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func               -1866	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func               -1865	  0.216  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func               -1865	  0.149  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func               -1865	  0.152  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func               -1865	  0.138  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  606] realtim 95 -1865	  0.225  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1864	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func               -1864	  0.164  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func               -1864	  0.187  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  512] VARAN_T 30 -1864	  0.233  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1864	  0.133  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  604] cyclic: 30 -1864	  0.155  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1863	  0.133  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  602] Loader: 29 -1863	  0.154  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1863	  0.207  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  608] backgrou 0 -1863	  0.225  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func               -1863	  0.117  ipipe_raise_irq+0x8 (period_update+=
0x10f [sigmatek_lrt])
:|  # func               -1863	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|  # func               -1863	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1862	  0.130  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|  # func               -1862	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  # func               -1862	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1862	  0.145  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  # func               -1862	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x1db)
:|  # func               -1862	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1862	  0.182  __ipipe_set_irq_pending+0x6 (__ipip=
e_dispatch_irq+0x1e4)
:|  # func               -1861	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  # func               -1861	  0.173  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1861+   1.658  ___xnpod_unlock_sched+0x3 (__xnpod=
_unlock_sched+0x19 [sigmatek_lrt])
:|  # func               -1860+   1.646  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func               -1858	  0.124  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func               -1858	  0.123  ___xnpod_unlock_sched+0x3 (__xnpod_=
unlock_sched+0x19 [sigmatek_lrt])
:|  # func               -1858	  0.172  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x10d [sigmatek_lrt])
:|  # func               -1857	  0.114  rthal_irq_end+0x5 (xnintr_irq_handl=
er+0x14d)
:|  # func               -1857	  0.123  irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  # func               -1857	  0.121  irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  # func               -1857	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  # func               -1857	  0.115  __ipipe_end_fasteoi_irq+0x3 (rthal_=
irq_end+0x38)
:|  # func               -1857	  0.115  release_ioapic_irq+0x5 (__ipipe_end=
_fasteoi_irq+0x16)
:|  # func               -1857	  0.151  __ipipe_spin_lock_irqsave+0x6 (rele=
ase_ioapic_irq+0x17)
:|  # func               -1857	  0.115  io_apic_modify_irq.isra.9+0x7 (rele=
ase_ioapic_irq+0x29)
:|  # func               -1856	  0.114  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|  # func               -1856+   1.333  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|  # func               -1855	  0.112  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|  # func               -1855	  0.123  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|  # func               -1855	  0.201  __ipipe_spin_unlock_irqrestore+0x4 =
(release_ioapic_irq+0x35)
:|  # func               -1855	  0.230  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # func               -1854	  0.166  __xnlock_spin+0x4 (__xnlock_get_irq=
save.constprop.43+0x3f)
:|  # [    0] -<?>-   -1 -1854	  0.144  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1854	  0.149  ipipe_send_ipi+0x6 (__xnpod_schedul=
e+0x7d)
:|  # func               -1854	  0.176  default_send_IPI_mask_logical+0x6 (=
ipipe_send_ipi+0x40)
:|  # func               -1854	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1854	  0.264  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1853	  0.307  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  606] realtim 95 -1853	  0.206  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1853	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1853	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1853	  0.332  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1852	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1852	  0.265  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x000000ef -1852	  0.133  apic_timer_interrupt+0x3a (hard_loc=
al_irq_enable+0x18)
:|  + func               -1852	  0.152  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func               -1852	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func               -1851	  0.126  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func               -1851	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func               -1851	  0.133  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func               -1851	  0.145  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func               -1851	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func               -1851	  0.191  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1851	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1850	  0.132  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1850	  0.219  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1850	  0.148  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1850	  0.118  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1850	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1850	  0.212  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1850	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1761 -1849	  0.114  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1849	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1849	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1849	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  606] realtim 95 -1849	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1849	  0.387  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1848	  0.397  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1848	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1848	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1847	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1847	  0.237  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1847	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1847	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1847	  0.191  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1847	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1846	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1846	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1846	  0.313  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1846	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1846	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1846	  0.190  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1845	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1845	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1845	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1845	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1845	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1845	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1845	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1845	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1844	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1844	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1844	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1844	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1844	  0.320  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1844	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  606] realtim 95 -1843	  0.200  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1843	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1843	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1843	  0.283  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func               -1842	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func               -1842	  0.146  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef -1842	  0.282  apic_timer_interrupt+0x52 (hard_loc=
al_irq_enable+0x18)
:   + func               -1842	  0.123  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func               -1842	  0.142  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1842	  0.126  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1842	  0.242  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001 -1841	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1841	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1841	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1841!  18.421  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   + func               -1822	  0.117  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1822	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1822	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1822	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1822	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1822	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1822	  0.127  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1821	  0.146  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1821	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1821	  0.117  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1821	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1821	  0.262  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1821	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1821	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1820	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1820	  0.129  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1820	  0.120  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1820	  0.144  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1820	  0.172  pci_locker_signal_stop+0x3 [sigmate=
k_lrt] (lrt_ioctl_work+0x768 [sigmatek_lrt])
:|  + begin   0x80000001 -1820	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1820	  0.132  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1819	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1819	  0.307  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1819	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1819	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1819	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1819	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1818	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1818	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1818	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1818	  0.141  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1818	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1818	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1818	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1818	  0.203  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1817	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1817	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1817	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1817	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1817	  0.118  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1817	  0.118  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1817	  0.151  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func               -1816	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func               -1816	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1816	  0.123  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1816	  0.130  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001 -1816	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001 -1816	  0.129  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func               -1816	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -1816	  0.120  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -1815	  0.210  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -1815	  0.157  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -1815	  0.170  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -1815	  0.193  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  606] realtim 95 -1815	  0.115  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1815	  0.305  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1814	  0.402  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30 -1814	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1814	  0.126  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1814	  0.141  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1813	  0.362  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1813	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1813	  0.154  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func               -1813	  0.120  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func               -1813	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1812	  0.124  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1812	  0.224  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001 -1812	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1812	  0.145  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1812	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1812!  50.921  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:|  + begin   0x000000ef -1761	  0.130  apic_timer_interrupt+0x3a (<102d024=
a>)
:|  + func               -1761	  0.152  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func               -1760	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func               -1760	  0.149  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func               -1760	  0.118  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func               -1760	  0.129  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func               -1760	  0.148  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func               -1760	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func               -1760	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1760	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1759	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1759	  0.250  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1759	  0.151  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1759	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1759	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1759	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1758	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1661 -1758	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1758	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1758	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1758	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30 -1758	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1757	  0.389  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1757	  0.396  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1757	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1757	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1756	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1756	  0.268  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1756	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1756	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1756	  0.185  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1756	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1755	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1755	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1755	  0.308  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1755	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1755	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1754	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1754	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1754	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1754	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1754	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1754	  0.136  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1754	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1754	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1753	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1753	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1753	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1753	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1753	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1753	  0.298  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1752	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30 -1752	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1752	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1752	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1752	  0.280  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func               -1751	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func               -1751	  0.146  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef -1751!  90.391  apic_timer_interrupt+0x52 (<102d02=
4a>)
:|  + begin   0x000000ef -1661	  0.209  apic_timer_interrupt+0x3a (<102d024=
a>)
:|  + func               -1661	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func               -1660	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func               -1660	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func               -1660	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func               -1660	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func               -1660	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func               -1660	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func               -1660	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1659	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1659	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1659	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1659	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1659	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1659	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1659	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1658	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1561 -1658	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1658	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1658	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1658	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30 -1658	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1658	  0378  xnsched_pick_next+0x5 (__xnpod_sched=
ule+0xa5)
:|  # func               -1657	  0.397  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1657	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1657	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1656	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1656	  0.247  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1656	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1656	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1656	  0.185  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1656	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1655	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1655	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1655	  0.301  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1655	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1655	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1655	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1654	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1654	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1654	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1654	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1654	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1654	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1654	  0.127  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1653	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1653	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1653	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1653	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1653	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1653	  0.292  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1652	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30 -1652	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1652	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1652	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1652	  0.265  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func               -1651	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func               -1651	  0.146  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef -1651!  97.810  apic_timer_interrupt+0x52 (<102d02=
4a>)
:|  + begin   0x000000ef -1553	  0.136  apic_timer_interrupt+0x3a (<10139d1=
e>)
:|  + func               -1553	  0.166  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func               -1553	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func               -1553	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func               -1553	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func               -1553	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func               -1553	  0.144  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func               -1552	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func               -1552	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1552	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1552	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1552	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1552	  0.148  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1552	  0.120  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1552	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1551	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1551	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1461 -1551	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1551	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1551	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1551	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30 -1550	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1550	  0.319  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1550	  0.403  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1550	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1549	  0.126  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1549	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1549	  0.213  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1549	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1549	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1549	  0.185  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1548	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1548	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1548	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1548	  0.305  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1548	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1547	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1547	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1547	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1547	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1547	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1547	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1547	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1547	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1546	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1546	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1546	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1546	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1546	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1546	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1546	  0.291  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1545	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30 -1545	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1545	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1545	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1545	  0.261  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func               -1544	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func               -1544	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef -1544!  83.896  apic_timer_interrupt+0x52 (<10139d=
1e>)
:|  + begin   0x000000ef -1460	  0.132  apic_timer_interrupt+0x3a (<1013cb6=
3>)
:|  + func               -1460	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func               -1460	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func               -1460	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func               -1460	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func               -1459	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func               -1459	  0.144  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func               -1459	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func               -1459	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1459	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1459	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1459	  0.172  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1459	  0.133  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1458	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1458	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1458	  0.206  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1458	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1361 -1458	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1458	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1458	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1457	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30 -1457	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1457	  0.322  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1457	  0.396  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1456	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1456	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1456	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1456	  0.213  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1456	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1455	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1455	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1455	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1455	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1455	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1455	  0.304  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1454	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1454	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1454	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1454	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1454	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1454	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1454	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1453	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1453	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1453	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1453	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1453	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1453	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1453	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1452	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1452	  0.291  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1452	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30 -1452	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1452	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1451	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1451	  0.264  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func               -1451	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func               -1451	  0.146  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef -1451	  0.629  apic_timer_interrupt+0x52 (<1013cb6=
3>)
:   + func               -1450	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1450	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1450	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1450	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1450	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1450	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1449	  0.124  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1449	  0.146  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1449	  0.118  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1449	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1449	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1449	  0.210  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1449	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1448	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1448	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1448	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1448	  0.118  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1448	  0.120  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1448	  0.149  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func               -1448	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func               -1447	  0.118  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func               -1447	  0.121  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func               -1447	  0.123  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001 -1447	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001 -1447	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func               -1447	  0.123  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -1447	  0.121  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -1447	  0.155  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -1446	  0.193  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -1446	  0.152  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -1446	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30 -1446	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1446	  0.265  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1446	  0.408  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  602] Loader: 29 -1445	  0.203  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1445	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1445	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1445	  0.285  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1444	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1444	  0.167  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func               -1444	  0.233  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x465 [sigmatek_lrt])
:|  + begin   0x80000001 -1444	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1444	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1444	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1443+   1.098  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   + func               -1442	  0.120  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1442	  0.118  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1442	  0.185  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1442	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1442	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1442	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1441	  0.124  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1441	  0.141  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1441	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func               -1441	  0.120  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func               -1441	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000 -1441	  0.203  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func               -1441	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1441	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1440	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001 -1440	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func               -1440	  0.117  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func               -1440	  0.136  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func               -1440	  0.124  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  + begin   0x80000001 -1440	  0.144  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:|  + end     0x80000001 -1440	  0.127  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x41d [sigmatek_lrt])
:   + func               -1439	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func               -1439	  0.121  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000 -1439	  0.155  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func               -1439	  0.160  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func               -1439	  0.144  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func               -1439	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  602] Loader: 29 -1439	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1438	  0.286  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1438	  0.319  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1438	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1438	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1438	  0.115  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1437	  0.154  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1437	  0.314  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1437	  0.191  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1437	  0.161  __ipipe_do_sync_stage+0x9 (__ipipe_=
do_sync_pipeline+0x5e)
:|   #end     0x80000000 -1437	  0.114  hard_local_irq_enable+0x16 (__ipipe=
_do_sync_stage+0xa1)
:    #func               -1437	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0xe4)
:    #func               -1436	  0.126  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:    #func               -1436	  0.120  irq_enter+0x4 (__ipipe_do_sync_stag=
e+0xe9)
:|   #begin   0x80000001 -1436	  0.142  debug_smp_processor_id+0x36 (irq_en=
ter+0xe)
:|   #end     0x80000001 -1436	  0.130  debug_smp_processor_id+0x82 (irq_en=
ter+0xe)
:    #func               -1436	  0.145  rcu_irq_enter+0x7 (irq_enter+0x15)
:|   #begin   0x80000001 -1436	  0.142  debug_smp_processor_id+0x36 (rcu_ir=
q_enter+0x1e)
:|   #end     0x80000001 -1436	  0.136  debug_smp_processor_id+0x82 (rcu_ir=
q_enter+0x1e)
:    #func               -1435	  0.132  rcu_eqs_exit_common.isra.47+0x5 (rc=
u_irq_enter+0x70)
:|   #begin   0x80000001 -1435	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_exit_common.isra.47+0x41)
:|   #end     0x80000001 -1435	  0.130  debug_smp_processor_id+0x82 (rcu_eq=
s_exit_common.isra.47+0x41)
:    #func               -1435	  0.114  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1435	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1435	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1435	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1434	  0.114  local_bh_disable+0x3 (irq_enter+0x3=
9)
:    #func               -1434	  0.117  add_preempt_count+0x4 (local_bh_dis=
able+0x12)
:    #func               -1434	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1434	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1434	  0.132  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1434	  0.117  tick_check_idle+0x8 (irq_enter+0x40)
:    #func               -1434	  0.149  tick_check_oneshot_broadcast+0x3 (t=
ick_check_idle+0x19)
:    #func               -1434	  0.203  ktime_get+0x9 (tick_check_idle+0x31)
:    #func               -1433	  0.115  tick_nohz_stop_idle+0x4 (tick_check=
_idle+0x48)
:    #func               -1433	  0.114  update_ts_time_stats+0x9 (tick_nohz=
_stop_idle+0x20)
:    #func               -1433	  0.129  nr_iowait_cpu+0x3 (update_ts_time_s=
tats+0x31)
:|   #begin   0x80000001 -1433	  0.142  debug_smp_processor_id+0x36 (tick_c=
heck_idle+0x53)
:|   #end     0x80000001 -1433	  0.163  debug_smp_processor_id+0x82 (tick_c=
heck_idle+0x53)
:    #func               -1433	  0.117  tick_do_update_jiffies64+0x9 (tick_=
check_idle+0x84)
:    #func               -1433	  0.114  ipipe_restore_root+0x4 (tick_check_=
idle+0x97)
:    #func               -1432	  0.120  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1432	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1432	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1432	  0.117  _local_bh_enable+0x3 (irq_enter+0x4=
5)
:    #func               -1432	  0.148  __local_bh_enable+0x4 (_local_bh_en=
able+0x12)
:    #func               -1432	  0.111  sub_preempt_count+0x4 (__local_bh_e=
nable+0x6a)
:    #func               -1432	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1432	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1431	  0.139  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1431	  0.117  add_preempt_count+0x4 (irq_enter+0x=
4f)
:    #func               -1431	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1431	  0.161  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1431	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1431	  0.115  wait_domain_nrt_handler+0x3 [sigmat=
ek_lrt] (__ipipe_do_sync_stage+0xff)
:    #func               -1431	  0.114  __wake_up+0x8 (wait_domain_nrt_hand=
ler+0x33 [sigmatek_lrt])
:    #func               -1430	  0.142  _raw_spin_lock_irqsave+0x5 (__wake_=
up+0x1a)
:    #func               -1430	  0.115  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1430	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1430	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1430	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1430	  0.118  __wake_up_common+0x9 (__wake_up+0x2=
e)
:    #func               -1430	  0.118  ipipe_root_only+0x5 (__wake_up_comm=
on+0x1b)
:|   #begin   0x80000001 -1430	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1429	  0.130  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1429	  0.123  __ipipe_spin_unlock_debug+0x3 (__wa=
ke_up+0x35)
:    #func               -1429	  0.124  _raw_spin_unlock_irqrestore+0x4 (__=
wake_up+0x3e)
:    #func               -1429	  0.117  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1429	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1429	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1429	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1428	  0.114  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1428	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1428	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1428	  0.138  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1428	  0.130  irq_exit+0x3 (__ipipe_do_sync_stage=
+0x104)
:    #func               -1428	  0.114  sub_preempt_count+0x4 (irq_exit+0x1=
7)
:    #func               -1428	  0.118  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1428	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1427	  0.158  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:|   #begin   0x80000001 -1427	  0.142  debug_smp_processor_id+0x36 (irq_ex=
it+0x4b)
:|   #end     0x80000001 -1427	  0.126  debug_smp_processor_id+0x82 (irq_ex=
it+0x4b)
:    #func               -1427	  0.124  idle_cpu+0x3 (irq_exit+0x50)
:    #func               -1427	  0.118  tick_nohz_irq_exit+0x4 (irq_exit+0x=
79)
:|   #begin   0x80000001 -1427	  0.142  debug_smp_processor_id+0x36 (tick_n=
ohz_irq_exit+0x13)
:|   #end     0x80000001 -1427	  0.129  debug_smp_processor_id+0x82 (tick_n=
ohz_irq_exit+0x13)
:    #func               -1426	  0.120  __tick_nohz_idle_enter+0x9 (tick_no=
hz_irq_exit+0x27)
:|   #begin   0x80000001 -1426	  0.142  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x16)
:|   #end     0x80000001 -1426	  0.129  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x16)
:    #func               -1426	  0.154  ktime_get+0x9 (__tick_nohz_idle_ent=
er+0x1e)
:|   #begin   0x80000001 -1426	  0.152  debug_smp_processor_id+0x36 (sched_=
clock_idle_sleep_event+0x8)
:|   #end     0x80000001 -1426	  0.145  debug_smp_processor_id+0x82 (sched_=
clock_idle_sleep_event+0x8)
:|   #begin   0x80000001 -1426	  0.149  debug_smp_processor_id+0x36 (__cycl=
es_2_ns+0x14)
:|   #end     0x80000001 -1425	  0.155  debug_smp_processor_id+0x82 (__cycl=
es_2_ns+0x14)
:|   #begin   0x80000001 -1425	  0.141  debug_smp_processor_id+0x36 (__tick=
_nohz_idle_enter+0x3b5)
:|   #end     0x80000001 -1425	  0.190  debug_smp_processor_id+0x82 (__tick=
_nohz_idle_enter+0x3b5)
:    #func               -1425	  0.135  timekeeping_max_deferment+0x5 (__ti=
ck_nohz_idle_enter+0x108)
:    #func               -1425	  0.145  rcu_needs_cpu+0x5 (__tick_nohz_idle=
_enter+0x124)
:|   #begin   0x80000001 -1425	  0.141  debug_smp_processor_id+0x36 (irq_wo=
rk_needs_cpu+0xe)
:|   #end     0x80000001 -1425	  0.130  debug_smp_processor_id+0x82 (irq_wo=
rk_needs_cpu+0xe)
:    #func               -1424	  0.138  get_next_timer_interrupt+0x9 (__tic=
k_nohz_idle_enter+0x147)
:|   #begin   0x80000001 -1424	  0.144  debug_smp_processor_id+0x36 (get_ne=
xt_timer_interrupt+0x25)
:|   #end     0x80000001 -1424	  0.127  debug_smp_processor_id+0x82 (get_ne=
xt_timer_interrupt+0x25)
:    #func               -1424	  0.115  _raw_spin_lock+0x4 (get_next_timer_=
interrupt+0x3f)
:    #func               -1424	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck+0x15)
:    #func               -1424	  0.117  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1424	  0.164  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1424	  0.155  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1423	  0.124  _raw_spin_unlock+0x3 (get_next_time=
r_interrupt+0x158)
:    #func               -1423	  0.118  sub_preempt_count+0x4 (_raw_spin_un=
lock+0x17)
:    #func               -1423	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1423	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1423	  0.133  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1423	  0.121  hrtimer_get_next_event+0x9 (get_nex=
t_timer_interrupt+0x162)
:|   #begin   0x80000001 -1423	  0.142  debug_smp_processor_id+0x36 (hrtime=
r_get_next_event+0x18)
:|   #end     0x80000001 -1422	  0.127  debug_smp_processor_id+0x82 (hrtime=
r_get_next_event+0x18)
:    #func               -1422	  0.142  _raw_spin_lock_irqsave+0x5 (hrtimer=
_get_next_event+0x26)
:    #func               -1422	  0.114  add_preempt_count+0x4 (_raw_spin_lo=
ck_irqsave+0x1d)
:    #func               -1422	  0.118  ipipe_root_only+0x5 (add_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1422	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1422	  0.142  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1422	  0.117  __ipipe_spin_unlock_debug+0x3 (hrti=
mer_get_next_event+0x97)
:    #func               -1422	  0.121  _raw_spin_unlock_irqrestore+0x4 (hr=
timer_get_next_event+0xa0)
:    #func               -1421	  0.118  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1421	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1421	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1421	  0.144  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1421	  0.120  sub_preempt_count+0x4 (_raw_spin_un=
lock_irqrestore+0x21)
:    #func               -1421	  0.117  ipipe_root_only+0x5 (sub_preempt_co=
unt+0x10)
:|   #begin   0x80000001 -1421	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1420	  0.152  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1420	  0.146  rcu_irq_exit+0x5 (irq_exit+0x7e)
:|   #begin   0x80000001 -1420	  0.141  debug_smp_processor_id+0x36 (rcu_ir=
q_exit+0x1b)
:|   #end     0x80000001 -1420	  0.130  debug_smp_processor_id+0x82 (rcu_ir=
q_exit+0x1b)
:    #func               -1420	  0.121  rcu_eqs_enter_common.isra.49+0x6 (r=
cu_irq_exit+0x68)
:|   #begin   0x80000001 -1420	  0.142  debug_smp_processor_id+0x36 (rcu_eq=
s_enter_common.isra.49+0x7d)
:|   #end     0x80000001 -1420	  0.141  debug_smp_processor_id+0x82 (rcu_eq=
s_enter_common.isra.49+0x7d)
:    #func               -1419	  0.120  ipipe_restore_root+0x4 (arch_local_=
irq_restore+0x11)
:    #func               -1419	  0.117  ipipe_root_only+0x5 (ipipe_restore_=
root+0x10)
:|   #begin   0x80000001 -1419	  0.163  hard_local_irq_save+0x16 (ipipe_roo=
t_only+0xf)
:|   #end     0x80000001 -1419	  0.157  hard_local_irq_restore+0x15 (ipipe_=
root_only+0x3f)
:    #func               -1419	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_do_sync_stage+0x117)
:    #func               -1419	  0.126  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   #begin   0x80000000 -1419	  0.181  hard_local_irq_disable+0x17 (__ipip=
e_do_sync_stage+0x11c)
:|   +func               -1419	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1418	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x00000051 -1418!  57.503  common_interrupt+0x51 (cpu_startup=
_entry+0x91)
:|   +begin   0x000000ef -1361	  0.172  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func               -1361	  0.172  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1360	  0.126  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1360	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1360	  0.139  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1360	  0.130  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1360	  0.151  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1360	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1360	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1359	  0.129  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1359	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1359	  0.219  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1359	  0.141  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1359	  0.114  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1359	  0.135  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1359	  0.190  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1358	  0.123  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1261 -1358	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1358	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1358	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1358	  0.178  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1358	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1357	  0.148  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1357	  0.319  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1357	  0.319  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1357	  0.212  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1356	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1356	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1356	  0.234  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1356	  0.163  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1356	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1356	  0.204  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1355	  0.167  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1355	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1355	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1355	  0.322  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1355	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1355	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1354	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1354	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1354	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1354	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1354	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1354	  0.129  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1354	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1353	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1353	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1353	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1353	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1353	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1353	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1353	  0.298  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1352	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1352	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1352	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1352	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1352	  0.127  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1352	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1351	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1351	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1351	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -1351!  90.100  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x000000ef -1261	  0.173  apic_timer_interrupt+0x3a (need_res=
ched+0x1)
:|   +func               -1261	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1260	  0.123  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1260	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1260	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1260	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1260	  0.145  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1260	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1260	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1259	  0.127  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1259	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1259	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1259	  0.138  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1259	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1259	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1259	  0.194  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1258	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1161 -1258	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1258	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1258	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1258	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1258	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1257	  0.151  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1257	  0.308  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1257	  0.301  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1257	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1257	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1256	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1256	  0.234  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1256	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1256	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1256	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1256	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1255	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1255	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1255	  0.301  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1255	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1255	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1255	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1254	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1254	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1254	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1254	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1254	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1254	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1254	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1253	  0.121  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1253	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1253	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1253	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1253	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1253	  0.299  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1252	  0.221  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1252	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1252	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1252	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1252	  0.127  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1252	  0.282  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1251	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1251	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1251	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -1251!  90.222  apic_timer_interrupt+0x52 (need_re=
sched+0x1)
:|   +begin   0x000000ef -1161	  0.175  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func               -1161	  0.176  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1160	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1160	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1160	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1160	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1160	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1160	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1160	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1159	  0.126  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1159	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1159	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1159	  0.133  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1159	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1159	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1159	  0.198  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1158	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-1061 -1158	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1158	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1158	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1158	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1158	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1157	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1157	  0.308  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1157	  0.301  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1157	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1157	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1156	  0.121  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1156	  0.234  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1156	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1156	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1156	  0.187  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1156	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1155	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1155	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1155	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1155	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1155	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1155	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1154	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1154	  0.126  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1154	  0.148  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1154	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1154	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1154	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1154	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1154	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1153	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1153	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1153	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1153	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1153	  0.299  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1152	  0.225  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1152	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1152	  0.117  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1152	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1152	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1152	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1151	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1151	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1151	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -1151!  90.241  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x000000ef -1061	  0.185  apic_timer_interrupt+0x3a (cpu_star=
tup_entry+0x91)
:|   +func               -1061	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func               -1060	  0.124  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func               -1060	  0.151  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func               -1060	  0.114  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func               -1060	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func               -1060	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func               -1060	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func               -1060	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1059	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func               -1059	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func               -1059	  0.216  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func               -1059	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func               -1059	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func               -1059	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99 -1059	  0.194  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func               -1058	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-961  -1058	  0.111  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func               -1058	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func               -1058	  0.253  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func               -1058	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1 -1058	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1057	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1057	  0.365  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func               -1057	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99 -1057	  0.234  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1056	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1056	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1056	  0.228  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1056	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func               -1056	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000 -1056	  0.182  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001 -1055	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001 -1055	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000 -1055	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000 -1055	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func               -1055	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func               -1055	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001 -1054	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001 -1054	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func               -1054	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001 -1054	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001 -1054	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func               -1054	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func               -1054	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func               -1053	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func               -1053	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000 -1053	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func               -1053	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func               -1053	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99 -1053	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func               -1053	  0.299  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func               -1052	  0.218  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1 -1052	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func               -1052	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func               -1052	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func               -1052	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func               -1052	  0.279  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func               -1051	  0.190  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func               -1051	  0.118  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func               -1051	  0.164  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef -1051!  90.100  apic_timer_interrupt+0x52 (cpu_sta=
rtup_entry+0x91)
:|   +begin   0x000000ef  -961	  0.175  apic_timer_interrupt+0x3a (need_res=
ched+0x0)
:|   +func                -961	  0.178  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|   +func                -960	  0.123  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func                -960	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func                -960	  0.117  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func                -960	  0.144  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|   +func                -960	  0.142  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|   +func                -960	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func                -960	  0.176  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -959	  0.127  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -959	  0.121  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -959	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -959	  0.135  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -959	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -959	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99  -959	  0.175  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -958	  0.123  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-861   -958	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -958	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -958	  0.256  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -958	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [    0] -<?>-   -1  -958	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -958	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -957	  0.311  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func                -957	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99  -957	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -957	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -956	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -956	  0.216  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -956	  0.160  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -956	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -956	  0.182  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -956	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -955	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -955	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -955	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -955	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -955	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -955	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -954	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -954	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -954	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -954	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -954	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -954	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -954	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -954	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -953	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -953	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -953	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99  -953	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -953	  0.288  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -953	  0.219  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [    0] -<?>-   -1  -952	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -952	  0.118  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -952	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -952	  0.129  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -952	  0.280  xnarch_tsc_to_ns+0x6 (measureIdleTi=
me+0xae [sigmatek_lrt])
:|   +func                -951	  0.191  __ipipe_do_sync_pipeline+0x4 (__ipi=
pe_dispatch_irq+0x1c1)
:|   +func                -951	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|   +func                -951	  0.166  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +end     0x000000ef  -951!  72.348  apic_timer_interrupt+0x52 (need_re=
sched+0x0)
:|   +begin   0x00000051  -879	  0.179  common_interrupt+0x39 (cpu_startup_=
entry+0x91)
:|   +func                -878	  0.142  __ipipe_handle_irq+0x7 (common_inte=
rrupt+0x40)
:|   +func                -878	  0.111  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|   +func                -878	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|   +func                -878	  0.124  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|   +func                -878	  0.139  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x26)
:|   +func                -878	  0.152  irq_to_desc+0x3 (__ipipe_dispatch_i=
rq+0x216)
:|   +func                -878	  0.118  __ipipe_ack_fasteoi_irq+0x3 (__ipip=
e_dispatch_irq+0xa9)
:|   +func                -878	  0.127  hold_ioapic_irq+0x4 (__ipipe_ack_fa=
steoi_irq+0x10)
:|   +func                -877	  0.135  io_apic_modify_irq.isra.9+0x7 (hold=
_ioapic_irq+0x41)
:|   +func                -877	  0.114  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|   +func                -877+   1.361  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|   +func                -876	  0.112  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|   +func                -876	  0.132  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|   +func                -876	  0.132  io_apic_sync+0x3 (io_apic_modify_ir=
q.isra.9+0x41)
:|   +func                -875+   1.162  io_apic_base+0x3 (io_apic_sync+0xf)
:|   +func                -874	  0.166  ack_apic_level+0x5 (hold_ioapic_irq=
+0x50)
:|   +func                -874	  0.112  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|   +func                -874	  0.187  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -874	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -874	  0.141  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -874	  0.138  xnintr_irq_handler+0x9 (__ipipe_dis=
patch_irq+0x182)
:|  # func                -873	  0.121  irqhandler_fpga+0x9 [sigmatek_lrt] =
(xnintr_irq_handler+0x78)
:|  # func                -873	  0.136  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x5a [sigmatek_lrt])
:|  # func                -873+   1.655  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func                -871	  0.127  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func                -871+   4.564  lrtdrv_monitoring_irq+0x4 [sigmate=
k_lrt] (irqhandler_fpga+0x13d [sigmatek_lrt])
:|  # func                -867	  0.117  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1a4 [sigmatek_lrt])
:|  # func                -867	  0.154  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x1d2 [sigmatek_lrt])
:|  # func                -867	  0.118  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x1e8 [sigmatek_lrt])
:|  # func                -866	  0.118  xnarch_get_cpu_time+0x4 (irqhandler=
_fpga+0x225 [sigmatek_lrt])
:|  # func                -866	  0.118  xnarch_tsc_to_ns+0x6 (xnarch_get_cp=
u_time+0x13)
:|  # func                -866	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x245 [sigmatek_lrt])
:|  # func                -866	  0.120  xnarch_tsc_to_ns+0x6 (irqhandler_fp=
ga+0x25b [sigmatek_lrt])
:|  # func                -866	  0.117  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x280 [sigmatek_lrt])
:|  # func                -866	  0.115  period_update+0x4 [sigmatek_lrt] (i=
rqhandler_fpga+0x287 [sigmatek_lrt])
:|  # func                -866	  0.146  lrtdrv_monitoring_start_timed+0x4 [=
sigmatek_lrt] (period_update+0x1f [sigmatek_lrt])
:|  # func                -866	  0.206  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func                -865	  0.227  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func                -865	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func                -865	  0.216  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func                -865	  0.148  rtdm_event_signal+0x5 (period_updat=
e+0xd9 [sigmatek_lrt])
:|  # func                -865	  0.152  xnsynch_flush+0x9 (rtdm_event_signa=
l+0x25)
:|  # func                -864	  0.138  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  606] realtim 95  -864	  0.227  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -864	  0.145  __rtdm_synch_flush+0x6 (period_upda=
te+0xe3 [sigmatek_lrt])
:|  # func                -864	  0.163  xnsynch_flush+0x9 (__rtdm_synch_flu=
sh+0x2f)
:|  # func                -864	  0.201  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  512] VARAN_T 30  -864	  0.236  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -863	  0.135  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  604] cyclic: 30  -863	  0.154  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -863	  0.135  xnpod_resume_thread+0x9 (xnsynch_fl=
ush+0x47)
:|  # [  602] Loader: 29  -863	  0.250  xnpod_resume_thread+0x39 (xnsynch_f=
lush+0x47)
:|  # func                -863	  0.132  ipipe_raise_irq+0x8 (period_update+=
0x10f [sigmatek_lrt])
:|  # func                -863	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (ipipe_raise_irq+0x36)
:|  # func                -862	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -862	  0.132  __ipipe_handle_irq+0x7 (ipipe_raise=
_irq+0x3e)
:|  # func                -862	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  # func                -862	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -862	  0.146  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  # func                -862	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x1db)
:|  # func                -862	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -862	  0.184  __ipipe_set_irq_pending+0x6 (__ipip=
e_dispatch_irq+0x1e4)
:|  # func                -861	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  # func                -861	  0.175  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -861+   1.637  ___xnpod_unlock_sched+0x3 (__xnpod=
_unlock_sched+0x19 [sigmatek_lrt])
:|  # func                -859+   1.646  ___xnpod_lock_sched+0x4 (__xnpod_l=
ock_sched+0x19 [sigmatek_lrt])
:|  # func                -858	  0.124  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0xe6 [sigmatek_lrt])
:|  # func                -858	  0.123  ___xnpod_unlock_sched+0x3 (__xnpod_=
unlock_sched+0x19 [sigmatek_lrt])
:|  # func                -858	  0.172  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irqhandler_fpga+0x10d [sigmatek_lrt])
:|  # func                -857	  0.115  rthal_irq_end+0x5 (xnintr_irq_handl=
er+0x14d)
:|  # func                -857	  0.123  irq_to_desc+0x3 (rthal_irq_end+0x1d)
:|  # func                -857	  0.121  irq_to_desc+0x3 (rthal_irq_end+0x28)
:|  # func                -857	  0.120  irq_to_desc+0x3 (rthal_irq_end+0x32)
:|  # func                -857	  0.115  __ipipe_end_fasteoi_irq+0x3 (rthal_=
irq_end+0x38)
:|  # func                -857	  0.115  release_ioapic_irq+0x5 (__ipipe_end=
_fasteoi_irq+0x16)
:|  # func                -857	  0.152  __ipipe_spin_lock_irqsave+0x6 (rele=
ase_ioapic_irq+0x17)
:|  # func                -856	  0.114  io_apic_modify_irq.isra.9+0x7 (rele=
ase_ioapic_irq+0x29)
:|  # func                -856	  0.114  native_io_apic_read+0x4 (io_apic_re=
ad+0x9)
:|  # func                -856+   1.355  io_apic_base+0x3 (native_io_apic_r=
ead+0x10)
:|  # func                -855	  0.112  native_io_apic_modify+0x5 (io_apic_=
modify_irq.isra.9+0x36)
:|  # func                -855	  0.121  io_apic_base+0x3 (native_io_apic_mo=
dify+0x13)
:|  # func                -855	  0.299  __ipipe_spin_unlock_irqrestore+0x4 =
(release_ioapic_irq+0x35)
:|  # func                -854	  0.250  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # func                -854+   1.716  __xnlock_spin+0x4 (__xnlock_get_ir=
qsave.constprop.43+0x3f)
:|  # [    0] -<?>-   -1  -852	  0.135  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -852	  0.148  ipipe_send_ipi+0x6 (__xnpod_schedul=
e+0x7d)
:|  # func                -852	  0.176  default_send_IPI_mask_logical+0x6 (=
ipipe_send_ipi+0x40)
:|  # func                -852	  0.127  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -852	  0.304  __ipipe_notify_vm_preemption+0x4 (_=
_xnpod_schedule+0x141)
:|  # func                -852	  0.308  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  606] realtim 95  -851	  0.206  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -851	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -851	  0.142  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -851	  0.335  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -850	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -850	  0.267  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x000000ef  -850	  0.130  apic_timer_interrupt+0x3a (hard_loc=
al_irq_enable+0x18)
:|  + func                -850	  0.149  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -850	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -850	  0.123  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func                -849	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -849	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -849	  0.145  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -849	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func                -849	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -849	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -849	  0.132  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -849	  0.170  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -848	  0.154  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -848	  0.120  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -848	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99  -848	  0.212  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -848	  0.127  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-761   -848	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -848	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -847	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -847	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  606] realtim 95  -847	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -847	  0.329  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -847	  0.399  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99  -846	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -846	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -846	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -846	  0.242  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -845	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -845	  0.133  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -845	  0.187  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -845	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -845	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -845	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -844	  0.307  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -844	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -844	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -844	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -844	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -844	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -843	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -843	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -843	  0.126  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -843	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -843	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -843	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -843	  0.219  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -843	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -842	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99  -842	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -842	  0.301  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -842	  0.304  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  606] realtim 95  -841	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -841	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -841	  0.141  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -841	  0.296  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -841	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func                -841	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef  -840	  0.283  apic_timer_interrupt+0x52 (hard_loc=
al_irq_enable+0x18)
:   + func                -840	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func                -840	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -840	  0.129  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -840	  0.243  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001  -840	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -839	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -839	  0.170  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -839!  18.387  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:   + func                -821	  0.120  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -821	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -820	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -820	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -820	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -820	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -820	  0.129  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -820	  0.169  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -820	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func                -819	  0.115  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func                -819	  0.123  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000  -819	  0.262  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func                -819	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -819	  0.124  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -819	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001  -819	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func                -818	  0.117  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func                -818	  0.155  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func                -818	  0.169  pci_locker_signal_stop+0x3 [sigmate=
k_lrt] (lrt_ioctl_work+0x768 [sigmatek_lrt])
:|  + begin   0x80000001  -818	  0.170  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -818	  0.132  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -818	  0.160  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -818	  0.308  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -817	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -817	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -817	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -817	  0.127  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -817	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -817	  0.144  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -816	  0.127  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -816	  0.139  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -816	  0.120  sys_rtdm_ioctl+0x3 (hisyscall_event=
+0x129)
:   + func                -816	  0.117  __rt_dev_ioctl+0x9 (sys_rtdm_ioctl+=
0x1d)
:   + func                -816	  0.121  rtdm_context_get+0x6 (__rt_dev_ioct=
l+0x24)
:|  + begin   0x80000000  -816	  0.204  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave+0xc)
:|  # func                -816	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -815	  0.123  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -815	  0.144  rtdm_in_rt_context+0x1d (__rt_dev_i=
octl+0x36)
:|  + end     0x80000001  -815	  0.127  rtdm_in_rt_context+0x67 (__rt_dev_i=
octl+0x36)
:   + func                -815	  0.120  lrt_ioctl+0x3 [sigmatek_lrt] (__rt_=
dev_ioctl+0x46)
:   + func                -815	  0.118  lrt_ioctl_work+0xc [sigmatek_lrt] (=
lrt_ioctl+0x10 [sigmatek_lrt])
:   + func                -815	  0.152  __copy_from_user_ll_nozero+0x6 (rtd=
m_safe_copy_from_user.isra.4+0x23 [sigmatek_lrt])
:   + func                -815	  0.117  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4a2 [sigmatek_lrt])
:   + func                -815	  0.118  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -814	  0.121  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -814	  0.132  lrtdrv_timing_wait+0x9 [sigmatek_lr=
t] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + begin   0x80000001  -814	  0.142  lrtdrv_timing_wait+0x39 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:|  + end     0x80000001  -814	  0.129  lrtdrv_timing_wait+0x85 [sigmatek_l=
rt] (lrt_ioctl_work+0x4c9 [sigmatek_lrt])
:   + func                -814	  0.118  rtdm_event_wait+0x3 (lrtdrv_timing_=
wait+0xdc [sigmatek_lrt])
:   + func                -814	  0.121  rtdm_event_timedwait+0x9 (rtdm_even=
t_wait+0x13)
:|  + begin   0x80000000  -814	  0.207  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.14+0x9)
:|  # func                -813	  0.158  xnsynch_sleep_on+0x9 (rtdm_event_ti=
medwait+0x8e)
:|  # func                -813	  0.145  xnpod_suspend_thread+0x9 (xnsynch_s=
leep_on+0x8b)
:|  # func                -813	  0.166  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  606] realtim 95  -813	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -813	  0.307  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -813	  0.405  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30  -812	  0.197  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -812	  0.121  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -812	  0.142  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -812	  0.359  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -811	  0.136  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -811	  0.164  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:   + func                -811	  0.118  lrtdrv_timing_watchdog+0x6 [sigmate=
k_lrt] (lrt_ioctl_work+0x4ea [sigmatek_lrt])
:   + func                -811	  0.117  setup_watchdog+0x6 [sigmatek_lrt] (=
lrtdrv_timing_watchdog+0x46 [sigmatek_lrt])
:   + func                -811	  0.124  rt_task_self+0x3 (setup_watchdog+0x=
42 [sigmatek_lrt])
:   + func                -811	  0.225  __copy_to_user_ll+0x6 (lrt_ioctl_wo=
rk+0x52e [sigmatek_lrt])
:|  + begin   0x80000001  -810	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -810	  0.146  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -810	  0.163  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -810!  49.213  __ipipe_syscall_root+0x70 (sysente=
r_past_esp+0x5b)
:|  + begin   0x000000ef  -761	  0.129  apic_timer_interrupt+0x3a (<102d024=
a>)
:|  + func                -761	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -760	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -760	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func                -760	  0.118  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -760	  0.129  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -760	  0.148  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -760	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func                -760	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -760	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -759	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -759	  0.219  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -759	  0.138  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -759	  0.112  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -759	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99  -759	  0.182  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -759	  0.123  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-661   -758	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -758	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -758	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -758	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30  -758	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -758	  0.334  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -757	  0.396  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99  -757	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -757	  0.123  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -757	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -756	  0.236  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -756	  0.164  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -756	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -756	  0.184  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -756	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -756	  0.144  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -755	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -755	  0.308  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -755	  0.118  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -755	  0.121  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -755	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -754	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -754	  0.118  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -754	  0.146  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -754	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -754	  0.130  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -754	  0.114  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -754	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -754	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -753	  0.166  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -753	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -753	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99  -753	  0.118  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -753	  0.288  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -753	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30  -752	  0.194  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -752	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -752	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -752	  0.262  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -752	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func                -751	  0.146  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef  -751!  90.605  apic_timer_interrupt+0x52 (<102d02=
4a>)
:|  + begin   0x000000ef  -661	  0.130  apic_timer_interrupt+0x3a (<102d025=
4>)
:|  + func                -661	  0.151  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                -660	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                -660	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func                -660	  0.120  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                -660	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                -660	  0.141  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                -660	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func                -660	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -660	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                -659	  0.118  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                -659	  0.233  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                -659	  0.354  __xnlock_spin+0x4 (__xnlock_get+0x2=
b)
:|  # func                -659	  0.151  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                -659	  0.115  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                -658	  0.136  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99  -658	  0.207  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                -658	  0.126  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@-561   -658	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                -658	  0.132  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                -658	  0.255  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                -657	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30  -657	  0.120  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -657	  0.320  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -657	  0.396  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99  -656	  0.215  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -656	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -656	  0.118  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -656	  0.221  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                -656	  0.161  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                -656	  0.135  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000  -655	  0.185  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001  -655	  0.169  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001  -655	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000  -655	  0.240  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000  -655	  0.298  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                -654	  0.120  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                -654	  0.120  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001  -654	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001  -654	  0.129  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                -654	  0.120  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001  -654	  0.145  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001  -654	  0.126  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                -654	  0.127  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                -653	  0.112  __rt_task_wait_period+0x5 (hisyscal=
l_event+0x129)
:   + func                -653	  0.118  rt_task_wait_period+0x4 (__rt_task_=
wait_period+0x14)
:   + func                -653	  0.120  xnpod_wait_thread_period+0x9 (rt_ta=
sk_wait_period+0x44)
:|  + begin   0x80000000  -653	  0.167  hard_local_irq_disable+0x15 (__xnlo=
ck_get_irqsave.constprop.43+0x9)
:|  # func                -653	  0.145  xnpod_suspend_thread+0x9 (xnpod_wai=
t_thread_period+0x6c)
:|  # func                -653	  0.167  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  615] -<?>-   99  -653	  0.117  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                -652	  0.291  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                -652	  0.302  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  604] cyclic: 30  -652	  0.195  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                -652	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                -652	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                -651	  0.261  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  + func                -651	  0.117  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0x10e)
:|  + func                -651	  0.145  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + end     0x000000ef  -651! 641.640  apic_timer_interrupt+0x52 (<102d02=
54>)
:|  + begin   0x000000ef    -9	  0.160  apic_timer_interrupt+0x3a (<080ac95=
a>)
:|  + func                  -9	  0.169  __ipipe_handle_irq+0x7 (apic_timer_=
interrupt+0x41)
:|  + func                  -9	  0.115  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_handle_irq+0xc4)
:|  + func                  -9	  0.154  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  + func                  -9	  0.115  __ipipe_dispatch_irq+0x9 (__ipipe_h=
andle_irq+0xce)
:|  + func                  -9	  0.132  __ipipe_ack_hrtimer_irq+0x6 (__ipip=
e_dispatch_irq+0xa9)
:|  + func                  -8	  0.144  lapic_itimer_ack+0x3 (__ipipe_ack_h=
rtimer_irq+0x59)
:|  + func                  -8	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x118)
:|  + func                  -8	  0.158  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                  -8	  0.114  irq_hook_handler+0x5 [sigmatek_lrt]=
 (__ipipe_dispatch_irq+0x172)
:|  # func                  -8	  0.120  lrtdrv_monitoring_irq+0x4 [sigmatek=
_lrt] (irq_hook_handler+0x32 [sigmatek_lrt])
:|  # func                  -8	  0.221  xnintr_clock_handler+0x9 (__ipipe_d=
ispatch_irq+0x182)
:|  # func                  -8	  0.148  xntimer_tick_aperiodic+0x9 (xnintr_=
clock_handler+0xb9)
:|  # func                  -7	  0.118  xnthread_periodic_handler+0x3 (xnti=
mer_tick_aperiodic+0xa0)
:|  # func                  -7	  0.138  xnpod_resume_thread+0x9 (xnthread_p=
eriodic_handler+0x20)
:|  # [  615] -<?>-   99    -7	  0.231  xnpod_resume_thread+0x39 (xnthread_=
periodic_handler+0x20)
:|  # func                  -7	  0.124  xntimer_next_local_shot+0x9 (xntime=
r_tick_aperiodic+0x177)
:|  # event   tick@38       -7	  0.112  xntimer_next_local_shot+0xca (xntim=
er_tick_aperiodic+0x177)
:|  # func                  -7	  0.133  ipipe_timer_set+0x5 (xntimer_next_l=
ocal_shot+0xd1)
:|  # func                  -7	  0.256  lapic_next_deadline+0x5 (ipipe_time=
r_set+0x67)
:|  # func                  -6	  0.176  __xnpod_schedule+0x9 (xnpod_schedul=
e+0x32)
:|  # [  604] cyclic: 30    -6	  0.121  __xnpod_schedule+0x58 (xnpod_schedu=
le+0x32)
:|  # func                  -6	  0.381  xnsched_pick_next+0x5 (__xnpod_sche=
dule+0xa5)
:|  # func                  -6	  0.405  __switch_to+0x9 (__xnpod_schedule+0=
x3b8)
:|  # [  615] -<?>-   99    -5	  0.221  __xnpod_schedule+0x431 (xnpod_sched=
ule+0x32)
:|  # func                  -5	  0.120  xnpod_fire_callouts+0x7 (__xnpod_sc=
hedule+0x4b4)
:|  # func                  -5	  0.117  taskSwitchXenomai+0x9 [sigmatek_lrt=
] (xnpod_fire_callouts+0x4c)
:|  # func                  -5	  0.221  measureIdleTime+0x9 [sigmatek_lrt] =
(taskSwitchXenomai+0x9a [sigmatek_lrt])
:|  # func                  -4	  0.237  xntimer_get_overruns+0x8 (xnpod_wai=
t_thread_period+0x93)
:|  # func                  -4	  0.142  __ipipe_restore_head+0x4 (ipipe_res=
tore_pipeline_head+0x42)
:|  + end     0x80000000    -4	  0.191  hard_local_irq_enable+0x16 (__ipipe=
_restore_head+0x66)
:|  + begin   0x80000001    -4	  0.184  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
:|  + end     0x80000001    -4	  0.142  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
:|  + begin   0x80000000    -4	  0.161  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
:|  + end     0x80000000    -3	  0.913  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
:   + func                  -3	  0.130  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
:   + func                  -2	  0.132  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
:|  + begin   0x80000001    -2	  0.187  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
:|  + end     0x80000001    -2	  0.126  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
:   + func                  -2	  0.121  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
:|  + begin   0x80000001    -2	  0.142  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
:|  + end     0x80000001    -2	  0.127  hard_local_irq_restore+0x15 (ipipe_=
syscall_hook+0x5b)
:   + func                  -2	  0.283  hisyscall_event+0x9 (ipipe_syscall_=
hook+0x6b)
:   + func                  -1	  0.252  xnshadow_sys_trace+0x6 (hisyscall_e=
vent+0x129)
:   + func                  -1	  0.206  ipipe_trace_frozen_reset+0x5 (xnsha=
dow_sys_trace+0x5e)
:   + func                  -1	  0.117  __ipipe_global_path_lock+0x7 (ipipe=
_trace_frozen_reset+0x14)
:   + func                  -1	  0.133  __ipipe_spin_lock_irqsave+0x6 (__ip=
ipe_global_path_lock+0x16)
:|  + begin   0x80000001    -1	  0.748  hard_local_irq_save+0x16 (__ipipe_s=
pin_lock_irqsave+0x12)
:|  # func                   0	  0.148  __ipipe_spin_unlock_irqcomplete+0x4=
 (__ipipe_global_path_unlock+0x5f)
:|  + end     0x80000001     0	  0.160  hard_local_irq_restore+0x15 (__ipip=
e_spin_unlock_irqcomplete+0x25)
<   + freeze  0x000875a1     0	  0.167  xnshadow_sys_trace+0x67 (hisyscall_=
event+0x129)
 |  + begin   0x80000001     0	  0.188  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x6b)
 |  + end     0x80000001     0	  0.139  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0xad)
 |  + begin   0x80000000     0	  0.173  hard_local_irq_disable+0x17 (__ipip=
e_syscall_root+0x38)
 |  + end     0x80000000     0	  0.201  __ipipe_syscall_root+0x70 (sysenter=
_past_esp+0x5b)
    + func                   0	  0.120  __ipipe_syscall_root+0x5 (sysenter_=
past_esp+0x5b)
    + func                   0	  0.129  __ipipe_notify_syscall+0x9 (__ipipe=
_syscall_root+0x31)
 |  + begin   0x80000001     1	  0.176  hard_local_irq_save+0x16 (__ipipe_n=
otify_syscall+0x18)
 |  + end     0x80000001     1	  0.136  hard_local_irq_restore+0x15 (__ipip=
e_notify_syscall+0x59)
    + func                   1	  0.126  ipipe_syscall_hook+0x7 (__ipipe_not=
ify_syscall+0x64)
 |  + begin   0x80000001     1	  0.000  hard_local_irq_save+0x16 (ipipe_sys=
call_hook+0x1b)
