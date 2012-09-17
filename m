Message-ID: <5056DA52.6040006@xenomai.org>
Date: Mon, 17 Sep 2012 10:07:46 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <5056C385.6090403@xenomai.org> <5056D4AE.2010201@web.de>
In-Reply-To: <5056D4AE.2010201@web.de>
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
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <Xenomai@xenomai.org>

On 09/17/2012 09:43 AM, Jan Kiszka wrote:
> On 2012-09-17 08:30, Gilles Chanteperdrix wrote:
>>
>> Hi,
>>
>> looking at x86 latencies, I found that what was taking long on my atom
>> was masking the fasteoi interrupts at IO-APIC level. So, I experimented
>> an idea: masking at LAPIC level instead of IO-APIC, by using the "task
>> priority" register. This seems to improve latencies on my atom:
>>
>> http://sisyphus.hd.free.fr/~gilles/core-3.4-latencies/atom.png
>>
>> This implies splitting the LAPIC vectors in a high priority and low
>> priority sets, the final implementation would use ipipe_enable_irqdesc
>> to detect a high priority domain, and change the vector at that time.
>>
>> This also improves the latencies on my old PIII with a VIA chipset, but
>> it generates spurious interrupts (I do not know if it really is a
>> matter, as handling a spurious interrupt is still faster than masking an
>> IO-APIC interrupt), the spurious interrupts in that case are a
>> documented behaviour of the LAPIC.
>>
>> Is there any interest in pursuing this idea, or are x86 with slow
>> IO-APIC the exception more than the rule, or having to split the vector
>> space appears too great a restriction?
> 
> Line-based interrupts are legacy, of decreasing relevance for PCI
> devices - likely what we are primarily interesting in here - due to MSI.

Even if I enable MSI, the kernel still uses these irqs for the 
peripherals integrated to the chipset, such as the USB HCI, or ATA 
driver (IOW, non PCI devices). 

atom login: root                                                                  
# cat /proc/interrupts                                                            
           CPU0       CPU1                                                        
  0:         41          0   IO-APIC-edge      timer                              
  4:         39          0   IO-APIC-edge      serial                             
  9:          0          0   IO-APIC-fasteoi   acpi                               
 14:          0          0   IO-APIC-edge      ata_piix                           
 15:          0          0   IO-APIC-edge      ata_piix                           
 16:          0          0   IO-APIC-fasteoi   uhci_hcd:usb5                      
 18:          0          0   IO-APIC-fasteoi   uhci_hcd:usb4                      
 19:          0          0   IO-APIC-fasteoi   ata_piix, uhci_hcd:usb3            
 23:       6598          0   IO-APIC-fasteoi   ehci_hcd:usb1, uhci_hcd:usb2       
 43:       2704          0   PCI-MSI-edge      eth0                               
 44:        249          0   PCI-MSI-edge      snd_hda_intel                      
NMI:          0          0   Non-maskable interrupts                              
LOC:        661        644   Local timer interrupts                               
SPU:          0          0   Spurious interrupts                                  
PMI:          0          0   Performance monitoring interrupts                    
IWI:          0          0   IRQ work interrupts                                  
RTR:          0          0   APIC ICR read retries                                
RES:       1582       2225   Rescheduling interrupts                              
CAL:         26         48   Function call interrupts                             
TLB:         10         19   TLB shootdowns                                       
ERR:          0                                                                   
MIS:          0                                                                   

I do not think peripherals integrated to chipsets can really be
considered "legacy". And they tend to be used in the field...

> So I tend to say "don't worry", specifically as fiddling with vector
> allocations will require yet another round of invasive changes to the
> IRQ subsystem of Linux.

The changes would be minimally invasive, we would reuse the functions
already existing (clear_irq_vector and assign_irq_vector).

-- 
					    Gilles.

