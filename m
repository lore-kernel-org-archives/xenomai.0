From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
Date: Thu, 26 Nov 2020 03:57:11 +0000
Message-ID: <MWHPR11MB17104A3ABA4757E973ED5736F2F90@MWHPR11MB1710.namprd11.prod.outlook.com>
References: <MWHPR11MB17100D1F48C3EF22B3C6A329F2E60@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lff5rtxl.fsf@xenomai.org>
 <CY4PR11MB170373477D42F1E0F39C1162F2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <CY4PR11MB17031A0E3842869F923D353FF2E50@CY4PR11MB1703.namprd11.prod.outlook.com>
 <87tutrolj3.fsf@xenomai.org> <877dqkfgl2.fsf@xenomai.org>
 <MWHPR11MB171050871553AA646AE42130F2E20@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87lfezetj9.fsf@xenomai.org>
 <MWHPR11MB1710A24CFCD223D9DC4E955FF2E00@MWHPR11MB1710.namprd11.prod.outlook.com>
 <MWHPR11MB17102B8431E8FB361CBA7637F2E00@MWHPR11MB1710.namprd11.prod.outlook.com>
 <72043f71-f89a-9167-b0cb-034493b966ee@siemens.com>
 <87k0uh4j7f.fsf@xenomai.org>
 <MWHPR11MB1710FF22D02B4C31494AA315F2FF0@MWHPR11MB1710.namprd11.prod.outlook.com>
 <877dqg2h0j.fsf@xenomai.org>
In-Reply-To: <877dqg2h0j.fsf@xenomai.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

>-----Original Message-----
>From: Philippe Gerum <rpm@xenomai.org>=20
>Sent: Friday, November 20, 2020 11:19 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xeno=
mai_init
>
>
>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>
>>>-----Original Message-----                                              =
                                      =20
>>>From: Philippe Gerum <rpm@xenomai.org>                                  =
                                      =20
>>>Sent: Thursday, November 19, 2020 8:36 PM                               =
                                      =20
>>>To: Jan Kiszka <jan.kiszka@siemens.com>                                 =
                                      =20
>>>Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org       =
                                      =20
>>>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xe=
nomai_init                            =20
>>>                                                                        =
                                      =20
>>>                                                                        =
                                      =20
>>>Jan Kiszka <jan.kiszka@siemens.com> writes:                             =
                                      =20
>>>                                                                        =
                                      =20
>>>> On 19.11.20 12:40, Chen, Hongzhan via Xenomai wrote:                  =
                                      =20
>>>>>                                                                      =
                                      =20
>>>>>>>> -->---Original Message-----                                       =
                                      =20
>>>>>>>> Fr>om: Philippe Gerum <rpm@xenomai.org>                           =
                                      =20
>>>>>>>> Se>nt: Tuesday, November 17, 2020 6:01 PM                         =
                                      =20
>>>>>>>> To>: Chen, Hongzhan <hongzhan.chen@intel.com>                     =
                                      =20
>>>>>>>> Cc>: xenomai@xenomai.org                                          =
                                      =20
>>>>>>>> Su>bject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier a=
fter xenomai_init                     =20
>>>>>>>>  >                                                                =
                                      =20
>>>>>>>>  >                                                                =
                                      =20
>>>>>>>> Ph>ilippe Gerum <rpm@xenomai.org> writes:                         =
                                      =20
>>>>>>>>  >                                                                =
                                      =20
>>>>>>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:                =
                                      =20
>>>>>>>>>>                                                                 =
                                      =20
>>>>>>>>>>> I have some clues about this issue. After xenomai_init is calle=
d, it seems that rcu_core             =20
>>>>>>>>>>> is never called from unknow startpoint ever after call call_rcu=
, which is supposed to be             =20
>>>>>>>>>>> called by rcu softirq handler after we call call_rcu.          =
                                      =20
