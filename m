From: "Chen, Hongzhan" <hongzhan.chen@intel.com>
Subject: RE: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
Date: Mon, 30 Nov 2020 07:17:42 +0000
Message-ID: <MWHPR11MB171090C83BE4C0A62B3131D9F2F50@MWHPR11MB1710.namprd11.prod.outlook.com>
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
 <MWHPR11MB17104A3ABA4757E973ED5736F2F90@MWHPR11MB1710.namprd11.prod.outlook.com>
 <87wny591q6.fsf@xenomai.org>
In-Reply-To: <87wny591q6.fsf@xenomai.org>
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
>Sent: Saturday, November 28, 2020 7:10 PM
>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xeno=
mai_init
>
>
>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>
>>>-----Original Message-----
>>>From: Philippe Gerum <rpm@xenomai.org>=20
>>>Sent: Friday, November 20, 2020 11:19 PM
>>>To: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>Cc: Jan Kiszka <jan.kiszka@siemens.com>; xenomai@xenomai.org
>>>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xe=
nomai_init
>>>
>>>
>>>Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>
>>>>>-----Original Message-----                                            =
                                        =20
>>>>>From: Philippe Gerum <rpm@xenomai.org>                                =
                                        =20
>>>>>Sent: Thursday, November 19, 2020 8:36 PM                             =
                                        =20
>>>>>To: Jan Kiszka <jan.kiszka@siemens.com>                               =
                                        =20
>>>>>Cc: Chen, Hongzhan <hongzhan.chen@intel.com>; xenomai@xenomai.org     =
                                        =20
>>>>>Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after =
xenomai_init                            =20
>>>>>                                                                      =
                                        =20
>>>>>                                                                      =
                                        =20
>>>>>Jan Kiszka <jan.kiszka@siemens.com> writes:                           =
                                        =20
>>>>>                                                                      =
                                        =20
>>>>>> On 19.11.20 12:40, Chen, Hongzhan via Xenomai wrote:                =
                                        =20
>>>>>>>                                                                    =
                                        =20
>>>>>>>>>> -->---Original Message-----                                     =
                                        =20
>>>>>>>>>> Fr>om: Philippe Gerum <rpm@xenomai.org>                         =
                                        =20
>>>>>>>>>> Se>nt: Tuesday, November 17, 2020 6:01 PM                       =
                                        =20
>>>>>>>>>> To>: Chen, Hongzhan <hongzhan.chen@intel.com>                   =
                                        =20
>>>>>>>>>> Cc>: xenomai@xenomai.org                                        =
                                        =20
>>>>>>>>>> Su>bject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier=
 after xenomai_init                     =20
>>>>>>>>>>  >                                                              =
                                        =20
>>>>>>>>>>  >                                                              =
                                        =20
>>>>>>>>>> Ph>ilippe Gerum <rpm@xenomai.org> writes:                       =
                                        =20
>>>>>>>>>>  >                                                              =
                                        =20
>>>>>>>>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:              =
                                        =20
>>>>>>>>>>>>                                                               =
                                        =20
>>>>>>>>>>>>> I have some clues about this issue. After xenomai_init is cal=
led, it seems that rcu_core             =20
>>>>>>>>>>>>> is never called from unknow startpoint ever after call call_r=
cu, which is supposed to be             =20
>>>>>>>>>>>>> called by rcu softirq handler after we call call_rcu.        =
                                        =20
>>>>>>>>>>>>> I am trying to debug why rcu softirq is not triggerred after =
then.                                   =20
>>>>>>>>>>>>                                                               =
                                        =20
>>>>>>>>>>>>                                                               =
                                        =20
>>>>>>>>>>>> You may want to make sure this is not offloaded to RCU kthread=
s,                                      =20
>>>>>>>>>>>> typically in case you run with nocbs settings. This said, trac=
ing                                     =20
>>>>>>>>>>>> rcu_core() would match both.                                  =
                                        =20
>>>>>>>>>>>>                                                               =
                                        =20
