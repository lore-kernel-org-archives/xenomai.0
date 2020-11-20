From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
Date: Fri, 20 Nov 2020 09:16:08 +0000
Message-ID: <MWHPR11MB1710FF22D02B4C31494AA315F2FF0@MWHPR11MB1710.namprd11.prod.outlook.com>
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
In-Reply-To: <87k0uh4j7f.fsf@xenomai.org>
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

>-----Original Message-----                                                =
                                    =20
>From: Philippe Gerum <rpm@xenomai.org>                                    =
                                    =20
>Sent: Thursday, November 19, 2020 8:36 PM                                 =
                                    =20
>To: Jan Kiszka <jan.kiszka@siemens.com>                                   =
                                    =20
>Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org         =
                                    =20
>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xeno=
mai_init                            =20
>                                                                          =
                                    =20
>                                                                          =
                                    =20
>Jan Kiszka <jan.kiszka@siemens.com> writes:                               =
                                    =20
>                                                                          =
                                    =20
>> On 19.11.20 12:40, Chen, Hongzhan via Xenomai wrote:                    =
                                    =20
>>>                                                                        =
                                    =20
>>>>>> -->---Original Message-----                                         =
                                    =20
>>>>>> Fr>om: Philippe Gerum <rpm@xenomai.org>                             =
                                    =20
>>>>>> Se>nt: Tuesday, November 17, 2020 6:01 PM                           =
                                    =20
>>>>>> To>: Chen, Hongzhan <hongzhan.chen@intel.com>                       =
                                    =20
>>>>>> Cc>: xenomai@xenomai.org                                            =
                                    =20
>>>>>> Su>bject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier aft=
er xenomai_init                     =20
>>>>>>  >                                                                  =
                                    =20
>>>>>>  >                                                                  =
                                    =20
>>>>>> Ph>ilippe Gerum <rpm@xenomai.org> writes:                           =
                                    =20
>>>>>>  >                                                                  =
                                    =20
>>>>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:                  =
                                    =20
>>>>>>>>                                                                   =
                                    =20
>>>>>>>>> I have some clues about this issue. After xenomai_init is called,=
 it seems that rcu_core             =20
>>>>>>>>> is never called from unknow startpoint ever after call call_rcu, =
which is supposed to be             =20
>>>>>>>>> called by rcu softirq handler after we call call_rcu.            =
                                    =20
>>>>>>>>> I am trying to debug why rcu softirq is not triggerred after then=
.                                   =20
>>>>>>>>                                                                   =
                                    =20
>>>>>>>>                                                                   =
                                    =20
>>>>>>>> You may want to make sure this is not offloaded to RCU kthreads,  =
                                    =20
>>>>>>>> typically in case you run with nocbs settings. This said, tracing =
                                    =20
>>>>>>>> rcu_core() would match both.                                      =
                                    =20
>>>>>>>>                                                                   =
                                    =20
>>>>>>>> I did not reproduce the issue you observed with the EVL core, test=
ing                                 =20
>>>>>>>> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight test =
to                                  =20
>>>>>>>> confirm this. This is why we need to be confident that an half-bak=
ed                                  =20
>>>>>>>> port on top of Dovetail is not causing this.                      =
                                    =20
>>>>>>  >                                                                  =
                                    =20
>>>>>> 44> hours uninterrupted runtime on armv7, x86 and armv8, under stres=
s: no                               =20
>>>>>> is>sue detected so far. This does not rule out a Dovetail bug yet, b=
ut                                  =20
>>>>>> th>e possibility of a Cobalt issue is real.                         =
                                    =20
>>>>>>  >                                                                  =
                                    =20
>>>>>> -->                                                                 =
                                    =20
>>>>>> Ph>ilippe.                                                          =
                                    =20
>>>>>                                                                      =
                                    =20
