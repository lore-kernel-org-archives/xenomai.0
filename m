Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 6 Apr 2007 11:09:12 +0200
Message-ID: <899865CA54E4444DAF2E3639C04C5F4805EC69@domain.hid>
From: "Richard Cochran" <richard.cochran@domain.hid>
Subject: [Xenomai-core] RTDM cannot open device
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

I am trying to write a simple driver using the RTDM. I have based my
driver on the examples at http://www.captain.at and at
http://stud3.tuwien.ac.at/~e0226686/xenomai/source_code.

The call to rt_dev_open() returns -1 (Operation not permitted).

The program is running as root, and I am able to run the 'latency'
test program.

What am I doing wrong?

I include some diagnostics, below...

Thanks,
Richard

--------------------------------------------------------------------
Richard Cochran (Mr), Software Development
OMICRON electronics GmbH, Oberes Ried 1, A-6833 Klaus / Austria
http://www.omicron.at/
--------------------------------------------------------------------

root@domain.hid:~# /usr/xenomai/bin/xeno-info
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
=20
BusyBox v1.01 (2007.01.31-09:53+0000) multi-call binary
Linux nslu2 2.6.19omicron-g103dbcb5 #27 Fri Apr 6 09:57:25 CEST 2007
armv5teb un
=20
module-init-tools      3.2.2
Modules Loaded         rt_miccpt

***

root@domain.hid:~# find /proc/xenomai -type f -print -exec cat {} \; -exec
echo \;
/proc/xenomai/rtdm/rt_miccpt/information
driver:         rt_miccpt
version:        0.0.0
peripheral:     micdev
provider:       -
class:          224
sub-class:      0
flags:          NAMED_DEVICE =20
lock count:     0

/proc/xenomai/rtdm/fildes
total=3D128:open=3D0:free=3D128

/proc/xenomai/rtdm/open_fildes
Index   Locked  Device

/proc/xenomai/rtdm/protocol_devices
Hash    ProtocolFamily:SocketType       Driver          /proc

/proc/xenomai/rtdm/named_devices
Hash    Name                            Driver          /proc
A8      micdev0                         rt_miccpt       rt_miccpt

/proc/xenomai/interfaces/rtdm
0

/proc/xenomai/interfaces/posix
0

/proc/xenomai/interfaces/native
0

/proc/xenomai/interfaces/sys
0

/proc/xenomai/heap
size=3D130560:used=3D64:pagesz=3D512

/proc/xenomai/irq
IRQ         CPU0
  5:        9611         [timer]
 34:           0         [virtual]

/proc/xenomai/timer
status=3Doneshot:setup=3D15:tickval=3D1:jiffies=3D100286782221

/proc/xenomai/version
2.3.1

/proc/xenomai/latency
9495

/proc/xenomai/stat
CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
  0  0      0          0          0     00400080   99.9  ROOT
  0  0      0          9619       0     00000000    0.0  IRQ5: [timer]

/proc/xenomai/sched
CPU  PID    PRI      PERIOD   TIMEOUT    STAT       NAME
  0  0       -1      0        0          R          ROOT

/proc/xenomai/apc
APC          CPU0
  0:            0    (pipe_wakeup)
  1:            0    (lostage_handler)
  2:            0    (registry_export)
  3:            0    (posix_signals_handler)

/proc/xenomai/faults
TRAP         CPU0
  0:            0    (Data or instruction access)
  1:            0    (Section fault)
  2:            0    (Generic data abort)
  3:            0    (Unknown exception)
  4:            0    (Instruction breakpoint)
  5:            0    (Floating point exception)
  6:            0    (VFP Floating point exception)
  7:            0    (Undefined instruction)

/proc/xenomai/hal
1.6-04

