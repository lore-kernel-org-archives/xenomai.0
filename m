Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <453647E6.2050307@domain.hid>
References: <1161184570.5093.61.camel@domain.hid>  <453647E6.2050307@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2OjaKUbPEJVS484UOsIh"
Date: Wed, 18 Oct 2006 17:56:06 +0200
Message-Id: <1161186966.5093.79.camel@domain.hid>
Mime-Version: 1.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>


--=-2OjaKUbPEJVS484UOsIh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> >=20
> > Again Latency:
> >=20
> > -sh-3.00#  time ./run -- -t 1 -p 1000 -T 10=20
> > *
> > *
> > * Type ^C to stop this application.
> > *
> > *
> > Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleus.=
ko
> > Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_nat=
ive.ko
> > Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.=
ko
> > Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbe=
nch.ko
> > =3D=3D Sampling period: 1000 us
> > =3D=3D Test mode: in-kernel periodic task
> > =3D=3D All results in microseconds
> > warming up...
> > RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
> > RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> > worst
> > RTD|      11.680|      16.586|      36.126|       0|      11.680|
> > 36.126
> > RTD|      11.182|      17.092|      43.947|       0|      11.182|
> > 43.947
> > RTD|      11.521|      17.091|      65.411|       0|      11.182|
> > 65.411
> > RTD|      11.981|      17.116|      63.388|       0|      11.182|
> > 65.411
> > RTD|      11.919|      17.121|      66.767|       0|      11.182|
> > 66.767
> > RTD|      12.354|      17.178|      42.996|       0|      11.182|
> > 66.767
> > RTD|      11.884|      17.122|      66.315|       0|      11.182|
> > 66.767
> > RTD|      11.849|      17.132|      65.287|       0|      11.182|
> > 66.767
> > RTD|      11.578|      17.093|      66.824|       0|      11.182|
> > 66.824
> > ---|------------|------------|------------|--------|-------------------=
------
> > RTS|-1095668.296|       0.001|      93.252|   93340|
> > 00:00:10/00:00:10
>=20
> Looks like you forgot to recompile the user space part after applying my
> patch. It changes the ABI between the driver and the test tool, so both
> sides have to be in sync.
>=20

User and Kernel-space are in sync, but i'm using xenomai-2.2.3:

typedef struct rttst_tmbench_config {
    int                     mode;
-   uint64_t                period;
    int                     priority;   =20
+   uint64_t                period;
    int                     warmup_loops;
    int                     histogram_size;
    int                     histogram_bucketsize;
    int                     freeze_max;
} rttst_tmbench_config_t;

RTTST_RTIOC_TMBENCH_START works

but every RTTST_RTIOC_INTERM_BENCH_RES is received by
rt_tmbench_ioctl_nrt (can't handle this request -> -ENOSYS) and
rt_tmbench_ioctl_rt. is this normal?

[42949607.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)

[42949607.410000] rt_tmbench_ioctl_rt -1070594560


I think i should download the latest working copy...

> >=20
> > real    0m17.730s
> > user    0m0.840s
> > sys     0m5.000s
> > Time is running very slowly while running this test
> > 0m17.730s on target, while 1m6 in reality
> >=20
>=20
> Sounds like Linux is not getting (enough) timer IRQs. Check
> /proc/interrupts for progress.
>=20

I know. That's the Problem. But why? ... Too short periode?=20
"It's sort of weird."
I'll try to check this tomorrow.=20


> Jan
>=20

Manfred

--=-2OjaKUbPEJVS484UOsIh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNk6UbMvu5jIEpfsRAnNJAJ9uBc2UbNTMjgOlCSPVTK38ovKpTgCgit0Q
olCG7y3ZFEtZddlRjnDNM6s=
=IEN/
-----END PGP SIGNATURE-----

--=-2OjaKUbPEJVS484UOsIh--


