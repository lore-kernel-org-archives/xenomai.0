From: Kronander Klas <klas.kronander@epfl.ch>
Date: Thu, 28 Jun 2012 11:45:42 +0000
Message-ID: <D1DC5191D5CF3A45A867CD95644B92392162BA13@REXMF.intranet.epfl.ch>
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>, 
	<4FE60190.5000108@xenomai.org>
	<D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
	<4FEC3FF0.1050307@grandegger.com>,<4FEC4245.9090804@grandegger.com>
In-Reply-To: <4FEC4245.9090804@grandegger.com>
Content-Language: en-GB
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=
=0A=
I still get the same error:=0A=
=0A=
mode: start(0x1)=0A=
Cannot open RTDM CAN Socket. Maybe Driver not loaded? =0A=
=0A=
I guess this error message is related to this line in my syslog (?) :=0A=
=0A=
Jun 28 11:58:14 wam-desktop kernel: [   13.017820] Xenomai: xnintr_shirq_ha=
ndler: IRQ17 not handled. Disabling IRQ line. =0A=
=0A=
the CAN card is on IRQ 17. =0A=
=0A=
Thanks,=0A=
Klas Kronander=0A=
________________________________________=0A=
From: Wolfgang Grandegger [wg@grandegger.com]=0A=
Sent: 28 June 2012 13:38=0A=
To: Kronander Klas=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem=0A=
=0A=
On 06/28/2012 01:28 PM, Wolfgang Grandegger wrote:=0A=
> On 06/28/2012 01:11 PM, Kronander Klas wrote:=0A=
>> Hi,=0A=
>>=0A=
>> Thanks for the response. I now tried with xenomai version 2.6, I have so=
me progress but it is still not working.=0A=
>>=0A=
>> CAN-problem:=0A=
>> Looking at the syslog, the can card is detected and the rtcan interfaces=
 are set up properly:=0A=
>>=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.954476] RT-Socket-CAN 0.90.2 =
- (C) 2006 RT-Socket-CAN Development Team=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.960228] RTCAN SJA1000 driver =
initialized=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.967911] PEAK-PCI-CAN: initial=
izing device 001c:0001=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.967920] PEAK-PCI-CAN 0000:05:=
05.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972902] PEAK-PCI-CAN: base_ad=
dr=3Df8470000 conf_addr=3Df8466000 irq=3D17=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972914] rtcan: registered rtc=
an0=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972920] PEAK-PCI-CAN: base_ad=
dr=3Df849e400 conf_addr=3Df8466000 irq=3D17=0A=
>> Jun 28 11:58:14 wam-desktop kernel: [   11.972928] rtcan: registered rtc=
an1=0A=
>>=0A=
>> I now also see the loaded xeno_can_peak_pci driver with lsmod. The statu=
s of the can is STOPPED for both ports:=0A=
>> cat /proc/rtcan/devices=0A=
>> Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors=0A=
>> rtcan0          undefined stopped           0          0          0=0A=
>> rtcan1          undefined stopped           0          0          0=0A=
>>=0A=
>> When trying to start rtcan0 I get an error:=0A=
>> /usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -c none start -v=0A=
>> Cannot open RTDM CAN socket. Maybe driver not loaded?=0A=
>=0A=
> Does the following command work?=0A=
>=0A=
> /usr/xenomai/sbin/rtcanconfig -b 1000000 -c none start -v rtcan0=0A=
=0A=
Sorry, it should be=0A=
=0A=
Usage: rtcanconfig <can-interface> [Options] [up|down|start|stop|sleep]=0A=
=0A=
Therefore try:=0A=
=0A=
#/usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -v start=0A=
=0A=
Wolfgang=0A=