>>>>>>>>>>> I am trying to debug why rcu softirq is not triggerred after th=
en.                                   =20
>>>>>>>>>>                                                                 =
                                      =20
>>>>>>>>>>                                                                 =
                                      =20
>>>>>>>>>> You may want to make sure this is not offloaded to RCU kthreads,=
                                      =20
>>>>>>>>>> typically in case you run with nocbs settings. This said, tracin=
g                                     =20
>>>>>>>>>> rcu_core() would match both.                                    =
                                      =20
>>>>>>>>>>                                                                 =
                                      =20
>>>>>>>>>> I did not reproduce the issue you observed with the EVL core, te=
sting                                 =20
>>>>>>>>>> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight tes=
t to                                  =20
>>>>>>>>>> confirm this. This is why we need to be confident that an half-b=
aked                                  =20
>>>>>>>>>> port on top of Dovetail is not causing this.                    =
                                      =20
>>>>>>>>  >                                                                =
                                      =20
>>>>>>>> 44> hours uninterrupted runtime on armv7, x86 and armv8, under str=
ess: no                               =20
>>>>>>>> is>sue detected so far. This does not rule out a Dovetail bug yet,=
 but                                  =20
>>>>>>>> th>e possibility of a Cobalt issue is real.                       =
                                      =20
>>>>>>>>  >                                                                =
                                      =20
>>>>>>>> -->                                                               =
                                      =20
>>>>>>>> Ph>ilippe.                                                        =
                                      =20
>>>>>>>                                                                    =
                                      =20
>>>>>>> Thanks for your feedback.  I already found the root cause for the i=
ssue. According to my                 =20
>>>>>>> debug on evl, I found that actually after call tick_install_proxy ,=
 the original                         =20
>>>>>>> hrtimer_interrupt would be called by proxy_irq_handler instead of  =
 __sysvec_apic_timer_interrupt        =20
>>>>>>> so that  rcu_sched_clock_irq still can be successfully called by  u=
pdate_process_times and               =20
>>>>>>> invoke_rcu_core would always be called and callback registerred by =
call_rcu can be successfully handled. =20
>>>>>>> But in my case, after call tick_install_proxy in xenomai, update_pr=
ocess_times is never called and then  =20
>>>>>>> cause hang in rcu_barrier issue later. I would continue to check wh=
y fail to replace timer irq in my case.
>>>>>>>                                                                    =
                                      =20
>>>>>>> Did you try running Dovetail's boot time pipeline torture tests? Th=
ose                                   =20
>>>>>>> would exercise the basic features, such as the tick proxy device,  =
                                      =20
>>>>>>> without any dependencies whatsoever. You may need to disable Cobalt=
 to                                   =20
>>>>>>> do so, in order to leave the out-of-band stage available to them at=
 boot.                                =20
>>>>>>>                                                                    =
                                      =20
>>>>>>> CONFIG_IRQ_PIPELINE_TORTURE_TESTS=3Dy                              =
                                        =20
>>>>>>> CONFIG_XENOMAI=3Dn                                                 =
                                        =20
>>>>>>>                                                                    =
                                      =20
>>>>>>> If successful, those tests on a quad-core CPU should yield that kin=
d of                                  =20
>>>>>>> traces in the kernel log:                                          =
                                      =20
>>>>>>>                                                                    =
                                      =20
>>>>>>> [    4.413767] Starting IRQ pipeline tests...                      =
                                      =20
>>>>>>> [    4.413772] IRQ pipeline: high-priority torture stage added.    =
                                      =20
>>>>>>> [    4.423571] irq_pipeline-torture: CPU2 initiates stop_machine() =
                                      =20
>>>>>>> [    4.429527] irq_pipeline-torture: CPU3 responds to stop_machine(=
)                                     =20
>>>>>>> [    4.429534] irq_pipeline-torture: CPU1 responds to stop_machine(=
)                                     =20
>>>>>>> [    4.429538] irq_pipeline-torture: CPU0 responds to stop_machine(=
)                                     =20
>>>>>>> [    4.447945] CPU0: proxy tick device registered (199.20MHz)      =
                                      =20