>>>>>>>>>>>> I did not reproduce the issue you observed with the EVL core, =
testing                                 =20
>>>>>>>>>>>> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight t=
est to                                  =20
>>>>>>>>>>>> confirm this. This is why we need to be confident that an half=
-baked                                  =20
>>>>>>>>>>>> port on top of Dovetail is not causing this.                  =
                                        =20
>>>>>>>>>>  >                                                              =
                                        =20
>>>>>>>>>> 44> hours uninterrupted runtime on armv7, x86 and armv8, under s=
tress: no                               =20
>>>>>>>>>> is>sue detected so far. This does not rule out a Dovetail bug ye=
t, but                                  =20
>>>>>>>>>> th>e possibility of a Cobalt issue is real.                     =
                                        =20
>>>>>>>>>>  >                                                              =
                                        =20
>>>>>>>>>> -->                                                             =
                                        =20
>>>>>>>>>> Ph>ilippe.                                                      =
                                        =20
>>>>>>>>>                                                                  =
                                        =20
>>>>>>>>> Thanks for your feedback.  I already found the root cause for the=
 issue. According to my                 =20
>>>>>>>>> debug on evl, I found that actually after call tick_install_proxy=
 , the original                         =20
>>>>>>>>> hrtimer_interrupt would be called by proxy_irq_handler instead of=
   __sysvec_apic_timer_interrupt        =20
>>>>>>>>> so that  rcu_sched_clock_irq still can be successfully called by =
 update_process_times and               =20
>>>>>>>>> invoke_rcu_core would always be called and callback registerred b=
y call_rcu can be successfully handled. =20
>>>>>>>>> But in my case, after call tick_install_proxy in xenomai, update_=
process_times is never called and then  =20
>>>>>>>>> cause hang in rcu_barrier issue later. I would continue to check =
why fail to replace timer irq in my case.
>>>>>>>>>                                                                  =
                                        =20
>>>>>>>>> Did you try running Dovetail's boot time pipeline torture tests? =
Those                                   =20
>>>>>>>>> would exercise the basic features, such as the tick proxy device,=
                                        =20
>>>>>>>>> without any dependencies whatsoever. You may need to disable Coba=
lt to                                   =20
>>>>>>>>> do so, in order to leave the out-of-band stage available to them =
at boot.                                =20
>>>>>>>>>                                                                  =
                                        =20
>>>>>>>>> CONFIG_IRQ_PIPELINE_TORTURE_TESTS=3Dy                            =
                                          =20
>>>>>>>>> CONFIG_XENOMAI=3Dn                                               =
                                          =20
>>>>>>>>>                                                                  =
                                        =20
>>>>>>>>> If successful, those tests on a quad-core CPU should yield that k=
ind of                                  =20
>>>>>>>>> traces in the kernel log:                                        =
                                        =20
>>>>>>>>>                                                                  =
                                        =20
>>>>>>>>> [    4.413767] Starting IRQ pipeline tests...                    =
                                        =20
>>>>>>>>> [    4.413772] IRQ pipeline: high-priority torture stage added.  =
                                        =20
>>>>>>>>> [    4.423571] irq_pipeline-torture: CPU2 initiates stop_machine(=
)                                       =20
>>>>>>>>> [    4.429527] irq_pipeline-torture: CPU3 responds to stop_machin=
e()                                     =20
>>>>>>>>> [    4.429534] irq_pipeline-torture: CPU1 responds to stop_machin=
e()                                     =20
>>>>>>>>> [    4.429538] irq_pipeline-torture: CPU0 responds to stop_machin=
e()                                     =20
>>>>>>>>> [    4.447945] CPU0: proxy tick device registered (199.20MHz)    =
                                        =20
>>>>>>>>> [    4.447948] CPU1: proxy tick device registered (199.20MHz)    =
                                        =20
>>>>>>>>> [    4.447954] CPU3: proxy tick device registered (199.20MHz)    =
                                        =20
>>>>>>>>> [    4.464448] CPU2: proxy tick device registered (199.20MHz)    =
                                        =20
>>>>>>>>> [    4.469985] irq_pipeline-torture: CPU2: irq_work handled      =
                                        =20
