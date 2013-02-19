Message-ID: <5123CD17.4020505@siemens.com>
Date: Tue, 19 Feb 2013 20:05:59 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <511CD2FB.7010502@gmail.com> <511DDBD5.4060505@web.de>
	<51236088.1030402@gmail.com> <51236A75.5090400@siemens.com>
	<5123C910.7090107@siemens.com> <5123C9E9.2060707@xenomai.org>
In-Reply-To: <5123C9E9.2060707@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] (Boot)-problems with (current) ipipe patch on AMD FX
 61000 - 2.6.38.8 & 3.5.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Manuel Huber <manuel.h87@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 2013-02-19 19:52, Gilles Chanteperdrix wrote:
> On 02/19/2013 07:48 PM, Jan Kiszka wrote:
> 
>> On 2013-02-19 13:05, Jan Kiszka wrote:
>>> On 2013-02-19 12:22, Manuel Huber wrote:
>>>> Thanks for your reply and sorry for the delay ;)
>>>> I have tried disabling the options and attached the logs. It still fails :(
>>>>
>>>> I hope it's okay to attach so many files... I can also add the config
>>>> files for
>>>> every build if that helps.
>>>
>>> I'll try your config later, though in a different environment. If I'm
>>> unable to reproduce, I'll provide further instrumentation suggestions.
>>
>> No luck in reproducing, even with enforced IRQ7 injection. I suppose
>> there are more factors influencing this. Again my question: any
>> indication on normal Linux kernels that there are spurious IRQs? What is
>> associated with IRQ7 on your system?
> 
> 
> IRQ7 may be a PIC spurious interrupt:
> http://wiki.osdev.org/Interrupts#Standard_ISA_IRQs
> http://wiki.osdev.org/8259_PIC#Spurious_IRQs

True. And the PIC may not deliver to all CPUs on all systems. Sometimes
those IRQs only land on CPU0.

I just stepped through start_secondary here. It starts with

(gdb) p $lx_per_cpu("vector_irq")[0x37]
$2 = -1

But then, before executing local_irq_enable:

(gdb) p $lx_per_cpu("vector_irq")[0x37]
$10 = 7

However:

(gdb) p /x $eflags
$11 = 0x46

Thus IRQs hard disabled. I really don't understand what happens there.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

