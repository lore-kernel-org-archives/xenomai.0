Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-g3Z6gjMOWbqYbk36sQ/J"
Date: Wed, 18 Oct 2006 17:16:10 +0200
Message-Id: <1161184570.5093.61.camel@domain.hid>
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


--=-g3Z6gjMOWbqYbk36sQ/J
Content-Type: multipart/mixed; boundary="=-c7BZNXAXl4DRqXdnlhMY"


--=-c7BZNXAXl4DRqXdnlhMY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



--=-c7BZNXAXl4DRqXdnlhMY
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Xenomai-help] Adeos/Xenomai
	Arm Port
Content-Type: message/rfc822

Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <45361870.7060005@domain.hid>
References: <1161099585.5024.48.camel@domain.hid>
	<1161167105.5053.34.camel@domain.hid>  <45361870.7060005@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-QaJE92zORxoqeKk2FHnC"
Date: Wed, 18 Oct 2006 17:15:09 +0200
Message-Id: <1161184509.5093.59.camel@domain.hid>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4


--=-QaJE92zORxoqeKk2FHnC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-10-18 at 14:05 +0200, Gilles Chanteperdrix wrote:

> Some ARMs do not boot when spinlock debugging is enabled, so it would be
> interesting to check if the error also occurs with I-pipe and Xenomai
> off.
>=20

You were right!

The kernel with active SPIN_DEBUG and without IPIPE doesn't boot (soft
lockup).

But very interresting: Kernel with SPIN_DEBUG and IPIPE seems to run
normally (with xenomai, but without xenomai apps).

Thanks


###########################################################################=
####

Again Latency:

-sh-3.00#  time ./run -- -t 1 -p 1000 -T 10=20
*
*
* Type ^C to stop this application.
*
*
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_native.=
ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbench.=
ko
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      11.680|      16.586|      36.126|       0|      11.680|
36.126
RTD|      11.182|      17.092|      43.947|       0|      11.182|
43.947
RTD|      11.521|      17.091|      65.411|       0|      11.182|
65.411
RTD|      11.981|      17.116|      63.388|       0|      11.182|
65.411
RTD|      11.919|      17.121|      66.767|       0|      11.182|
66.767
RTD|      12.354|      17.178|      42.996|       0|      11.182|
66.767
RTD|      11.884|      17.122|      66.315|       0|      11.182|
66.767
RTD|      11.849|      17.132|      65.287|       0|      11.182|
66.767
RTD|      11.578|      17.093|      66.824|       0|      11.182|
66.824
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1095668.296|       0.001|      93.252|   93340|
00:00:10/00:00:10

real    0m17.730s
user    0m0.840s
sys     0m5.000s
Time is running very slowly while running this test
0m17.730s on target, while 1m6 in reality


kernel-output while running latency:

[42949604.150000] I-pipe: Domain Xenomai registered.
[42949604.160000] Xenomai: hal/arm started.
[42949604.180000] Xenomai: real-time nucleus v2.2.3 (Memories) loaded.
[42949605.050000] Xenomai: starting native API services.
[42949605.860000] Xenomai: starting RTDM services.
[42949607.280000] rt_tmbench_ioctl_rt 1075840528
[42949607.280000] rt_tmbench_ioctl_rt: request
1075840528(RTTST_RTIOC_TMBENCH_START) -> ret =3D -ENOSYS(-38)
[42949607.320000] KERNEL: rt_tmbench_ioctl_nrt got
RTTST_RTIOC_TMBENCH_START:
[42949607.340000] mode    0
[42949607.350000] periode 1000000
[42949607.360000] pri     99
[42949607.370000] warmup  1
[42949607.370000] hist_s  0
[42949607.380000] hist_bs 1000
[42949607.390000] fmax    0
[42949607.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949607.410000] rt_tmbench_ioctl_rt -1070594560
[42949609.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949609.410000] rt_tmbench_ioctl_rt -1070594560
[42949610.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949610.410000] rt_tmbench_ioctl_rt -1070594560
[42949611.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949611.410000] rt_tmbench_ioctl_rt -1070594560
[42949612.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949612.410000] rt_tmbench_ioctl_rt -1070594560
[42949613.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949613.410000] rt_tmbench_ioctl_rt -1070594560
[42949614.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949614.410000] rt_tmbench_ioctl_rt -1070594560
[42949615.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949615.410000] rt_tmbench_ioctl_rt -1070594560
[42949616.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949616.410000] rt_tmbench_ioctl_rt -1070594560
[42949617.400000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[42949617.410000] rt_tmbench_ioctl_rt -1070594560
[42949618.250000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
-ENOTTY(-25)
[42949618.660000] Xenomai: stopping RTDM services.
[42949618.740000] Xenomai: stopping native API services.
[42949619.330000] I-pipe: Domain Xenomai unregistered.
[42949619.340000] Xenomai: hal/arm stopped.
[42949619.360000] Xenomai: real-time nucleus unloaded.


-sh-3.00#  time ./run -- -t 1 -T 10 -p 10000
*
*
* Type ^C to stop this application.
*
*
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_native.=
ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbench.=
ko
=3D=3D Sampling period: 10000 us
=3D=3D Test mode: in-kernel periodic task
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel periodic task, 10000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      21.774|      26.435|      34.151|       0|      21.774|
34.151
RTD|      19.050|      26.756|      39.418|       0|      19.050|
39.418
RTD|      19.774|      27.098|      39.938|       0|      19.050|
39.938
RTD|      18.666|      26.861|      38.344|       0|      18.666|
39.938
RTD|      18.282|      26.930|      37.621|       0|      18.282|
39.938
RTD|      19.468|      26.695|      39.599|       0|      18.282|
39.938
RTD|      15.501|      27.011|      38.604|       0|      15.501|
39.938
RTD|      16.270|      26.488|      37.790|       0|      15.501|
39.938
RTD|      17.400|      26.790|      39.621|       0|      15.501|
39.938
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1098666.568|       0.001|      93.252|   93340|
00:00:10/00:00:10

real    0m17.670s
user    0m0.860s
sys     0m5.180s
time is running normally with a periode of 10000

kernel output ... see above




-sh-3.00#  time ./run -- -t 2 -p 1000 -T 10=20
*
*
* Type ^C to stop this application.
*
*
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_native.=
ko
Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtdm.ko
Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerbench.=
ko
=3D=3D Sampling period: 1000 us
=3D=3D Test mode: in-kernel timer handler
=3D=3D All results in microseconds
warming up...
RTT|  00:00:01  (in-kernel timer handler, 1000 us period, priority 99)
RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---lat
worst
RTD|      -9.445|      -6.173|      -4.339|       0|      -9.445|
-4.339
RTD|      -9.445|      -6.169|      -4.349|       0|      -9.445|
-4.339
RTD|      -9.445|      -6.167|      -4.100|       0|      -9.445|
-4.100
RTD|      -9.445|      -6.172|      -3.943|       0|      -9.445|
-3.943
RTD|      -9.445|      -6.164|      -4.157|       0|      -9.445|
-3.943
RTD|      -9.445|      -6.162|      -4.316|       0|      -9.445|
-3.943
RTD|      -9.445|      -6.171|      -4.780|       0|      -9.445|
-3.943
RTD|      -9.445|      -6.170|      -4.078|       0|      -9.445|
-3.943
RTD|      -9.445|      -6.166|      -4.180|       0|      -9.445|
-3.943
---|------------|------------|------------|--------|-----------------------=
--
RTS|-1096483.400|       0.001|      93.252|   93340|
00:00:10/00:00:10

real    0m17.660s
user    0m0.880s
sys     0m5.150s
-sh-3.00#=20


kernel-output:

[ 1872.720000] Xenomai: hal/arm started.
[ 1872.740000] Xenomai: real-time nucleus v2.2.3 (Memories) loaded.
[ 1873.600000] Xenomai: starting native API services.
[ 1874.410000] Xenomai: starting RTDM services.
[ 1875.810000] rt_tmbench_ioctl_rt 1075840528
[ 1875.810000] rt_tmbench_ioctl_rt: request
1075840528(RTTST_RTIOC_TMBENCH_START) -> ret =3D -ENOSYS(-38)
[ 1875.860000] KERNEL: rt_tmbench_ioctl_nrt got
RTTST_RTIOC_TMBENCH_START:
[ 1875.880000] mode    1
[ 1875.880000] periode 1000000
[ 1875.890000] pri     99
[ 1875.900000] warmup  1
[ 1875.910000] hist_s  0
[ 1875.910000] hist_bs 1000
[ 1875.920000] fmax    0
[ 1875.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1875.960000] rt_tmbench_ioctl_rt -1070594560
[ 1877.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1877.960000] rt_tmbench_ioctl_rt -1070594560
[ 1878.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1878.960000] rt_tmbench_ioctl_rt -1070594560
[ 1879.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1879.960000] rt_tmbench_ioctl_rt -1070594560
[ 1880.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1880.960000] rt_tmbench_ioctl_rt -1070594560
[ 1881.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1881.960000] rt_tmbench_ioctl_rt -1070594560
[ 1882.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1882.960000] rt_tmbench_ioctl_rt -1070594560
[ 1883.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1883.960000] rt_tmbench_ioctl_rt -1070594560
[ 1884.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1884.960000] rt_tmbench_ioctl_rt -1070594560
[ 1885.930000] rt_tmbench_ioctl_nrt: request
-1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
[ 1885.960000] rt_tmbench_ioctl_rt -1070594560
[ 1886.790000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
-ENOTTY(-25)
[ 1887.190000] Xenomai: stopping RTDM services.
[ 1887.280000] Xenomai: stopping native API services.
[ 1887.860000] I-pipe: Domain Xenomai unregistered.
[ 1887.870000] Xenomai: hal/arm stopped.
[ 1887.890000] Xenomai: real-time nucleus unloaded.

time is running normally in this case





###########################################################################=
####


Another question relating ipipe:
My timer is running with 27648 ticks per jiffy using system-clock
divided by 64, but I'm able to simply use systemclock to get
1769472(27648*64) ticks per jiffy, so the timing-resolution gets finer.=20
What do you think about it?





Thanks
	Manfred Schlaegl

--=-QaJE92zORxoqeKk2FHnC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNkT7bMvu5jIEpfsRAgi/AJ9PP45rPfqXv6+6e9AO3rBgcxbJHQCeJAkW
1oKGUJqb5+pbL2HHRE0Niw4=
=LNZX
-----END PGP SIGNATURE-----

--=-QaJE92zORxoqeKk2FHnC--

--=-c7BZNXAXl4DRqXdnlhMY--

--=-g3Z6gjMOWbqYbk36sQ/J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNkU6bMvu5jIEpfsRAq4yAJwLP4ch6mMExP9ku2pZI7A0ltl2mgCfWxrA
3qSh7apmS03RskSKEmXoCcs=
=znJG
-----END PGP SIGNATURE-----

--=-g3Z6gjMOWbqYbk36sQ/J--