>>>>>>>>> [    4.475322] irq_pipeline-torture: CPU2: in-band->in-band irq_w=
ork trigger works                       =20
>>>>>>>>> [    4.482648] irq_pipeline-torture: CPU2: stage escalation reque=
st works                                =20
>>>>>>>>> [    4.482650] irq_pipeline-torture: CPU2: irq_work handled      =
                                        =20
>>>>>>>>> [    4.494523] irq_pipeline-torture: CPU2: oob->in-band irq_work =
trigger works                           =20
>>>>>>>>> [    5.523585] CPU3: proxy tick device unregistered              =
                                        =20
>>>>>>>>> [    5.523590] CPU1: proxy tick device unregistered              =
                                        =20
>>>>>>>>> [    5.523592] CPU0: proxy tick device unregistered              =
                                        =20
>>>>>>>>> [    5.537459] CPU2: proxy tick device unregistered              =
                                        =20
>>>>>>>>> [    5.542113] IRQ pipeline: torture stage removed.              =
                                        =20
>>>>>>>>> [    5.546753] IRQ pipeline tests OK.                            =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> Anything suspicious there instead would point to a Dovetail-relate=
d                                       =20
>>>>>>>> issue.                                                            =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> --                                                                =
                                        =20
>>>>>>>> Philippe.                                                         =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> The pipeline tests OK after I enable CONFIG_IRQ_PIPELINE_TORTURE_T=
EST and                                 =20
>>>>>>>> disable xenomai as you suggested.                                 =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> When I try to debug this issue and add some printk info for functi=
ons                                     =20
>>>>>>>> such as clockevents_register_proxy in files like                  =
                                        =20
>>>>>>>> kernel/time/tick-proxy.c and kernel/time/clockevents.c, kernel han=
g in                                    =20
>>>>>>>> mark_readonly->rcu_barrier would suddenly dissappear, kernel      =
                                        =20
>>>>>>>> can boot into nfsroot and debian after then. But system would stil=
l hang in                               =20
>>>>>>>> other ruc_barrier during systemd trying to boot up some services. =
                                        =20
>>>>>>>> I try to count interrupt in founction handle_apic_irq of arch/x86/=
kernel/irq_pipeline.c                   =20
>>>>>>>> for each cpu and then print this irq number in rcu_barrier for deb=
uging and                               =20
>>>>>>>> finally found that actually cpu0  stop counting from very early be=
fore hang in                            =20
>>>>>>>> mark_readonly->rcu_barrier of kernel. After further debug, I found=
 that cpu0                              =20
>>>>>>>> stop counting after call tick_install_proxy when kernel hang in   =
                                        =20
>>>>>>>> mark_readonly->rcu_barrier.                                       =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> For another hang case that system can boot into systemd but hang i=
n other                                 =20
>>>>>>>> rcu_barrier, I found that actually other three cpus randomly stop =
producing                               =20
>>>>>>>> apic timer interrupt except cpu0 after call tick_install_proxy acc=
ording to my test.                      =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> I do not know what may cause this issue. Do you have any suggestio=
ns about it?                            =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> Regards                                                           =
                                        =20
>>>>>>>>                                                                   =
                                        =20
>>>>>>>> Hongzhan Chen                                                     =
                                        =20
>>>>>>>                                                                    =
                                        =20
>>>>>>> I reproduced following issue steadily today. I think this should be=
 root cause for my                      =20
>>>>>>> hang issue. Till now I deeply understand what you suggested about p=
orting....                              =20
>>>>>>> I want to say it is really genius design about pipeline + proxy tic=
k for real time system                  =20
>>>>>>> on Linux kernel.                                                   =
                                        =20
>>>>>>>                                                                    =
                                        =20
>>>>>>> [    8.032556] IRQ pipeline: some code running in oob context 'Xeno=
mai'                                    =20
>>>>>> [    8.032557]               called an in-band only routine         =
                                       =20
>>>>>> [    8.032558] CPU: 0 PID: 12 Comm: migration/0 Tainted: G     U    =
        5.8.0+ #30                     =20