>>>>>>> [    4.447948] CPU1: proxy tick device registered (199.20MHz)      =
                                      =20
>>>>>>> [    4.447954] CPU3: proxy tick device registered (199.20MHz)      =
                                      =20
>>>>>>> [    4.464448] CPU2: proxy tick device registered (199.20MHz)      =
                                      =20
>>>>>>> [    4.469985] irq_pipeline-torture: CPU2: irq_work handled        =
                                      =20
>>>>>>> [    4.475322] irq_pipeline-torture: CPU2: in-band->in-band irq_wor=
k trigger works                       =20
>>>>>>> [    4.482648] irq_pipeline-torture: CPU2: stage escalation request=
 works                                =20
>>>>>>> [    4.482650] irq_pipeline-torture: CPU2: irq_work handled        =
                                      =20
>>>>>>> [    4.494523] irq_pipeline-torture: CPU2: oob->in-band irq_work tr=
igger works                           =20
>>>>>>> [    5.523585] CPU3: proxy tick device unregistered                =
                                      =20
>>>>>>> [    5.523590] CPU1: proxy tick device unregistered                =
                                      =20
>>>>>>> [    5.523592] CPU0: proxy tick device unregistered                =
                                      =20
>>>>>>> [    5.537459] CPU2: proxy tick device unregistered                =
                                      =20
>>>>>>> [    5.542113] IRQ pipeline: torture stage removed.                =
                                      =20
>>>>>>> [    5.546753] IRQ pipeline tests OK.                              =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> Anything suspicious there instead would point to a Dovetail-related =
                                      =20
>>>>>> issue.                                                              =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> --                                                                  =
                                      =20
>>>>>> Philippe.                                                           =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> The pipeline tests OK after I enable CONFIG_IRQ_PIPELINE_TORTURE_TES=
T and                                 =20
>>>>>> disable xenomai as you suggested.                                   =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> When I try to debug this issue and add some printk info for function=
s                                     =20
>>>>>> such as clockevents_register_proxy in files like                    =
                                      =20
>>>>>> kernel/time/tick-proxy.c and kernel/time/clockevents.c, kernel hang =
in                                    =20
>>>>>> mark_readonly->rcu_barrier would suddenly dissappear, kernel        =
                                      =20
>>>>>> can boot into nfsroot and debian after then. But system would still =
hang in                               =20
>>>>>> other ruc_barrier during systemd trying to boot up some services.   =
                                      =20
>>>>>> I try to count interrupt in founction handle_apic_irq of arch/x86/ke=
rnel/irq_pipeline.c                   =20
>>>>>> for each cpu and then print this irq number in rcu_barrier for debug=
ing and                               =20
>>>>>> finally found that actually cpu0  stop counting from very early befo=
re hang in                            =20
>>>>>> mark_readonly->rcu_barrier of kernel. After further debug, I found t=
hat cpu0                              =20
>>>>>> stop counting after call tick_install_proxy when kernel hang in     =
                                      =20
>>>>>> mark_readonly->rcu_barrier.                                         =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> For another hang case that system can boot into systemd but hang in =
other                                 =20
>>>>>> rcu_barrier, I found that actually other three cpus randomly stop pr=
oducing                               =20
>>>>>> apic timer interrupt except cpu0 after call tick_install_proxy accor=
ding to my test.                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> I do not know what may cause this issue. Do you have any suggestions=
 about it?                            =20
>>>>>>                                                                     =
                                      =20
>>>>>> Regards                                                             =
                                      =20
>>>>>>                                                                     =
                                      =20
>>>>>> Hongzhan Chen                                                       =
                                      =20
>>>>>                                                                      =
                                      =20
