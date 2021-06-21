References: <1202-60cce900-16b-1ab27320@266264893>
 <44a6fe35-7e36-39c6-6a3e-3aa39e796eac@siemens.com>
 <87eecv1rr2.fsf@xenomai.org>
 <730a599c-4a53-1b48-a5ec-442e58eb34df@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Large gpio interrupt latency
In-reply-to: <730a599c-4a53-1b48-a5ec-442e58eb34df@siemens.com>
Date: Mon, 21 Jun 2021 15:54:01 +0200
Message-ID: <8735tb1fye.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: =?utf-8?Q?Fran=C3=A7ois?= Legal <devel@thom.fr.eu.org>, "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 21.06.21 11:39, Philippe Gerum wrote:
>>=20
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>>=20
>>> On 18.06.21 20:41, Fran=C3=A7ois Legal wrote:
>>>> Le Mercredi, Juin 16, 2021 17:10 CEST, Jan Kiszka <jan.kiszka@siemens.=
com> a =C3=A9crit:=20
>>>>=20=20
>>>>> On 16.06.21 15:51, Fran=C3=A7ois Legal wrote:
>>>>>> Le Mercredi, Juin 16, 2021 15:38 CEST, Jan Kiszka <jan.kiszka@siemen=
s.com> a =C3=A9crit:=20
>>>>>>=20=20
>>>>>>> On 16.06.21 15:29, Fran=C3=A7ois Legal wrote:
>>>>>>>> Le Mercredi, Juin 16, 2021 11:40 CEST, Jan Kiszka <jan.kiszka@siem=
ens.com> a =C3=A9crit:=20
>>>>>>>>=20=20
>>>>>>>>> On 16.06.21 11:12, Fran=C3=A7ois Legal via Xenomai wrote:
>>>>>>>>>> Le Mercredi, Juin 16, 2021 11:05 CEST, "Chen, Hongzhan" <hongzha=
n.chen@intel.com> a =C3=A9crit:=20
>>>>>>>>>>=20=20
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>> From: Fran=C3=A7ois Legal <devel@thom.fr.eu.org>=20
>>>>>>>>>>>> Sent: Wednesday, June 16, 2021 4:19 PM
>>>>>>>>>>>> To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>>>>>>>>> Cc: xenomai@xenomai.org
>>>>>>>>>>>> Subject: RE: Large gpio interrupt latency
>>>>>>>>>>>>
>>>>>>>>>>>> Le Mercredi, Juin 16, 2021 10:10 CEST, "Chen, Hongzhan" <hongz=
han.chen@intel.com> a =C3=A9crit:=20
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>>> From: Xenomai <xenomai-bounces@xenomai.org> On Behalf Of Fra=
n=C3=A7ois Legal via Xenomai
>>>>>>>>>>>>>> Sent: Wednesday, June 16, 2021 3:16 PM
>>>>>>>>>>>>>> To: xenomai@xenomai.org
>>>>>>>>>>>>>> Subject: Large gpio interrupt latency
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Hello,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> working on a realtime data recorder (for which I submitted a=
 patch to add timestamp retrieval for net packets), I experience a strange =
latency problem with taking GPIO interrupts.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So basically my app monitors network packets (which as recei=
ved by the DUT would trigger toggling of a GPIO on the DUT) and one GPIO.
>>>>>>>>>>>>>> We know (from some ohter reference instrument) that the DUT =
would toggle the GPIO 1-2ms after receiving a specific network packet.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> My recorder app relies on the timestamping of events done in=
 interrupts service routines for GPIOs and network interface. By checking t=
