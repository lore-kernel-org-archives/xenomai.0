Message-ID: <44CF6EB1.1010808@domain.hid>
Date: Tue, 01 Aug 2006 17:09:37 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060101060608030808060108"
Subject: [Xenomai-core] [ANNOUNCE] RTDM driver for CAN devices
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------060101060608030808060108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

at "ftp://ftp.denx.de/pub/xenomai/rtcan" you can find a first version of
RTCAN, an Open Source hard real-time protocol stack for CAN devices
based on BSD sockets. It is based on the SJA1000 socket-based CAN driver
for RTDM by Sebastian Smolorz (see CREDITS file).

Currently it consist of a RTDM driver patch for Xenomai and a tar
archive with the RTCAN utilities. I have attached the README for further
details. It would be nice if the RTCAN patch could be integrated into
Xenomai. As this driver is bigger and more complex than the other RTDM
drivers, it rises a few issues with RTDM driver integration and maintenance:

- Where to put a few utility or test programs
- Where to put miscellaneous files like README, CREDITS, etc.
- Where to discuss RTCAN related question.

For the moment, please report CAN related bugs, questions and comments
to the Socketcan mailing list "Socketcan-users@domain.hid" at
http://developer.berlios.de/projects/socketcan/

Wolfgang.



--------------060101060608030808060108
Content-Type: text/plain;
 name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README"

RTCAN is an Open Source hard real-time protocol stack for CAN devices
based on BSD sockets. This implementation is for RTDM, the Real-Time-
Driver-Model. Note that there is a similar variant being developed for
standard Linux using the Linux networking stack.


Status:
------

Note: this is a preliminary version of the RTCAN RTDM driver!

It is available for the following CAN controller and devices:

   SJA1000 ISA devices
   SJA1000 PEAK PCI card
   SJA1000 PEAK parallel port Dongle
   MSCAN for MPC5200 boards

Currently it consist of a RTDM driver patch for Xenomai and a tar 
archive with the RTCAN utilities:

   rtcan-xenomai-0.20.1.patch
   rtcan-utils-0.20.1.tar.bz2

Likely some internals will change sooner than later, e.g. it might be
integrated into Xenomai. Nevertheless, the API is already settled well
as a result of discussions on the "Socketcan" mailing list 
(Socketcan-users@domain.hid)


Installation:
------------

