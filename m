Message-ID: <425A8687.3010200@domain.hid>
Date: Mon, 11 Apr 2005 16:15:35 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200504011643.38582.lbocseg@domain.hid> <200504061337.16492.lbocseg@domain.hid> <Pine.LNX.4.53.0504070825020.17256@domain.hid> <200504081512.16320.lbocseg@domain.hid> <4257C2C3.7030906@domain.hid> <Pine.LNX.4.53.0504111247180.7909@domain.hid>
In-Reply-To: <Pine.LNX.4.53.0504111247180.7909@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] Re: adeos-linux-2.6.11-i386-r10c2.patch [Some progress]
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Rus V. Brushkoff" <rus@domain.hid>
Cc: rtai@domain.hid, adeos-main@gna.org

Rus V. Brushkoff wrote:
> 	Hi.
> [...]
> 
> :o APIC, no IO-APIC, Adeos built into the kernel, ACPI disabled
> 
>  Well with ACPI totally disabled Adeos-10rc2 works on my intel m/b ! I
> have working all peripheria connected to ICH chipset. X11 over nvidia kernel
> driver is works too. Now it is doesn't matter if adeos compiled as module
> or not.

Ok, it's official now, we are close to the twilight zone: r10c2 boots 
and works ok here with ACPI enabled on a P4+ICH5+e100:

DMI 2.3 present.
ACPI: RSDP (v000 DELL                                  ) @ 0x000feb90
ACPI: RSDT (v001 DELL    170L    0x00000007 ASL  0x00000061) @ 0x000fd1ea
ACPI: FADT (v001 DELL    170L    0x00000007 ASL  0x00000061) @ 0x000fd21e
ACPI: SSDT (v001   DELL    st_ex 0x00001000 MSFT 0x0100000d) @ 0xfffd19c9
ACPI: MADT (v001 DELL    170L    0x00000007 ASL  0x00000061) @ 0x000fd292
ACPI: BOOT (v001 DELL    170L    0x00000007 ASL  0x00000061) @ 0x000fd2fe
ACPI: DSDT (v001   DELL    dt_ex 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x01] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 1ff00000 (gap: 1ff00000:ded00000)
Built 1 zonelists
Kernel command line: ro root=/dev/hda2 console=tty0 
console=ttyS0,115200n8 nmi_w
atchdog=2
__iounmap: bad address c00fffd9
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
Adeos 2.6r10c2/x86: Root domain Linux registered.
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 2793.640 MHz processor.

> :
> 
> 		Rus
> 
> _______________________________________________
> RTAI mailing list
> RTAI@rtai.org
> https://mail.rtai.org/cgi-bin/mailman/listinfo/rtai


-- 

Philippe.

