From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 12 Jan 2009 10:33:06 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2004DF784062@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<200901071828.31323.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
	<4965D651.5010808@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
In-Reply-To: <CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_CF7FB0793253794F9F45991443E5FE2004DF784062us194mx002tyc_"
MIME-Version: 1.0
Subject: Re: [Xenomai-help] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <smolorz@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

--_002_CF7FB0793253794F9F45991443E5FE2004DF784062us194mx002tyc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am attaching an updated rtcan_tscan1.c driver for the TS_CAN1 PC-104 CAN =
interface.  I have only attempted to configure it for x86 so it is not conf=
igured for ARM or any other architecture.

I tried to build lincan-0.3.3 for linux-2.6.27.7 and so far have not
succeeded so I have returned to testing the rtcan_tscan1.c module in
xenomai-2.4.6.1.  I wait for input from rtcan0 in one terminal and
send to rtcan1 in another terminal. From previous tests the send does not b=
lock the first time but always
blocks on the second attempt (or in this case with multiple loops)
with a socket filter of -1.  The details are below:

root@domain.hid:~$ rtcanconfig rtcan0 --verbose --baudrate=3D125000 start
mode: start (0x1)
baudrate: 125000
root@domain.hid:~$ rtcanconfig rtcan1 --verbose --baudrate=3D125000 start
mode: start (0x1)
baudrate: 125000
root@domain.hid:~$ cat /proc/rtcan/devices
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors
rtcan0             125000 active            0          0          0
rtcan1             125000 active            0          0          0
root@domain.hid:~$ cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX=
_Lo
root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=3D0xffff
interface rtcan0
s=3D0, ifr_name=3Drtcan0
Using err_mask=3D0xffff

>>Blocks waiting for input

>>In another terminal:
rtcansend -d 500 -l 10 rtcan1 1 2 3 4 5 6 7 8

blocks waiting for transmit

In a third terminal:

root@domain.hid:~$ cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX=
_Lo
 1                     -1 0x00000      infinite      infinite          0   =
  1
 0                      1 0x0ffff      infinite      infinite          0   =
  1
root@domain.hid:~$ cat /proc/rtcan0/info
cat: /proc/rtcan0/info: No such file or directory
root@domain.hid:~$ cat /proc/rtcan/rtcan0/info
Device     rtcan0
Controller SJA1000
Board      TSCAN1-Board
Clock-Hz   8000000
Baudrate   125000
Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0
root@domain.hid:~$ cat /proc/rtcan/rtcan1/info
Device     rtcan1
Controller SJA1000
Board      TSCAN1-Board
Clock-Hz   8000000
Baudrate   125000
Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sam=
=3D0
Ctrl-Mode
State      active
TX-Counter 1
RX-Counter 0
Errors     0
Refcount   1
root@domain.hid:~$

I am not sure what the 'Filter' parameter does.  in the send socket,
it is -1 and in the receive socket it is 1. Since the receive socket
doesn't receive anything it indicates that the send never goes out on
the wire or the receive interrupt is not occurring.

If I do this:
root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=3D0xffff --filter=
=3D-1:-1:1:1
Filter #0: id=3D0xffffffff mask=3D0xffffffff
Filter #1: id=3D0x00000001 mask=3D0x00000001
interface rtcan0
s=3D0, ifr_name=3Drtcan0
Using err_mask=3D0xffff

The filter parameter is set to 2 for the receiver socket:
root@domain.hid:~$ cat /proc/rtcan/sockets
fd Name___________ Filter ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX=
_Lo
 0                      2 0x0ffff      infinite      infinite          0   =
  1
 1                     -1 0x00000      infinite      infinite          0   =
  1
root@domain.hid:~$

Both send and receive sockets remain blocked.

--John=20

-----Original Message-----
From: socketcan-users-bounces@domain.hid [mailto:socketcan-users-boun=
ces@domain.hid] On Behalf Of Charlton, John
Sent: Thursday, January 08, 2009 8:21 AM
To: Sebastian Smolorz
Cc: xenomai@xenomai.org; socketcan-users@domain.hid
Subject: Re: [Socketcan-users] [Xenomai-help] rtcanconfig rtcansend rtcanre=
cv

Sebastian,

