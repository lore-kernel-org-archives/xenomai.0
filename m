MIME-Version: 1.0
In-Reply-To: <CALZu-7amePV01sp_x6ao_06ZFuADycuj8TU4MOLUuxfCviaC1A@mail.gmail.com>
References: <CALZu-7bww3OBzRcu67gP4yWeJ0GRfGR5Mm6_sDWen2V5Aryp8Q@mail.gmail.com>
 <20160701113422.GF17647@hermes.click-hack.org>
 <CALZu-7amePV01sp_x6ao_06ZFuADycuj8TU4MOLUuxfCviaC1A@mail.gmail.com>
From: marc favereau <favereau.marc.m2gl@gmail.com>
Date: Fri, 1 Jul 2016 14:30:49 +0200
Message-ID: <CALZu-7YnBgp58AWcxgdcZ7aaH7DVEz8JOJCOEm+_EWdJF5jJfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Pb with 4 serial ports Moxa card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

I just try to unbinding driver and thats give me :

[root@BedyCalculo1 favereau]# lspci -v | grep -a5 -i moxa
    I/O ports at 6000 [size=3D256]
    Memory at e8000000 (32-bit, non-prefetchable) [size=3D64]
    Memory at e0000000 (32-bit, non-prefetchable) [size=3D128M]
    Capabilities: [78] Power Management version 3

0c:0e.0 Serial controller: Moxa Technologies Co Ltd CP134U (4-Port
RS-422/485 Universal PCI) (prog-if 02 [16550])
    Subsystem: Moxa Technologies Co Ltd CP134U (4-Port RS-422/485 Universal
PCI)
    Flags: medium devsel, IRQ 19
    I/O ports at 6140 [size=3D32]
    I/O ports at 6100 [size=3D64]
    I/O ports at 6160 [size=3D16]
    Kernel driver in use: mxser








[root@BedyCalculo1 favereau]# dmesg | grep -i -a5 0c:0e.0
[    0.622980] pci 0000:0c:0c.0: [114a:5565] type 00 class 0x028000
[    0.623014] pci 0000:0c:0c.0: reg 10: [mem 0xe8001000-0xe80011ff]
[    0.623033] pci 0000:0c:0c.0: reg 14: [io  0x6000-0x60ff]
[    0.623052] pci 0000:0c:0c.0: reg 18: [mem 0xe8000000-0xe800003f]
[    0.623071] pci 0000:0c:0c.0: reg 1c: [mem 0xe0000000-0xe7ffffff]
[    0.623200] pci 0000:0c:0e.0: [1393:1340] type 00 class 0x070002
[    0.623242] pci 0000:0c:0e.0: reg 14: [io  0x6140-0x615f]
[    0.623260] pci 0000:0c:0e.0: reg 18: [io  0x6100-0x613f]
[    0.623278] pci 0000:0c:0e.0: reg 1c: [io  0x6160-0x616f]
[    0.623388] pci 0000:0b:00.0: PCI bridge to [bus 0c]
[    0.623394] pci 0000:0b:00.0:   bridge window [io  0x6000-0x6fff]
[    0.623400] pci 0000:0b:00.0:   bridge window [mem 0xe0000000-0xe80fffff=
]
[    0.623548] pci 0000:0b:00.2: PCI bridge to [bus 0d]
[    0.623707] pci 0000:0e:00.0: [8086:1521] type 00 class 0x020000
--
[    1.002405] pcieport 0000:06:03.0: Signaling PME through PCIe PME
interrupt
[    1.002407] pcieport 0000:06:04.0: Signaling PME through PCIe PME
interrupt
[    1.002408] pcieport 0000:06:05.0: Signaling PME through PCIe PME
interrupt
[    1.002410] pci 0000:0b:00.0: Signaling PME through PCIe PME interrupt
[    1.002412] pci 0000:0c:0c.0: Signaling PME through PCIe PME interrupt
[    1.002414] pci 0000:0c:0e.0: Signaling PME through PCIe PME interrupt
[    1.002416] pci 0000:0b:00.2: Signaling PME through PCIe PME interrupt
[    1.002420] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    1.002436] pcieport 0000:00:1c.4: Signaling PME through PCIe PME
interrupt
[    1.002438] pci 0000:0e:00.0: Signaling PME through PCIe PME interrupt
[    1.002440] pci 0000:0e:00.1: Signaling PME through PCIe PME interrupt
--
[   10.136206] usb 2-1.3: Endpoint 1 MaxPacketSize 64
[   10.136208] usb 2-1.3: Endpoint 2 MaxPacketSize 64
[   10.136210] usb 2-1.3: Setting MaxPacketSize 64
[   10.136601] usb 2-1.3: FTDI USB Serial Device converter now attached to
ttyUSB0
[   10.137807] MOXA Smartio/Industio family driver version 2.0.5
[   10.137921] mxser 0000:0c:0e.0: found MOXA CP-134U series board
(BusNo=3D12, DevNo=3D14)
[   10.137992] mxser: max. baud rate =3D 921600 bps
[   10.151178] iTCO_vendor_support: vendor-support=3D0
[   10.155508] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   10.155548] iTCO_wdt: Found a Patsburg TCO device (Version=3D2,
TCOBASE=3D0x0460)
[   10.155736] iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)



