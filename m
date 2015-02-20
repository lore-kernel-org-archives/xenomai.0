Message-ID: <54E78F62.9040505@xenomai.org>
Date: Fri, 20 Feb 2015 20:47:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54E776E2.2030501@siemens.com> <54E77A52.4010806@siemens.com>
 <54E78EB8.4060204@xenomai.org>
In-Reply-To: <54E78EB8.4060204@xenomai.org>
Content-Type: text/plain; charset=windows-1252
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, Xenomai <xenomai@xenomai.org>

On 02/20/2015 08:44 PM, Philippe Gerum wrote:
> On 02/20/2015 07:17 PM, Jan Kiszka wrote:
>> On 2015-02-20 19:03, Jan Kiszka wrote:
>>> Hi Gilles,
>>>
>>> analyzing a lockdep warning on 3.16 with I-pipe enabled, I dug deeper
>>> into the hard and virtual interrupt state management during exception
>>> handling on ARM. I think there are several issues:
>>>
>>> - ipipe_fault_entry should not fiddle with the root irq state if run
>>>   over head, only when invoked over root.
>>> - ipipe_fault_exit must not change the root state unless we entered over
>>>   head and are about to leave over root - see x86. The current code may
>>>   keep root incorrectly stalled after an exception, though this will
>>>   probably be fixed up again in practice quickly.
>>
>> And the adjustment of the root irq state after migration has to happen
>> before Linux starts to handle the event. It would basically be a late
>> ipipe_fault_entry.
>>
>>> - do_sect_fault is only called by do_DataAbort and do_PrefetchAbort,
>>>   in both cases already wrapped in ipipe_fault_entry/exit, thus it
>>>   shouldn't invoke them once again.
>>
>> Sorry, this was a misinterpretation - do_sect_fault is invoked before
>> ipipe_fault_entry.
>>
>> What I need to add, though:
>>
>> - do_DataAbort and do_PrefetchAbort call __ipipe_report_trap after
>>   ipipe_fault_entry, thus with hard IRQs on.
> 
> This would break LPAE with the Xenomai nucleus as a module on 2.6.x, by
> treading over a non-linear kernel mapping before the page table could be
> fixed up. do_translation_fault() must run via the fsr handler
> indirection before any non-linear access.
> 

Sorry, if you do that _after_ the fault entry notification, then it's ok
in theory. However, I don't understand why we would need to notify when
only a minor fixup is required, that does not entail a mode migration.

-- 
Philippe.

