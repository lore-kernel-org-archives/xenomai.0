Message-ID: <444F3201.2080302@domain.hid>
Date: Wed, 26 Apr 2006 10:40:33 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Latencies for the Freescale i.MX21/CSB535FS
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD0@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD0@domain.hid>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: ROSSIER Daniel <Daniel.Rossier@domain.hid>
Cc: xenomai@xenomai.org

ROSSIER Daniel wrote:
> Hi all,
>=20
> =20
>=20
> As promised, you can find the latency results (latency =96t0/-t1/-t2) a=
s=20
> well as the
>=20
> stats from the switch utility for the performance of our Xenomai port=20
> onto the i.MX21 board.
>=20
> =20
>=20
> These are fesh results J and we didn't have time to analyze them yet.
>=20
> =20
>=20
> Thanks for any feedback=85

The tests have not been run long enough under load to get a reliable=20
measure of the real worst-case figures, but still, the data sets seem=20
consistent.

- the test run of latency -t2 (in-kernel timer handler) shows equivalent=20
worst-case figures than the -t1 form (in-kernel thread), which means=20
that most of the latency hit is taken at the Adeos level, i.e. in-kernel=20
scheduling adds little in the picture. Room for improvement is primarily=20
hiding somewhere in the Adeos layer, I think.

- comparing the min latency observed in the -t1 and -t2 forms, it looks=20
like the inherent cost of traversing the rescheduling path would be=20
close to ~10 us.

- comparing the min latency observed in the -t0 and -t1 forms, there is=20
another 10+ us consumed in switching mm contexts, and paying the=20
involved cache penalties. The way to measure the level of perturbation=20
Linux adds by switching its own tasks is to write a simple kernel module=20
embodying a Xenomai thread that keeps the CPU busy while the performance=20
  test is running at a higher priority.

I'd say that the most efficient way to reduce those latencies would=20
require to first identify the source of the 40+ us spot observed with=20
the -t2 form on an idle system. For that, I'm convinced that porting the=20
I-pipe tracer to ARM would be the best option, since this tool would be=20
of great help there.

This port basically requires 1) to code the mcount() routine supporting=20
gcc's -pg option, 2) to solve early boot issues so that mcount() does=20
not attempt to trace anything while the memory environment has not been=20
fully set up. The rest is pretty generic.

--=20

Philippe.