This example installation is for the DENX "linuxppc_2_4_devel" tree
(Linux 2.4.25) using the ELDK (see http://www.denx.de). It works in a
similar way for other kernels and distributions including Linux 2.6.


o General part:

  - Download the Xenomai distribution from the SVN repository, apply 
    the RTCAN patch and run "bootstrap":

    $ svn co http://svn.gna.org/svn/xenomai/trunk xenomai
    $ export XENO_ROOT=$PWD/xenomai
    $ cd $XENO_ROOT
    $ patch -p1 < /tmp/rtcan-xenomai-0.20.1.patch
    $ scripts/bootstrap

    The "bootstrap" is necessary to get "include/rtdm/rtcan.h" copied
    to the installation directory with make install. Alternatively,
    you can copy it by hand. 
    

o Kernel space part:

  - Please install the Xenomai kernel space part as described in the
    README.INSTALL. The following variable should point to the Xenomai
    patched kernel:

    $ export KERNEL_ROOT=/home/wolf/test/linuxppc_2_4_devel-xenomai

  - Configure RTCAN as kernel modules as required by your hardware 
    (and make sure that loadable module support is enabled):

    $ cd $KERNEL_ROOT
    $ export CROSS_COMPILE=ppc_82xx-
    $ make menuconfig
    ... Select "Loadable module support  --->" 
    [*] Enable loadable module support 
    ... Exit
    ... Select "Real-time sub-system --->"
               "Real-time drivers --->" 
                 "CAN bus controller --->"
    [M] RTCAN raw socket interface (NEW)
    (1024) Size of receive ring buffers (must be 2^N) (NEW)
    (4) Maximum number of devices (NEW)
    (16) Maximum number of receive filters per device (NEW)
    [M] MSCAN driver for MPC5200 (NEW)
    [*] Enable CAN 1 (NEW)
    [*] Enable CAN 2 (NEW)
    (66000000) Clock Frequency in Hz (NEW)
    (I2C1/TMR01) Pin Configuration
    <M> Philips SJA1000 CAN controller (NEW)
    <M>   Standard ISA devices
    (4)   Maximum number of ISA devices (NEW)
    <M>   PEAK PCI cards
    ... Exit and save

    Note: you can also statically link the MSCAN drivers into 
    the kernel.


  - Make the Linux kernel and RTCAN modules and copy them to the root
    filesystem:

    $ make dep
    $ make uImage
    $ cp -p arch/ppc/boot/images/uImage /tftpboot/icecube/uImage-rtcan
    $ make modules
    $ export DESTDIR=/opt/eldk/ppc_82xx
    $ make modules_install INSTALL_MOD_PATH=$DESTDIR
    $ find $DESTDIR/lib/modules/2.4.25/kernel/drivers/xenomai/rtcan
    .../rtcan
    .../rtcan/xeno_rtcan.o
    .../rtcan/mscan
    .../rtcan/mscan/xeno_rtcan_mscan.o
    .../rtcan/sja1000/xeno_rtcan_sja1000.o
    .../rtcan/sja1000/xeno_rtcan_peak_pci.o
    .../rtcan/sja1000/xeno_rtcan_isa.o


o User space part:

  - Please install the Xenomai user space part as described in the
    README.INSTALL. You need the path to the Xenomai installation 
    directory to make the RTCAN utilities.

  - Unpack the RTCAN utility distribution:

    $ tar xjf rtcan-utils-0.20.1.tar.bz2
    $ export RTCAN_ROOT $PWD/rtcan-utils-0.20.1

  - Make the RTCAN utilities and install them:

    $ cd $RTCAN_ROOT
    $ export XENO_INSTDIR=/opt/eldk/ppc_82xx/usr/xenomai
    $ make
    $ make install


Running and using RTCAN:
-----------------------

Now boot the Xenomai enabled kernel on your target system.

In case RTCAN is built as kernel modules, you need to load them using
modprobe or insmod, e.g. for this example build:

  # export MODDIR=/lib/modules/2.4.25/kernel/drivers/xenomai/rtcan
  # insmod $MODDIR/xeno_rtcan.o
  # insmod $MODDIR/mscan/xeno_rtcan_mscan.o
  # insmod $MODDIR/sja1000/xeno_rtcan_sja1000.o
  # insmod $MODDIR/sja1000/xeno_rtcan_peak_pci.o

Note that various kernel module parameters can be passed with insmod.
Please use "modinfo" to list them or check the corresponding source 
code files for further information

There are a few RTCAN utilities to configure RTCAN and to send and 
receive CAN messages, which have been installed in the Xenomai
installation directory with "make install":

  # export XENO_ROOT=/usr/xenomai
  # export PATH=$PATH:$XENO_ROOT/bin
  # export LD_LIBRARY_PATH=$XENO_ROOT/lib

  # rtcanconfig --help
  Usage: rtcanconfig <can-interface> [Options] [up|down|start|stop|sleep]
  Options:
   -v, --verbose            be verbose
   -h, --help               this help
   -c, --ctrlmode=M1:M2:... listenonly or loopback mode
   -b, --baudrate=BPS       baudrate in bits/sec
   -B, --bittime=BTR0:BTR1  BTR or standard bit-time
   -B, --bittime=BRP:PROP_SEG:PHASE_SEG1:PHASE_SEG2:SJW:SAM

  # rtcanrecv --help
  Usage: rtcanrecv <can-interface> [Options]
  Options:
   -f  --filter=id:mask[:id:mask]... apply filter
   -e  --error=mask      receive error messages
   -t, --timeout=MS      timeout in ms
   -v, --verbose         be verbose
   -p, --print=MODULO    print every MODULO message
   -n, --name=STRING     name of the RT task
   -h, --help            this help

  # rtcansend --help
  Usage: rtcansend <can-interface> [Options] <can-msg>
  <can-msg> can consist of up to 8 bytes given as a space separated list
  Options:
   -i, --identifier=ID   CAN Identifier (default = 1)
   -r  --rtr             send remote request
   -e  --extended        send extended frame
   -l  --loop=COUNT      send message COUNT times
   -c, --count           message count in data[0-3]
   -d, --delay=MS        delay in ms (default = 1ms)
   -t, --timeout=MS      timeout in ms
   -v, --verbose         be verbose
   -p, --print=MODULO    print every MODULO message
   -h, --help            this help

Here are a few self-explanary commands:

  # rtcanconfig rtcan0 --baudrate=125000 start

  # rtcansend rtcan2 --verbose --identifier=0x123 0xde 0xad
  <0x123> [2] de ad

  # rtcanrecv rtcan0 --verbose
  #1: <0x123> [2] de ad

  bash-2.05b# rtcanrecv rtcan0 --filter=0x120:0x120
  Filter #0: id=0x00000120 mask=0x00000120
  #0: <0x124> [2] de ad
  #1: <0x123> [3] 12 34 56
  #2: <0x133> [4] 11 22 33 44

  # rtcanrecv rtcan0 --error=0xffff
  #1: !0x00000008! [8] 00 00 80 19 00 00 00 00 ERROR


PROC filesystem: the followingfiles provide useful information
on the status of the CAN controller, filter settings, registers,
etc.

  # cat /proc/rtcan/devices
  Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
  rtcan0             125000 active            0          8          0
  rtcan1             125000 active            0          8          0
  rtcan2             125000 passive           8          0      14714

  # cat /proc/rtcan/sockets
  fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull
   0 rtcan0               1 0x0ffff      infinite      infinite          0
   1 rtcan0               1 0x00000      infinite      infinite          0

  # cat /proc/rtcan/rtcan2/info
  Device     rtcan2
  Controller SJA1000
  Board      PEAK-PCI
  Clock-Hz   8000000
  Baudrate   125000
  Bit-time   brp=4 prop_seg=0 phase_seg1=13 phase_seg2=2 sjw=1 sam=0
  Ctrl-Mode
  State      passive
  TX-Counter 3
  RX-Counter 0
  Errors     45424
  Refcount   0

  # cat /proc/rtcan/rtcan0/filters
  fd __CAN_ID__ _CAN_Mask_ MatchCount
   0 0x00000000 0x00000000          0
   1 0x00000120 0x00000120          3

  # cat /proc/rtcan/rtcan0/registers
  MSCAN registers at f0000900
  canctl0  0x90 rxfrm synch
  canctl1  0xc0 cane clksrc
  ...

  # cat /proc/rtcan/rtcan2/registers
  SJA1000 registers
  00: 00 00 4c 00 ff 00 03 1c 1a 00 00 02 d6 60 14 88
  10: 02 26 60 de ad 04 04 00 ef c7 ef ef 40 00 00 c7


Documentation:
-------------

Temoporarily, The RTDM CAN profile is documented using Doxygen in
"api_doc/index.html"


Feedback:
--------

Please report Xenomai related bugs and comments to the Xenomai mailing 
list "xenomai@xenomai.org".

Please report CAN related bugs and comments to the "Socketcan" mailing 
list (Socketcan-users@domain.hid) or directly to the main authors 
Wolfgang Grandegger (wg@domain.hid) or Sebastian Smolorz 
(Sebastian.Smolorz@domain.hid). 


Credits:
-------

See CREDITS file.


License:
-------

RTCAN is free software, and you are welcome to redistribute it under
the terms of the GNU General Public License. This program comes with
ABSOLUTELY NO WARRANTY. See "COPYING" for details.

--------------060101060608030808060108--

