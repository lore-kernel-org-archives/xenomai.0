Message-ID: <4926E5C6.8030502@domain.hid>
Date: Fri, 21 Nov 2008 17:45:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <A820268933E41D449CC13B5E097C1E2F0363CE11@domain.hid>
In-Reply-To: <A820268933E41D449CC13B5E097C1E2F0363CE11@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] External PCIe device: MSI interrupt install
	hangs up the CPU
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Rubio, Martial" <Martial.Rubio@domain.hid>
Cc: jeanfrancois.gilot@domain.hid, xenomai@xenomai.org, "Dupeyrou,
	Gilles" <Gilles.Dupeyrou@domain.hid>

Rubio, Martial wrote:
> Hello everybody
>  
> I'm working with following config : 
>  
> CPU (0=>3) AMD Dual Core AMD Opteron 
> Linux version 2.6.25-pae

2.6.25 comes with the risk of missing relevant fixes that went into .26
and later. Do you have a chance to update? 2.6.27 is a bit fresh,
2.6.26.7 + ipipe-2.0-16 would be a conservative approach right now.

> Xenomai : hal / i386
> Xenomai : real time nucleus v2.4.5
>  
> Here's below the state of /proc/interrupts :
>  
> in red fonts the range of PCIe(xpress)-MSI vectors :

Uuh, please don't expect the reader to have HTML rendering on for a
typically text-only medium like mail. Yeah, it tends to be the other way
around inside companies, I know...

>  
> hurle-bise [anaisvs](34):more /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:        146          0          0          0    XT-PIC-XT
> timer
>   1:       1039          0          0          0    XT-PIC-XT
> i8042
>   2:          0          0          0          0    XT-PIC-XT
> cascade
>   4:          5          0          0          0    XT-PIC-XT
>   5:          2          0          0          0    XT-PIC-XT
> ehci_hcd:usb2
>   6:          5          0          0          0    XT-PIC-XT
> floppy
>   7:      16300          0          0          0    XT-PIC-XT
> ohci_hcd:usb1
>  10:     155104          0          0          0    XT-PIC-XT
> ioc0, sata_nv, sata_nv, ohci1394
>  11:      47305          0          0          0    XT-PIC-XT
> sata_nv, HDA Intel
>  14:          0          0          0          0    XT-PIC-XT
> pata_amd
>  15:          0          0          0          0    XT-PIC-XT
> pata_amd
> 212:          0          9        487    1942504   PCI-MSI-edge
> eth0
> 213:          0          0          0          0   PCI-MSI-edge
> shpchp
> NMI:          0          0          0          0   Non-maskable
> interrupts
> LOC:    3722798    3722767    3722730    3722768   Local timer
> interrupts
> RES:      39386      37672      23570      25780   Rescheduling
> interrupts
> CAL:       1112       1273       1280        250   function call
> interrupts
> TLB:       6144       8510       6271       9025   TLB shootdowns
> TRM:          0          0          0          0   Thermal event
> interrupts
> SPU:          0          0          0          0   Spurious interrupts
> ERR:          1
> MIS:          0
>  
> I try to install a new MSI interrupt via rtdm package (rtdm_irq_request)
> with
> a vector number (211) given by the call to pci_msi_enable for the new
> PCIe device.

Is that driver prepared to possibly receive an immediate IRQ after
registration? Of course, that can only happen if the device's hardware
is not explicitly configured to disable IRQ delivery. I'm asking as it
is a common mistake to mixup IRQ arming and proper driver state
initialization.

>  
> The system hangs up immediatly (sometimes I can catch the stack trace
> with dmesg
> the last reference seems to be in rt_hal package)

You should try to capture a full trace via a serial console e.g., see
linux/Documentation/serial-console.txt.

>  
> If I replace (for debug only!!!) this vector number by an unused
> "classical" vector number (for instance
> 14 or 15) ... no problem.
>  
> Have you allready test this kind of configuration ... if so a little
> help from your part would be
> greatly appreciated!

Another test around MSI: try to disable CONFIG_PCI_MSI and check if
something changes.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2 ES-OS
Corporate Competence Center Embedded Linux