>>>>> Thanks for your feedback.  I already found the root cause for the iss=
ue. According to my                 =20
>>>>> debug on evl, I found that actually after call tick_install_proxy , t=
he original                         =20
>>>>> hrtimer_interrupt would be called by proxy_irq_handler instead of   _=
_sysvec_apic_timer_interrupt        =20
>>>>> so that  rcu_sched_clock_irq still can be successfully called by  upd=
ate_process_times and               =20
>>>>> invoke_rcu_core would always be called and callback registerred by ca=
ll_rcu can be successfully handled. =20
>>>>> But in my case, after call tick_install_proxy in xenomai, update_proc=
ess_times is never called and then  =20
>>>>> cause hang in rcu_barrier issue later. I would continue to check why =
fail to replace timer irq in my case.
>>>>>                                                                      =
                                    =20
>>>>> Did you try running Dovetail's boot time pipeline torture tests? Thos=
e                                   =20
>>>>> would exercise the basic features, such as the tick proxy device,    =
                                    =20
>>>>> without any dependencies whatsoever. You may need to disable Cobalt t=
o                                   =20
>>>>> do so, in order to leave the out-of-band stage available to them at b=
oot.                                =20
>>>>>                                                                      =
                                    =20
>>>>> CONFIG_IRQ_PIPELINE_TORTURE_TESTS=3Dy                                =
                                      =20
>>>>> CONFIG_XENOMAI=3Dn                                                   =
                                      =20
>>>>>                                                                      =
                                    =20
>>>>> If successful, those tests on a quad-core CPU should yield that kind =
of                                  =20
>>>>> traces in the kernel log:                                            =
                                    =20
>>>>>                                                                      =
                                    =20
>>>>> [    4.413767] Starting IRQ pipeline tests...                        =
                                    =20
>>>>> [    4.413772] IRQ pipeline: high-priority torture stage added.      =
                                    =20
>>>>> [    4.423571] irq_pipeline-torture: CPU2 initiates stop_machine()   =
                                    =20
>>>>> [    4.429527] irq_pipeline-torture: CPU3 responds to stop_machine() =
                                    =20
>>>>> [    4.429534] irq_pipeline-torture: CPU1 responds to stop_machine() =
                                    =20
>>>>> [    4.429538] irq_pipeline-torture: CPU0 responds to stop_machine() =
                                    =20
>>>>> [    4.447945] CPU0: proxy tick device registered (199.20MHz)        =
                                    =20
>>>>> [    4.447948] CPU1: proxy tick device registered (199.20MHz)        =
                                    =20
>>>>> [    4.447954] CPU3: proxy tick device registered (199.20MHz)        =
                                    =20
>>>>> [    4.464448] CPU2: proxy tick device registered (199.20MHz)        =
                                    =20
>>>>> [    4.469985] irq_pipeline-torture: CPU2: irq_work handled          =
                                    =20
>>>>> [    4.475322] irq_pipeline-torture: CPU2: in-band->in-band irq_work =
trigger works                       =20
>>>>> [    4.482648] irq_pipeline-torture: CPU2: stage escalation request w=
orks                                =20
>>>>> [    4.482650] irq_pipeline-torture: CPU2: irq_work handled          =
                                    =20
>>>>> [    4.494523] irq_pipeline-torture: CPU2: oob->in-band irq_work trig=
ger works                           =20
>>>>> [    5.523585] CPU3: proxy tick device unregistered                  =
                                    =20
>>>>> [    5.523590] CPU1: proxy tick device unregistered                  =
                                    =20
>>>>> [    5.523592] CPU0: proxy tick device unregistered                  =
                                    =20
>>>>> [    5.537459] CPU2: proxy tick device unregistered                  =
                                    =20
>>>>> [    5.542113] IRQ pipeline: torture stage removed.                  =
                                    =20
>>>>> [    5.546753] IRQ pipeline tests OK.                                =
                                    =20
>>>>                                                                       =
                                    =20
>>>> Anything suspicious there instead would point to a Dovetail-related   =
                                    =20
>>>> issue.                                                                =
                                    =20
>>>>                                                                       =
                                    =20
>>>> --                                                                    =
                                    =20
>>>> Philippe.                                                             =
                                    =20
>>>>                                                                       =
                                    =20
>>>> The pipeline tests OK after I enable CONFIG_IRQ_PIPELINE_TORTURE_TEST =
and                                 =20
>>>> disable xenomai as you suggested.                                     =
                                    =20
