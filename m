Message-ID: <54EB557F.1060909@xenomai.org>
Date: Mon, 23 Feb 2015 17:29:51 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54E776E2.2030501@siemens.com>
 <20150220183829.GA2356@hermes.click-hack.org> <54E78227.6000700@siemens.com>
 <54E84C3C.8070204@xenomai.org> <54EB4E70.2000009@siemens.com>
In-Reply-To: <54EB4E70.2000009@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 02/23/2015 04:59 PM, Jan Kiszka wrote:
> On 2015-02-21 10:13, Philippe Gerum wrote:
>> On 02/20/2015 07:51 PM, Jan Kiszka wrote:
>>> On 2015-02-20 19:38, Gilles Chanteperdrix wrote:
>>>> On Fri, Feb 20, 2015 at 07:03:14PM +0100, Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> analyzing a lockdep warning on 3.16 with I-pipe enabled, I dug deeper
>>>>> into the hard and virtual interrupt state management during exception
>>>>> handling on ARM. I think there are several issues:
>>>>>
>>>>> - ipipe_fault_entry should not fiddle with the root irq state if run
>>>>>   over head, only when invoked over root.
>>>>> - ipipe_fault_exit must not change the root state unless we entered over
>>>>>   head and are about to leave over root - see x86. The current code may
>>>>>   keep root incorrectly stalled after an exception, though this will
>>>>>   probably be fixed up again in practice quickly.
>>>>> - do_sect_fault is only called by do_DataAbort and do_PrefetchAbort,
>>>>>   in both cases already wrapped in ipipe_fault_entry/exit, thus it
>>>>>   shouldn't invoke them once again.
>>>>>
>>>>> Room for optimization:
>>>>> - ipipe_fault_entry is always called with hard IRQs off from
>>>>>   do_page_fault and do_translation_fault. I suspect this applies to the
>>>>>   remaining callers (do_DataAbort and do_PrefetchAbort ) as well. Thus
>>>>>   the hard IRQ state is actually known at compile time, right?
>>>
>>> To follow up on this: do_DataAbort and do_PrefetchAbort are always
>>> invoked with hard IRQs disable when a regular exception takes us there.
>>> Only the ghost syscall cmpxchg simulates do_DataAbort without adjusting
>>> hardware interrupt. It's probably easier to adjust that than to account
>>> for hw irqs being potentially on an fault entry.
>>>
>>>>>
>>>>> I can hack up patches, but I'd like to confirm first that I'm not
>>>>> missing anything subtle or ARM-specific here.
>>>>
>>>> Just to explain the original hack.
>>>>
>>>> Some time ago, the faults handlers were executed irqs on ARM. The
>>>> irqs were enabled in entry.S before executing the handlers.
>>>>
>>>> At some point, this was removed in entry.S and fault handlers
>>>> started to be executed irqs off. On ARM, all faults relax to be
>>>> handled in secondary mode, actually there is an exception, the FPU,
>>>> but it goes through a completely different path which had always
>>>> been executed irqs off until recently where the irqs are reenabled
>>>> when accessing user-space to be able to handle faults without
>>>> lockups. 
>>>>
>>>> My concern was that the code thus executed could have assertion
>>>> about the root domain being stalled which would be fail, so I added
>>>> code which stalled root and enabled hardware irqs on fault entry and
>>>> unstalled root and disabled hardware irqs on fault exit (which
>>>> always happen on root domain). This should have worked even if a fault
>>>> had happened to be handled in head domain, because then the
>>>> operation would have been a nop (simply stall/then unstall). 
>>>>
>>>> But Philippe found this dumb approach to fail when working on LPAE,
>>>> IIRC. IIRC, namely, if the root domain happens to be stalled when
>>>> entering a fault over head domain, it would end up unstalled after
>>>> the operation. So, I believe the code he added saves the stall state
>>>> on fault entry and restores it on fault exit. I have checked
>>>> Philippe's code details at the time and did not find anything wrong.
>>>
>>> I suspect the LPAE scenario takes the do_page_fault path? Then it should
>>
>> It takes the do_translation_fault path, where the page table fixups will
>> happen.
> 
> For kernel space addresses, the fixup happens directly, indeed. But here
> we need no fiddling with the root IRQ state at all as no sensitive
> kernel functions are called.
> 
> User space will end up in do_page_fault.
> 

If you refer to a first level translation fault, we currently don't
fiddle with the virtual IRQ state, and also refrain from running any
client hook until the page table is fixed up, so that we don't do any
access to non-linear memory before this happened either.

If you refer to do_page_fault instead, I see no issue in restoring the
root context across a migration from head to root, although not
required. But this is hardly an optimization, given the cost of a domain
migration in the first place. Do you have any scenario in mind which
would trigger a bug?

There is indeed the issue of the vanilla kernel code re-enabling
interrupts if the caller entered the trap handler with the CPSR_I bit
set, in which case a fault taken on behalf a kernel context in a
virtually masked section, but actually unmasked CPU state, would
eventually exit with the root domain stalled. The main problem I see
here, is that a scheduler transition to a blocked state (e.g.
down_read()) would be entered with virtual IRQs off, which may not be a
good idea.

-- 
Philippe.

