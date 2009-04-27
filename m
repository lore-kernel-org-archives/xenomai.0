MIME-Version: 1.0
Date: Mon, 27 Apr 2009 14:53:41 +0200
Message-ID: <37f89760904270553s1d862905l5c3c4df01ce0d984@domain.hid>
From: Marcel Soulot <msoulot@domain.hid>
Content-Type: multipart/alternative; boundary=0016e6d46a65fd4f70046888d54a
Subject: [Xenomai-help] Try to get recption on driver CAN
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

--0016e6d46a65fd4f70046888d54a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I try to receive data from CAN network. I got a PCI card with a FPGA which
emulates the SJA1000.
So I load the following modules :
insmod ./xeno_can.ko
insmod ./xeno_can_sja1000.ko
insmod ./xeno_can_mem.ko mem=0xe0000800 irq=5 can_clock=80000000 cdr=0x8F

then I configure with :
./rtcanconfig rtcan0 -v --baudrate=125000 start

and launch the receive test application :
./rtcanrecv rtcan0 -v

The task is running but nothing happen in reception.
I could just say that the transmitter was blocked before I load the driver.
After all the upon configuration, I can check that the connection with
transmitter is now enabled and the data are sent.

First, my question is this procedure have any chance to work ? or I missed
something in the configuration ?
I haven't set any filter, so I guess that I will receive all the data
incoming, right ?

thanks for your help,
Marcel


here I joined all the info concerning the driver setting:

INFO:
Device     rtcan0
Controller SJA1000
Board      mem mapped
Clock-Hz   40000000
Baudrate   125000
Bit-time   brp=16 prop_seg=0 phase_seg1=16 phase_seg2=3 sjw=1 sam=0
Ctrl-Mode
State      active
TX-Counter 0
RX-Counter 0
Errors     0
Refcount   0

REGISTERS :
SJA1000 registers
00: 00 00 0d 01 ff 00 0f 2f 00 00 00 00 00 60 00 00
10: 08 a1 80 80 00 00 00 00 00 00 00 08 a2 40 00 8f

FILTERS:
fd __CAN_ID__ _CAN_Mask_ Inv MatchCount
 0 0x00000000 0x00000000  no          0

--0016e6d46a65fd4f70046888d54a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I try to receive data from CAN network. I got a PCI card with a =
FPGA which emulates the SJA1000.<br>So I load the following modules : <br>i=
nsmod ./xeno_can.ko<br>insmod ./xeno_can_sja1000.ko<br>insmod ./xeno_can_me=
m.ko mem=3D0xe0000800 irq=3D5 can_clock=3D80000000 cdr=3D0x8F<br>
<br>then I configure with :<br>./rtcanconfig rtcan0 -v --baudrate=3D125000 =
start<br><br>and launch the receive test application :<br>./rtcanrecv rtcan=
0 -v <br><br>The task is running but nothing happen in reception. <br>I cou=
ld just say that the transmitter was blocked before I load the driver. Afte=
r all the upon configuration, I can check that the connection with transmit=
ter is now enabled and the data are sent. <br>
<br>First, my question is this procedure have any chance to work ? or I mis=
sed something in the configuration ?<br>I haven&#39;t set any filter, so I =
guess that I will receive all the data incoming, right ?<br><br>thanks for =
your help,<br>
Marcel<br><br><br>here I joined all the info concerning the driver setting:=
<br><br>INFO:<br>Device=A0=A0=A0=A0 rtcan0<br>Controller SJA1000<br>Board=
=A0=A0=A0=A0=A0 mem mapped<br>Clock-Hz=A0=A0 40000000<br>Baudrate=A0=A0 125=
000<br>Bit-time=A0=A0 brp=3D16 prop_seg=3D0 phase_seg1=3D16 phase_seg2=3D3 =
sjw=3D1 sam=3D0<br>
Ctrl-Mode=A0 <br>State=A0=A0=A0=A0=A0 active<br>TX-Counter 0<br>RX-Counter =
0<br>Errors=A0=A0=A0=A0 0<br>Refcount=A0=A0 0<br><br>REGISTERS :<br>SJA1000=
 registers<br>00: 00 00 0d 01 ff 00 0f 2f 00 00 00 00 00 60 00 00<br>10: 08=
 a1 80 80 00 00 00 00 00 00 00 08 a2 40 00 8f<br>
=A0<br>FILTERS: <br>fd __CAN_ID__ _CAN_Mask_ Inv MatchCount<br>=A00 0x00000=
000 0x00000000=A0 no=A0=A0=A0=A0=A0=A0=A0=A0=A0 0<br>

--0016e6d46a65fd4f70046888d54a--