>>>>                                                                       =
                                    =20
>>>> When I try to debug this issue and add some printk info for functions =
                                    =20
>>>> such as clockevents_register_proxy in files like                      =
                                    =20
>>>> kernel/time/tick-proxy.c and kernel/time/clockevents.c, kernel hang in=
                                    =20
>>>> mark_readonly->rcu_barrier would suddenly dissappear, kernel          =
                                    =20
>>>> can boot into nfsroot and debian after then. But system would still ha=
ng in                               =20
>>>> other ruc_barrier during systemd trying to boot up some services.     =
                                    =20
>>>> I try to count interrupt in founction handle_apic_irq of arch/x86/kern=
el/irq_pipeline.c                   =20
>>>> for each cpu and then print this irq number in rcu_barrier for debugin=
g and                               =20
>>>> finally found that actually cpu0  stop counting from very early before=
 hang in                            =20
>>>> mark_readonly->rcu_barrier of kernel. After further debug, I found tha=
t cpu0                              =20
>>>> stop counting after call tick_install_proxy when kernel hang in       =
                                    =20
>>>> mark_readonly->rcu_barrier.                                           =
                                    =20
>>>>                                                                       =
                                    =20
>>>> For another hang case that system can boot into systemd but hang in ot=
her                                 =20
>>>> rcu_barrier, I found that actually other three cpus randomly stop prod=
ucing                               =20
>>>> apic timer interrupt except cpu0 after call tick_install_proxy accordi=
ng to my test.                      =20
>>>>                                                                       =
                                    =20
>>>> I do not know what may cause this issue. Do you have any suggestions a=
bout it?                            =20
>>>>                                                                       =
                                    =20
>>>> Regards                                                               =
                                    =20
>>>>                                                                       =
                                    =20
>>>> Hongzhan Chen                                                         =
                                    =20
>>>                                                                        =
                                    =20
>>> I reproduced following issue steadily today. I think this should be roo=
t cause for my                      =20
>>> hang issue. Till now I deeply understand what you suggested about porti=
ng....                              =20
>>> I want to say it is really genius design about pipeline + proxy tick fo=
r real time system                  =20
>>> on Linux kernel.                                                       =
                                    =20
>>>                                                                        =
                                    =20
>>> [    8.032556] IRQ pipeline: some code running in oob context 'Xenomai'=
                                    =20
>> [    8.032557]               called an in-band only routine             =
                                   =20
>> [    8.032558] CPU: 0 PID: 12 Comm: migration/0 Tainted: G     U        =
    5.8.0+ #30                     =20
>> [    8.032558] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/201=
9                                  =20
>> [    8.032559] IRQ stage: Xenomai                                       =
                                   =20
>> [    8.032559] Call Trace:                                              =
                                   =20
>> [    8.032560]  dump_stack+0x85/0xa6                                    =
                                   =20
>> [    8.032561]  inband_irq_save+0x6/0x30                                =
                                   =20
>> [    8.032561]  ktime_get+0x24/0x140                                    =
                                   =20
>                                                                          =
                                   =20
> Is calling that function OK in the EVL context? Does xnclock_tick() do   =
                                   =20
>                                                                          =
                                    =20
>Nope, calling ktime_get() would not be correct in the EVL context either. =
                                    =20
>                                                                          =
                                    =20
>--                                                                        =
                                    =20
>Philippe.  =20

ktime_get_mono_fast_ns really works. After replace ktime_get , my debug ker=
nel
image which I added debug info in several files as I mentioned before
now can successfully boot into debian system on our lava test environment w=
ith
ramdisk and nfsrootfs image built from xenoami-isar. But it is still quite =
unstable because
stall issue like in following log [1] still happen randomly on other three =
cpus=20
except cpu0 on my platform. If I remove all printk debug info, system alway=
s fail
to boot into debian because of cpu stall issue like [1]. According to my de=
bug,=20
cpu stall reported because these cpus stop producing apic timer interrupt a=
fter=20
call tick_install_proxy in xenomai_init earlier before. Do you have any ide=
as about it? Is it=20
worth continuing to debug it or I skip it at first to validate and debug ot=
her functions
I ported like xenomai scheduler with running latency test basedon on my bra=
nch?
 I am asking this because I saw that you already decided to restart poring =