[root@BedyCalculo1 favereau]# tree /sys/bus/pci/drivers/mxser/
/sys/bus/pci/drivers/mxser/
=E2=94=9C=E2=94=80=E2=94=80 0000:0c:0e.0 ->
../../../../devices/pci0000:00/0000:00:1c.0/0000:05:00.0/0000:06:05.0/0000:=
0b:00.0/0000:0c:0e.0
=E2=94=9C=E2=94=80=E2=94=80 bind
=E2=94=9C=E2=94=80=E2=94=80 module -> ../../../../module/mxser
=E2=94=9C=E2=94=80=E2=94=80 new_id
=E2=94=9C=E2=94=80=E2=94=80 remove_id
=E2=94=9C=E2=94=80=E2=94=80 uevent
=E2=94=94=E2=94=80=E2=94=80 unbind


[root@BedyCalculo1 favereau]# echo -n "0000:0c:0e.0" >
/sys/bus/pci/drivers/mxser/unbind
[root@BedyCalculo1 favereau]#
[root@BedyCalculo1 favereau]#
[root@BedyCalculo1 favereau]# tree /sys/bus/pci/drivers/mxser/
/sys/bus/pci/drivers/mxser/
=E2=94=9C=E2=94=80=E2=94=80 bind
=E2=94=9C=E2=94=80=E2=94=80 module -> ../../../../module/mxser
=E2=94=9C=E2=94=80=E2=94=80 new_id
=E2=94=9C=E2=94=80=E2=94=80 remove_id
=E2=94=9C=E2=94=80=E2=94=80 uevent
=E2=94=94=E2=94=80=E2=94=80 unbind


[root@BedyCalculo1 favereau]# modprobe xeno_16550A io=3D6100,6108,6110,6118
irq=3D19,19,19,19 baud_base=3D921600,921600,921600,921600
modprobe: ERROR: could not insert 'xeno_16550A': Device or resource busy


I don't understand why the driver is on /sys/bus/pci/drivers and not on
/sys/bus/pci_express/drivers  ???



After i'm doing :

