From: ken barnett <kbb@domain.hid>
Date: Thu, 16 Oct 2008 13:40:11 +0000 (UTC)
Message-ID: <loom.20081016T133219-64@domain.hid>
References: <loom.20081016T124807-588@domain.hid>
	<48F73A6D.7000607@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@domain.hid>
Subject: [Xenomai-help] Unhandled irq 9
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Gilles Chanteperdrix <gilles.chanteperdrix <at> xenomai.org> writes:

> 
> ken barnett wrote:
> > Hope you can help.
> > 
> > My configuration is as follows:
> > PXA25xx ADS card w/ NO PCI bridge
> > Linux-2.6.24.5 kernel
> > Xenomai 2.4.5 stable
> > 
> > The Xenomai port to the kernel is as follows:
> > 
> > ./prepare-kernel.sh linux=../../linux-2.6.24.5
> > --adeos=adeos-ipipe-2.6.24-arm-1.9-00.patch
> > --adeos=adeos-ipipe-2.6.24-arm-1.9-01.patch --arch=arm
> > 
> > ./xenomai-2.4.5/scripts/prepare-kernel.sh --linux=linux-2.6.24.5
> > --adeos=./xenomai-2.4.5/ksrc/arch/arm/patches/
> > adeos-ipipe-2.6.24-arm-1.9-01.patch
> > 
> > I used 2 patches  but have tried to use either/or with the 
> > same indications.
> > 
> > configure CC=arm-linux-gcc --enable-arm-eabi
> > --prefix=/home/dvdb-lite/rootfs/usr/xenomai --host=arm-linux 
> > --enable-arm-arch=pxa
> > 
> > See attached for the output log1.
> > 
> > Step 1:
> > Looking at post from July 05, 2008 - 12:26: it states 
to turn on full debug to
> > get the best output so that output file is attached 
also as debug3.log
> > 
> > Step 2
> > Then it stated to turn off Xenomai all together:
> > The log looks the same but is also attached as debug2.log
> > 
> > Step 3
> > Turn off ipipe altogether
> > The kernel/card is back to working.
> > 
> > Hop you can help,
> 
> I am afraid you forgot attachments, or url to them.
> 
Oops: There is nowhere to attach a file so I will add them inline

log1

Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
pxa2xx_udc: version 30-June-2007
udc: disconnect from host
udc: is connected
ether gadget: using random self ethernet address
ether gadget: using random host ethernet address
usb0: Ethernet Gadget, version: May Day 2005
usb0: using pxa2xx_udc, OUT ep2out-bulk IN ep1in-bulk
usb0: MAC 06:6d:0a:58:17:f1
udc: connect to host
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
mice: PS/2 mouse device common for all mice
input: ADSmartIO AT keyboard as /class/input/input0
input: ADS784x touch screen as /class/input/input1
ts: ADS784x touchscreen initialized
i2c /dev entries driver
i2c-adapter i2c-0: registered adapter pxa2xx-i2c.0
rtc-ds1307 0-0068: ds1307 rtc found
rtc-ds1307 0-0068: rtc core: registered ds1307 as rtc0
rtc-ds1307 0-0068: 56 bytes nvram
ltc1663 0-0020: ltc1663 dac found
SA1100/PXA2xx Watchdog Timer: timer margin 60 sec
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
pxamci: MMC/SD slot initialized
Unable to set MCI power
Unable to set MCI power
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 
(Tue Nov 20 19:16:42
2007 UTC).
usbcore: registered new interface driver snd-usb-audio
nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@domain.hid>
XScale DSP coprocessor detected.
AC'97 0 access error (not audio or modem codec)
pxa2xx-ac97: probe of pxa2xx-ac97 failed with error -13
cpufreq: pxa255 cpu frequency driver initialized
cpufreq: changing pxa255 frequency to 398 Mhz, (SDRAM 196 Mhz)
mmc0: new SD card at address 0001
mmcblk0: mmc0:0001 SD2GB 2025984KiB 
 mmcblk0:
hda: SanDisk SDCFBI-256, CFA DISK drive
ide0 at 0xcaa80000-0xcaa80007,0xcaa8000e on irq 205
hda: max request size: 128KiB
hda: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32
 hda:irq 9, desc: c0431354, depth: 0, count: 0, unhandled: 0
irq 9, desc: c0431354, depth: 0, count: 0, unhandled: 0
irq 9, desc: c0431354, depth: 0, count: 0, unhandled: 0
irq 9, desc: c0431354, depth: 0, count: 0, unhandled: 0


>From here it just continues!