>>>>> I reproduced following issue steadily today. I think this should be r=
oot cause for my                      =20
>>>>> hang issue. Till now I deeply understand what you suggested about por=
ting....                              =20
>>>>> I want to say it is really genius design about pipeline + proxy tick =
for real time system                  =20
>>>>> on Linux kernel.                                                     =
                                      =20
>>>>>                                                                      =
                                      =20
>>>>> [    8.032556] IRQ pipeline: some code running in oob context 'Xenoma=
i'                                    =20
>>>> [    8.032557]               called an in-band only routine           =
                                     =20
>>>> [    8.032558] CPU: 0 PID: 12 Comm: migration/0 Tainted: G     U      =
      5.8.0+ #30                     =20
>>>> [    8.032558] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2=
019                                  =20
>>>> [    8.032559] IRQ stage: Xenomai                                     =
                                     =20
>>>> [    8.032559] Call Trace:                                            =
                                     =20
>>>> [    8.032560]  dump_stack+0x85/0xa6                                  =
                                     =20
>>>> [    8.032561]  inband_irq_save+0x6/0x30                              =
                                     =20
>>>> [    8.032561]  ktime_get+0x24/0x140                                  =
                                     =20
>>                                                                         =
                                    =20
>> Is calling that function OK in the EVL context? Does xnclock_tick() do  =
                                    =20
>>                                                                         =
                                     =20
>>Nope, calling ktime_get() would not be correct in the EVL context either.=
                                     =20
>>                                                                         =
                                     =20
>>--                                                                       =
                                     =20
>>Philippe.  =20
>>
>> ktime_get_mono_fast_ns really works. After replace ktime_get , my debug =
kernel
>> image which I added debug info in several files as I mentioned before
>> now can successfully boot into debian system on our lava test environmen=
t with
>> ramdisk and nfsrootfs image built from xenoami-isar. But it is still qui=
te unstable because
>> stall issue like in following log [1] still happen randomly on other thr=
ee cpus=20
>> except cpu0 on my platform. If I remove all printk debug info, system al=
ways fail
>> to boot into debian because of cpu stall issue like [1]. According to my=
 debug,=20
>> cpu stall reported because these cpus stop producing apic timer interrup=
t after=20
>> call tick_install_proxy in xenomai_init earlier before. Do you have
>> any ideas about it?
>
>Multiple causes might be involved:
>
>- ONESHOT_STOPPED mode not handled properly by the real-time core, when
>  entered by the in-band kernel code. For reference, the EVL core does
>  it the right way. The basic idea is that, whenever the proxy tick
>  device enters the ONESHOT_STOPPED mode, the underlying (real) tick
>  device is turned off as a result. After this transition has been
>  detected, next time the in-band kernel tells the real-time core to arm
>  a shot via the proxy, the core needs to force-program the timer
>  hardware to wake it up, i.e. calling ->set_next_event(). If we don't
>  do that, the real-time core might skip this step in case the next host
>  tick is not the earliest event in line, leaving the real device turned
>  off indefinitely. See program_timer() in the EVL core, tracking how
>  RQ_TSTOPPED is used.

Thanks for your instruction. It works for the issue that 100% system hang
on cpu0.

>- some issue related to entering a deep sleep mode, which ends up
>  confusing the Cobalt timing logic, causing the tick proxy to stop
>  relaying ticks to the in-band kernel. e.g. the CPU idling code
>  determines that it might be time for the current CPU to enter some
>  sleep state, but it should ask the real-time core to confirm this by
>  calling irq_cpuidle_control(). If the core does not implement this
>  call, then the transition is accepted by default. The EVL core
>  implements this weak call to figure out whether it is actually
>  acceptable to enter a sleep state wrt pending real-time duties: you
>  may want to have a look at the underlying logic there.
>

