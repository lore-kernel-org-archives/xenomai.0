From: "Charlton, John" <john.charlton@domain.hid>
Date: Wed, 7 Jan 2009 15:08:12 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003E4BAC0D0@domain.hid>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<200901071828.31323.Sebastian.Smolorz@domain.hid>
In-Reply-To: <200901071828.31323.Sebastian.Smolorz@domain.hid>
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_002_CF7FB0793253794F9F45991443E5FE2003E4BAC0D0us194mx002tyc_"
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
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>, "xenomai@xenomai.org" <xenomai@xenomai.org>
Cc: "socketcan-users@domain.hid" <socketcan-users@domain.hid>

--_002_CF7FB0793253794F9F45991443E5FE2003E4BAC0D0us194mx002tyc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I removed the ts-can1 manual to meet the list size limit and added a little=
 more description to the first paragraph below.

I am attaching rtcan_tscan1.zip which contains the added rtcan_tscan1.c and=
 Kconfig and Makefile modifications I made.  It is possible that there is s=
omething in my kernel module that is causing the problem.  I copied the rtc=
an_isa.c module and changed the names for the tscan1 device.  The TS-CAN1 P=
C-104 has jumper selectable configuration registers and IRQ.  The first TS-=
CAN1 is at the default open jumper setting which is IO address 0x150 to 0x1=
57 and IRQ5 (both JP4 and JP5).  The second TS-CAN1 is at 0x158 to 0x15F an=
d IRQ7 (only JP5).  When you write 0x60 + idx where idx is the device index=
 to the TS-CAN1 base address + 5 it sets the SJA1000 address range dependin=
g on idx.  For idx =3D 0 SJA1000 is at 0x100 and for idx =3D 1 SJA1000 is a=
t 0x120.

Wolfgang is correct in his reply there is nothing going out on the wire or =
at least the receiver is not receiving anything.  I used rtcanrecv rtcan0 -=
e 0xffff and no errors are displayed.  After rtcansend the /proc/rtcan/rtca=
n{0|1}/info show that nothing is changed in the receiver and the sender TX-=
counter is incremented to 1:

After:
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


After:
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
Refcount   0


-----Original Message-----
From: Sebastian Smolorz [mailto:Sebastian.Smolorz@domain.hid]
Sent: Wednesday, January 07, 2009 12:29 PM
To: xenomai@xenomai.org
Cc: Charlton, John; socketcan-users@domain.hid
Subject: Re: [Xenomai-help] rtcanconfig rtcansend rtcanrecv

Charlton, John wrote:
> I added a kernel module to the xenomai ksrc/drivers/xenomai/can/sja1000.

In an earlier post to the xenomai-help ML you said that you modified rtcan_=
isa.c to make your CAN adapter work. Could you share your modifications wit=
h us? Otherwise it's difficult to analyse your problem because you changed =
the code we know in an unknown matter and maybe you made a mistake. It's li=
ke chasing ghosts without your source code.

--
Sebastian

--_002_CF7FB0793253794F9F45991443E5FE2003E4BAC0D0us194mx002tyc_
Content-Type: application/x-zip-compressed; name="rtcan_tscan1.zip"
Content-Description: rtcan_tscan1.zip
Content-Disposition: attachment; filename="rtcan_tscan1.zip"; size=3902;
	creation-date="Wed, 07 Jan 2009 14:30:59 GMT";
	modification-date="Wed, 07 Jan 2009 14:30:59 GMT"
Content-Transfer-Encoding: base64

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
+3DJAVBLBQYAAAAAAwADABMBAAAVDgAAAAA=

--_002_CF7FB0793253794F9F45991443E5FE2003E4BAC0D0us194mx002tyc_--

