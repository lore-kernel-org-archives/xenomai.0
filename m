Message-ID: <4450B2B8.1060800@domain.hid>
Date: Thu, 27 Apr 2006 14:02:00 +0200
From: Jan Kiszka <kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Latencies for the Freescale i.MX21/CSB535FS
References: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD6@domain.hid>
In-Reply-To: <FDBBB5CC70676540B3EF7CFE83FD94E0210DD6@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig12BF1A5765DACC72BE149013"
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

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig12BF1A5765DACC72BE149013
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

ROSSIER Daniel wrote:
>>
>> I'd say that the most efficient way to reduce those latencies would
>> require to first identify the source of the 40+ us spot observed with
>> the -t2 form on an idle system. For that, I'm convinced that porting t=
he
>> I-pipe tracer to ARM would be the best option, since this tool would b=
e
>> of great help there.
>>
> Thanks for the hint; we will spend some time on the tracer in the comin=
g days. We keep you informed.
>=20

Cool, tracing also for ARM!

>> This port basically requires 1) to code the mcount() routine supportin=
g
>> gcc's -pg option, 2) to solve early boot issues so that mcount() does
>> not attempt to trace anything while the memory environment has not bee=
n
>> fully set up. The rest is pretty generic.
>>

Regarding a mcount() implementation and other details, the original
tracer effort by Ingo Molnar may give useful hints (at least it did for m=
e):

http://people.redhat.com/mingo/latency-tracing-patches/

I remember the ARM part not being that simple as x86. I think this was
also due to lacking stack unwinding support on that arch.

Jan


--------------enig12BF1A5765DACC72BE149013
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEULK4ncNeS9Q0k+IRAuFvAKDbT869Ei1vWTe+GiGOldqr0Tn3DACfcZgz
K9QWc3YjQZyxc6vrn1hCkvc=
=FwgT
-----END PGP SIGNATURE-----

--------------enig12BF1A5765DACC72BE149013--