But system still randomly hang because tick proxy fail to relay tick
to the in-band kernel even after I disable CONFIG_CPU_IDLE in building kern=
el time.=20
In my dozens of  reboot test , about 1/3 case would fail because of cpu sta=
ll.

Before issue happen, all cpu ticks work fine for first several seconds=20
after xenomai init according to tick count log that I added  for each cpu,
but from unknow point , some cpus would randomly stop reacting to=20
tick_notify_proxy after run successful several millions of ticks like log [=
3].
In this case , issue happen on cpu3. I printed tick count in rcu_barrier ,
which start counting when first handle_oob_event of proxy tick callback reg=
istered=20
is called. Actually , cpu3 stop counting a little bit earlier(about 300ms) =
 before  rcu_barrier
according to tick count difference between cpu3 and (cpu2 or cpu1).

What I am doing on disabling CONFIG_CPU_IDLE can isolate issue related to=20
deep sleep mode?  =20

[3]:
2020-11-26T10:25:16 [   11.432623] calling  tcp_congestion_default+0x0/0x13=
 @ 1
2020-11-26T10:25:16 [   11.437978] initcall tcp_congestion_default+0x0/0x13=
 returned 0 after 8 usecs
2020-11-26T10:25:16 [   11.445131] calling  ip_auto_config+0x0/0xbb @ 1
2020-11-26T10:25:19 [   14.479746] igb 0000:03:00.0 eth0: igb: eth0 NIC Lin=
k is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
2020-11-26T10:25:20 [   14.702050] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: lin=
k becomes ready
2020-11-26T10:25:20 [   14.714005] Sending DHCP requests ., OK
2020-11-26T10:25:20 [   14.722082] IP-Config: Got DHCP answer from 192.168.=
1.1, my address is 192.168.1.163
2020-11-26T10:25:20 [   14.729865] IP-Config: Complete:
2020-11-26T10:25:20 [   14.733126]      device=3Deth0, hwaddr=3Db0:41:6f:05=
:61:8e, ipaddr=3D192.168.1.163, mask=3D255.255.255.0, gw=3D192.168.1.1
2020-11-26T10:25:20 [   14.743317]      host=3D192.168.1.163, domain=3D, ni=
s-domain=3D(none)
2020-11-26T10:25:20 [   14.749270]      bootserver=3D0.0.0.0, rootserver=3D=
192.168.1.100, rootpath=3D
2020-11-26T10:25:20 [   14.749274]      nameserver0=3D192.168.1.1
2020-11-26T10:25:20 [   14.793429] initcall ip_auto_config+0x0/0xbb returne=
d 0 after 3265281 usecs
2020-11-26T10:25:20 [   14.800426] calling  regulatory_init_db+0x0/0x1b2 @ =
1
2020-11-26T10:25:20 [   14.805554] cfg80211: Loading compiled-in X.509 cert=
ificates for regulatory database
2020-11-26T10:25:20 [   14.837330] modprobe (94) used greatest stack depth:=
 13448 bytes left
