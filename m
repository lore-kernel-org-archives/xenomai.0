Message-ID: <5056F4A1.6070500@xenomai.org>
Date: Mon, 17 Sep 2012 12:00:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org> <5056D4AE.2010201@web.de>
	<5056DA52.6040006@xenomai.org> <5056DCC5.10909@web.de>
	<5056E024.5020904@xenomai.org> <5056E863.4090606@siemens.com>
	<5056ED68.6050101@xenomai.org> <5056F09C.8050602@siemens.com>
In-Reply-To: <5056F09C.8050602@siemens.com>
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
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Xenomai <Xenomai@xenomai.org>

On 09/17/2012 11:42 AM, Jan Kiszka wrote:
> On 2012-09-17 11:29, Gilles Chanteperdrix wrote:
>> On 09/17/2012 11:07 AM, Jan Kiszka wrote:
>>> On 2012-09-17 10:32, Gilles Chanteperdrix wrote:
>>>> On 09/17/2012 10:18 AM, Jan Kiszka wrote:
>>>>> On 2012-09-17 10:07, Gilles Chanteperdrix wrote:
>>>>>> On 09/17/2012 09:43 AM, Jan Kiszka wrote:
>>>>>>> On 2012-09-17 08:30, Gilles Chanteperdrix wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> looking at x86 latencies, I found that what was taking long on my atom
>>>>>>>> was masking the fasteoi interrupts at IO-APIC level. So, I experimented
>>>>>>>> an idea: masking at LAPIC level instead of IO-APIC, by using the "task
>>>>>>>> priority" register. This seems to improve latencies on my atom:
>>>>>>>>
>>>>>>>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
>>>>>>>>
>>>>>>>> This implies splitting the LAPIC vectors in a high priority and low
>>>>>>>> priority sets, the final implementation would use ipipe_enable_irqdesc
>>>>>>>> to detect a high priority domain, and change the vector at that time.
>>>>>>>>
>>>>>>>> This also improves the latencies on my old PIII with a VIA chipset, but
>>>>>>>> it generates spurious interrupts (I do not know if it really is a
>>>>>>>> matter, as handling a spurious interrupt is still faster than masking an
>>>>>>>> IO-APIC interrupt), the spurious interrupts in that case are a
>>>>>>>> documented behaviour of the LAPIC.
>>>>>>>>
>>>>>>>> Is there any interest in pursuing this idea, or are x86 with slow
>>>>>>>> IO-APIC the exception more than the rule, or having to split the vector
>>>>>>>> space appears too great a restriction?
>>>>>>>
>>>>>>> Line-based interrupts are legacy, of decreasing relevance for PCI
>>>>>>> devices - likely what we are primarily interesting in here - due to MSI.
>>>>>>
>>>>>> Even if I enable MSI, the kernel still uses these irqs for the 
>>>>>> peripherals integrated to the chipset, such as the USB HCI, or ATA 
>>>>>> driver (IOW, non PCI devices). 
>>>>>
>>>>> Those are all PCI as well. And modern chipsets include variants of them
>>>>> with MSI(-X) support.
>>>>>
>>>>>>
>>>>>> atom login: root                                                                  
>>>>>> # cat /proc/interrupts                                                            
>>>>>>            CPU0       CPU1                                                        
>>>>>>   0:         41          0   IO-APIC-edge      timer                              
>>>>>>   4:         39          0   IO-APIC-edge      serial                             
>>>>>>   9:          0          0   IO-APIC-fasteoi   acpi                               
>>>>>>  14:          0          0   IO-APIC-edge      ata_piix                           
>>>>>>  15:          0          0   IO-APIC-edge      ata_piix                           
>>>>>>  16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5                      
>>>>>>  18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4                      
>>>>>>  19:          0          0   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb3            
>>>>>>  23:       6598          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2       
>>>>>>  43:       2704          0   PCI-MSI-edge      eth0                               
>>>>>>  44:        249          0   PCI-MSI-edge      snd_hda_intel                      
>>>>>> NMI:          0          0   Non-maskable interrupts                              
>>>>>> LOC:        661        644   Local timer interrupts                               
>>>>>> SPU:          0          0   Spurious interrupts                                  
>>>>>> PMI:          0          0   Performance monitoring interrupts                    
>>>>>> IWI:          0          0   IRQ work interrupts                                  
>>>>>> RTR:          0          0   APIC ICR read retries                                
>>>>>> RES:       1582       2225   Rescheduling interrupts                              
>>>>>> CAL:         26         48   Function call interrupts                             
>>>>>> TLB:         10         19   TLB shootdowns                                       
>>>>>> ERR:          0                                                                   
>>>>>> MIS:          0                                                                   
>>>>>>
>>>>>> I do not think peripherals integrated to chipsets can really be
>>>>>> considered "legacy". And they tend to be used in the field...
>>>>>
>>>>> The good news is that, even on your low-end atom, you can avoid those
>>>>> latencies by CPU assignment, i.e. isolating the Linux IRQ load on one
>>>>> core and the RT on the other. That's getting easier and easier due to
>>>>> the inflation of cores.
>>>>
>>>> What if you want to use RTUSB for instance?
>>>
>>> Then I will likely not worry about a few micros of additional latency
>>> due to IO-APIC accesses.
>>
>> On my atom, taking an IO-APIC fasteoi interrupt, acking and masking it,
>> takes 10us in UP, and 20us in SMP (with the tracer on).
> 
> ...and on more appropriate chipsets? I bet the Atom is (once again) off
> here.

I do not know, do you care for sharing your traces with us? I only run
Xenomai on atom (which I am not sure do not qualify as "modern", new
atoms seem to be produced), geode (ok, this one is definitely dead, but
there seem to be people still running xenomai on them), and an old
pentium III with an old VIA686 chipset, where masking the IO-APIC is
even slower than acking the i8259.

Anyway, the IO-APIC registers accesses does not look designed for speed:
it has an indirect scheme that seem more designed to save space in the
processor mapping and to be configured once and for all when
enabling/disabling interrupt, not at each and every interrupt.

The point is: people may want to use Xenomai on atoms. We do not really
know on what kind of x86 people run xenomai, knowing that would help us
directing our efforts.

-- 
					    Gilles.

