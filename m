From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1281709057.650414331@domain.hid>
References: <1281709057.650414331@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 13 Aug 2010 16:40:38 +0200
Message-ID: <1281710438.1730.114.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Very high latencies under stress testing
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: edward.robbins@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2010-08-13 at 15:17 +0100,
edward.robbins@domain.hid wrote:
> Hello all,
> 
> I have just set up my first xenomai system, and though I believe I
> have followed most of the guidelines, if I run latency it sits at
> around 8uS max, until I run something to stress the system (e.g.
> startx, or killing the x server) when it jumps to 700-800uS.
> 
> I wonder if this is to do with graphics? I have set "NoAccel" in the
> driver section of Xorg.conf (I am using fbdev). I also notice that
> latencies go massive (e.g. 4200uS) the first time I run glxgears.
> "glxinfo" reports "Direct rendering: no".

Yes, this is likely related to some kernel resource(s) involved in
graphics, at least, this is a usual suspect - the fact that it happens
only(?) upon X server state transitions does not point the finger at SMI
issues, which are the other sources of high latencies on x86.

Typically, we had some issues over time with MTRR handling, inducing
either massive jitter or even crashes on x86. Normally, the Adeos patch
would fix those issues as they are discovered, but it may well happen
that some bugs are still hiding.

Since your box does not bluntly crash, could you try running the I-pipe
tracer, to get a snapshot of the latest kernel activity before the max
latency is reached?

This howto explains how to set it up:
http://www.xenomai.org/index.php/I-pipe:Tracer

In case of doubt about the way to get those traces, just ask.

