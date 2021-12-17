MIME-Version: 1.0
References: <20211216074829.32236-1-ksmola51@gmail.com>
 <e5126b04-5f04-57bc-8450-e519e251b9a6@siemens.com>
 <CAC2JQehOUsbGFmnfuLxukomvN-vjPLqo9nPk3ws1_7e10yOEZw@mail.gmail.com>
 <4a09e1bb-ab4d-4ff7-77bf-8ffff6b23cbb@siemens.com>
In-Reply-To: <4a09e1bb-ab4d-4ff7-77bf-8ffff6b23cbb@siemens.com>
From: k smo <ksmola51@gmail.com>
Date: Thu, 16 Dec 2021 23:08:46 -0800
Message-ID: <CAC2JQeiAbgYO_XPrh2UFCMLsim4yXd=F1kwR0+h4Ha2bFhmSpQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added verbosity to serial driver.
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

It seems helpful for debugging purposes to know what version of the driver
is loaded, at least. I'll remove the author and make the first line less
verbose. I took a look at my booted kernel and many drivers/subsystems
announce they are loading, often Xenomai drivers! :
[    0.112115] SELinux:  Initializing.
[    0.301270] vgaarb: loaded
[    0.301464] SCSI subsystem initialized
[    0.301612] libata version 3.00 loaded.
[    0.304940] NetLabel: Initializing
[    1.611426] I-pipe: head domain Xenomai registered.
[    1.612696] [Xenomai] Cobalt v3.1 [DEBUG]
[    1.743396] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 243)
[    1.750026] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.971201] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.997552] uhci_hcd: USB Universal Host Controller Interface driver
[    2.011696] device-mapper: ioctl: 4.39.0-ioctl (2018-04-03) initialised:
dm-devel@redhat.com
[    2.012270] hidraw: raw HID events driver (C) Jiri Kosina
[    2.012554] usbhid: USB HID core driver
[    4.288742] systemd[1]: Started Hardware RNG Entropy Gatherer Daemon.
[    4.343025] fuse init (API version 7.27)
[    4.880889] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.987217] igb: Intel(R) Gigabit Ethernet Network Driver - version
5.4.0-k
[    8.125205] RTnet: initialising real-time networking
[    8.139234] RT-Socket-CAN 0.90.2 - (C) 2006 RT-Socket-CAN Development
Team
[    8.187524] rt_igb: Intel(R) Gigabit Ethernet Network Driver - version
5.2.18-k
[    8.193912] rt_e1000e: Copyright(c) 1999 - 2011 Intel Corporation.
[    8.314125] ppdev: user-space parallel port driver
[   17.009338] tun: Universal TUN/TAP device driver, 1.6

-Konstantin


On Thu, Dec 16, 2021 at 10:08 AM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> On 16.12.21 18:40, k smo wrote:
> > I will re-submit patch with a better explanation.  But look at this
> > dmesg output:
> >
> > [55025.834492] xeno_16550A: RTDM-based driver for 16550A UARTs rev
> > 1.5.2, Jan Kiszka <jan.kiszka@web.de <mailto:jan.kiszka@web.de>>
> > [55025.834568] xeno_16550A: rtser0 io=0x3f8 irq=4
> > [55025.834614] xeno_16550A: rtser1 io=0x2f8 irq=3
> > [55025.834646] xeno_16550A: rtser2 io=0xd000 irq=18
> > [55025.834680] xeno_16550A: rtser3 io=0xd008 irq=18
> > [55025.835322] xeno_16550A: rtser4 io=0xd010 irq=18
> > [55025.836801] xeno_16550A: rtser5 io=0xd018 irq=18
> > later...
> > [55044.800713] xeno_16550A: Unloaded.
> >
> > In our systems the serial driver is loaded by shell scripts and config
> > files which make decisions as to what to load. so without verbosity the
> > driver prints nothing and it is not easy to determine (in terms of
> > timing relative to other drivers as seen in dmesg) if the driver ever
> > got loaded or what ports it is listening to. This is highly informative
> > verbosity.
> >
>
> Ok, that makes sense and is similar to what the kernel tty drivers do. I
> don't think it needs the very first line, though.
>
> Jan
>
> --
> Siemens AG, T RDA IOT
> Corporate Competence Center Embedded Linux
>
