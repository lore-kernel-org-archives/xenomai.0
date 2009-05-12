Message-ID: <4A0949E7.2050309@domain.hid>
Date: Tue, 12 May 2009 12:05:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF4972A89C.E992E0BC-ONC12575B4.002430E6-C12575B4.0029BFB6@domain.hid>
In-Reply-To: <OF4972A89C.E992E0BC-ONC12575B4.002430E6-C12575B4.0029BFB6@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

henning.richter@domain.hid wrote:
> 
> It really is the first bug.
> 
> [ 2510.572237] BUG: unable to handle kernel paging request at b807a7fc
> [ 2510.576044] IP: [<c01070c6>] profile_pc+0x46/0x50
> [ 2510.576044] Oops: 0000 [#1] SMP
> [ 2510.576044] Modules linked in: nls_iso8859_1 nls_cp437 vfat fat e100
> rt_eepro100 rtpacket rtnet af_packet i915 drm bridge stp bnep rfcomm sco
> l2cap bluetooth ppdev ipv6 iptable_filter ip_tables x_tables parport_pc lp
> parport sr_mod cdrom serio_raw evdev psmouse com20020_pci com20020 arcnet
> iTCO_wdt iTCO_vendor_support shpchp intel_agp pci_hotplug agpgart ext3 jbd
> mbcache sd_mod crc_t10dif sg usb_storage libusual ata_piix ata_generic
> libata mii uhci_hcd ehci_hcd scsi_mod dock usbcore fuse [last unloaded:
> e100]
> 
> 
> here the corresponding disassembly:
> 
> c0107080 <profile_pc>:
> c0107080:      55                      push   %ebp
> c0107081:      89 e5                   mov    %esp,%ebp
> c0107083:      83 ec 08                sub    $0x8,%esp
> c0107086:      89 1c 24                mov    %ebx,(%esp)
> c0107089:      89 74 24 04             mov    %esi,0x4(%esp)

Ok. So profile_pc reserves some room on the stack for mcount arguments...

> c010708d:      e8 da 24 01 00          call   c011956c <mcount>
> c0107092:      f6 40 36 02             testb  $0x2,0x36(%eax)
> c0107096:      8b 70 2c                mov    0x2c(%eax),%esi
> c0107099:      89 c3                   mov    %eax,%ebx
> c010709b:      75 0d                   jne    c01070aa <profile_pc+0x2a>
> c010709d:      8b 40 30                mov    0x30(%eax),%eax
> c01070a0:      25 fc 00 00 00          and    $0xfc,%eax
> c01070a5:      83 f8 60                cmp    $0x60,%eax
> c01070a8:      74 0e                   je     c01070b8 <profile_pc+0x38>
> c01070aa:      89 f0                   mov    %esi,%eax
> c01070ac:      8b 1c 24                mov    (%esp),%ebx
> c01070af:      8b 74 24 04             mov    0x4(%esp),%esi

And then tries to access the same room on the stack believing that the
frame pointer or pc is stored there. Game over.

Modify profile_pc function declaration to add the "notrace" qualifier.

This bug is a red herring, this is a simple effect of enabling the tracing.

However, it would be nice if you could recompile the kernel without the
following configuration options:
CONFIG_PROFILING
CONFIG_MARKERS
CONFIG_OPROFILE
CONFIG_KPROBES
CONFIG_KRETPROBES


-- 
                                                 Gilles.

