References: <3511af9f-f393-a226-0e41-a23d8c1577c8@siemens.com>
 <87ft0xfyj4.fsf@xenomai.org>
 <4f5118a4-d362-7f18-fdcf-da22aabb7344@siemens.com>
 <87czw0g5b5.fsf@xenomai.org>
 <bf661a41-7ddf-196f-e57f-eb0be99ea565@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH 5.4] x86: ipipe: Harden path between use_temporary_mm
 and unuse_temporary_mm
In-reply-to: <bf661a41-7ddf-196f-e57f-eb0be99ea565@siemens.com>
Date: Mon, 15 Mar 2021 10:43:38 +0100
Message-ID: <874khcg3at.fsf@xenomai.org>
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
Cc: xenomai@xenomai.org


Jan Kiszka <jan.kiszka@siemens.com> writes:

> On 15.03.21 10:00, Philippe Gerum wrote:
>> 
>> Jan Kiszka <jan.kiszka@siemens.com> writes:
>> 
>>> On 14.03.21 18:14, Philippe Gerum wrote:
>>>>
>>>> Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:
>>>>
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>
>>>>> This is only called during early init, e.g. for switching alternatives.
>>>>> Still, switch_mm_irqs_off would complain without this, and we are better
>>>>> safe than sorry.
>>>>>
>>>>
>>>> The way this is done in Dovetail is fragile too, since the protection we
>>>> have there still expects the pipeline entry code not to mess up on
>>>> handling an interrupt, which defeats the purpose of such
>>>> precaution. Besides, the temp_state should be snapshot under protection
>>>> too. IOW, IRQs should be hard disabled fully while using the temporary
>>>> mm.
>>>>
>>>> Upstreaming a similar patch for Dovetail.
>>>
>>> Just saw it: It's wrong as it left the hard_irq_save_full at the caller
>>> site. Would raise a warning when debugging is enabled. Please fix.
>>>
>> 
>> I guess you mean local_irq_save_full(). After a second look, the hard
>> irqs off section should cover the entire code poking new text into a
>> live kernel. This is what switching to the _full() forms enforced
>> already. So I see no point in changing the IRQ state in the use/unuse
>> helpers eventually.
>
> Right, either way is needed. If the tlb flush should be fully protected,
> the existing pattern is needed. But maybe more:
>
> Under I-pipe, playing with full disabling didn't work out well. Some
> spinlock function called via get_locked_pte reenabled hard IRQs. Not
> sure if dovetail is affected by that as well.
>

This was likely caused by ipipe_unstall_root(void) force enabling hard
irqs on. This is gone in Dovetail, and unstalling the inband stage with
hard irqs off is even considered a bug now (inband_irq_enable()
complains about this) so that we catch the callers who would still be
making the original assumption.

IOW, allocating page table directories when locking PTEs should not
cause hard IRQs to be force enabled with Dovetail. I'm going to check
this for peace of mind.

-- 
Philippe.