[root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
total 0
dr-xr-xr-x. 2 root root 0  1 juil. 14:26 drvIT400_xeno
-r--r--r--. 1 root root 0  1 juil. 14:26 fildes
-r--r--r--. 1 root root 0  1 juil. 14:26 named_devices
-rw-r--r--. 1 root root 0  1 juil. 14:26 open_fildes
-r--r--r--. 1 root root 0  1 juil. 14:26 protocol_devices
dr-xr-xr-x. 2 root root 0  1 juil. 14:26 rtipc
dr-xr-xr-x. 2 root root 0  1 juil. 14:26 rttest-switchtest0
dr-xr-xr-x. 2 root root 0  1 juil. 14:26 rttest-timerbench0



[root@BedyCalculo1 favereau]# modprobe xeno_16550A io=3D6100 irq=3D19
baud_base=3D921600
[root@BedyCalculo1 favereau]#
[root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
total 0
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 drvIT400_xeno
-r--r--r--. 1 root root 0  1 juil. 14:27 fildes
-r--r--r--. 1 root root 0  1 juil. 14:27 named_devices
-rw-r--r--. 1 root root 0  1 juil. 14:27 open_fildes
-r--r--r--. 1 root root 0  1 juil. 14:27 protocol_devices
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtipc
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtser0
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtser1
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtser2
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtser3
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rtser4
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rttest-switchtest0
dr-xr-xr-x. 2 root root 0  1 juil. 14:27 rttest-timerbench0



?!?!?!?!

Why 5 rtser instead of 1 ???

and why no error ???

Thanks,
Marc.


2016-07-01 14:10 GMT+02:00 marc favereau <favereau.marc.m2gl@gmail.com>:

> Why not,
>
> But i tried to remove 'mxser' driver
>
> *rmmod mxser*
>
> and after i tried to install xenomai driver with :
>
> *modprobe xeno_16550A io=3D6100,6108,6110,6118 irq=3D19,19,19,19
> baud_base=3D921600,921600,**921600,921600*
>
> and i have the same error :
>
> modprobe: ERROR: could not insert 'xeno_16550A': Device or resource busy
>
> So, i tried to install only 1 port :
>
> *modprobe xeno_16550A io=3D6100 irq=3D19 baud_base=3D921600*
>
> And i haven't an errors but when i do
>
>
>
> *ll /proc/xenomai/rtdm/*
> I have rtser0, rtser1, rtser2, rtser3 and rtser4.
> I'm a little bit confuse !!!
>
> I will try to unbind mxser and i'll tell you.
>
> Thanks, Marc.
>
> 2016-07-01 13:34 GMT+02:00 Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org>:
>
>> On Fri, Jul 01, 2016 at 12:25:07PM +0200, marc favereau wrote:
>> > Hi,
>> >
>> > First i'm sorry for my poor level in english !!!
>> >
>> > I will try to explain my problem.
>> >
>> > I have to use a MOXA CP-134 card to communicate with a device (1 port
>> for
>> > writing and 1 port for reading) in RS422.
>> > I'm using Xenomai 2.6.3 on a kernel linux 3.8.13 installed on a Xeon
>> > E5-2430 multicore desktop.
>> > I plug the card on a PCIe slot, that's why i configure kernel options
>> like
>> > this :
>> >
>> > Real-time sub-system->Drivers->Serial Drivers->16550A UART driver as a
>> > Module
>> > Real-time sub-system->Drivers->Serial Drivers->Hardware acces mode =3D=
 Any
>> > acces mode
>> > Real-time sub-system->Drivers->Serial Drivers->PCI board support *
>> > Real-time sub-system->Drivers->Serial Drivers->Moxa PCI boards *
>> >
>> >
>> > I show you my commands :
>> >
>> >
>> >
>> > [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
>> > total 0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:08 drvIT400_xeno
>> > -r--r--r--. 1 root root 0  1 juil. 11:08 fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:08 named_devices
>> > -rw-r--r--. 1 root root 0  1 juil. 11:08 open_fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:08 protocol_devices
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rtipc
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rttest-switchtest0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rttest-timerbench0
>> >
>> > That's OK, i don't see rtser...
>> >
>> >
>> > [root@BedyCalculo1 favereau]# lsmod | grep -i -a3 mxser
>> > ptp                    18413  1 igb
>> > pps_core               18854  1 ptp
>> > dca                    14601  1 igb
>> > mxser                  43739  0
>> > e1000e                240573  0
>> > parport                40425  2 ppdev,parport_pc
>> > i2c_i801               18136  0
>> >
>> > That's OK, I have a correct linux driver for serial ports
>> >
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS0
>> > /dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS1
>> > /dev/ttyS1, UART: unknown, Port: 0x02f8, IRQ: 3
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS2
>> > /dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS3
>> > /dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS4
>> > /dev/ttyS4, UART: 16550A, Port: 0x90a0, IRQ: 17
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS5
>> > /dev/ttyS5, UART: 16650V2, Port: 0x8030, IRQ: 40
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS6
>> > /dev/ttyS6, UART: 16650V2, Port: 0x8020, IRQ: 44
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS7
>> > /dev/ttyS7, UART: unknown, Port: 0x0000, IRQ: 0
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS8
>> > /dev/ttyS8, UART: unknown, Port: 0x0000, IRQ: 0
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyS9
>> > /dev/ttyS9, UART: unknown, Port: 0x0000, IRQ: 0
>> >
>> > That's OK, I have my system serial ports
>> >
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0
>> > /dev/ttyMI0, UART: 16550A, Port: 0x6100, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1
>> > /dev/ttyMI1, UART: 16550A, Port: 0x6108, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2
>> > /dev/ttyMI2, UART: 16550A, Port: 0x6110, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3
>> > /dev/ttyMI3, UART: 16550A, Port: 0x6118, IRQ: 19
>> >
>> > That's OK, I have the 4 MOXA card ports, with irq and adresses.
>> >
>> > Now, i try to install xenomai driver :
>> >
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0 uart none
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1 uart none
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2 uart none
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3 uart none
>> >
>> >
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0
>> > /dev/ttyMI0, UART: unknown, Port: 0x6100, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1
>> > /dev/ttyMI1, UART: unknown, Port: 0x6108, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2
>> > /dev/ttyMI2, UART: unknown, Port: 0x6110, IRQ: 19
>> > [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3
>> > /dev/ttyMI3, UART: unknown, Port: 0x6118, IRQ: 19
>> >
>> >
>> >
>> > [root@BedyCalculo1 favereau]# modprobe xeno_16550A
>> io=3D6100,6108,6110,6118
>> > irq=3D19,19,19,19 baud_base=3D921600,921600,921600,921600
>> > modprobe: ERROR: could not insert 'xeno_16550A': Device or resource bu=
sy
>> >
>> >
>> > ??????????
>> > I don't understand why i have this error.
>> > So i try to configure only 1 port :
>> >
>> >
>> > [root@BedyCalculo1 favereau]# modprobe xeno_16550A io=3D6100 irq=3D19
>> > baud_base=3D921600
>> >
>> > [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
>> > total 0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 drvIT400_xeno
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 named_devices
>> > -rw-r--r--. 1 root root 0  1 juil. 11:52 open_fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 protocol_devices
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtipc
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtser0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-switchtest0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-timerbench0
>> >
>> > That's OK, no error and i have RTSER0
>> >
>> > I retry to configure 4 ports :
>> >
>> > [root@BedyCalculo1 favereau]# modprobe xeno_16550A
>> io=3D6100,6108,6110,6118
>> > irq=3D19,19,19,19 baud_base=3D921600,921600,921600,921600
>> >
>> > And now i have no errors !!!!!    but...
>> >
>> >
>> > [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
>> > total 0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 drvIT400_xeno
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 named_devices
>> > -rw-r--r--. 1 root root 0  1 juil. 11:52 open_fildes
>> > -r--r--r--. 1 root root 0  1 juil. 11:52 protocol_devices
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtipc
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtser0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-switchtest0
>> > dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-timerbench0
>> >
>> > I have only 1 ports : RTSER0 !!!
>> >
>> > and for information :
>> >
>> > [root@BedyCalculo1 favereau]# cat /proc/xenomai/rtdm/rtser0/informatio=
n
>> > driver:        xeno_16550A
>> > version:    1.5.2
>> > peripheral:    UART 16550A
>> > provider:    Jan Kiszka
>> > class:        2
>> > sub-class:    0
>> > flags:        EXCLUSIVE  NAMED_DEVICE
>> > lock count:    0
>> >
>> >
>> > If someone have an idea for a solution ?
>>
>> Have you tried to unbind your moxa pci card from the Linux driver?
>> Manual unbinding is explained here:
>> https://lwn.net/Articles/143397/
>>
>> Well, the example is for USB devices, but it works for PCI devices
>> as well. The ID you pass to the bind/unbind proc is the one
>> you see in the kernel logs, things like:
>> 0000:01:00.0
>>
>> On my computers it is usually 0000: + the ID in lspci.
>>
>> --
>>                                             Gilles.
>> https://click-hack.org
>>
>
>
