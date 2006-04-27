Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [Xenomai-core] Latencies for the Freescale i.MX21/CSB535FS
Date: Thu, 27 Apr 2006 13:50:05 +0200
Message-ID: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD6@domain.hid>
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org



> -----Message d'origine-----
> De=A0: Philippe Gerum [mailto:rpm@xenomai.org]
> Envoy=E9=A0: mercredi, 26. avril 2006 10:41
> =C0=A0: ROSSIER Daniel
> Cc=A0: xenomai@xenomai.org
> Objet=A0: Re: [Xenomai-core] Latencies for the Freescale =
i.MX21/CSB535FS
>=20
> ROSSIER Daniel wrote:
> > Hi all,
> >
> >
> >
> > As promised, you can find the latency results (latency -t0/-t1/-t2) =
as
> > well as the
> >
> > stats from the switch utility for the performance of our Xenomai =
port
> > onto the i.MX21 board.
> >
> >
> >
> > These are fesh results J and we didn't have time to analyze them =
yet.
> >
> >
> >
> > Thanks for any feedback...
>=20
> The tests have not been run long enough under load to get a reliable
> measure of the real worst-case figures, but still, the data sets seem
> consistent.

Ok; we will then make further test.

>=20
> - the test run of latency -t2 (in-kernel timer handler) shows =
equivalent
> worst-case figures than the -t1 form (in-kernel thread), which means
> that most of the latency hit is taken at the Adeos level, i.e. =
in-kernel
> scheduling adds little in the picture. Room for improvement is =
primarily
> hiding somewhere in the Adeos layer, I think.
>=20

ok; we still have to investigate all the call paths at the Adeos layer =
before the timer reprogramming.

> - comparing the min latency observed in the -t1 and -t2 forms, it =
looks
> like the inherent cost of traversing the rescheduling path would be
> close to ~10 us.
>=20
> - comparing the min latency observed in the -t0 and -t1 forms, there =
is
> another 10+ us consumed in switching mm contexts, and paying the
> involved cache penalties. The way to measure the level of perturbation
> Linux adds by switching its own tasks is to write a simple kernel =
module
> embodying a Xenomai thread that keeps the CPU busy while the =
performance
>   test is running at a higher priority.
>=20
> I'd say that the most efficient way to reduce those latencies would
> require to first identify the source of the 40+ us spot observed with
> the -t2 form on an idle system. For that, I'm convinced that porting =
the
> I-pipe tracer to ARM would be the best option, since this tool would =
be
> of great help there.
>=20
Thanks for the hint; we will spend some time on the tracer in the coming =
days. We keep you informed.

> This port basically requires 1) to code the mcount() routine =
supporting
> gcc's -pg option, 2) to solve early boot issues so that mcount() does
> not attempt to trace anything while the memory environment has not =
been
> fully set up. The rest is pretty generic.
>=20
> --
>=20
> Philippe.

Daniel

