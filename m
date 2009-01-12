From: "Charlton, John" <john.charlton@domain.hid>
Date: Mon, 12 Jan 2009 11:30:01 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2004DF7840E1@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<200901071828.31323.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
	<4965D651.5010808@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2004DF784062@domain.hid>
	<496B6B66.7070905@domain.hid>
In-Reply-To: <496B6B66.7070905@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai-help] [Socketcan-users] rtcanconfig rtcansend rtcanrecv
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>, "socketcan-users@domain.hid" <socketcan-users@domain.hid>

Wolfgang,

Thank you for the help.  I do have XENO_DRIVERS_CAN_DEBUG enabled and the r=
egisters are:

root@domain.hid:~$ cat /proc/rtcan/rtcan1/registers
SJA1000 registers
00: 00 00 0c 02 ff 00 03 1c 1a 00 00 00 00 60 00 00
10: 08 00 20 01 02 03 04 05 06 07 08 ff 20 00 00 c8
root@domain.hid:~$ cat /proc/rtcan/rtcan0/registers
SJA1000 registers
00: 00 00 0d 01 ff 00 03 1c 1a 00 00 00 00 60 00 00
10: 08 00 20 01 02 03 04 05 06 07 08 bf 00 01 00 c8
root@domain.hid:~$

I will focus on the transmitter and try another CAN device or CAN analyzer =
as you suggest.

--John

-----Original Message-----
From: Wolfgang Grandegger [mailto:wg@domain.hid
Sent: Monday, January 12, 2009 11:10 AM
To: Charlton, John
Cc: Sebastian Smolorz; xenomai@xenomai.org; socketcan-users@domain.hid.=
de
Subject: Re: [Socketcan-users] [Xenomai-help] rtcanconfig rtcansend rtcanre=
cv

Charlton, John wrote:
> I am attaching an updated rtcan_tscan1.c driver for the TS_CAN1 PC-104 CA=
N interface.  I have only attempted to configure it for x86 so it is not co=
nfigured for ARM or any other architecture.
>=20
> I tried to build lincan-0.3.3 for linux-2.6.27.7 and so far have not=20
> succeeded so I have returned to testing the rtcan_tscan1.c module in=20
> xenomai-2.4.6.1.  I wait for input from rtcan0 in one terminal and=20
> send to rtcan1 in another terminal. From previous tests the send does=20
> not block the first time but always blocks on the second attempt (or=20
> in this case with multiple loops) with a socket filter of -1.  The detail=
s are below:
>=20
> root@domain.hid:~$ rtcanconfig rtcan0 --verbose --baudrate=3D125000=20
> start
> mode: start (0x1)
> baudrate: 125000
> root@domain.hid:~$ rtcanconfig rtcan1 --verbose --baudrate=3D125000=20
> start
> mode: start (0x1)
> baudrate: 125000
> root@domain.hid:~$ cat /proc/rtcan/devices Name___________ _Baudrate=20
> State___ TX_Counter RX_Counter ____Errors
> rtcan0             125000 active            0          0          0
> rtcan1             125000 active            0          0          0
> root@domain.hid:~$ cat /proc/rtcan/sockets fd Name___________ Filter=20
> ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo=20
> root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=3D0xffff=20
> interface rtcan0 s=3D0, ifr_name=3Drtcan0 Using err_mask=3D0xffff
>=20
>>> Blocks waiting for input
>=20
>>> In another terminal:
> rtcansend -d 500 -l 10 rtcan1 1 2 3 4 5 6 7 8
>=20
> blocks waiting for transmit
>=20
> In a third terminal:
>=20
> root@domain.hid:~$ cat /proc/rtcan/sockets fd Name___________ Filter=20
> ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo
>  1                     -1 0x00000      infinite      infinite          0 =
    1
>  0                      1 0x0ffff      infinite      infinite          0 =
    1
> root@domain.hid:~$ cat /proc/rtcan0/info
> cat: /proc/rtcan0/info: No such file or directory root@domain.hid
> cat /proc/rtcan/rtcan0/info
> Device     rtcan0
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sa=
m=3D0
> Ctrl-Mode
> State      active
> TX-Counter 0
> RX-Counter 0
> Errors     0
> Refcount   0
> root@domain.hid:~$ cat /proc/rtcan/rtcan1/info
> Device     rtcan1
> Controller SJA1000
> Board      TSCAN1-Board
> Clock-Hz   8000000
> Baudrate   125000
> Bit-time   brp=3D4 prop_seg=3D0 phase_seg1=3D13 phase_seg2=3D2 sjw=3D1 sa=
m=3D0
> Ctrl-Mode
> State      active
> TX-Counter 1
> RX-Counter 0
> Errors     0
> Refcount   1
> root@domain.hid:~$
>=20
> I am not sure what the 'Filter' parameter does.  in the send socket,=20
> it is -1 and in the receive socket it is 1. Since the receive socket=20
> doesn't receive anything it indicates that the send never goes out on=20
> the wire or the receive interrupt is not occurring.
>=20
> If I do this:
> root@domain.hid:~$ rtcanrecv rtcan0 --verbose --error=3D0xffff=20
> --filter=3D-1:-1:1:1 Filter #0: id=3D0xffffffff mask=3D0xffffffff Filter =
#1:=20
> id=3D0x00000001 mask=3D0x00000001 interface rtcan0 s=3D0, ifr_name=3Drtca=
n0=20
> Using err_mask=3D0xffff
>=20
> The filter parameter is set to 2 for the receiver socket:
> root@domain.hid:~$ cat /proc/rtcan/sockets fd Name___________ Filter=20
> ErrMask RX_Timeout_ns TX_Timeout_ns RX_BufFull TX_Lo
>  0                      2 0x0ffff      infinite      infinite          0 =
    1
>  1                     -1 0x00000      infinite      infinite          0 =
    1
> root@domain.hid:~$
>=20
> Both send and receive sockets remain blocked.

The TX done interrupt does not come indicating that the hardware is not con=
figured or handled correctly. To simplify debugging

- connect an external known-to-work node your CAN bus, preferably a
  CAN bus analyzer, to receive and send CAN messages.

- To inspect the SJA1000 registers und /proc/rtcan/rtcan[01]/registers,
  enable the Kconfig option XENO_DRIVERS_CAN_DEBUG:

  http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/can/Kconfi=
g#009

Wolfgang.