he timestamps returned by the application, I get an about 50ms delay betwee=
n the network packet and the GPIO (so something between 51 and 52ms delay).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Are you toggling gpio and access gpio device  through your rt=
dm device like on path /dev/rtdm/your_gpiocontroller/gpio*?
>>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Maybe my setup was not very clear.
>>>>>>>>>>>> I've got a DUT that receives network data, and toggles one of =
its GPIOs depending one the network data.
>>>>>>>>>>>>
>>>>>>>>>>>> I've got another device running my realtime recording app, tha=
t receives the same network data as the DUT, and that has one of its GPIO c=
onnected to the DUT GPIO.
>>>>>>>>>>>>
>>>>>>>>>>>> On the recording app, I use the RTDM device to open, ioctl (en=
able interrupt + timestamp), then select & read the GPIO value.
>>>>>>>>>>>
>>>>>>>>>>> When issue happen, the recording app side have got same number =
of network data packages and gpio interrupts with that DUT have been toggli=
ng?=20=20
>>>>>>>>>>> I am asking this because I met gpio hardware issue that would c=
ause gpio interrupt missing or invalid gpio interrupts when gpio is connect=
ing on two different boards.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> AFAICT, I'm not missing GPIO edges/interrupts in the app. Regard=
ing network, the DUT and the recoding device are connected to the same swit=
ch with the same port config.
>>>>>>>>>>
>>>>>>>>>> Moreover, I tried changing the interrupt polarity of the recordi=
ng device (switched from rising edge to falling edge), and the result is 1-=
2ms + ~30ms (the width of the pulse of the DUT) + 50ms latency
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Can you (or did you already) break down the latencies on the DUT =
via
>>>>>>>>> tracing? Is it really the GPIO output path? What is happening in =
it,
>>>>>>>>> starting with RT/Linux task switches, mode transitions etc.?
>>>>>>>>>
>>>>>>>>
>>>>>>>> I just did it.
>>>>>>>>
>>>>>>>> I did put gpio_pin_interrupt as trigger, then ran my application, =
triggered the GPIO.
>>>>>>>> This is what I get in frozen, but I'm not quite sure how to read i=
t and what conclusion I could derive :
>>>>>>>>  cat frozen
>>>>>>>> I-pipe frozen back-tracing service on 4.4.227+/ipipe release #10
>>>>>>>> ------------------------------------------------------------
>>>>>>>> CPU: 0, Freeze: 218343820846 cycles, Trace Points: 100 (+10)
>>>>>>>> Calibrated minimum trace-point overhead: 0.461 us
>>>>>>>>
>>>>>>>>  +----- Hard IRQs ('|': locked)
>>>>>>>>  |+-- Xenomai
>>>>>>>>  ||+- Linux ('*': domain stalled, '+': current, '#': current+stall=
ed)
>>>>>>>>  |||                      +---------- Delay flag ('+': > 1 us, '!'=
: > 10 us)
>>>>>>>>  |||                      |        +- NMI noise ('N')
>>>>>>>>  |||                      |        |
>>>>>>>>           Type    User Val.   Time    Delay  Function (Parent)
>>>>>>>> :  +func               -6087+   1.302  load_balance+0x14 (run_reba=
lance_domains+0x7e8)
>>>>>>>> :  +func               -6085      0.826  idle_cpu+0x10 (load_balan=
ce+0x180)
>>>>>>>> :  +func               -6084      0.892  find_busiest_group+0x14 (=
load_balance+0x1a4)
>>>>>>>> :  +func               -6084      0.757  update_group_capacity+0x1=
4 (find_busiest_group+0x128)
>>>>>>>> :  +func               -6083+   1.452  __msecs_to_jiffies+0x10 (up=
date_group_capacity+0x30)
>>>>>>>> :  +func               -6081+   1.535  idle_cpu+0x10 (find_busiest=
_group+0x1e4)
>>>>>>>> :  +func               -6080+   1.410  idle_cpu+0x10 (find_busiest=
_group+0x1e4)
>>>>>>>> :  +func               -6078      0.967  __msecs_to_jiffies+0x10 (=
run_rebalance_domains+0x810)
>>>>>>>> :  +func               -6077      0.886  __rcu_read_unlock+0x10 (r=
un_rebalance_domains+0x648)
>>>>>>>> :  +func               -6077      0.820  rcu_bh_qs+0x10 (__do_soft=
irq+0x1b0)
>>>>>>>> :  +func               -6076      0.742  ipipe_stall_root+0x10 (__=
do_softirq+0x1b4)
>>>>>>>> :  +func               -6075      0.766  ipipe_root_only+0x10 (ipi=
pe_stall_root+0x18)
>>>>>>>> :| +begin   0x80000001 -6074      0.934  ipipe_trace_begin+0x24 (i=
pipe_root_only+0xb8)
>>>>>>>> :| +end     0x80000001 -6073      0.811  ipipe_trace_end+0x24 (ipi=
pe_root_only+0xfc)
>>>>>>>> :| +begin   0x80000001 -6072      0.895  ipipe_trace_begin+0x24 (i=
pipe_stall_root+0x78)
>>>>>>>> :| #end     0x80000001 -6072      0.847  ipipe_trace_end+0x24 (ipi=
pe_stall_root+0xb8)
>>>>>>>> :  #func               -6071      0.814  __local_bh_enable+0x10 (_=
_do_softirq+0x214)
>>>>>>>> :  #func               -6070      0.760  ipipe_test_root+0x10 (__l=
ocal_bh_enable+0x1c)
>>>>>>>> :| #begin   0x80000001 -6069      0.907  ipipe_trace_begin+0x24 (i=
pipe_test_root+0x74)
>>>>>>>> :| #end     0x80000001 -6068      0.898  ipipe_trace_end+0x24 (ipi=
pe_test_root+0xb8)
>>>>>>>> :  #func               -6067      0.811  rcu_irq_exit+0x10 (irq_ex=
it+0x84)
>>>>>>>> :  #func               -6067      0.781  ipipe_test_and_stall_root=
+0x10 (rcu_irq_exit+0x18)
>>>>>>>> :  #func               -6066      0.799  ipipe_root_only+0x10 (ipi=
pe_test_and_stall_root+0x18)
>>>>>>>> :| #begin   0x80000001 -6065+   1.041  ipipe_trace_begin+0x24 (ipi=
pe_root_only+0xb8)
>>>>>>>> :| #end     0x80000001 -6064      0.769  ipipe_trace_end+0x24 (ipi=
pe_root_only+0xfc)
>>>>>>>> :| #begin   0x80000001 -6063      0.895  ipipe_trace_begin+0x24 (i=
pipe_test_and_stall_root+0x80)
>>>>>>>> :| #end     0x80000001 -6062      0.841  ipipe_trace_end+0x24 (ipi=
pe_test_and_stall_root+0xc4)
>>>>>>>> :  #func               -6061+   1.197  rcu_eqs_enter_common.constp=
rop.21+0x10 (rcu_irq_exit+0x80)
>>>>>>>> :| #begin   0x80000000 -6060+   1.413  ipipe_trace_begin+0x24 (__i=
pipe_do_sync_stage+0x2b8)
>>>>>>>> :| +end     0x00000012 -6059+   1.044  ipipe_trace_end+0x24 (__ipi=
pe_grab_irq+0x84)
>>>>>>>> :| +func               -6058      0.988  __ipipe_check_root_interr=
uptible+0x10 (__irq_svc+0x70)
>>>>>>>> :| +func               -6057      0.976  ipipe_test_root+0x10 (__i=
pipe_check_root_interruptible+0x68)
>>>>>>>> :| +func               -6056      0.829  __ipipe_bugon_irqs_enable=
d+0x10 (__ipipe_fast_svc_irq_exit+0x4)
>>>>>>>> :| +end     0x90000000 -6055      0.913  __ipipe_fast_svc_irq_exit=
+0x20 (ipipe_unstall_root+0x88)
>>>>>>>> :  +func               -6054      0.781  ipipe_test_root+0x10 (cpu=
_startup_entry+0x12c)
>>>>>>>> :| +begin   0x80000001 -6053      0.868  ipipe_trace_begin+0x24 (i=
pipe_test_root+0x74)
>>>>>>>> :| +end     0x80000001 -6052      0.781  ipipe_trace_end+0x24 (ipi=
pe_test_root+0xb8)
>>>>>>>> :  +func               -6052      0.748  rcu_idle_exit+0x10 (cpu_s=
tartup_entry+0x138)
>>>>>>>> :  +func               -6051      0.739  ipipe_test_and_stall_root=
+0x10 (rcu_idle_exit+0x18)
>>>>>>>> :  +func               -6050      0.775  ipipe_root_only+0x10 (ipi=
pe_test_and_stall_root+0x18)
>>>>>>>> :| +begin   0x80000001 -6049+   1.011  ipipe_trace_begin+0x24 (ipi=
pe_root_only+0xb8)
>>>>>>>> :| +end     0x80000001 -6048      0.742  ipipe_trace_end+0x24 (ipi=
pe_root_only+0xfc)
>>>>>>>> :| +begin   0x80000001 -6048      0.940  ipipe_trace_begin+0x24 (i=
pipe_test_and_stall_root+0x80)
>>>>>>>> :| #end     0x80000001 -6047      0.790  ipipe_trace_end+0x24 (ipi=
pe_test_and_stall_root+0xc4)
>>>>>>>> :  #func               -6046      0.859  rcu_eqs_exit_common.const=
prop.19+0x10 (rcu_idle_exit+0x8c)
>>>>>>>> :  #func               -6045      0.772  ipipe_unstall_root+0x10 (=
rcu_idle_exit+0x78)
>>>>>>>> :| #begin   0x80000000 -6044      0.814  ipipe_trace_begin+0x24 (i=
pipe_unstall_root+0x98)
>>>>>>>> :| #func               -6043+   1.077  ipipe_root_only+0x10 (ipipe=
_unstall_root+0x24)
>>>>>>>> :| +end     0x80000000 -6042      0.835  ipipe_trace_end+0x24 (ipi=
pe_unstall_root+0x84)
>>>>>>>> :  +func               -6042      0.922  arch_cpu_idle_exit+0x10 (=
cpu_startup_entry+0xfc)
>>>>>>>> :  +func               -6041      0.793  ipipe_stall_root+0x10 (cp=
u_startup_entry+0xc4)
>>>>>>>> :  +func               -6040      0.724  ipipe_root_only+0x10 (ipi=
pe_stall_root+0x18)
>>>>>>>> :| +begin   0x80000001 -6039+   1.098  ipipe_trace_begin+0x24 (ipi=
pe_root_only+0xb8)
>>>>>>>> :| +end     0x80000001 -6038      0.772  ipipe_trace_end+0x24 (ipi=
pe_root_only+0xfc)
>>>>>>>> :| +begin   0x80000001 -6037      0.841  ipipe_trace_begin+0x24 (i=
pipe_stall_root+0x78)
>>>>>>>> :| #end     0x80000001 -6036      0.763  ipipe_trace_end+0x24 (ipi=
pe_stall_root+0xb8)
>>>>>>>> :  #func               -6036      0.838  arch_cpu_idle_enter+0x10 =
(cpu_startup_entry+0xc8)
>>>>>>>> :  #func               -6035      0.745  arm_heavy_mb+0x10 (arch_c=
pu_idle_enter+0x1c)
>>>>>>>> :  #func               -6034      0.916  l2c210_sync+0x10 (arm_hea=
vy_mb+0x2c)
>>>>>>>> :  #func               -6033+   1.062  tick_check_broadcast_expire=
d+0x10 (cpu_startup_entry+0xd8)
>>>>>>>> :  #func               -6032      0.787  rcu_idle_enter+0x10 (cpu_=
startup_entry+0x124)
>>>>>>>> :  #func               -6031      0.745  ipipe_test_and_stall_root=
+0x10 (rcu_idle_enter+0x18)
>>>>>>>> :  #func               -6031      0.751  ipipe_root_only+0x10 (ipi=
pe_test_and_stall_root+0x18)
>>>>>>>> :| #begin   0x80000001 -6030      0.991  ipipe_trace_begin+0x24 (i=
pipe_root_only+0xb8)
>>>>>>>> :| #end     0x80000001 -6029      0.772  ipipe_trace_end+0x24 (ipi=
pe_root_only+0xfc)
>>>>>>>> :| #begin   0x80000001 -6028      0.892  ipipe_trace_begin+0x24 (i=
pipe_test_and_stall_root+0x80)
>>>>>>>> :| #end     0x80000001 -6027      0.847  ipipe_trace_end+0x24 (ipi=
pe_test_and_stall_root+0xc4)
>>>>>>>> :  #func               -6026      0.922  rcu_eqs_enter_common.cons=
tprop.21+0x10 (rcu_idle_enter+0x90)
>>>>>>>> :  #func               -6025      0.862  default_idle_call+0x10 (c=
pu_startup_entry+0x128)
>>>>>>>> :  #func               -6024      0.877  arch_cpu_idle+0x10 (defau=
lt_idle_call+0x38)
>>>>>>>> :| #begin   0x80000000 -6024! 5992.167  ipipe_trace_begin+0x24 (ar=
ch_cpu_idle+0xb8)
>>>>>>>
>>>>>>> Here your system (or this core) went idle, waiting for the next eve=
nt.
>>>>>>>
>>>>>>>> :| +func                 -31      0.760  ipipe_unstall_root+0x10 (=
arch_cpu_idle+0x30)
>>>>>>>
>>>>>>> Comming back from idle.
>>>>>>>
>>>>>>>> :| +func                 -31+   1.116  ipipe_root_only+0x10 (ipipe=
_unstall_root+0x24)
>>>>>>>> :| +end     0x80000000   -30      0.931  ipipe_trace_end+0x24 (ipi=
pe_unstall_root+0x84)
>>>>>>>> :| +begin   0x90000000   -29      0.844  __irq_svc+0x58 (ipipe_uns=
tall_root+0x88)
>>>>>>>> :| +func                 -28      0.925  gic_handle_irq+0x10 (__ir=
q_svc+0x6c)
>>>>>>>> :| +func                 -27      0.904  irq_find_mapping+0x10 (gi=
c_handle_irq+0x50)
>>>>>>>> :| +func                 -26      0.940  __ipipe_grab_irq+0x10 (gi=
c_handle_irq+0x58)
>>>>>>>> :| +begin   0x000000c9   -25      0.826  ipipe_trace_begin+0x24 (_=
_ipipe_grab_irq+0x58)
>>>>>>>> :| +func                 -24      0.814  __ipipe_dispatch_irq+0x10=
 (__ipipe_grab_irq+0x7c)
