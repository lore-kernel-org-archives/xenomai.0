MIME-Version: 1.0
References: <CAHk=vNFHsSE5iaJd30tSxEDiNBD+w2hmuhnY7CD7Rz6EyjqtJg@mail.gmail.com>
 <87a6ldy49p.fsf@xenomai.org>
 <CAJte2PAC49ZBgvW_GtzBh_S77F-ehzJxZbrt8UQN-=A7OsunCA@mail.gmail.com>
In-Reply-To: <CAJte2PAC49ZBgvW_GtzBh_S77F-ehzJxZbrt8UQN-=A7OsunCA@mail.gmail.com>
From: Hans Petersen <hpetersenlg@googlemail.com>
Date: Fri, 20 Aug 2021 10:11:26 +0200
Message-ID: <CAHk=vNGKMrpfKyZOd7rYbC55bCP4Bz_jU2r1x4gMUhEyXeFZMg@mail.gmail.com>
Subject: Re: xenomai-4 on raspberry-pi-4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Byron Jacquot <bjacquot@cardinalpeak.com>
Cc: Philippe Gerum <rpm@xenomai.org>, xenomai@xenomai.org

Hi Philipe, Byron,

thanks for answers.

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------

Philippe:

I chose Raspbian because it promised me the greatest dissemination and
support from the community.

In general, I have integrated a CM4 module into my own hardware, so I
rely on the integration of the CM4 and the IO board on the newer
versions.
But first I will test the Raspi-4b.

Do you have an alternative to the Raspbian OS? Don't they have the
same problems?

Next week I'll try to research the differences between the Raspbian
and Evl-kernels.

I'll keep you updated.

Thanks again for your extensive support, Hans

---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------

Byron:

I tried this too. Unfortunately I didn't succeed.
However, I have a Raspi-4b with a touch display.

I cross compile on a debian-10 in the VMWare virtual machine.

I am following the tutorial, i.e.

- git clone, bcm2711_defconfig, make .... (zImage, modules, dtbs, install)
- copy kernel (zImage), dtb-files, overlay-folder to '/ boot' on sd-card.
- copy kernel modules to '/ lib / modules' ext4 file system on sd-card.
- add kernel =3D zImage to 'config.txt' on sd-card.

The problem is that in the evl-source tree (same as mainline) several
things are not available at first glance:

- in arch/arm/configs /; there is no bcm2711_defconfig
- in arch/arm/dts /; there are no dts files for rpi-4 and rpi-cm4
- in arch/arm/dts /; there is no overlay directory and no entries in
the make files for this overlay directory
- in driver/char; the broadcom directory does not exist

The make does not create an overlay directory. So I copied the device
tree files and the overlay directory from the Raspbian-OS into the
/boot directory.

When booting, there are various error messages and the system then hangs up=
.
If I delete the kernel directory in /lib/modules, the kernel boots,
but since no modules can be loaded of course no USB, no network, etc.
will run.

However, I had similar problems with newer versions of the Raspbian OS.
So my idea was to take the working version 5.10.52 from the Raspian
and then install a 5.10.57 kernel with modules, since this is close to
the version.

This boots the system and works including GUI and touch.
But there are still some error messages when booting.

There are probably problems with the interrupt installation in the SPI
device and access to the EEProm and a few others.
I suspect that something is wrong with the device drivers.

Here are a few excerpts from the reports without wanting to annoy you
with details:

[    1.196254] ------------[ cut here ]------------
[    1.196260] WARNING: CPU: 0 PID: 1 at kernel/irq/chip.c:1149
__irq_do_set_handler+0x98/0x204
[    1.196264] Modules linked in:
[    1.196273] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.57-v7l #3
[    1.196277] Hardware name: BCM2711
[    1.196281] IRQ stage: Linux

[  OK  ] Started Forward Password R=E2=80=A6s to Plymouth Directory Watch.
[    8.877325] 8<--- cut here ---
[    8.877332] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    8.877336] pgd =3D (ptrval)
[    8.877341] [00000004] *pgd=3D034cd003, *pmd=3D00000000
[    8.877354] Internal error: Oops: 206 [#1] SMP ARM
[    8.877358] Modules linked in: dwc2(+) vc4(+) raspberrypi_hwmon
roles i2c_bcm2835 cec drm_kms_helper spi_bcm2835 drm
drm_panel_orientat
   ion_quirks snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd
syscopyarea sysfillrect sysimgblt fb_sys_fops backlight
uio_pdrv_genirq ui
   o i2c_dev ip_tables x_tables ipv6
[    8.877462] CPU: 3 PID: 156 Comm: systemd-udevd Tainted: G        W
        5.10.57-v7l #3
[    8.877466] Hardware name: BCM2711

[[    9.937210] usb usb3: Manufacturer: Linux 5.10.57-v7l dwc2_hsotg
  OK      9.937226] usb usb3: SerialNumber: fe980000.usb
0m] Foun[    9.949213] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt failed with error
                                                                -2
