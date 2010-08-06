MIME-Version: 1.0
Date: Fri, 6 Aug 2010 23:42:21 +0200
Message-ID: <AANLkTi=yDXty82va8JGzmRA453e021EvomyYitaQTCTg@domain.hid>
From: Guenter Ebermann <guenter.ebermann@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] migration scenario to xenomai
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi,

At the moment I am thinking about a possible migration of a automotive bus
measuring/simulation application and some drivers from eCos to Linux/Xenoma=
i.
The move is primarily motivated by the huge software and device driver supp=
ort
under linux.

However some device drivers which interfaces our custom devices in FPGA mus=
t be
ported to linux or xenomai user-space or xenomai-rtdm.

But I dont want to write device drivers in kernel-space, because this would
involve some serious restructuring of our current drivers and software
structure and a possible performance penalty because of unneeded data copyi=
ng.
It is also harder to debug a kernel-driver. In eCos there is no
user/kernel space
seperation and our custom device drivers access the registers based in FPGA
directly. The interface of these drivers to the application is not via a de=
vice
file but over direct function invocation.

So I thought of moving this part of our communication stack which has hard-=
real
time requirement (FlexRay, CAN, LIN) into a seperate process which only liv=
es
in the xenomai domain (it will communicate with low-prio linux processes vi=
a
non-blocking fifo or such). But this raises two important questions: Can I
access the FPGA registers directly from a xenomai task in the user space? =
=A0Or
do I have to write a minimal linux or xenomai-rtdm device driver which maps
FPGA registers from kernel to user space?

-- Guenter