>>>>>>>> :| +func                 -23+   1.275  irq_to_desc+0x10 (__ipipe_d=
ispatch_irq+0x184)
>>>>>>>> :| +func                 -22+   1.679  irq_to_desc+0x10 (__ipipe_d=
ispatch_irq+0x198)
>>>>>>>> :| +func                 -20+   2.092  ucc_gpio_irqhandler+0x14 (_=
_ipipe_dispatch_irq+0x1fc)
>>>>>>>> :| +func                 -18+   1.413  irq_find_mapping+0x10 (ucc_=
gpio_irqhandler+0x84)
>>>>>>>> :| +begin   0x000000e3   -17      0.757  ipipe_trace_begin+0x24 (u=
cc_gpio_irqhandler+0x8c)
>>>>>>>> :| +func                 -16      0.778  __ipipe_dispatch_irq+0x10=
 (ucc_gpio_irqhandler+0x98)
>>>>>>>> :| +func                 -15+   1.023  irq_to_desc+0x10 (__ipipe_d=
ispatch_irq+0x184)
>>>>>>>> :| +func                 -14+   1.494  irq_to_desc+0x10 (__ipipe_d=
ispatch_irq+0x198)
>>>>>>>> :| +func                 -13+   1.014  __ipipe_ack_level_irq+0x10 =
(__ipipe_dispatch_irq+0x1fc)
>>>>>>>> :| +func                 -12      0.763  ucc_gpio_irq_mask+0x10 (_=
_ipipe_ack_level_irq+0x54)
>>>>>>>> :| +func                 -11+   1.248  __ipipe_spin_lock_irqsave+0=
x10 (ucc_gpio_irq_mask+0x2c)
>>>>>>>> :| #func                 -10+   1.619  __ipipe_spin_unlock_irqrest=
ore+0x10 (ucc_gpio_irq_mask+0x4c)
>>>>>>>> :| +func                  -8+   1.239  __ipipe_set_irq_pending+0x1=
0 (__ipipe_dispatch_irq+0x3bc)
>>>>>>>> :| +end     0x000000e3    -7      0.994  ipipe_trace_end+0x24 (ucc=
_gpio_irqhandler+0xa0)
>>>>>>>> :| +func                  -6+   1.029  gic_eoi_irq+0x10 (ucc_gpio_=
irqhandler+0xd4)
>>>>>>>> :| +func                  -5+   1.353  __ipipe_do_sync_pipeline+0x=
14 (__ipipe_dispatch_irq+0x17c)
>>>>>>>> :|+ func                  -4+   1.449  __ipipe_do_sync_stage+0x14 =
(__ipipe_do_sync_pipeline+0xf0)
>>>>>>>> :|# func                  -2+   1.191  xnintr_irq_handler+0x14 (__=
ipipe_do_sync_stage+0x200)
>>>>>>>> :|# func                  -1+   1.455  ___xnlock_get+0x10 (xnintr_=
irq_handler+0xc0)
>>>>>>>> <|# func                   0      1.107  gpio_pin_interrupt+0x10 (=
xnintr_irq_handler+0xf4)
>>>>>>>
>>>>>>> And here we start to process that GPIO interrupt in the RTDM handle=
r,
>>>>>>> roughly after 30 =C2=B5s (which are also due to tracing overhead). =
So far
>>>>>>> nothing suspiciuos.
>>>>>>>
>>>>>>>>  |# func                   1      1.236  xnclock_core_read_monoton=
ic+0x10 (gpio_pin_interrupt+0x1c)
>>>>>>>>  |# func                   2      1.224  rtdm_event_signal+0x10 (g=
pio_pin_interrupt+0x2c)
>>>>>>>
>>>>>>> Here some likely waiting RT task is signalled. Does that one notice=
 a
