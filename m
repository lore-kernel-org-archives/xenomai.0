From: Kronander Klas <klas.kronander@epfl.ch>
Date: Thu, 28 Jun 2012 11:11:43 +0000
Message-ID: <D1DC5191D5CF3A45A867CD95644B92392162B98F@REXMF.intranet.epfl.ch>
References: <D1DC5191D5CF3A45A867CD95644B923921629A6D@REXMF.intranet.epfl.ch>,
	<4FE60190.5000108@xenomai.org>
In-Reply-To: <4FE60190.5000108@xenomai.org>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,=0A=
=0A=
Thanks for the response. I now tried with xenomai version 2.6, I have some =
progress but it is still not working. =0A=
=0A=
CAN-problem:=0A=
Looking at the syslog, the can card is detected and the rtcan interfaces ar=
e set up properly:=0A=
=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.954476] RT-Socket-CAN 0.90.2 - (=
C) 2006 RT-Socket-CAN Development Team=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.960228] RTCAN SJA1000 driver ini=
tialized=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.967911] PEAK-PCI-CAN: initializi=
ng device 001c:0001=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.967920] PEAK-PCI-CAN 0000:05:05.=
0: PCI INT A -> GSI 17 (level, low) -> IRQ 17=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.972902] PEAK-PCI-CAN: base_addr=
=3Df8470000 conf_addr=3Df8466000 irq=3D17=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.972914] rtcan: registered rtcan0=
=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.972920] PEAK-PCI-CAN: base_addr=
=3Df849e400 conf_addr=3Df8466000 irq=3D17=0A=
Jun 28 11:58:14 wam-desktop kernel: [   11.972928] rtcan: registered rtcan1=
=0A=
=0A=
I now also see the loaded xeno_can_peak_pci driver with lsmod. The status o=
f the can is STOPPED for both ports:=0A=
cat /proc/rtcan/devices=0A=
Name___________ _Baudrate State___ TX_Counter RX_Counter ____Errors=0A=
rtcan0          undefined stopped           0          0          0=0A=
rtcan1          undefined stopped           0          0          0=0A=
=0A=
When trying to start rtcan0 I get an error:=0A=
/usr/xenomai/sbin/rtcanconfig rtcan0 -b 1000000 -c none start -v =0A=
Cannot open RTDM CAN socket. Maybe driver not loaded?=0A=
=0A=
But the driver IS loaded, so there is another problem. I looked in the sysl=
og and could found this line:=0A=
=0A=
Jun 28 11:58:14 wam-desktop kernel: [   13.017820] Xenomai: xnintr_shirq_ha=
ndler: IRQ17 not handled. Disabling IRQ line.=0A=
=0A=
I don't know exactly what happens there or why, but it seems that IRQ 17 is=
 disabled? Why and when does this happen?=0A=
=0A=
On IRQ 17 there is the CAN card and two usb controllers. In the rc.local we=
 try to disable the conflicting devices using:=0A=
=0A=
echo -n "0000:00:1a.1" > /sys/bus/pci/drivers/uhci_hcd/unbind=0A=
echo -n "0000:00:1d.1" > /sys/bus/pci/drivers/uhci_hcd/unbind=0A=
=0A=
But that does not make any difference. Thankful for any ideas or suggestion=
s on how to proceed!=0A=
=0A=
Thanks in advance,=0A=
Klas Kronander=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From: Gilles Chanteperdrix [gilles.chanteperdrix@xenomai.org]=0A=
Sent: 23 June 2012 19:49=0A=
To: Kronander Klas=0A=
Cc: xenomai@xenomai.org=0A=
Subject: Re: [Xenomai] Peak PCI CAN card RTCAN problem=0A=
=0A=
On 06/23/2012 04:24 PM, Kronander Klas wrote:=0A=
> Hi,=0A=
>=0A=
> I have an installation of ubuntu 12.04 with xenomai 2.5.5.2.=0A=
=0A=
Do you have the same issues with xenomai 2.5.6, or even better, xenomai=0A=
2.6.0 ?=0A=
=0A=
--=0A=
                                                                Gilles.=0A=

