From: "Charlton, John" <john.charlton@domain.hid>
Date: Thu, 8 Jan 2009 08:21:01 -0500
Message-ID: <CF7FB0793253794F9F45991443E5FE2003E4EFB9BA@us194mx002.tycoelectronics.net>
References: <CF7FB0793253794F9F45991443E5FE2003E4BABF18@domain.hid>
	<200901071828.31323.Sebastian.Smolorz@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2003E4BAC0C0@domain.hid>
	<4965D651.5010808@domain.hid>
In-Reply-To: <4965D651.5010808@domain.hid>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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
1 is set to the default base address of 0x150 and irq 5 and the second is s=
et to 0x158 and irq 7 and the module is loaded as follows:

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
> I am attaching rtcan_tscan1.zip (and the ts-can1-manual.pdf) which
> contains the added rtcan_tscan1.c and Kconfig and Makefile
> modifications I made. It is possible that there is something in my
> kernel module that is causing the problem.  I copied the rtcan_isa.c
> module and changed the names for the tscan1 device.  The TS-CAN1
> PC-104 has jumper selectable configuration registers and IRQ.  The
> first TS-CAN1 is at the default open jumper setting which is IO
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

