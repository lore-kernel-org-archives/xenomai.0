Message-ID: <54E77AC4.3000109@siemens.com>
Date: Fri, 20 Feb 2015 19:19:48 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54E776E2.2030501@siemens.com> <54E77A52.4010806@siemens.com>
In-Reply-To: <54E77A52.4010806@siemens.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] ipipe: issues with ARM exception handling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>, Philippe Gerum <rpm@xenomai.org>

Mails crossed - Philippe, can you comment on this topic?

On 2015-02-20 19:17, Jan Kiszka wrote:
> On 2015-02-20 19:03, Jan Kiszka wrote:
>> Hi Gilles,
>>
>> analyzing a lockdep warning on 3.16 with I-pipe enabled, I dug deeper
>> into the hard and virtual interrupt state management during exception
>> handling on ARM. I think there are several issues:
>>
>> - ipipe_fault_entry should not fiddle with the root irq state if run
>>   over head, only when invoked over root.
>> - ipipe_fault_exit must not change the root state unless we entered over
>>   head and are about to leave over root - see x86. The current code may
>>   keep root incorrectly stalled after an exception, though this will
>>   probably be fixed up again in practice quickly.
> 
> And the adjustment of the root irq state after migration has to happen
> before Linux starts to handle the event. It would basically be a late
> ipipe_fault_entry.
> 
>> - do_sect_fault is only called by do_DataAbort and do_PrefetchAbort,
>>   in both cases already wrapped in ipipe_fault_entry/exit, thus it
>>   shouldn't invoke them once again.
> 
> Sorry, this was a misinterpretation - do_sect_fault is invoked before
> ipipe_fault_entry.
> 
> What I need to add, though:
> 
> - do_DataAbort and do_PrefetchAbort call __ipipe_report_trap after
>   ipipe_fault_entry, thus with hard IRQs on. That's contradicting the
>   pattern used otherwise. If we can avoid this, ipipe_fault_entry/exit
>   would probably only run over the root domain, and things become
>   simpler to sort out.
> 
> Jan
> 
>>
>> Room for optimization:
>> - ipipe_fault_entry is always called with hard IRQs off from
>>   do_page_fault and do_translation_fault. I suspect this applies to the
>>   remaining callers (do_DataAbort and do_PrefetchAbort ) as well. Thus
>>   the hard IRQ state is actually known at compile time, right?
>>
>> I can hack up patches, but I'd like to confirm first that I'm not
>> missing anything subtle or ARM-specific here.
>>
>> Jan
>>
> 

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

