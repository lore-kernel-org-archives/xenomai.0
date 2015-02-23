Message-ID: <54EB7C0E.80201@siemens.com>
Date: Mon, 23 Feb 2015 20:14:22 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <54EB5D02.8080105@xenomai.org>
 <20150223171250.GE22377@hermes.click-hack.org>
 <20150223172146.GG22377@hermes.click-hack.org> <54EB66BB.2060703@siemens.com>
 <20150223175110.GI22377@hermes.click-hack.org> <54EB695C.4000909@siemens.com>
 <20150223180425.GJ22377@hermes.click-hack.org>
 <20150223181124.GK22377@hermes.click-hack.org> <54EB6E68.3010200@siemens.com>
 <54EB7235.4000401@siemens.com> <20150223183443.GM22377@hermes.click-hack.org>
In-Reply-To: <20150223183443.GM22377@hermes.click-hack.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 2015-02-23 19:34, Gilles Chanteperdrix wrote:
> On Mon, Feb 23, 2015 at 07:32:21PM +0100, Jan Kiszka wrote:
>> On 2015-02-23 19:16, Jan Kiszka wrote:
>>> On 2015-02-23 19:11, Gilles Chanteperdrix wrote:
>>>> On Mon, Feb 23, 2015 at 07:04:25PM +0100, Gilles Chanteperdrix wrote:
>>>>> So, finally, I propose:
>>>>
>>>> Mmmm. try again.
>>>>
>>>>>
>>>>> static inline unsigned long ipipe_fault_entry(void)
>>>>> {
>>>>> 	unsigned long flags;
>>>>>
>>>>> 	local_irq_save(flags);      /* Re-enables hw irqs */
>>>>
>>>> We need the explicit hard_local_irq_enable() here.
>>
>> And we need to fix up regs->ARM_cpsr according to flags.
> 
> No, we have no reason to fix up regs->ARM_cpsr.

do_page_fault:
	if (interrupts_enabled(regs))
		local_irq_enable();

It's very valuable to study x86 on this. It may overdo some things (we
will clean it up), but it is also very similar to ARM architecturally,
so we can draw conclusions from that.

> 
> It has been saved when entering the exception, and contains the
> state of the calling context. It needs to be restored exactly as it
> is.

See x86 for the reasons.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

