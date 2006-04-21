Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE : RE : [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
Date: Fri, 21 Apr 2006 10:44:58 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0043160@domain.hid>
References: <FDBBB5CC70676540B3EF7CFE83FD94E0043151@domain.hid>	<44478FFE.2050608@domain.hid>
	<4447AA62.6080506@domain.hid>
	<FDBBB5CC70676540B3EF7CFE83FD94E0043154@domain.hid>
	<44488A37.80700@domain.hid>
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org


Yes indeed; we actually intend to implement some interaction protocols =
between
the processor and an FPGA as realtime tasks for cryptographic =
operations. We
therefore try to have some minimal overhead.
Right now, we focus on the iMX21 proc. and since we're bound to some =
industrial projects,
we won't have much time to have a look at other archs, although we are, =
of course, very
interested in getting some feedback on other archs and we're ready to =
provide some help as much as we can.
We stay in touch :-) (i look forward to having further details about =
your micro-optimisation
approach in the user space; at the moment, we mainly work RT tasks in =
the kernel space for architectural reasons,
but migrating the code to a more convenient execution environment in the =
user space definitively retains our attention).

By the way, I have a student who will work on an extension of LTTng =
(Linux trace toolkit) in order to support Xenomai, in the context of his =
diploma work. Examining the RT traces, filtering events, tracking RT =
activities in user/kernel space, detecting priority inversions, etc. are =
some interesting topics we're promoting in our Institute. Any =
ideas/suggestions about features and extensions to improve such =
visualization tools are also welcome :-) (we will publish everything as =
soon as we have some substantial results, but the student work is mainly =
on the second half of the Year at Montreal to the originator's =
premises).

Daniel


-------- Message d'origine--------
De: Jan Kiszka [mailto:jan.kiszka@domain.hid]
Date: ven. 21.04.2006 09:31
=C0: ROSSIER Daniel
Cc: rtai@domain.hid; xenomai@xenomai.org
Objet : Re: RE : [Xenomai-core] Xenomai on Freescale i.MX21 (ARM926J)
=20
ROSSIER Daniel wrote:
> Hi Marco,
>=20
> Two of our soft/hard engineers (S=E9bastien Gerber & Guillaume
> Boutillier) have worked quite a lot over these last 6 months for this
> port.
> These last weeks, they spent much work on measuring the response time
> (by means of a digital analyzer) and trying to move some piece of
> code and re-work out a bit the current patch in order to make the IRQ
> virtualization as clean as possible and to get very low latency.
> Thanks to them :-)
>=20

I guess this significant effort was related to the fact that you were
hunting nanoseconds, aren't you? Well, that's great! Can we hire you for
other archs as well? ;) [I also have some weird ideas regarding
micro-optimisations of the user space interface.]

Jan