2020-11-26T10:25:20 [   14.865860] cfg80211: Loaded X.509 cert 'sforshee: 0=
0b28ddf47aef9cea7'
2020-11-26T10:25:20 [   14.872621] initcall regulatory_init_db+0x0/0x1b2 re=
turned 0 after 65535 usecs
2020-11-26T10:25:20 [   14.879895] calling  pci_mmcfg_late_insert_resources=
+0x0/0x4c @ 1
2020-11-26T10:25:20 [   14.886030] initcall pci_mmcfg_late_insert_resources=
+0x0/0x4c returned 0 after 9 usecs
2020-11-26T10:25:20 [   14.893977] calling  software_resume+0x0/0x2b0 @ 1
2020-11-26T10:25:20 [   14.899599] platform regulatory.0: Direct firmware l=
oad for regulatory.db failed with error -2
2020-11-26T10:25:20 [   14.908481] cfg80211: failed to load regulatory.db
2020-11-26T10:25:20 [   14.913731] initcall software_resume+0x0/0x2b0 retur=
ned -2 after 14572 usecs
2020-11-26T10:25:20 [   14.920874] calling  clear_boot_tracer+0x0/0x26 @ 1
2020-11-26T10:25:20 [   14.925785] initcall clear_boot_tracer+0x0/0x26 retu=
rned 0 after 3 usecs
2020-11-26T10:25:20 [   14.932514] calling  tracing_set_default_clock+0x0/0=
x5c @ 1
2020-11-26T10:25:20 [   14.938119] initcall tracing_set_default_clock+0x0/0=
x5c returned 0 after 3 usecs
2020-11-26T10:25:20 [   14.945539] calling  fb_logo_late_init+0x0/0xa @ 1
2020-11-26T10:25:20 [   14.950363] initcall fb_logo_late_init+0x0/0xa retur=
ned 0 after 3 usecs
2020-11-26T10:25:20 [   14.957017] calling  clk_disable_unused+0x0/0xfd @ 1
2020-11-26T10:25:20 [   14.962046] initcall clk_disable_unused+0x0/0xfd ret=
urned 0 after 25 usecs
2020-11-26T10:25:20 [   14.975079] Freeing unused kernel image (initmem) me=
mory: 1176K
2020-11-26T10:25:20 [   14.981577] rcu_barrier begine
2020-11-26T10:25:20 ^A6----------------------------------------------------=
--
2020-11-26T10:25:20 ^A6 cpu 0 [0x13c063] [0x13c063] [0x13c063] [0x0] [0x13c=
063] [0x13c063] [0x13c063] [0x13c063] [0x2780c6]
2020-11-26T10:25:20 ^A6 cpu 1 [0x23d048] [0x23d047] [0x23d047] [0x0] [0x23d=
048] [0x23d048] [0x23d048] [0x23d048] [0x47a08f]
2020-11-26T10:25:20 ^A6 cpu 2 [0x23cffd] [0x23cffd] [0x23cffd] [0x0] [0x23c=
ffd] [0x23cffd] [0x23cffd] [0x23cffd] [0x479ffa]
2020-11-26T10:25:20 ^A6 cpu 3 [0x22ac9d] [0x22ac9c] [0x22ac9c] [0x0] [0x22a=
c9d] [0x22ac9c] [0x22ac9d] [0x22ac9d] [0x455939]

Regards

Hongzhan Chen

>- some issue in the way the clockevent driver is handling oob events
>  [1]. For x86, it would be unlikely, but double-checking would not
>  harm.
>
>NOTE: for debugging all this tricky stuff, you may want to enable
>CONFIG_RAW_PRINTK, using raw_printk() for your debug messages instead of
>printk(). That would send the messages via the raw console interface
>Dovetail adds to some UART drivers, like the 16550A or variant you
>likely have on board. This way, you would ensure that no debug would be
>delayed (or remain stuck on crash) by the complex printk() machinery,
>but would be synchronously hammered to the output FIFO instead. See [2].
>
>[1] https://evlproject.org/dovetail/porting/timer/
>[2] https://evlproject.org/dovetail/rulesofthumb/
>
>> Is it=20
>> worth continuing to debug it or I skip it at first to validate and debug=
 other functions
>> I ported like xenomai scheduler with running latency test basedon on my =
branch?
>>  I am asking this because I saw that you already decided to restart pori=
ng dovetail over xenomai=20
>> in anther thread but I do not know if what I am doing would be helpful.
>>
>
>Everything you did so far was useful in the sense that we need more
>people to get their feet wet with dual kernel internals so that
>long-term maintenance is no more at risk due to a tiny bus factor.
>
>Regarding the reboot of this port, I'm going to resurrect the initial
>code base I worked on a year ago, which partially implements the
>abstraction layer we need. Your work would fit in the Dovetail-side of
>this layer.
>
>--=20
>Philippe.

