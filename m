Message-ID: <51237586.6030201@arcor.de>
Date: Tue, 19 Feb 2013 13:52:22 +0100
From: Christopher Hahn <hahnchristopher@arcor.de>
MIME-Version: 1.0
References: <224444793.158669.1360843957336.JavaMail.ngmail@webmail16.arcor-online.net>	<511CD5C2.50701@arcor.de>	<511CD673.2030400@xenomai.org>
	<511CDF65.1020907@arcor.de>	<511D3A22.40307@xenomai.org>
	<511DF30B.6040601@arcor.de> <511E26AE.1010203@xenomai.org>
	<511E3A5C.4000209@arcor.de>
In-Reply-To: <511E3A5C.4000209@arcor.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] kernel configuration problems with ACPI
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Am 15.02.2013 14:38, schrieb Christopher Hahn:
> Am 15.02.2013 13:14, schrieb Gilles Chanteperdrix:
>> On 02/15/2013 09:34 AM, Christopher Hahn wrote:
>>
>>> after running the application which accesses the serial device
>>> "Xenomai: xnintr_edge_shirq_handler: IRQ4 not handled. Disabling IRQ
>>> line." was printed to dmesg and the next two outputs of
>>> /proc/interrupts and /proc/xenomai/irq
>>
>> If xnintr_edge_shirq_handler is called, an RTDM driver registered a
>> handler for this irq. So, please keep the application running with all
>> the file descriptors opened, and run cat /proc/xenomai/irq while the
>> application is still running.
>>
>> The most logical result would be that irq 4 is claimed by the 16550A 
>> driver.
>>
>>
> while accessing one serial port I get this
> -------------- next part --------------
> # cat /proc/interrupts           CPU0       CPU1       CPU2 CPU3       
>  0:        120          0          0          0 IO-APIC-edge      timer
>  1:          2          1          0          0 IO-APIC-edge      i8042
>  4:          3          2          2          3   IO-APIC-fasteoi 
>  7:          0          0          0          0 IO-APIC-fasteoi   
> parport0
>  8:          0          0          1          0 IO-APIC-edge      rtc0
>  9:          0          0          0          0 IO-APIC-fasteoi   acpi
> 16:         82         57         68         77 IO-APIC-fasteoi   i915
> 18:          0          0          0          0 IO-APIC-fasteoi   
> uhci_hcd:usb3
> 19:          9         10          9          9 IO-APIC-fasteoi   
> uhci_hcd:usb2
> 20:        307        330        311        331 IO-APIC-fasteoi   eth0
> 22:       3663       3657       3664       3649 IO-APIC-fasteoi   
> ahci, snd_hda_intel
> 23:        158        167        166        159 IO-APIC-fasteoi   
> uhci_hcd:usb1
> NMI:          0          0          0          0   Non-maskable 
> interrupts
> LOC:      29253      30056      31887      29552   Local timer interrupts
> SPU:          0          0          0          0   Spurious interrupts
> PMI:          0          0          0          0   Performance 
> monitoring interrupts
> IWI:          0          0          0          0   IRQ work interrupts
> RTR:          0          0          0          0   APIC ICR read retries
> RES:      44295      49569      39033      35105   Rescheduling 
> interrupts
> CAL:       1197       1346       2564       2107   Function call 
> interrupts
> TLB:        422        730        896        626   TLB shootdowns
> TRM:          0          0          0          0   Thermal event 
> interrupts
> THR:          0          0          0          0   Threshold APIC 
> interrupts
> MCE:          0          0          0          0   Machine check 
> exceptions
> MCP:          1          1          1          1   Machine check polls
> ERR:          0
> MIS:          0
>
> # cat /proc/xenomai/irq IRQ         CPU0        CPU1 CPU2        CPU3
>  4:         252         252         252         251         rtser0
> 19:         251         250         253         246 SJA1000 SJA1000
> 2336:       29837       30730       31906       30007 [timer]
> 2337:           0           1           2           1 [reschedule]
> 2338:           0           1           1           1 [timer-ipi]
> 2339:           0           0           0           0 [sync]
> 2371:           3           0           0           0 [virtual]
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai

Do you have any idea how to solve the problem?
Even if the system receives interrupts at IRQ 4, the program doesn't 
receive any message from the serial port with this kernel configuration.

Thank you,

Christopher