> 
> This is a core 2 duo system (MEN F19P cPCI) with ICH9M-SFF chipset. I
> am running debian (lenny) and have followed the guide in the wiki
> (here: http://www.xenomai.org/index.php/Building_Debian_packages) to
> install kernel 2.6.32.15 and xenomai 2.5.4. I have made the following
> selections for kernel configuration in order to try and prevent
> latency issues:
> 
> Processor type and features:
>          Enable interrupt pipeline
>          Enable high resolution timer support
>          Disable dell laptop support
>          Processor family --> Core 2/Newer Xeon
>          Preemption model --> Preemptible kernel (low latency desktop)
> 
> Bus options (PCI etc):
>          Disable PCI express hotplug driver
>          Disable message signalled interrupts (MSI and MSI-X)
>          Disable PCCard (PCMCIA/Cardbus support)
>          Disable support for PCI hotplug
> 
> Device drivers:
>          Disable Memory Technology Device (MTD) support
>          Disable Fusion MPT device support
>          Disable I20 device support
>          Disable ISDN support
> 
> Power management options (ACPUI, APM):
>          Disable ACPI (Advanced Configuration and Power Interface)
> Support --> Processor
>          Disable CPU Frequency Scaling
>          Disable CPU idle PM support
>          Disable Power Managment Support
> 
> Real-time sub-system:
>          Enable Machine--> SMI workaround 
>          Enable Machine--> globally disable SMI
> 
> I have read through this:
> http://svn.gna.org/svn/xenomai/trunk/TROUBLESHOOTING and tried to find
> anything relevant. I am booting from an on board compact flash via
> USB. I wondered if this could be the problem. Output of hdparm:
> 
> hdparm -v /dev/sda
> 
> readonly = 0 (off)
> readahead = 256 (on)
> geometry = 1024/255/63, sectors = 31227840, start = 0
> 
> hdparm -acdgkmur /dev/sda
> 
> HDIO_GET_MULTICOUNT failed: Invalid argument
> HDIO_GET_32BIT failed: Invalid argument
> HDIO_GET_UNMASKINTR failed: Invalid argument
> HDIO_GET_DMA failed: Invaid argument
> HDIO_GET_KEEPSETTINGS failed: Invalid argument
> (reast of output same as hdparm -v)
> 
> hdparm -t /dev/sda
> 
> /dev/sda:
> Timing buffered disk reads: 100MB in 3.01 seconds = 33.24 MB/sec
> 
> hdparm -T /dev/sda
> 
> /dev/sda:
> Timing cached reads: 11006 MB in 2.00 seconds = 5503.00 MB/sec
> 
> Then I did cat /proc/scsi/scsi:
> Host: scsi4 Channel: 00 Id: 00 Lun: 00
>   Vendor: Generic  Model: Flash HS-CF        Rev: 1.68
>   Type:     Direct-Access                              ANSI   SCSI
> revision: 00
> 
> Also, this embedded system has a lot of configuration options in the
> BIOS (more than I have seen on any other system). Some seem like they
> could be very useful but are currently unusable (e.g. if I set "SMI
> handler" to off, the system will no longer boot from compact flash).
> There are also other options that might be relevant. I have tried
> playing with them, but am not even sure what some are and the manual
> is quite cryptic:
> 
> IDE Controller settings
>          "HDC configure as" Options: "IDE", "RAID", "AHCI"
> 
> USB Configuration
>          "USB Legacy" Enable/Disable
>          "EHCI1" Enable/Disable
>          "EHCI2"            "
>          "UHCI1"            "
>          "UHCI2"
>          ...
>          "UHCI5"
>          "Per-Port Control2" Enable/Disable
>          "USB Pre-fetch Feature" Enable/Disable
>          "USB Pre-fetch Time" 2ms/4ms
>          "USB HC Alignment" Enable/Disable
> 
> Chipset Configuration
>          "CRID/SRID" Enable/Disable
>          "Port 80h Cycles" LPC bus/PCI bus
>          "DMI Link ASPM Control" Enable/Disable
>          "Automatic ASMO" Auto/Manual
>          "ASPM L0s Support" Enable/Disable
>          "ASPM L0sL1 Support" Enable/Disable
>          "VT-d" Enable/Disable
> 
> ACPI Table/Feature Control
>          "FACP - C2 Latency Value" Enable/Disable
>          "FACP - C3 Latency Value" Enable/Disable
>          "FACP - RTC S4 Wakeup" Enable/Disable
>          "APIC - IO APIC Mode" Enable/Disable
>          "HPET - HPET Support" Enable/Disable
>          
> PCI Express Root Port 1/2/3/4/5/6 Settings
>          "ASPM" Enable/Disable
>          "Automatic ASPM" Auto/Manual
>          "ASPM L0s" Root&Endpoint Ports/ Disabled/ Root Port Only/
> Endpoint port Only
>          "ASPM L1" Enable/Disable
>          "URR" Enable/Disable
>          "FER" Enable/Disable
>          "NFER" Enable/Disable
>          "CER" Enable/Disable
>          "CTO" Enable/Disable
>          "SEFE" Enable/Disable
>          "SENFE" Enable/Disable
>          "SECE" Enable/Disable
>          "PME Interrupt" Enable/Disable
>          "PME SCI" Enable/Disable
>          "Hot Plug SCI" Enable/Disable
> 
> Advanced CPU Control
>          "P-States" Enable/Disable
>          "CMP Support" Enable/Disable
>          "Vanderpool Technology" Enable/Disable
>          "SMRR Support" Auto/Disable
>          "C-States" Enable/Disable
>          "Enhanced C-States" Enable/Disable
>          "C-State Pop Up Mode" Enable/Disable
>          "C-State Pop Down Mode" Enable/Disable
>          "C4 Exit Timing Mode" Fast/Slow/Default/Force Slow
>          "DeepC4" Enable/Disable
>          "Hard C4E" Enable/Disable
>          "Enable C6" Enable/Disable
>          "EMTTM" Enable/Disable
>          "Bi-directional PROCHOT#" Enable/Disable
>          "ACPI 3.0 T-States" Enable/Disable
>          "DTS" Enable/Disable"
>          ... (lots more options that I am not sure what they really
> are for!)
> 
> Platfoirm Power Management
>          "Storage Break Event" Enable/Disable
>          "PCIE Break Event" Enable/Disable
>          "PCI Break Event" Enable/Disable
>          "EHCI Break Event" Enable/Disable
>          "UHCI Break Event" Enable/Disable
>          "HDA Break Event" Enable/Disable
>          "ACPI S3" Enable/Disable
> 
> So, could anyone suggest what I might try to improve the system? Sorry
> for the torrent of information... I thought it better to give as much
> info as I could think of than to not provide enough to make a
> diagnosis!
> 
> Thanks,
> 
> Edward Robbins
> 
> Control Systems Engineer
> Oxford Technologies Ltd
> UKAEA Culham
> Joint European Torus, Remote Handling Division
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help

-- 
Philippe.