>>>>>> [    8.032558] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16=
/2019                                  =20
>>>>>> [    8.032559] IRQ stage: Xenomai                                   =
                                       =20
>>>>>> [    8.032559] Call Trace:                                          =
                                       =20
>>>>>> [    8.032560]  dump_stack+0x85/0xa6                                =
                                       =20
>>>>>> [    8.032561]  inband_irq_save+0x6/0x30                            =
                                       =20
>>>>>> [    8.032561]  ktime_get+0x24/0x140                                =
                                       =20
>>>>                                                                       =
                                      =20
>>>> Is calling that function OK in the EVL context? Does xnclock_tick() do=
                                      =20
>>>>                                                                       =
                                       =20
>>>>Nope, calling ktime_get() would not be correct in the EVL context eithe=
r.                                     =20
>>>>                                                                       =
                                       =20
>>>>--                                                                     =
                                       =20
>>>>Philippe.  =20
>>>>
>>>> ktime_get_mono_fast_ns really works. After replace ktime_get , my debu=
g kernel
>>>> image which I added debug info in several files as I mentioned before
>>>> now can successfully boot into debian system on our lava test environm=
ent with
>>>> ramdisk and nfsrootfs image built from xenoami-isar. But it is still q=
uite unstable because
>>>> stall issue like in following log [1] still happen randomly on other t=
hree cpus=20
>>>> except cpu0 on my platform. If I remove all printk debug info, system =
always fail
>>>> to boot into debian because of cpu stall issue like [1]. According to =
my debug,=20
>>>> cpu stall reported because these cpus stop producing apic timer interr=
upt after=20
>>>> call tick_install_proxy in xenomai_init earlier before. Do you have
>>>> any ideas about it?
>>>
>>>Multiple causes might be involved:
>>>
>>>- ONESHOT_STOPPED mode not handled properly by the real-time core, when
>>>  entered by the in-band kernel code. For reference, the EVL core does
>>>  it the right way. The basic idea is that, whenever the proxy tick
>>>  device enters the ONESHOT_STOPPED mode, the underlying (real) tick
>>>  device is turned off as a result. After this transition has been
>>>  detected, next time the in-band kernel tells the real-time core to arm
>>>  a shot via the proxy, the core needs to force-program the timer
>>>  hardware to wake it up, i.e. calling ->set_next_event(). If we don't
>>>  do that, the real-time core might skip this step in case the next host
>>>  tick is not the earliest event in line, leaving the real device turned
>>>  off indefinitely. See program_timer() in the EVL core, tracking how
>>>  RQ_TSTOPPED is used.
>>
>> Thanks for your instruction. It works for the issue that 100% system han=
g
>> on cpu0.
>>
>>>- some issue related to entering a deep sleep mode, which ends up
>>>  confusing the Cobalt timing logic, causing the tick proxy to stop
>>>  relaying ticks to the in-band kernel. e.g. the CPU idling code
>>>  determines that it might be time for the current CPU to enter some
>>>  sleep state, but it should ask the real-time core to confirm this by
>>>  calling irq_cpuidle_control(). If the core does not implement this
>>>  call, then the transition is accepted by default. The EVL core
>>>  implements this weak call to figure out whether it is actually
>>>  acceptable to enter a sleep state wrt pending real-time duties: you
>>>  may want to have a look at the underlying logic there.
>>>
>>
>> But system still randomly hang because tick proxy fail to relay tick
>> to the in-band kernel even after I disable CONFIG_CPU_IDLE in building k=
ernel time.=20
>> In my dozens of  reboot test , about 1/3 case would fail because of cpu =
stall.
>>
>> Before issue happen, all cpu ticks work fine for first several seconds=20
>> after xenomai init according to tick count log that I added  for each cp=
u,
>> but from unknow point , some cpus would randomly stop reacting to=20
>> tick_notify_proxy after run successful several millions of ticks like
>> log [3].
>
>This would be typical of a problem happening in the wake of a CPU idling
>phase: if clock tick interrupts can still be observed, then this would
>rule out unexpected issue(s) with the clockevent chip entering the
>oneshot-stopped mode. On the other end, CPUs tend to be fairly busy
>during the boot sequence, until userland is eventually started
>(i.e. init is bootstrapped), at which point many/most of them may go
>idle.
>
>> In this case , issue happen on cpu3. I printed tick count in rcu_barrier=
 ,
