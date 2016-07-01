Date: Fri, 1 Jul 2016 13:34:22 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20160701113422.GF17647@hermes.click-hack.org>
References: <CALZu-7bww3OBzRcu67gP4yWeJ0GRfGR5Mm6_sDWen2V5Aryp8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALZu-7bww3OBzRcu67gP4yWeJ0GRfGR5Mm6_sDWen2V5Aryp8Q@mail.gmail.com>
Subject: Re: [Xenomai] Pb with 4 serial ports Moxa card
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: marc favereau <favereau.marc.m2gl@gmail.com>
Cc: xenomai@xenomai.org

On Fri, Jul 01, 2016 at 12:25:07PM +0200, marc favereau wrote:
> Hi,
> 
> First i'm sorry for my poor level in english !!!
> 
> I will try to explain my problem.
> 
> I have to use a MOXA CP-134 card to communicate with a device (1 port for
> writing and 1 port for reading) in RS422.
> I'm using Xenomai 2.6.3 on a kernel linux 3.8.13 installed on a Xeon
> E5-2430 multicore desktop.
> I plug the card on a PCIe slot, that's why i configure kernel options like
> this :
> 
> Real-time sub-system->Drivers->Serial Drivers->16550A UART driver as a
> Module
> Real-time sub-system->Drivers->Serial Drivers->Hardware acces mode = Any
> acces mode
> Real-time sub-system->Drivers->Serial Drivers->PCI board support *
> Real-time sub-system->Drivers->Serial Drivers->Moxa PCI boards *
> 
> 
> I show you my commands :
> 
> 
> 
> [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
> total 0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:08 drvIT400_xeno
> -r--r--r--. 1 root root 0  1 juil. 11:08 fildes
> -r--r--r--. 1 root root 0  1 juil. 11:08 named_devices
> -rw-r--r--. 1 root root 0  1 juil. 11:08 open_fildes
> -r--r--r--. 1 root root 0  1 juil. 11:08 protocol_devices
> dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rtipc
> dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rttest-switchtest0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:08 rttest-timerbench0
> 
> That's OK, i don't see rtser...
> 
> 
> [root@BedyCalculo1 favereau]# lsmod | grep -i -a3 mxser
> ptp                    18413  1 igb
> pps_core               18854  1 ptp
> dca                    14601  1 igb
> mxser                  43739  0
> e1000e                240573  0
> parport                40425  2 ppdev,parport_pc
> i2c_i801               18136  0
> 
> That's OK, I have a correct linux driver for serial ports
> 
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS0
> /dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS1
> /dev/ttyS1, UART: unknown, Port: 0x02f8, IRQ: 3
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS2
> /dev/ttyS2, UART: unknown, Port: 0x03e8, IRQ: 4
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS3
> /dev/ttyS3, UART: unknown, Port: 0x02e8, IRQ: 3
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS4
> /dev/ttyS4, UART: 16550A, Port: 0x90a0, IRQ: 17
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS5
> /dev/ttyS5, UART: 16650V2, Port: 0x8030, IRQ: 40
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS6
> /dev/ttyS6, UART: 16650V2, Port: 0x8020, IRQ: 44
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS7
> /dev/ttyS7, UART: unknown, Port: 0x0000, IRQ: 0
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS8
> /dev/ttyS8, UART: unknown, Port: 0x0000, IRQ: 0
> [root@BedyCalculo1 favereau]# setserial /dev/ttyS9
> /dev/ttyS9, UART: unknown, Port: 0x0000, IRQ: 0
> 
> That's OK, I have my system serial ports
> 
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0
> /dev/ttyMI0, UART: 16550A, Port: 0x6100, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1
> /dev/ttyMI1, UART: 16550A, Port: 0x6108, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2
> /dev/ttyMI2, UART: 16550A, Port: 0x6110, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3
> /dev/ttyMI3, UART: 16550A, Port: 0x6118, IRQ: 19
> 
> That's OK, I have the 4 MOXA card ports, with irq and adresses.
> 
> Now, i try to install xenomai driver :
> 
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0 uart none
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1 uart none
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2 uart none
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3 uart none
> 
> 
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI0
> /dev/ttyMI0, UART: unknown, Port: 0x6100, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI1
> /dev/ttyMI1, UART: unknown, Port: 0x6108, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI2
> /dev/ttyMI2, UART: unknown, Port: 0x6110, IRQ: 19
> [root@BedyCalculo1 favereau]# setserial /dev/ttyMI3
> /dev/ttyMI3, UART: unknown, Port: 0x6118, IRQ: 19
> 
> 
> 
> [root@BedyCalculo1 favereau]# modprobe xeno_16550A io=6100,6108,6110,6118
> irq=19,19,19,19 baud_base=921600,921600,921600,921600
> modprobe: ERROR: could not insert 'xeno_16550A': Device or resource busy
> 
> 
> ??????????
> I don't understand why i have this error.
> So i try to configure only 1 port :
> 
> 
> [root@BedyCalculo1 favereau]# modprobe xeno_16550A io=6100 irq=19
> baud_base=921600
> 
> [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
> total 0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 drvIT400_xeno
> -r--r--r--. 1 root root 0  1 juil. 11:52 fildes
> -r--r--r--. 1 root root 0  1 juil. 11:52 named_devices
> -rw-r--r--. 1 root root 0  1 juil. 11:52 open_fildes
> -r--r--r--. 1 root root 0  1 juil. 11:52 protocol_devices
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtipc
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtser0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-switchtest0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-timerbench0
> 
> That's OK, no error and i have RTSER0
> 
> I retry to configure 4 ports :
> 
> [root@BedyCalculo1 favereau]# modprobe xeno_16550A io=6100,6108,6110,6118
> irq=19,19,19,19 baud_base=921600,921600,921600,921600
> 
> And now i have no errors !!!!!    but...
> 
> 
> [root@BedyCalculo1 favereau]# ll /proc/xenomai/rtdm/
> total 0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 drvIT400_xeno
> -r--r--r--. 1 root root 0  1 juil. 11:52 fildes
> -r--r--r--. 1 root root 0  1 juil. 11:52 named_devices
> -rw-r--r--. 1 root root 0  1 juil. 11:52 open_fildes
> -r--r--r--. 1 root root 0  1 juil. 11:52 protocol_devices
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtipc
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rtser0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-switchtest0
> dr-xr-xr-x. 2 root root 0  1 juil. 11:52 rttest-timerbench0
> 
> I have only 1 ports : RTSER0 !!!
> 
> and for information :
> 
> [root@BedyCalculo1 favereau]# cat /proc/xenomai/rtdm/rtser0/information
> driver:        xeno_16550A
> version:    1.5.2
> peripheral:    UART 16550A
> provider:    Jan Kiszka
> class:        2
> sub-class:    0
> flags:        EXCLUSIVE  NAMED_DEVICE
> lock count:    0
> 
> 
> If someone have an idea for a solution ?

Have you tried to unbind your moxa pci card from the Linux driver?
Manual unbinding is explained here:
https://lwn.net/Articles/143397/

Well, the example is for USB devices, but it works for PCI devices
as well. The ID you pass to the bind/unbind proc is the one
you see in the kernel logs, things like:
0000:01:00.0

On my computers it is usually 0000: + the ID in lspci.

-- 
					    Gilles.
https://click-hack.org

