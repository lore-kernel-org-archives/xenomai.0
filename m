Message-ID: <4871F8C3.3030601@domain.hid>
Date: Mon, 07 Jul 2008 13:06:43 +0200
From: Stephan Adler <stephan.adler@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Problems with level triggered Interrupts on ARM
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

Dear list!

I have a problem in understanding how Xenomai handles level triggered=20
Interrupts.

I am using an ARM AT91RM9200 with the native Xenomai (2.4.2) skin.

I try to implement the handling of a network protocol on that platform.=20
Therefore a network controller is used which is directly connected to=20
the Arm.
This network controller has one level-trigerred interrupt line. The line=20
is used to signal when a packet has arrived in the controller. There are=20
two types of messages - a control-type and a data-type. The interrupt is=20
shared for both packet types.

When a packet arrives the interrupt line is pulled to a low-level until=20
the Arm reads a certain register depending on the packet-type. A problem=20
occurs when - while handling a data-message - a control-message is=20
received by the controller. The interrupt line will stay down after the=20
data-packet is handled until I handle the control-message also.

Well - as I am using a level triggered interrupt I'd expect Xenomai to=20
jump over the rt_intr_wait() instruction until the level of the=20
interrupt rises again. But that actually doesn't happen. Indeed Xenomai=20
just counts the interrupt whenever an new edge of the interrupt signal=20
occurs.

I searched this list for an explanation of that behavior and found these=20
two messages:

https://mail.gna.org/public/xenomai-help/2006-06/msg00078.html
https://mail.gna.org/public/xenomai-help/2008-05/msg00263.html

When I understand both posts correctly, I assume the following behavior=20
of the Arm vs. Xenomai:

- the ARM sends an hardware interrupt to Xenomai each an etch occurs in=20
the signal. This should be interpreted as an "interrupt start" and=20
"interrupt end" event for a level triggered interrupt.

- Xenomai does not interpret both events this way, but just counts each=20
event as single interrupt event. - When the "interrupt end" event does=20
not occur an the level stays low, Xenomai will step over rt_intr_wait()=20
for one time - and not again - although the level triggered interrupt is=20
still active.

My question is now wether I understood this behavior correctly - or=20
wether I am doing something wrong. I could work around that problem by=20
myself by just counting the interrupts - but that would not be very=20
satisfying.

I also read that there might be some way to work around that issue by=20
using rt_intr_enable() - if this is the case - how to do so?

Thanks a lot
Stephan Adler

--=20
Stephan Adler

imc Me=DFsysteme GmbH

