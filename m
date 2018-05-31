From: Philippe Gerum <rpm@xenomai.org>
References: <20180531072547.xss3iljr5uk4cxnw@fsr-ub1664-175>
 <f700d5b6-c780-f306-0453-f984aee4b937@xenomai.org>
Message-ID: <d869577b-bb66-7cb7-5682-48d8c2acf85c@xenomai.org>
Date: Thu, 31 May 2018 15:06:16 +0200
MIME-Version: 1.0
In-Reply-To: <f700d5b6-c780-f306-0453-f984aee4b937@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Problem with ipipe locking PPIs and SGIs globally not
 per cpu
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Abel Vesa <abel.vesa@nxp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 05/31/2018 03:01 PM, Philippe Gerum wrote:
> On 05/31/2018 09:25 AM, Abel Vesa wrote:
>> The problem is the fact that the arm twd irq (for example) is masked on that
>> specific core inside gic, but the ipipe is locking it globally.
>>
>> According to GIC architecture specification
>>
>> https://www.cl.cam.ac.uk/research/srg/han/ACS-P35/zynq/arm_gic_architecture_specification.pdf
>>
>> Section 2.2.1
>>
>>         ...
>>         Interrupt numbers ID0-ID31 are used for interrupts that are private to a CPU interface. These interrupts are
>>         banked in the Distributor.
>>
>>         A banked interrupt is one where the Distributor can have multiple interrupts with the same ID. A banked
>>         interrupt is identified uniquely by its ID number and its associated CPU interface number. Of the banked
>>         interrupt IDs:
>>                 — ID0-ID15 are used for SGIs
>>                 — ID16-ID31 are used for PPIs
>>                 In a multiprocessor system:
>>                 — A PPI is forwarded to a particular CPU interface, and is private to that interface. In prioritizing
>>                 interrupts for a CPU interface the Distributor does not consider PPIs that relate to other interfaces.
>>         ...
>>
>> In our case, we're talking about ID29 (linux mapped 16). In kernel/ipipe/core.c,
>> in function __ipipe_lock_irq the control bits should either be set per cpu and
>> not globally if the hwirq is less than 31.
>>
>> A suggestion would be to use the NR_CPUS bits from ipd->irqs[irq].control to
>> mark the lock on a per cpu basis and then depending on the type of the irq
>> set the corresponding bits for each (or all, in case SPIs) cpu.
> 
> Using the control bits would limit the number of supported CPUs to
> __WORD_SIZE - 3, which would be too restrictive on high-end x86 or
> armv8-based boards.
> 
>  And then, when
>> checking if locked (in __ipipe_set_irq_pending and __ipipe_do_sync_stage)
>> include the cpu in the condition. That should be all.
>>
>> I'll try to come up with a patch later. I just wanted to point out the problem
>> here.
>>
> 
> Thanks for looking at this. Originally, this per-IRQ pipeline-specific
> bit was aimed at addressing the following scenario:
> 
>         local_irq_disable()
>         -> [IRQ receipt, logged for root stage]
> 	   disable_irq(irq)
> 	   ...
> 	   local_irq_enable()
> 	      -> [spurious IRQ replay upon log sync since IRQ
> 	          is deemed disabled]
> 
> It turns out that this is definitely not the best way to address it. It
> suffers multiple shortcomings, including SMP races and the requirement
> to fix up each and every mask/unmask irqchip handlers being used. The
> current approach even abuses the internal genirq interface, by handling
> a corner case related to the (shutdown|disable)_irq ops from the
> mask/unmask handlers.
> 
> There is an ongoing work to overhaul the integration of the interrupt
> pipeline with the genirq core which addresses this issue, and several
> others.
> 
> In the meantime, you could work around this issue by dropping the
> __ipipe_lock/unlock dance entirely, addressing this case by clearing the
> IRQ bit of the disabled/shutdown interrupt in each per-CPU log, from
> within irq(_percpu)_disable, __irq_disable and irq_shutdown. That would
> still not be perfect from a SMP synchronization point of view, but not
> worse than the current __ipipe_lock/unlock_irq scheme regarding this,
> and definitely better in all other aspects.
> 

If you go for that fix, please make sure to bypass the lazy disable mode
for IRQs and actually mask the IC hardware upon __irq_disable, otherwise
clearing the IRQ log for that IRQ would be pointless.

-- 
Philippe.

