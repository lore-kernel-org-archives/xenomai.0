From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17444.15257.481188.985854@domain.hid>
Date: Fri, 24 Mar 2006 19:34:01 +0100
Subject: Re: [Xenomai-help] Crashing at boot with 2.6.15.4
In-Reply-To: <4424264F.7090401@domain.hid>
References: <440DA975.50002@domain.hid> <440DAC21.9030801@domain.hid>
	<44241F36.40201@domain.hid> <4424264F.7090401@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Jan Kiszka wrote:
 > Sean McGranaghan wrote:
 > > FYI,
 > > 
 > > Just following up on my crash issue from a couple weeks ago. It appears that 
 > > disabling the local APIC in the kernel fixed my crash. I have a complete dump of 
 > > the console messages before the crash and two kernel config files attached. The 
 > > only difference in the config files is the APIC settings.
 > > 
 > > My test system is an older PII 350MHz with 512M. The vanilla kernel boots fine 
 > > with APIC support enabled, but when the Xenomai patches are applied I get the crash.
 > > 
 > > Also, this may be in the release notes but I wanted to mention it anyway. I 
 > > noticed that the valid return values for an RTDM interrupt handler have changed 
 > > between Xenomai 2.0 and 2.1. I have a driver I wrote in 2.0.92 that fails to 
 > > compile under 2.1. It looks like the valid return code have changed as follows:
 > > 
 > > Xenomai 2.0.92
 > > RTDM_IRQ_PROPAGATE
 > > RTDM_IRQ_ENABLE
 > > 
 > > Xenomai 2.1
 > > RTDM_IRQ_NONE
 > > RTDM_IRQ_HANDLED
 > > 
 > > When an interrupt handler now returns RTDM_IRQ_HANDLED I assume it will be 
 > > re-enabled, is this true?
 > 
 > That's true, and it should be described, see RTDM API docs and
 > ksrc/skins/rtdm/API.CHANGES. The upgrade is straightforward:
 > 
 > old			-> new
 > 
 > 0			-> RTDM_IRQ_NONE
 > RTDM_IRQ_ENABLE		-> RTDM_IRQ_HANDLED
 > RTDM_IRQ_PROPAGATE	-> -unsupported-
 > 
 > > Linux version 2.6.15.6-ipipe (smm@domain.hid) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #3 Thu Mar 23 11:45:02 EST 2006
 > > BIOS-provided physical RAM map:
 > >  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 > >  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 > >  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 > >  BIOS-e820: 0000000000100000 - 000000001fffd000 (usable)
 > >  BIOS-e820: 000000001fffd000 - 000000001ffff000 (ACPI data)
 > >  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 > >  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 > > 0MB HIGHMEM available.
 > > 511MB LOWMEM available.
 > > DMI 2.0 present.
 > > Allocating PCI resources starting at 30000000 (gap: 20000000:dfff0000)
 > > Built 1 zonelists
 > > Kernel command line: ro root=LABEL=/ console=ttyS0,115200n8
 > > Local APIC disabled by BIOS -- you can enable it with "lapic"
 > 
 > You may either follow this suggestion or actually leave local APIC off
 > at compile time.
 > 
 > > Initializing CPU#0
 > > CPU 0 irqstacks, hard=c0414000 soft=c0413000
 > > PID hash table entries: 2048 (order: 11, 32768 bytes)
 > > Detected 350.905 MHz processor.
 > > Using tsc for high-res timesource
 > > I-pipe 1.2-01: pipeline enabled.
 > > Console: colour VGA+ 80x25
 > > Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 > > Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
 > > Memory: 514088k/524276k available (2222k kernel code, 9656k reserved, 730k data, 168k init, 0k highmem)
 > > Checking if this processor honours the WP bit even in supervisor mode... Ok.
 > > Calibrating delay using timer specific routine.. 702.33 BogoMIPS (lpj=351169)
 > > Security Framework v1.0.0 initialized
 > > SELinux:  Initializing.
 > > SELinux:  Starting in permissive mode
 > > selinux_register_security:  Registering secondary module capability
 > > Capability LSM initialized as secondary
 > > Mount-cache hash table entries: 512
 > > CPU: L1 I cache: 16K, L1 D cache: 16K
 > > CPU: L2 cache: 512K
 > > Intel machine check architecture supported.
 > > Intel machine check reporting enabled on CPU#0.
 > > mtrr: v2.0 (20020519)
 > > CPU: Intel Pentium II (Deschutes) stepping 02
 > > Enabling fast FPU save and restore... done.
 > > Checking 'hlt' instruction... OK.
 > > checking if image is initramfs... it is
 > > Freeing initrd memory: 1070k freed
 > > NET: Registered protocol family 16
 > > PCI: PCI BIOS revision 2.10 entry at 0xf0720, last bus=1
 > > PCI: Using configuration type 1
 > > Linux Plug and Play Support v0.97 (c) Adam Belay
 > > SCSI subsystem initialized
 > > usbcore: registered new driver usbfs
 > > usbcore: registered new driver hub
 > > PCI: Probing PCI hardware
 > > PCI quirk: region e400-e43f claimed by PIIX4 ACPI
 > > PCI quirk: region e800-e80f claimed by PIIX4 SMB
 > > PIIX4 devres B PIO at 0290-0297
 > > PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:04.0
 > > PCI: IRQ 0 for device 0000:00:04.2 doesn't match PIRQ mask - try pci=usepirqmask
 > > PCI: Bridge: 0000:00:01.0
 > >   IO window: disabled.
 > >   MEM window: e0000000-e1dfffff
 > >   PREFETCH window: e1f00000-e3ffffff
 > > audit: initializing netlink socket (disabled)
 > > audit(1143117255.879:1): initialized
 > > Xenomai: Local APIC absent or disabled!
 > >          Disable APIC support or pass "lapic=1" as bootparam.
 > > Xenomai: system init failed, code -19.
 > 
 > This is normal, given the lacking "lapic=1".
 > 
 > > divide error: 0000 [#1]
 > > Modules linked in:
 > > CPU:    0
 > > EIP:    0060:[<c014243a>]    Not tainted VLI
 > > EFLAGS: 00010246   (2.6.15.6-ipipe)
 > > EIP is at xntimer_get_jiffies_aperiodic+0x5a/0xf0
 > 
 > This is not ok, but should be easy to fix.

I am able to reproduce that bug, trying to fix...

-- 


					    Gilles Chanteperdrix.

