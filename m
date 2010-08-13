Message-ID: <4C65583D.3030800@domain.hid>
Date: Fri, 13 Aug 2010 16:35:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1281709057.650414331@domain.hid>
In-Reply-To: <1281709057.650414331@domain.hid>
Content-Type: text/plain; charset=UTF-8
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

This is bad news. It could come either from the fact that the Xorg
driver shuts hardware interrupts off (there is nothing xenomai can do
about that), or it could be an SMI issue. What about using the driver
for the real graphic card you have ? Probably intel card? Do you observe
any big latencies if you stress the system with anything else than X?

> Power management options (ACPUI, APM): Disable ACPI (Advanced
> Configuration and Power Interface) Support --> Processor Disable CPU
> Frequency Scaling Disable CPU idle PM support Disable Power Managment
> Support

Disabling ACPI is a bad idea. As repeated many times, only
ACPI_PROCESSOR should be disabled, not ACPI.

> 
> Real-time sub-system: Enable Machine--> SMI workaround Enable
> Machine--> globally disable SMI

Do you have a message in the kernel boot logs telling you that the SMI
workaround actually worked?

> 
> I have read through this:
> http://svn.gna.org/svn/xenomai/trunk/TROUBLESHOOTING and tried to
> find anything relevant. I am booting from an on board compact flash
> via USB. I wondered if this could be the problem. Output of hdparm:

Well, this is not the latest version of the TROUBLESHOOTING guide. The
latest version is in Xenomai sources, or accessible through our website.
Though I am not sure much things have changed.


> IDE Controller settings "HDC configure as" Options: "IDE", "RAID",
> "AHCI"

Do not select IDE here, it probably uses SMIs

> 
> USB Configuration "USB Legacy" Enable/Disable "EHCI1" Enable/Disable 
> "EHCI2"            " "UHCI1"            " "UHCI2" ... "UHCI5" 
> "Per-Port Control2" Enable/Disable "USB Pre-fetch Feature"
> Enable/Disable "USB Pre-fetch Time" 2ms/4ms "USB HC Alignment"
> Enable/Disable

Do not select USB legacy, it probably uses SMI.

> 
> Chipset Configuration "CRID/SRID" Enable/Disable "Port 80h Cycles"
> LPC bus/PCI bus "DMI Link ASPM Control" Enable/Disable "Automatic
> ASMO" Auto/Manual "ASPM L0s Support" Enable/Disable "ASPM L0sL1
> Support" Enable/Disable "VT-d" Enable/Disable
> 
> ACPI Table/Feature Control "FACP - C2 Latency Value" Enable/Disable 
> "FACP - C3 Latency Value" Enable/Disable "FACP - RTC S4 Wakeup"
> Enable/Disable "APIC - IO APIC Mode" Enable/Disable "HPET - HPET
> Support" Enable/Disable

You probably want the APIC and IO APIC.

> So, could anyone suggest what I might try to improve the system?
> Sorry for the torrent of information... I thought it better to give
> as much info as I could think of than to not provide enough to make a
> diagnosis!

test whether you have issues without the X server,
if yes, check whether the SMI workaround actually works,
if no, test with another X server (the one specific to your graphic
card, presumably the intel one).

-- 
					    Gilles.

