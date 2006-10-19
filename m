Message-ID: <4537129B.1040506@domain.hid>
Date: Thu, 19 Oct 2006 07:52:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161184570.5093.61.camel@domain.hid> <453647E6.2050307@domain.hid>
	<1161186966.5093.79.camel@domain.hid>
In-Reply-To: <1161186966.5093.79.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig75572C403C4213DD245F590F"
Sender: jan.kiszka@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: =?ISO-8859-1?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig75572C403C4213DD245F590F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
>>> Again Latency:
>>>
>>> -sh-3.00#  time ./run -- -t 1 -p 1000 -T 10=20
>>> *
>>> *
>>> * Type ^C to stop this application.
>>> *
>>> *
>>> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/nucleus/xeno_nucleu=
s.ko
>>> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/native/xeno_n=
ative.ko
>>> Using /lib/modules/2.6.15.7/kernel/kernel/xenomai/skins/rtdm/xeno_rtd=
m.ko
>>> Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timer=
bench.ko
>>> =3D=3D Sampling period: 1000 us
>>> =3D=3D Test mode: in-kernel periodic task
>>> =3D=3D All results in microseconds
>>> warming up...
>>> RTT|  00:00:01  (in-kernel periodic task, 1000 us period, priority 99=
)
>>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---l=
at
>>> worst
>>> RTD|      11.680|      16.586|      36.126|       0|      11.680|
>>> 36.126
>>> RTD|      11.182|      17.092|      43.947|       0|      11.182|
>>> 43.947
>>> RTD|      11.521|      17.091|      65.411|       0|      11.182|
>>> 65.411
>>> RTD|      11.981|      17.116|      63.388|       0|      11.182|
>>> 65.411
>>> RTD|      11.919|      17.121|      66.767|       0|      11.182|
>>> 66.767
>>> RTD|      12.354|      17.178|      42.996|       0|      11.182|
>>> 66.767
>>> RTD|      11.884|      17.122|      66.315|       0|      11.182|
>>> 66.767
>>> RTD|      11.849|      17.132|      65.287|       0|      11.182|
>>> 66.767
>>> RTD|      11.578|      17.093|      66.824|       0|      11.182|
>>> 66.824
>>> ---|------------|------------|------------|--------|-----------------=
--------
>>> RTS|-1095668.296|       0.001|      93.252|   93340|
>>> 00:00:10/00:00:10
>> Looks like you forgot to recompile the user space part after applying =
my
>> patch. It changes the ABI between the driver and the test tool, so bot=
h
>> sides have to be in sync.
>>
>=20
> User and Kernel-space are in sync, but i'm using xenomai-2.2.3:
>=20
> typedef struct rttst_tmbench_config {
>     int                     mode;
> -   uint64_t                period;
>     int                     priority;   =20
> +   uint64_t                period;
>     int                     warmup_loops;
>     int                     histogram_size;
>     int                     histogram_bucketsize;
>     int                     freeze_max;
> } rttst_tmbench_config_t;
>=20
> RTTST_RTIOC_TMBENCH_START works
>=20
> but every RTTST_RTIOC_INTERM_BENCH_RES is received by
> rt_tmbench_ioctl_nrt (can't handle this request -> -ENOSYS) and
> rt_tmbench_ioctl_rt. is this normal?

Yes, it is. After each of these real-time-requiring services comes a
printf in the display task of latency. So the task is switch to
secondary mode again and the next RTTST_RTIOC_INTERM_BENCH_RES has to
switch it back.

Maybe the broken output of the latency test summary correlates to the
timer issue, maybe there is just a problem in the data transfer from the
driver to the user space application.

Jan



--------------enig75572C403C4213DD245F590F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFNxKbniDOoMHTA+kRAvWmAJ9z2NK9NWpI362f83izyfDsKs+VtQCeISgG
DlyIrylZHQOxbs6nJdp1pJs=
=lb3I
-----END PGP SIGNATURE-----

--------------enig75572C403C4213DD245F590F--

