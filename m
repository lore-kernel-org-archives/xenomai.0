References: <EB4794275C0C904BBABD6840AB8DC22D0598637E@DENBGAT9EL2MSX.ww902.siemens.net>
 <01691a1a-f661-4c0b-890f-d83038b25344@siemens.com>
 <EB4794275C0C904BBABD6840AB8DC22D05986505@DENBGAT9EL2MSX.ww902.siemens.net>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <9cd25122-adc5-735f-0bdc-fb22028bc2ed@siemens.com>
Date: Thu, 8 Feb 2018 13:52:51 +0100
MIME-Version: 1.0
In-Reply-To: <EB4794275C0C904BBABD6840AB8DC22D05986505@DENBGAT9EL2MSX.ww902.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Merging v4.4.108 into I-Pipe,
	issue with switch_mm on x86
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Sudler, Simon (PD PA CI R&D 3)" <simon.sudler@siemens.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2018-02-08 10:46, Sudler, Simon (PD PA CI R&D 3) wrote:
>> Jan Kiszka wrote:
>>
>> On 2018-02-08 09:12, Sudler, Simon (PD PA CI R&D 3) wrote:
>>> Hi Guys,
>>>
>>> I was just about to merging the v4.4.108 tag into the I-Pipe branch when I fall over these 4
>>> commits from Andy Lutomirski:
>>>
>>> git log --oneline dfe513a4e8ddde75ffc6abd3f139c5d65bf925d7..4ead44fd2525ed97e5362a806d312a0e3b0ea445
>>> 4ead44fd2525 x86/mm, sched/core: Turn off IRQs in switch_mm()
>>> 70a39c7fd167 x86/mm, sched/core: Uninline switch_mm()
>>> 83cc4b50e3a9 x86/mm: Build arch/x86/mm/tlb.c even on !SMP
>>> 425f13a36652 sched/core: Add switch_mm_irqs_off() and use it in the scheduler
>>>
>>> He introduces a switch_mm_irqs_off function and turns IRQs of inside the switch_mm function. In
>>> the switch_mm case local_irq_save/restore is to handle the interrupt flags.
>>>
>>> In the I-Pipe case, the switch_mm functions was renamed to __switch_mm which then handels the
>>> irq flags with hard_cond_local_irq_save/restore.
>>>
>>> So my question is: Is this double saving and restoring of the flags useful in the I-Pipe case? Maybe
>>> the the hard_cond_local_irq_save/restore can be moved to the local_irq_save/restore to have the
>>> irq flag handling at one place.
>>
>> Oops, when chatting with you, I totally forgot that I already did a 109
>> merge last month, just didn't find enough time to test. Now that you are
>> mentioning this concrete conflict, I started to remember. Please have a
>> look at
>> http://git.xenomai.org/ipipe-jki.git/log/?h=for-upstream/4.4-update.
>> That version /seems/ to work.
> 
> Okay, you added the "__" to the switch_mm_irqs_off. Wouldn't it be easier to just add
> 
> void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> 			  struct task_struct *tsk)
> {
> #ifdef CONFIG_IPIPE
> 	unsigned long flags = hard_cond_local_irq_save();
> #endif /* CONFIG_IPIPE */
> 
> 	unsigned cpu = smp_processor_id();
> 
> 
> to the mm/tlb.c and restore them at the end of the function? Then we could leaf the
> mmc_context.h untouched.
> 

This could be done (btw, #ifdef is unneeded), but it would redundantly
disable/restore IRQs for all the callers of __switch_mm_irqs_off that
already have hard IRQs off (if you find one in my merge that have them
on, please let me know!).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