>>>>>>> too high latency?
>>>>>>
>>>>>> I may have been wrong speaking of "latency". The problem I'm trying =
to fix, is understanding why my reference instrument indicates a delay from=
 network packet to GPIO on the DUT of about 1 to 2ms, whereas my xenomai po=
wered realtime recorder application, given the same network stream and gpio=
 access gives me ~50 to 52 ms.
>>>>>>
>>>>>> I first though there was something wrong/delayed on the GPIO interru=
pt side (the network packet could not have been received before it is sent =
right).
>>>>>> The trace seem to demonstrate ~30=C2=B5s of interrupt latency (a num=
ber I expected for interrupt latency on that system) for the GPIO. So somet=
hing is wrong on my system, but I don't know what !
>>>>>>
>>>>>
>>>>> Try to trace events, not functions, using regular ftrace ("trace-cmd
>>>>> record -e cobalt* -e sched* -e irq* -e signal*" e.g.). Check when the
>>>>> NIC gets the interrupt and compare that to when the GPIO event is
>>>>> triggered (or whatever is trigger and reaction). Function tracing is =
for
>>>>> zooming in when you know where to zoom.
>>>>>
>>>>
>>>> So I think I found the answer to my problem.
>>>> Is there any reason why NET events (in NIC irq functions) are dated wi=
th rtdm_clock_read, whereas GPIO event are dated with rtdm_clock_read_monot=
onic ?
>>>>
>>>
>>> Inconsistency of the GPIO drivers, UART drivers use rtdm_clock_read for
>>> user-exposed timestamping as well. Maybe Philippe can comment on
>>> thoughts behind this deviation.
>>>
>>=20
>> When running over the I-pipe, rtdm_clock_read() is based on Xenomai's
>> idea of real time, which is the Cobalt monotonic clock plus an arbitrary
>> offset. For this reason, rtdm_clock_read() is not SMP-consistent
>> (different CPUs might read different timestamps at the exact same time),
>> is not in sync with linux's wall clock either. For these reasons, I
>> don't see any practical way to synchronize multiple systems on the clock
>> underlying rtdm_clock_read().
>>=20
>> Therefore, there is no upside in using rtdm_clock_read() for
>> timestamping in this context, only adding the potential for even more
>> surprising results due to the mono->real-time offset changing under our
>> feet, since the epoch of the Xenomai real-time clock can be (re)set
>> during runtime.
>>=20
>> I believe the UART driver is wrong here, it should return timestamps
>> based on the monotonic source, which best fits the common need: getting
>> timestamps from the local CPU for measuring delays between events
>> received by drivers and the actions taken by the applications which
>> consume them, immune from updates to the underlying clock
>> epoch. Granted, there might be a catch when a timestamp is taken from
>> IRQ context, which is then consumed from a thread living on a different
>> CPU, if per-CPU clocks are not/badly synchronized. But that would happen
>> the exact same way with rtdm_clock_read() anyway.
>>=20
>> The situation improves when running on top of Dovetail, since Xenomai
>> now refers to the common linux clocks (mono / real) instead of providing
>> its own idea of time, but the UART driver code predates the Dovetail
>> port.
>>=20=20
>
> Well, it's not just UART. All hardware drivers - except for GPIO - use
> rtdm_clock_read. That was no problem in practice for their use cases so
> far. One problem is that GPIO timestamps are now not comparable to others.
>
> But IIRC, most Xenomai APIs using absolute timestamps are based on
> Xenomai's real-time clock. Therefore, providing timestamps for that

/*
 * The Copperplate clock shall be monotonic unless the threading
 * library has restrictions to support this over Mercury.
 *
 * In the normal case, this means that ongoing delays and timeouts
 * won't be affected when the host system date is changed. In the
 * restricted case by contrast, ongoing delays and timeouts may be
 * impacted by changes to the host system date.
 *
 * The implementation maintains a per-clock epoch value, so that
 * different emulators can have different (virtual) system dates.
 */
#ifdef CONFIG_XENO_COPPERPLATE_CLOCK_RESTRICTED
#define CLOCK_COPPERPLATE  CLOCK_REALTIME
#else
#define CLOCK_COPPERPLATE  CLOCK_MONOTONIC
#endif

So no, only the POSIX API is using what the standard mandates, which is
CLOCK_REALTIME. All other APIs are based on copperplate, and they are
using a monotonic source as documented above.

> particular clock was the original idea of rtdm_clock_read (which
> predates rtdm_clock_read_monotonic). GPIO breaks that and should be
> fixed - unless I'm wrong with that assumption.
>

We cannot assume the epoch is going to remain stable with
rtdm_clock_read() the way it is implemented, which is quite of a
problem wrt the common use case. For timestamping, a majority of
mainline drivers is using ktime_get() or a variant thereof which is
based on the monotonic clock source, not the _real form. Why would the
real-time I/O drivers be different?

--=20
Philippe.

