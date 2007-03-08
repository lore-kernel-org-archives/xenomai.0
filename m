Subject: Re: [Xenomai-core] xenomai preempting interrupt handler ?
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <45EFE384.1070602@domain.hid>
References: <45EFD796.7050002@domain.hid>
	<1173346938.17515.16.camel@domain.hid>  <45EFE089.9000508@domain.hid>
	<1173349157.17515.19.camel@domain.hid>  <45EFE384.1070602@domain.hid>
Content-Type: text/plain; charset="iso-8859-1"
Date: Thu, 08 Mar 2007 11:28:54 +0100
Message-Id: <1173349735.17515.22.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Steven Scholz <steven.scholz@domain.hid>
Cc: Xenomai-core@domain.hid

On Thu, 2007-03-08 at 11:20 +0100, Steven Scholz wrote:
> Philippe Gerum wrote:
> > On Thu, 2007-03-08 at 11:08 +0100, Steven Scholz wrote:
> >> Philippe,
> >>
> >>>> using an oscilloscope I found that the AT91RM9200 spends up to 300=
=B5s in the
> >>>> interrupt handler for ethernet controller.
> >>>>
> >>>> Now I wonder if this interrupt handler will be preempted by Xenomai =
if there
> >>>> is a high priority, periodic real time task?
> >>> Hw interrupts are forcibly enabled before entering any Linux IRQ
> >>> handler, exactely to prevent the issue you described (e.g. fiddling w=
ith
> >>> an IDE controller in PIO mode also gives funky latency results unless
> >>> the latter is true), so the answer is yes.
> >> Thanks.
> >>
> >>>>  Thus will the duration of the
> >>>> ethernet interrupt handler add the the worst case latency?
> >>> Not from Linux IRQ handlers; you may want to check this using the
> >>> tracer. If hw interrupts are masked there, then it's a blatant bug.
> >> How could I check this using the tracer? Small hint please?
> >=20
> > http://www.xenomai.org/index.php/I-pipe:Tracer
>=20
> I know this. But I was asking how I could use it to check the above probl=
em.
>=20
> Is "Trace IRQs-off times CONFIG_IPIPE_TRACE_IRQSOFF ... Instrument each
> disable and re-enable of hardware IRQs. This allows to identify the longe=
st
> path in a system with IRQs disabled." the important stuff?

Yes. If the "IRQ off" marker appears when running the Linux ethernet IRQ
handler, then we have a problem.

>=20
> --
> Steven
--=20
Philippe.