dovetail over xenomai=20
in anther thread but I do not know if what I am doing would be helpful.

[1]:
[   25.439200] systemd-udevd (123) used greatest stack depth: 12888 bytes l=
eft
mount: I/O error
[   29.487335] nfsmount (136) used greatest stack depth: 12536 bytes left
Begin: Retrying nfs mount ... [   33.541996] nfsmount (141) used greatest s=
tack depth: 12504 bytes left
done.
done.
Begin: Running /scripts/nfs-bottom ... done.
Begin: Running /scripts/init-bottom ...=20
[   33.622747] mount (146) used greatest stack depth: 12456 bytes left
done.
[   33.773193] run-init (150) used greatest stack depth: 12216 bytes left
[   60.011438] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   60.017944] rcu: 	2-...!: (1223 GPs behind) idle=3D67c/0/0x0 softirq=3D0=
/0 fqs=3D0  (false positive?)
[   60.027481] 	(detected by 1, t=3D26018 jiffies, g=3D3961, q=3D2)
[   60.033477] Sending NMI from CPU 1 to CPUs 2:
[   60.039265] NMI backtrace for cpu 2 skipped: idling at cpu_idle_poll+0x3=
5/0x1f0
[   60.039269] rcu: rcu_sched kthread starved for 26029 jiffies! g3961 f0x0=
 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[   60.058468] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[   60.068253] rcu: RCU grace-period kthread stack dump:
[   60.073782] rcu_sched       I14904    11      2 0x00004000
[   60.079790] Call Trace:
[   60.082488]  __schedule+0x40c/0x990
[   60.086292]  schedule+0x50/0xc0
[   60.089738]  schedule_timeout+0x16d/0x2e0
[   60.094144]  ? __next_timer_interrupt+0xc0/0xc0
[   60.099113]  rcu_gp_kthread+0x883/0x15f0
[   60.103399]  ? trace_hardirqs_on+0x37/0x110
[   60.107969]  ? rcu_core_si+0x10/0x10
[   60.111881]  kthread+0x134/0x150
[   60.115393]  ? kthread_park+0x80/0x80
[   60.119382]  ret_from_fork+0x1f/0x30
[   86.124454] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
[   86.130955] rcu: 	2-...!: (1224 GPs behind) idle=3D680/0/0x0 softirq=3D0=
/0 fqs=3D0  (false positive?)
[   86.140491] 	(detected by 0, t=3D26002 jiffies, g=3D3965, q=3D24)
[   86.146573] Sending NMI from CPU 0 to CPUs 2:
[   86.152345] NMI backtrace for cpu 2 skipped: idling at cpu_idle_poll+0x3=
5/0x1f0
[   86.152349] rcu: rcu_sched kthread starved for 26001 jiffies! g3965 f0x0=
 RCU_GP_WAIT_FQS(5) ->state=3D0x402 ->cpu=3D0
[   86.171517] rcu: 	Unless rcu_sched kthread gets sufficient CPU time, OOM=
 is now expected behavior.
[   86.181283] rcu: RCU grace-period kthread stack dump:
[   86.186819] rcu_sched       I14904    11      2 0x00004000
[   86.192816] Call Trace:
[   86.195500]  __schedule+0x40c/0x990
[   86.199340]  schedule+0x50/0xc0
[   86.202804]  schedule_timeout+0x16d/0x2e0
[   86.207201]  ? __next_timer_interrupt+0xc0/0xc0
[   86.212157]  rcu_gp_kthread+0x883/0x15f0
[   86.216464]  ? trace_hardirqs_on+0x37/0x110
[   86.221051]  ? rcu_core_si+0x10/0x10
[   86.224982]  kthread+0x134/0x150
[   86.228499]  ? kthread_park+0x80/0x80
[   86.232502]  ret_from_fork+0x1f/0x30
[  112.238440] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:

Regards

Hongzhan Chen