>> which start counting when first handle_oob_event of proxy tick callback =
registered=20
>> is called. Actually , cpu3 stop counting a little bit earlier(about 300m=
s)  before  rcu_barrier
>> according to tick count difference between cpu3 and (cpu2 or cpu1).
>>
>> What I am doing on disabling CONFIG_CPU_IDLE can isolate issue related t=
o=20
>> deep sleep mode?  =20
>>
>
>This would disable cpuidle governors, not the entire idling logic. Let's
>assume there is a flaw in Dovetail's generic idling logic
>(i.e. kernel/sched/idle.c) which for some reason would leave the in-band
>stage spuriously stalled after wake up (i.e. irqs_disabled() =3D=3D
>true). In this case, proxy ticks would be piling up in the interrupt log
>of the in-band stage, but never played back by the pipeline engine.  I
>have no evidence of such Dovetail bug with the various tests I have been
>running on multiple archs so far, but it would make sense to start the
>investigations from the core layer in this case.
>
>First thing would be to change the runtime conditions by passing
>idle=3Dpoll on the kernel command line; that would enable a different set
>of code paths.
>
>Next, you may want to turn off the NO_HZ machinery in order to figure
>out whether it might be involved in this issue Dovetail-wise:
>
>CONFIG_TICK_ONESHOT=3Dy
>CONFIG_HZ_PERIODIC=3Dy
># CONFIG_NO_HZ_IDLE is not set
># CONFIG_NO_HZ_FULL is not set
>CONFIG_CONTEXT_TRACKING=3Dy
># CONFIG_CONTEXT_TRACKING_FORCE is not set
># CONFIG_NO_HZ is not set
>CONFIG_HIGH_RES_TIMERS=3Dy
># end of Timers subsystem
>
>I just checked this configuration with the EVL core, and the pipeline
>torture tests did pass.
>
>Eventually, you may want to instrument/ftrace the idling code inside the
>do_idle() loop (kernel/sched/idle.c) to make sure that in-band irqs are
>enabled as expected (i.e. irqs_enabled() =3D=3D true) every time
>arch_cpu_idle_exit() is reached.
>
>PS: you may also want to work on v5.9, not v5.8. The former is the
>current stable target along with v5.4.x for Dovetail. v5.10-rc is the
>current development series. Not all changes to v5.9+ have been
>backported to v5.8, which has been frozen weeks ago.

Thanks for your suggestions. After rebased onto v5.9-evl4  and turned off N=
O_HZ with using
configuration you mentioned with passing idle=3Dpoll ( actually  I have bee=
n always passing it in past test) ,
 in my 50 times of reboot test as usual , the old issue I reported totally =
can not be reproduced now.
 But there is one new issue occurred 4/50 like following log [5] after kern=
el totally boot up,  which is also quite
random but system is more stable than before.

Any suggestion about this issue? In addition , I would like to spend more t=
ime on validating xenomai scheduler=20
over dovetail with running benchmark like latency test based on my porting =
before your abstraction layer is done.=20
What is your suggestions?

Regards

Hongzhan Chen

[5]:
[   19.489210] igb 0000:04:00.0 enp4s0: renamed from eth1
Begin: Loading essential drivers ... done.
Begin: Running /scripts/init-premount ... done.
Begin: Mounting root file system ... Begin: Running /scripts/nfs-top ... do=
ne.
.....
 [   20.596766] nfsmount (134) used greatest stack depth: 12568 bytes left
done.
Begin: Running /scripts/nfs-bottom ... done.
Begin: Running /scripts/init-bottom ... done.
[   20.777483] run-init (143) used greatest stack depth: 12328 bytes left
SELinux:  Could not open policy file <=3D /etc/selinux/targeted/policy/poli=
cy.33:  No such file or directory
[   21.967433] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT=
 +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNU=
TLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default=
-hierarchy=3Dhybrid)
[   22.006061] systemd[1]: Detected architecture x86-64.
Welcome to [1mDebian GNU/Linux 10 (buster)[0m!
....
 [[0;32m  OK  [0m] Started [0;1;39mUpdate UTMP about System Runlevel Change=
s[0m.
Xenomai Demo Image (login: root/root)
Matched prompt #5: demo login:
case: kernel-messages
case_id: 44072
definition: lava
duration: 148.96
extra: ...
level: 2.3.4
namespace: common
result: pass
Sending username root
Sending with 500 millisecond of delay
root
demo login: root
Waiting for password prompt
auto-login-action: Wait for prompt ['root@demo:', 'Password:', 'Login timed=
 out'] (timeout 00:10:13)
root
Matched prompt #1: Password:
Sending password root
Sending with 500 millisecond of delay
root
Password: root
auto-login-action: Wait for prompt ['root@demo:', 'Login incorrect', 'Login=
 timed out'] (timeout 00:10:10)
[  148.586619] traps: PANIC: double fault, error_code: 0x0
[  148.586620] double fault: 0000 [#1] SMP NOPTI IRQ_PIPELINE
[  148.586621] CPU: 0 PID: 352 Comm: sd-resolve Not tainted 5.9.0+ #130
[  148.586621] Hardware name: Maxtang WL10/WL10, BIOS WL10R106 11/07/2019
[  148.586622] IRQ stage: Linux
[  148.586622] RIP: 0010:error_entry+0x1f/0xe0
[  148.586623] Code: 00 66 2e 0f 1f 84 00 00 00 00 00 fc 56 48 8b 74 24 08 =
48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <41=
> 57 56 31 d2 31 c9 45 31 c0 45 31 c9 45 31 d2 45 31 db 31 db 31
[  148.586624] RSP: 0018:00007fa093323000 EFLAGS: 00010006
[  148.586625] RAX: 0000000081c00ed7 RBX: 00007fa0933230f8 RCX: ffffffff81c=
00ed7
[  148.586625] RDX: 0000000000000000 RSI: ffffffff81c00ab8 RDI: 00007fa0933=
230f8
[  148.586626] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  148.586626] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  148.586627] R13: 0000000000016f40 R14: 0000000000000000 R15: 00000000000=
00000
[  148.586628] FS:  00007fa09332b700(0000) GS:ffff88845dc00000(0000) knlGS:=
ffff88845dc00000
[  148.586628] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.586629] CR2: 00007fa093322ff8 CR3: 0000000459a88002 CR4: 00000000001=
706f0
[  148.586629] Call Trace:
[  148.586629] Modules linked in:
[  148.714427] ---[ end trace a15909b9aa88a41f ]---
[  148.714428] RIP: 0010:error_entry+0x1f/0xe0
[  148.714429] Code: 00 66 2e 0f 1f 84 00 00 00 00 00 fc 56 48 8b 74 24 08 =
48 89 7c 24 08 52 51 50 41 50 41 51 41 52 41 53 53 55 41 54 41 55 41 56 <41=
> 57 56 31 d2 31 c9 45 31 c0 45 31 c9 45 31 d2 45 31 db 31 db 31
[  148.714429] RSP: 0018:00007fa093323000 EFLAGS: 00010006
[  148.714430] RAX: 0000000081c00ed7 RBX: 00007fa0933230f8 RCX: ffffffff81c=
00ed7
[  148.714430] RDX: 0000000000000000 RSI: ffffffff81c00ab8 RDI: 00007fa0933=
230f8
[  148.714431] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[  148.714432] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[  148.714432] R13: 0000000000016f40 R14: 0000000000000000 R15: 00000000000=
00000
[  148.714433] FS:  00007fa09332b700(0000) GS:ffff88845dc00000(0000) knlGS:=
ffff88845dc00000
[  148.714433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  148.714434] CR2: 00007fa093322ff8 CR3: 0000000459a88002 CR4: 00000000001=
706f0
[  148.714434] Kernel panic - not syncing: Fatal exception in interrupt
[  148.714443] Kernel Offset: disabled

>
>--=20
>Philippe.
>

