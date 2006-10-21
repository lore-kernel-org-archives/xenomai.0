Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <1161174276.5093.22.camel@domain.hid>
References: <1161099585.5024.48.camel@domain.hid>
	<1161157955.5093.3.camel@domain.hid>  <4536038A.4000002@domain.hid>
	<1161174276.5093.22.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-gDDA/nej9bPEsQKEc6n2"
Date: Sat, 21 Oct 2006 16:56:09 +0200
Message-Id: <1161442569.5007.25.camel@domain.hid>
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


--=-gDDA/nej9bPEsQKEc6n2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-18 at 14:24 +0200, Schl=E4gl Manfred jun. wrote:
> On Wed, 2006-10-18 at 12:35 +0200, Jan Kiszka wrote:
>=20
> > I vote for solution 4:
> >=20
> > --- include/rtdm/rttesting.h    (revision 1731)
> > +++ include/rtdm/rttesting.h    (working copy)
> > @@ -85,8 +85,8 @@ typedef struct rttst_overall_bench_res {
> >=20
> >  typedef struct rttst_tmbench_config {
> >      int                     mode;
> > -    nanosecs_rel_t          period;
> >      int                     priority;
> > +    nanosecs_rel_t          period;
> >      int                     warmup_loops;
> >      int                     histogram_size;
> >      int                     histogram_bucketsize;
> >=20
> > Could you check if this helps?
> >=20
> > Thanks,
> > Jan
> >=20
>=20
>=20
> Thanks! It works. ioctls are working
>=20
> But there is another Problem: I've inserted debug messages
>=20
> // USER-PROCESS
> -sh-3.00# ./run -- -t 1 -p 10000 -T 5
> *
> *
> * Type ^C to stop this application.
> *
> *
> Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbenc=
h.ko
> =3D=3D Sampling period: 10000 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> LATENCY: display send RTTST_RTIOC_TMBENCH_START:
> mode    0
> periode 1
> pri     99
> warmup  1
> hist_s  0
> hist_bs 1000
> fmax    0
> DEBUG: rt_dev_ioctl: request: 1075840528
> warming up...
> DEBUG: rt_dev_ioctl: request: -1070594560
> RTT|  00:00:01  (in-kernel periodic task, 10000 us period, priority 99)
> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
> worst
> RTD|      29.369|      32.341|      35.879|       0|      29.369|
> 35.879
> DEBUG: rt_dev_ioctl: request: -1070594560
> RTD|      22.135|      32.381|      36.241|       0|      22.135|
> 36.241
> DEBUG: rt_dev_ioctl: request: -1070594560
> RTD|      21.050|      32.378|      37.326|       0|      21.050|
> 37.326
> DEBUG: rt_dev_ioctl: request: -1070594560
> DEBUG: rt_dev_ioctl: request: -1071118831
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|-1095770.696|       0.001|      93.660|   93748|
> 00:00:05/00:00:05
> -sh-3.00# =09
>=20
> // KERNEL-OUTPUT
>=20
> [42949410.980000] KERNEL: rt_tmbench_ioctl_nrt got request 1075840528
> [42949410.990000] KERNEL: rt_tmbench_ioctl_nrt got
> RTTST_RTIOC_TMBENCH_START:
> [42949411.020000] mode    0
> [42949411.020000] periode 10000000
> [42949411.030000] pri     99
> [42949411.040000] warmup  1
> [42949411.050000] hist_s  0
> [42949411.060000] hist_bs 1000
> [42949411.070000] fmax    0
> [42949411.080000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560
> [42949411.090000] rt_tmbench_ioctl_nrt: request
> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
> [42949411.120000] rt_tmbench_ioctl_rt -1070594560
> [42949413.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560
> [42949413.090000] rt_tmbench_ioctl_nrt: request
> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
> [42949413.120000] rt_tmbench_ioctl_rt -1070594560
> [42949414.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560
> [42949414.090000] rt_tmbench_ioctl_nrt: request
> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
> [42949414.120000] rt_tmbench_ioctl_rt -1070594560
> [42949415.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560
> [42949415.090000] rt_tmbench_ioctl_nrt: request
> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
> [42949415.120000] rt_tmbench_ioctl_rt -1070594560
> [42949415.290000] KERNEL: rt_tmbench_ioctl_nrt got request -1071118831
> [42949415.310000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
> -ENOTTY(-25)
>=20
>=20
>=20
> The RTTST_RTIOC_INTERM_BENCH_RES request is received by
> rt_tmbench_ioctl_nrt and rt_tmbench_ioctl_rt. Is this normal on arm?
> (on my x86 this happens only at the beginning of a test-run)
>=20
>=20
> Thank you
> 	Manfred Schlaegl
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


Like above i had a problem using RTTST_RTIOC_TMBENCH_STOP too.


typedef struct rttst_bench_res {
    long long               avg;
    long                    min;
    long                    max;
    long                    overruns;
    long                    test_loops;
} rttst_bench_res_t;

typedef struct rttst_overall_bench_res {
    struct rttst_bench_res  result;
    long                    *histogram_avg;
    long                    *histogram_min;
    long                    *histogram_max;
} rttst_overall_bench_res_t;



sizeof(struct rttst_bench_res):
Kernel	24
User	24

sizeof(struct rttst_overall_bench_res):
Kernel	36
User	40


I used this Patch:

typedef struct rttst_overall_bench_res {
    struct rttst_bench_res  result;
+   char                    __fill;	/* fill byte */
    long                    *histogram_avg;
    long                    *histogram_min;
    long                    *histogram_max;
} rttst_overall_bench_res_t;

sizeof(struct rttst_overall_bench_res):
Kernel	40
User	40




	- Manfred

--=-gDDA/nej9bPEsQKEc6n2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFOjUHbMvu5jIEpfsRArpTAJ96gLwlk4JSeKuxpMbHhPhh8xRQCQCfROiD
4slHjMubTdPgYEJjOi40fZc=
=o8Yq
-----END PGP SIGNATURE-----

--=-gDDA/nej9bPEsQKEc6n2--