d device[    9.989897] hub 3-0:1.0: USB hub found
 /dev/serial1.
[   10.002053] hub 3-0:1.0: 1 port detected
[  OK  ] Found device /dev/ttyS0.
[   10.212135] ------------[ cut here ]------------
[   10.219217] WARNING: CPU: 3 PID: 275 at drivers/spi/spidev.c:945
spidev_probe+0x108/0x1c4 [spidev]
[   10.233106] /soc/spi@7e204000/spidev@0: buggy DT: spidev listed
directly in DT
[   10.243764] Modules linked in: spidev(+) joydev brcmfmac brcmutil
sha256_generic cfg80211 rfkill raspberrypi_ts dwc2 vc4(+) raspberrypi
 _hwmon roles i2c_bcm2835 cec drm_kms_helper spi_bcm2835 drm
drm_panel_orientation_quirks snd_soc_core snd_pcm_dmaengine snd_pcm
snd_timer
 snd syscopyarea sysfillrect sysimgblt fb_sys_fops backlight
uio_pdrv_genirq uio i2c_dev ip_tables x_tables ipv6
[   10.252627] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[   10.288515] CPU: 3 PID: 275 Comm: modprobe Tainted: G      D W
   5.10.57-v7l #3
[   10.310376] Hardware name: BCM2711
[   10.316082] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6
wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d
                                                                  2e
[   10.316308] IRQ stage: Linux

[   10.805600] WARNING: CPU: 3 PID: 275 at drivers/spi/spidev.c:945
spidev_probe+0x108/0x1c4 [spidev]
[   10.805637] /soc/spi@7e204000/spidev@1: buggy DT: spidev listed
directly in DT
[   10.830198] Modules linked in: spidev(+) joydev brcmfmac brcmutil
sha256_generic cfg80211 rfkill raspberrypi_ts dwc2 vc4(+) raspberrypi
 _hwmon roles i2c_bcm2835 cec drm_kms_helper spi_bcm2835 drm
drm_panel_orientation_quirks snd_soc_core snd_pcm_dmaengine snd_pcm
snd_timer
snd syscopyarea sysfillrect sysimgblt fb_sys_fops backlight
uio_pdrv_genirq uio i2c_dev ip_tables x_tables ipv6
[   10.876236] CPU: 3 PID: 275 Comm: modprobe Tainted: G      D W
   5.10.57-v7l #3
[   10.886966] Hardware name: BCM2711

[FAILED] Failed to start Check for Raspberry Pi EEPROM updates.
See 'systemctl status rpi-eeprom-update.service' for details.

Thanks for your advice, Hans




Am Do., 19. Aug. 2021 um 19:54 Uhr schrieb Byron Jacquot <
bjacquot@cardinalpeak.com>:

> Hello Hans, Philippe,
>
> I can confirm that I'm successfully running Xenomai 4 on the Pi 4.
>
> I started with a plain Raspbian Lite on an SD card.  On target, I cloned
> the 5.12-evl-rebase branch, built (~6 hours) and installed it.  I
> copied the kernel and DTBs to my Boot partition, amended boot/config.txt,
> and it runs nicely.
>
> -Byron Jacquot
>
> On Thu, Aug 19, 2021 at 7:04 AM Philippe Gerum via Xenomai <
> xenomai@xenomai.org> wrote:
>
>>
>> Hans Petersen via Xenomai <xenomai@xenomai.org> writes:
>>
>> > Hi, everyone,
>> >
>> > I'm trying to get XENOMAI-4 to run on the Raspberry-PI-4.
>> >
>> > For this I downloaded the source files '*v5.10.y-evl-rebase*' and
>> compiled
>> > them with 'bcm2711_defconfig'.
>> >
>> > Unfortunately, the image does not work because many specific files,
>> such as
>> > the device tree and the broadcom drivers and serveral config-flags, ar=
e
>> > missing in the source tree.
>> > However, these are also missing in the mainline kernel.
>> >
>>
>> Xenomai targets mainline kernels exclusively.
>>
>> > I can load a kernel version *'5.10.52*' from the *Raspbian repository*=
.
>> >
>> > *Now my question*:
>> >
>> > Is there a possibility to patch XENOMAI4 into the Raspbian sources, or
>> any
>> > other way to install a Xenomai-4 on the Raspberry-PI-4?
>> >
>>
>> Unlike its predecessors, Xenomai 4 does not use the patch model, it is
>> directly developed into the target kernel.
>>
>> FWIW, I have been running EVL based on the mainline kernel on the rpi4
>> for more than a year now (headless system though), and this is actually
>> one of my workhorses for testing it. If you really need to run a vendor
>> kernel, then you are pretty much on your own unfortunately; you might
>> try to apply the 5.10.y..5.10.y-evl-rebase diff set to a Raspbian kernel
>> based on the same mainline version.
>>
>> --
>> Philippe.
>>
>>
