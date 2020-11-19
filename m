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
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after
 xenomai_init
In-reply-to: <72043f71-f89a-9167-b0cb-034493b966ee@siemens.com>
Date: Thu, 19 Nov 2020 13:36:20 +0100
Message-ID: <87k0uh4j7f.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "Chen, Hongzhan" <hongzhan.chen@intel.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 19.11.20 12:40, Chen, Hongzhan via Xenomai wrote:
>> 
>>>>> -->---Original Message-----
>>>>> Fr>om: Philippe Gerum <rpm@xenomai.org> 
>>>>> Se>nt: Tuesday, November 17, 2020 6:01 PM
>>>>> To>: Chen, Hongzhan <hongzhan.chen@intel.com>
>>>>> Cc>: xenomai@xenomai.org
>>>>> Su>bject: Re: [Xenomai over dovetail] Kernel hang in rcu_barrier after xenomai_init
>>>>>  >
>>>>>  >
>>>>> Ph>ilippe Gerum <rpm@xenomai.org> writes:
>>>>>  >
>>>>>>> Chen, Hongzhan <hongzhan.chen@intel.com> writes:
>>>>>>>
>>>>>>>> I have some clues about this issue. After xenomai_init is called, it seems that rcu_core
>>>>>>>> is never called from unknow startpoint ever after call call_rcu, which is supposed to be 
>>>>>>>> called by rcu softirq handler after we call call_rcu.
>>>>>>>> I am trying to debug why rcu softirq is not triggerred after then.
>>>>>>>
>>>>>>>
>>>>>>> You may want to make sure this is not offloaded to RCU kthreads,
>>>>>>> typically in case you run with nocbs settings. This said, tracing
>>>>>>> rcu_core() would match both.
>>>>>>>
>>>>>>> I did not reproduce the issue you observed with the EVL core, testing
>>>>>>> v5.8, v5.9 and v5.10-rc3. I'm currently running an overnight test to
>>>>>>> confirm this. This is why we need to be confident that an half-baked
>>>>>>> port on top of Dovetail is not causing this.
>>>>>  >
>>>>> 44> hours uninterrupted runtime on armv7, x86 and armv8, under stress: no
>>>>> is>sue detected so far. This does not rule out a Dovetail bug yet, but
>>>>> th>e possibility of a Cobalt issue is real.
>>>>>  >
>>>>> --> 
>>>>> Ph>ilippe.
>>>>
>>>> Thanks for your feedback.  I already found the root cause for the issue. According to my
>>>> debug on evl, I found that actually after call tick_install_proxy , the original 
>>>> hrtimer_interrupt would be called by proxy_irq_handler instead of   __sysvec_apic_timer_interrupt
>>>> so that  rcu_sched_clock_irq still can be successfully called by  update_process_times and
>>>> invoke_rcu_core would always be called and callback registerred by call_rcu can be successfully handled.
>>>> But in my case, after call tick_install_proxy in xenomai, update_process_times is never called and then
>>>> cause hang in rcu_barrier issue later. I would continue to check why fail to replace timer irq in my case.
>>>>
>>>> Did you try running Dovetail's boot time pipeline torture tests? Those
>>>> would exercise the basic features, such as the tick proxy device,
>>>> without any dependencies whatsoever. You may need to disable Cobalt to
>>>> do so, in order to leave the out-of-band stage available to them at boot.
>>>>
>>>> CONFIG_IRQ_PIPELINE_TORTURE_TESTS=y
>>>> CONFIG_XENOMAI=n
>>>>
>>>> If successful, those tests on a quad-core CPU should yield that kind of
>>>> traces in the kernel log:
>>>>
>>>> [    4.413767] Starting IRQ pipeline tests...
>>>> [    4.413772] IRQ pipeline: high-priority torture stage added.
>>>> [    4.423571] irq_pipeline-torture: CPU2 initiates stop_machine()
>>>> [    4.429527] irq_pipeline-torture: CPU3 responds to stop_machine()
>>>> [    4.429534] irq_pipeline-torture: CPU1 responds to stop_machine()
>>>> [    4.429538] irq_pipeline-torture: CPU0 responds to stop_machine()
>>>> [    4.447945] CPU0: proxy tick device registered (199.20MHz)
>>>> [    4.447948] CPU1: proxy tick device registered (199.20MHz)
>>>> [    4.447954] CPU3: proxy tick device registered (199.20MHz)
>>>> [    4.464448] CPU2: proxy tick device registered (199.20MHz)
>>>> [    4.469985] irq_pipeline-torture: CPU2: irq_work handled
>>>> [    4.475322] irq_pipeline-torture: CPU2: in-band->in-band irq_work trigger works
>>>> [    4.482648] irq_pipeline-torture: CPU2: stage escalation request works
>>>> [    4.482650] irq_pipeline-torture: CPU2: irq_work handled
>>>> [    4.494523] irq_pipeline-torture: CPU2: oob->in-band irq_work trigger works
>>>> [    5.523585] CPU3: proxy tick device unregistered
>>>> [    5.523590] CPU1: proxy tick device unregistered
>>>> [    5.523592] CPU0: proxy tick device unregistered
>>>> [    5.537459] CPU2: proxy tick device unregistered
>>>> [    5.542113] IRQ pipeline: torture stage removed.
>>>> [    5.546753] IRQ pipeline tests OK.
>>>
>>> Anything suspicious there instead would point to a Dovetail-related
>>> issue.
>>>
>>> -- 
>>> Philippe.
>>>
>>> The pipeline tests OK after I enable CONFIG_IRQ_PIPELINE_TORTURE_TEST and
>>> disable xenomai as you suggested. 
>>>
>>> When I try to debug this issue and add some printk info for functions 
>>> such as clockevents_register_proxy in files like 
>>> kernel/time/tick-proxy.c and kernel/time/clockevents.c, kernel hang in 
>>> mark_readonly->rcu_barrier would suddenly dissappear, kernel
>>> can boot into nfsroot and debian after then. But system would still hang in 
>>> other ruc_barrier during systemd trying to boot up some services.
>>> I try to count interrupt in founction handle_apic_irq of arch/x86/kernel/irq_pipeline.c
>>> for each cpu and then print this irq number in rcu_barrier for debuging and 
>>> finally found that actually cpu0  stop counting from very early before hang in
>>> mark_readonly->rcu_barrier of kernel. After further debug, I found that cpu0 
>>> stop counting after call tick_install_proxy when kernel hang in 
>>> mark_readonly->rcu_barrier. 
>>>
>>> For another hang case that system can boot into systemd but hang in other 
>>> rcu_barrier, I found that actually other three cpus randomly stop producing 
>>> apic timer interrupt except cpu0 after call tick_install_proxy according to my test.
>>>
>>> I do not know what may cause this issue. Do you have any suggestions about it?
>>>
>>> Regards
>>>
>>> Hongzhan Chen
>> 
>> I reproduced following issue steadily today. I think this should be root cause for my
>> hang issue. Till now I deeply understand what you suggested about porting.... 
>> I want to say it is really genius design about pipeline + proxy tick for real time system
>> on Linux kernel.
>> 
>> [    8.032556] IRQ pipeline: some code running in oob context 'Xenomai'
>> [    8.032557]               called an in-band only routine
>> [    8.032558] CPU: 0 PID: 12 Comm: migration/0 Tainted: G     U            5.8.0+ #30
>> [    8.032558] Hardware name: Maxtang WL10/WL10, BIOS WL10T105 10/16/2019
>> [    8.032559] IRQ stage: Xenomai
>> [    8.032559] Call Trace:
>> [    8.032560]  dump_stack+0x85/0xa6
>> [    8.032561]  inband_irq_save+0x6/0x30
>> [    8.032561]  ktime_get+0x24/0x140
>
> Is calling that function OK in the EVL context? Does xnclock_tick() do

Nope, calling ktime_get() would not be correct in the EVL context either.

-- 
Philippe.