Thank you for looking at the rtcan_tscan1.c source code.  You are right, th=
ere are two distinct IO regions in the TS-CAN1, but rtcan_sja1000_regs.h on=
ly should access the SJA1000 region.  The other IO region is accessed only =
by the rtcan_tscan1.c module to select the IO region for the SJA1000.  The =
TS-CAN1 and IRQ lines are selected by jumpers and the jumper selection is n=
ot currently checked in the rtcan_tscan1.c module (it can be checked since =
it is readable from the TS-CAN1 base + 6 status register).  The TS-CAN1 bas=
e + 5 register is the one that selects the SJA1000 base address.  Setting o=
nly bit 6 of TS-CAN1 + 5 maps the SJA1000 to 0x100 - 0x11F.  The rtcan_tsca=
n1.c module sets the lower three bits of the TS-CAN1 + 5 to the idx paramet=
er which maps the SJA1000 to 0x120 - 0x13F if idx is 1 and so on.  The io a=
ddresses and irq variables passed to the xeno_can_tscan1 module when loaded=
 must be consistent with the jumper settings.  In my test, the first TS-CAN=
1 is set to the
  default base address of 0x150 and irq 5 and the second is set to 0x158 an=
d irq 7 and the module is loaded as follows:

insmod xeno_can_tscan1.ko io=3D0x100,0x120 irq=3D5,7

Note that the io base address array is set to the SJA1000 base addresses an=
d not the TS-CAN1 addresses.  The rtcan_tscan1.c module takes care of setti=
ng the TS-CAN1 base address + 5 so that the SJA1000 IO region is as specifi=
ed in the insmod above.

Since my primary goal at present is to test and compare CAN IP performance =
with ethernet IP performance, I am going to shift to the lincan driver.  We=
 are planning to use xenomai in the near future so I would like to fix the =
rtcan_tscan1.c module to work correctly.

--John


-----Original Message-----
From: Sebastian Smolorz [mailto:smolorz@domain.hid]
Sent: Thursday, January 08, 2009 5:33 AM
To: Charlton, John
Cc: xenomai@xenomai.org; socketcan-users@domain.hid
Subject: Re: [Xenomai-help] rtcanconfig rtcansend rtcanrecv

Charlton, John wrote:
> I am attaching rtcan_tscan1.zip (and the ts-can1-manual.pdf) which=20
> contains the added rtcan_tscan1.c and Kconfig and Makefile=20
> modifications I made. It is possible that there is something in my=20
> kernel module that is causing the problem.  I copied the rtcan_isa.c=20
> module and changed the names for the tscan1 device.  The TS-CAN1
> PC-104 has jumper selectable configuration registers and IRQ.  The=20
> first TS-CAN1 is at the default open jumper setting which is IO=20
> address 0x150 to 0x157 and IRQ5 (both
> JP4 and JP5).  The second TS-CAN1 is at 0x158 to 0x15F and IRQ7 (only JP5=
).

Without digging too deep into the special properties of your CAN hardware a=
nd your source code modifications: It seems to me that your CAN controller =
has two distinct IO regions whereas rtcan_isa assumes that there is one IO =
region of 32 bytes which belongs to the SJA1000.
What are the two regions of your hardware for especially, the one with only=
 8 bytes? You should check whether you access those SJA1000 registers corre=
ctly. A look into rtcan_sja1000_regs.h may help you.

However, as Wolfgang already suggested, there is at least one driver availa=
ble for plain Linux which should work with your CAN controller. If you test=
ed this driver successfully you could take a look into its source to get fu=
rther hints for your Xenomai driver.

--
Sebastian
_______________________________________________
Socketcan-users mailing list
Socketcan-users@domain.hid
https://lists.berlios.de/mailman/listinfo/socketcan-users

--_002_CF7FB0793253794F9F45991443E5FE2004DF784062us194mx002tyc_
Content-Type: application/x-compressed; name="rtcan_tscan1.tgz"
Content-Description: rtcan_tscan1.tgz
Content-Disposition: attachment; filename="rtcan_tscan1.tgz"; size=2348;
	creation-date="Mon, 12 Jan 2009 10:24:47 GMT";
	modification-date="Mon, 12 Jan 2009 10:24:47 GMT"
Content-Transfer-Encoding: base64

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
Zv0Ll1gQsAAoAAA=

--_002_CF7FB0793253794F9F45991443E5FE2004DF784062us194mx002tyc_--

