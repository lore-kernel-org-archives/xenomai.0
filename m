Message-ID: <50573532.20700@siemens.com>
Date: Mon, 17 Sep 2012 16:35:30 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org>	<5056D4AE.2010201@web.de>
	<5056DA52.6040006@xenomai.org>	<5056DCC5.10909@web.de>
	<5056E024.5020904@xenomai.org>	<5056E863.4090606@siemens.com>
	<5056ED68.6050101@xenomai.org>	<5056F09C.8050602@siemens.com>
	<5056F4A1.6070500@xenomai.org>
	<CANKLDmuxUk0XQobqs_OJ8vwQvaMie3Q3JU5Fn5DjpfpfZH3=cg@mail.gmail.com>
	<50570606.7060909@xenomai.org>
	<CANKLDmuTU3351fNd8eTqiY-9+53h2iO5TzWNsX-wqPj98f4gMw@mail.gmail.com>
	<5057173C.9070108@siemens.com> <5057299B.9060804@xenomai.org>
	<50572B95.2060302@siemens.com> <50572D86.3040306@xenomai.org>
In-Reply-To: <50572D86.3040306@xenomai.org>
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

On 2012-09-17 16:02, Gilles Chanteperdrix wrote:
> On 09/17/2012 03:54 PM, Jan Kiszka wrote:
>> On 2012-09-17 15:46, Gilles Chanteperdrix wrote:
>>> On 09/17/2012 02:27 PM, Jan Kiszka wrote:
>>>> On 2012-09-17 14:15, Henri Roosen wrote:
>>>>> On Mon, Sep 17, 2012 at 1:14 PM, Gilles Chanteperdrix
>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>> On 09/17/2012 12:39 PM, Henri Roosen wrote:
>>>>>>
>>>>>>> On Mon, Sep 17, 2012 at 12:00 PM, Gilles Chanteperdrix
>>>>>>> <gilles.chanteperdrix@xenomai.org> wrote:
>>>>>>>> On 09/17/2012 11:42 AM, Jan Kiszka wrote:
>>>>>>>>> On 2012-09-17 11:29, Gilles Chanteperdrix wrote:
>>>>>>>>>> On 09/17/2012 11:07 AM, Jan Kiszka wrote:
>>>>>>>>>>> On 2012-09-17 10:32, Gilles Chanteperdrix wrote:
>>>>>>>>>>>> On 09/17/2012 10:18 AM, Jan Kiszka wrote:
>>>>>>>>>>>>> On 2012-09-17 10:07, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>> On 09/17/2012 09:43 AM, Jan Kiszka wrote:
>>>>>>>>>>>>>>> On 2012-09-17 08:30, Gilles Chanteperdrix wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> looking at x86 latencies, I found that what was taking long on my atom
>>>>>>>>>>>>>>>> was masking the fasteoi interrupts at IO-APIC level. So, I experimented
>>>>>>>>>>>>>>>> an idea: masking at LAPIC level instead of IO-APIC, by using the "task
>>>>>>>>>>>>>>>> priority" register. This seems to improve latencies on my atom:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This implies splitting the LAPIC vectors in a high priority and low
>>>>>>>>>>>>>>>> priority sets, the final implementation would use ipipe_enable_irqdesc
>>>>>>>>>>>>>>>> to detect a high priority domain, and change the vector at that time.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> This also improves the latencies on my old PIII with a VIA chipset, but
>>>>>>>>>>>>>>>> it generates spurious interrupts (I do not know if it really is a
>>>>>>>>>>>>>>>> matter, as handling a spurious interrupt is still faster than masking an
>>>>>>>>>>>>>>>> IO-APIC interrupt), the spurious interrupts in that case are a
>>>>>>>>>>>>>>>> documented behaviour of the LAPIC.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Is there any interest in pursuing this idea, or are x86 with slow
>>>>>>>>>>>>>>>> IO-APIC the exception more than the rule, or having to split the vector
>>>>>>>>>>>>>>>> space appears too great a restriction?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Line-based interrupts are legacy, of decreasing relevance for PCI
>>>>>>>>>>>>>>> devices - likely what we are primarily interesting in here - due to MSI.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Even if I enable MSI, the kernel still uses these irqs for the
>>>>>>>>>>>>>> peripherals integrated to the chipset, such as the USB HCI, or ATA
>>>>>>>>>>>>>> driver (IOW, non PCI devices).
>>>>>>>>>>>>>
>>>>>>>>>>>>> Those are all PCI as well. And modern chipsets include variants of them
>>>>>>>>>>>>> with MSI(-X) support.
>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> atom login: root
>>>>>>>>>>>>>> # cat /proc/interrupts
>>>>>>>>>>>>>>            CPU0       CPU1
>>>>>>>>>>>>>>   0:         41          0   IO-APIC-edge      timer
>>>>>>>>>>>>>>   4:         39          0   IO-APIC-edge      serial
>>>>>>>>>>>>>>   9:          0          0   IO-APIC-fasteoi   acpi
>>>>>>>>>>>>>>  14:          0          0   IO-APIC-edge      ata_piix
>>>>>>>>>>>>>>  15:          0          0   IO-APIC-edge      ata_piix
>>>>>>>>>>>>>>  16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5
>>>>>>>>>>>>>>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
>>>>>>>>>>>>>>  19:          0          0   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb3
>>>>>>>>>>>>>>  23:       6598          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
>>>>>>>>>>>>>>  43:       2704          0   PCI-MSI-edge      eth0
>>>>>>>>>>>>>>  44:        249          0   PCI-MSI-edge      snd_hda_intel
>>>>>>>>>>>>>> NMI:          0          0   Non-maskable interrupts
>>>>>>>>>>>>>> LOC:        661        644   Local timer interrupts
>>>>>>>>>>>>>> SPU:          0          0   Spurious interrupts
>>>>>>>>>>>>>> PMI:          0          0   Performance monitoring interrupts
>>>>>>>>>>>>>> IWI:          0          0   IRQ work interrupts
>>>>>>>>>>>>>> RTR:          0          0   APIC ICR read retries
>>>>>>>>>>>>>> RES:       1582       2225   Rescheduling interrupts
>>>>>>>>>>>>>> CAL:         26         48   Function call interrupts
>>>>>>>>>>>>>> TLB:         10         19   TLB shootdowns
>>>>>>>>>>>>>> ERR:          0
>>>>>>>>>>>>>> MIS:          0
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I do not think peripherals integrated to chipsets can really be
>>>>>>>>>>>>>> considered "legacy". And they tend to be used in the field...
>>>>>>>>>>>>>
>>>>>>>>>>>>> The good news is that, even on your low-end atom, you can avoid those
>>>>>>>>>>>>> latencies by CPU assignment, i.e. isolating the Linux IRQ load on one
>>>>>>>>>>>>> core and the RT on the other. That's getting easier and easier due to
>>>>>>>>>>>>> the inflation of cores.
>>>>>>>>>>>>
>>>>>>>>>>>> What if you want to use RTUSB for instance?
>>>>>>>>>>>
>>>>>>>>>>> Then I will likely not worry about a few micros of additional latency
>>>>>>>>>>> due to IO-APIC accesses.
>>>>>>>>>>
>>>>>>>>>> On my atom, taking an IO-APIC fasteoi interrupt, acking and masking it,
>>>>>>>>>> takes 10us in UP, and 20us in SMP (with the tracer on).
>>>>>>>>>
>>>>>>>>> ...and on more appropriate chipsets? I bet the Atom is (once again) off
>>>>>>>>> here.
>>>>>>>>
>>>>>>>> I do not know, do you care for sharing your traces with us? I only run
>>>>>>>> Xenomai on atom (which I am not sure do not qualify as "modern", new
>>>>>>>> atoms seem to be produced), geode (ok, this one is definitely dead, but
>>>>>>>> there seem to be people still running xenomai on them), and an old
>>>>>>>> pentium III with an old VIA686 chipset, where masking the IO-APIC is
>>>>>>>> even slower than acking the i8259.
>>>>>>>>
>>>>>>>> Anyway, the IO-APIC registers accesses does not look designed for speed:
>>>>>>>> it has an indirect scheme that seem more designed to save space in the
>>>>>>>> processor mapping and to be configured once and for all when
>>>>>>>> enabling/disabling interrupt, not at each and every interrupt.
>>>>>>>>
>>>>>>>> The point is: people may want to use Xenomai on atoms. We do not really
>>>>>>>> know on what kind of x86 people run xenomai, knowing that would help us
>>>>>>>> directing our efforts.
>>>>>>>
>>>>>>> We are currently investigating whether we can use Atom's for our
>>>>>>> future products. We have to stick to the x86 architecture and our
>>>>>>> products should work without big cooling fans. Currently running tests
>>>>>>> on Atom D2700 (which I know is EOL, but for research purposes should
>>>>>>> give us a good indication).
>>>>>>>
>>>>>>> A 20us latency gain is a lot and would be very welcome in our system!
>>>>>>
>>>>>>
>>>>>> If you enable CONFIG_MSI, do you still see some IO-APIC-fasteoi in
>>>>>> /proc/interrupts?
>>>>>>
>>>>>
>>>>> The kernel config has no CONFIG_MSI, but instead:
>>>>> CONFIG_ARCH_SUPPORTS_MSI=y
>>>>> CONFIG_PCI_MSI=y
>>>>>
>>>>> There is still IO-APIC-fasteoi in /proc/interrupts:
>>>>>
>>>>> # cat /proc/interrupts
>>>>>            CPU0       CPU1
>>>>>   0:        250          0   IO-APIC-edge      timer
>>>>>   4:         71          0   IO-APIC-edge      serial
>>>>>   7:         29          0   IO-APIC-edge
>>>>>   8:          0          0   IO-APIC-edge      rtc0
>>>>>   9:          0          0   IO-APIC-fasteoi   acpi
>>>>>  16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5
>>>>>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4
>>>>>  19:         41          0   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb3
>>>>>  23:       5440          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2
>>>>>  40:        940          0   PCI-MSI-edge      eth0
>>>>>  41:         21          0   PCI-MSI-edge      xhci_hcd
>>>>>  42:          0          0   PCI-MSI-edge      xhci_hcd
>>>>>  43:          0          0   PCI-MSI-edge      xhci_hcd
>>>>> NMI:          0          0   Non-maskable interrupts
>>>>> LOC:      29559      25129   Local timer interrupts
>>>>> SPU:          0          0   Spurious interrupts
>>>>> PMI:          0          0   Performance monitoring interrupts
>>>>> IWI:          0          0   IRQ work interrupts
>>>>> RTR:          0          0   APIC ICR read retries
>>>>> RES:         20          0   Rescheduling interrupts
>>>>> CAL:          0          8   Function call interrupts
>>>>> TLB:          9          5   TLB shootdowns
>>>>> ERR:         74
>>>>> MIS:          0
>>>>
>>>> Unless you are short on CPU resources: isolcpus=1. At least bind all
>>>> Linux IRQs to one CPU. That's independent of any potential low-level
>>>> optimizations.
>>>
>>> The advantage of the masking at LAPIC using elevated priority I propose
>>> is that for most APICs, the IO-APIC will forward the interrupts to the
>>> cpus not currently running with elevated priority (that is what the
>>> dest_LowestPrio constant means). Dynamically.
>>
>> And the advantage of isolcpus is that it avoids any kind of disturbances
>> due to dynamics, thus provides the best latency.
> 
> And the worst scalability.

There is no free lunch.

> But I agree on machines where the cache is
> not shared between cores (which I believe is not the case of atom), the
> fact to not send the irq to the same core every time is detrimental to
> no real-time performances.
> 
>>
>> Also, I'm not sure how what efforts will be required to handle cases
>> Linux or some RT driver decides to keep an IRQ masked for a longer
>> period. That would block everything below that level and is surely not
>> what we want.
> 
> It is only the masking done by the I-pipe (aka
> desc->ipipe_ack/desc->ipipe_end) which use this method. The real masking
> is still done by masking at IO-APIC level.

Then you need to prevent the (mis-)use of XN_ISR_NOENABLE.

And when is the end executed for Linux IRQs? Do you want to migrate from
TPR-based based masking to standard IO-APIC masking when switching to
the Linux domain? But that will not avoid the IO-APIC access latency,
just reshuffle it.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SDP-DE
Corporate Competence Center Embedded Linux