debug2.log

Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
pxa2xx_udc: version 30-June-2007
udc: disconnect from host
udc: is connected
ether gadget: using random self ethernet address
ether gadget: using random host ethernet address
usb0: Ethernet Gadget, version: May Day 2005
usb0: using pxa2xx_udc, OUT ep2out-bulk IN ep1in-bulk
usb0: MAC 36:0a:b7:83:e8:4d
udc: connect to host
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
mice: PS/2 mouse device common for all mice
input: ADSmartIO AT keyboard as /class/input/input0
input: ADS784x touch screen as /class/input/input1
ts: ADS784x touchscreen initialized
i2c /dev entries driver
i2c-adapter i2c-0: registered adapter pxa2xx-i2c.0
rtc-ds1307 0-0068: ds1307 rtc found
rtc-ds1307 0-0068: rtc core: registered ds1307 as rtc0
rtc-ds1307 0-0068: 56 bytes nvram
ltc1663 0-0020: ltc1663 dac found
SA1100/PXA2xx Watchdog Timer: timer margin 60 sec
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
pxamci: MMC/SD slot initialized
Unable to set MCI power
Unable to set MCI power
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 
(Tue Nov 20 19:16:42
2007 UTC).
usbcore: registered new interface driver snd-usb-audio
nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@domain.hid>
XScale DSP coprocessor detected.
AC'97 0 access error (not audio or modem codec)
pxa2xx-ac97: probe of pxa2xx-ac97 failed with error -13
cpufreq: pxa255 cpu frequency driver initialized
cpufreq: changing pxa255 frequency to 398 Mhz, (SDRAM 196 Mhz)
mmc0: new SD card at address 0001
mmcblk0: mmc0:0001 SD2GB 2025984KiB 
 mmcblk0:
hda: SanDisk SDCFBI-256, CFA DISK drive
ide0 at 0xcaa80000-0xcaa80007,0xcaa8000e on irq 205
hda: max request size: 128KiB
hda: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32
 hda:irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0
irq 9, desc: c03ff2d4, depth: 0, count: 0, unhandled: 0


debug3.log
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
pxa2xx_udc: version 30-June-2007
udc: disconnect from host
udc: is connected
ether gadget: using random self ethernet address
ether gadget: using random host ethernet address
usb0: Ethernet Gadget, version: May Day 2005
usb0: using pxa2xx_udc, OUT ep2out-bulk IN ep1in-bulk
usb0: MAC 26:cb:79:29:ff:48
udc: connect to host
pccard: PCMCIA card inserted into slot 0
pcmcia: registering new device pcmcia0.0
mice: PS/2 mouse device common for all mice
input: ADSmartIO AT keyboard as /class/input/input0
input: ADS784x touch screen as /class/input/input1
ts: ADS784x touchscreen initialized
i2c /dev entries driver
i2c-adapter i2c-0: registered adapter pxa2xx-i2c.0
rtc-ds1307 0-0068: ds1307 rtc found
rtc-ds1307 0-0068: rtc core: registered ds1307 as rtc0
rtc-ds1307 0-0068: 56 bytes nvram
ltc1663 0-0020: ltc1663 dac found
SA1100/PXA2xx Watchdog Timer: timer margin 60 sec
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
pxamci: MMC/SD slot initialized
Unable to set MCI power
Unable to set MCI power
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Advanced Linux Sound Architecture Driver Version 1.0.15 
(Tue Nov 20 19:16:42
2007 UTC).
usbcore: registered new interface driver snd-usb-audio
nf_conntrack version 0.5.0 (1024 buckets, 4096 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: BNEP (Ethernet Emulation) ver 1.2
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@domain.hid>
XScale DSP coprocessor detected.
mmc0: new SD card at address 0001
mmcblk0: mmc0:0001 SD2GB 2025984KiB 
 mmcblk0:<3>AC'97 0 access error (not audio or modem codec)
pxa2xx-ac97: probe of pxa2xx-ac97 failed with error -13
cpufreq: pxa255 cpu frequency driver initialized

cpufreq: changing pxa255 frequency to 398 Mhz, (SDRAM 196 Mhz)
hda: SanDisk SDCFBI-256, CFA DISK drive
ide0 at 0xcaa80000-0xcaa80007,0xcaa8000e on irq 205
hda: max request size: 128KiB
hda: 501760 sectors (256 MB) w/1KiB Cache, CHS=980/16/32
 hda:irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
__ipipe_ack_bad_irq: unknown flow handler for IRQ 9
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0
->handle_irq():  c003f020, ->chip(): c044f770, ->action(): 00000000
   IRQ_NOPROBE set
 IRQ_NOREQUEST set
irq 9, desc: c0455354, depth: 0, count: 0, unhandled: 0



