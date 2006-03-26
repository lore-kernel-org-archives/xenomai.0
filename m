Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Timer IRQ propagation
Date: Sun, 26 Mar 2006 13:19:46 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E004310B@EINT11.einet.ad.eivd.ch>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210D6B@EINT11.einet.ad.eivd.ch>
From: "ROSSIER Daniel" <Daniel.Rossier@domain.hid>
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>, xenomai@xenomai.org


Just to stimulate some discussions, I tried to bring some pieces of =
answers.


-----Original Message-----
From: xenomai-core-bounces@domain.hid on behalf of ROSSIER Daniel
Sent: Fri 3/24/2006 4:38 PM
To: xenomai@xenomai.org
Subject: [Xenomai-core] Timer IRQ propagation
=20
=20

Hi,

=20

We have some doubts about how the things work between i-pipe & xenomai =
regarding the timer.

=20

1-  First, when Xenomai is registered, the 10ms timer of Linux is stolen =
by the Xenomai domain. How

is the 10ms timer preserved? is it registered as a timer by the pod ?

=20
> Ok, silly question: the 10ms timer (or 1ms timer) is managed by Linux =
directly with its own list of timers; this doesn't affect Xenomai's =
timer list.


2-       When a timer IRQ is received, we understood that the IRQ is =
ack'd and masked by handle_irq() and sent to the domains through =
walk_pipeline() including Linux; but we have some doubts about that =
since the timer ISR of Linux first acknowledges the interrupt, and it =
seems that it acknowledges physically (hw ack); we expected that the =
acknowledgement would be a virtual ack in the Linux domain since the ack =
has been made previously by handle_irq(). In our case (ARM arch), the =
ack actually corresponds to a mask and therefore the timer IRQ is masked =
by Linux once it gets,  and we then suspect some loss of timer =
interrupts.

have we understood correctly the mechanism? Any idea about this =
behaviour? Is it normal?

=20
> Still unclear to me; the ack would be done in the timer ISR; however =
in the (ARM) patch we have, ipipe performs a hardware ack; I've seen in =
the x86 patch that adeos makes nothing within __ipipe_ack_system_irq(). =
I guess the last behaviour is correct, isn't it?


Thanks in advance

=20

Daniel

=20

=20

=20



