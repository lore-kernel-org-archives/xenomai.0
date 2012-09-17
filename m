Message-ID: <50571738.9060204@siemens.com>
Date: Mon, 17 Sep 2012 14:27:36 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org> <5056D4AE.2010201@web.de>
	<5056DA52.6040006@xenomai.org> <5056DCC5.10909@web.de>
	<505715E4.4080404@xenomai.org>
In-Reply-To: <505715E4.4080404@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] IO-APIC latencies
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <Xenomai@xenomai.org>

On 2012-09-17 14:21, Gilles Chanteperdrix wrote:
> On 09/17/2012 10:18 AM, Jan Kiszka wrote:
>> On 2012-09-17 10:07, Gilles Chanteperdrix wrote:
>>> On 09/17/2012 09:43 AM, Jan Kiszka wrote:
>>>> On 2012-09-17 08:30, Gilles Chanteperdrix wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> looking at x86 latencies, I found that what was taking long on my atom
>>>>> was masking the fasteoi interrupts at IO-APIC level. So, I experimented
>>>>> an idea: masking at LAPIC level instead of IO-APIC, by using the "task
>>>>> priority" register. This seems to improve latencies on my atom:
>>>>>
>>>>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
>>>>>
>>>>> This implies splitting the LAPIC vectors in a high priority and low
>>>>> priority sets, the final implementation would use ipipe_enable_irqdesc
>>>>> to detect a high priority domain, and change the vector at that time.
>>>>>
>>>>> This also improves the latencies on my old PIII with a VIA chipset, but
>>>>> it generates spurious interrupts (I do not know if it really is a
>>>>> matter, as handling a spurious interrupt is still faster than masking an
>>>>> IO-APIC interrupt), the spurious interrupts in that case are a
>>>>> documented behaviour of the LAPIC.
>>>>>
>>>>> Is there any interest in pursuing this idea, or are x86 with slow
>>>>> IO-APIC the exception more than the rule, or having to split the vector
>>>>> space appears too great a restriction?
>>>>
>>>> Line-based interrupts are legacy, of decreasing relevance for PCI
>>>> devices - likely what we are primarily interesting in here - due to MSI.
>>>
>>> Even if I enable MSI, the kernel still uses these irqs for the 
>>> peripherals integrated to the chipset, such as the USB HCI, or ATA 
>>> driver (IOW, non PCI devices). 
>>
>> Those are all PCI as well. And modern chipsets include variants of them
>> with MSI(-X) support.
> 
> Here is what I get on my workstation:
> $ grep fasteoi /proc/interrupts 
>   9:          0          0          0          0   IO-APIC-fasteoi   acpi
>  19:          0          0          0          0   IO-APIC-fasteoi   ahci
>  23:  280150305          0          0          0   IO-APIC-fasteoi   ehci_hcd:usb5, ehci_hcd:usb6
> 
> It is an sandy bridge processor, it has less than 2 years. 
> What exactly do you mean by "modern" ?

Mine is more than 2 years old and has an MSI-capable AHCI e.g.

Also interesting is the IO-APIC access delay you see on this platform.
We'll try to measure here as well.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

