Message-ID: <453A4E5C.3020606@domain.hid>
Date: Sat, 21 Oct 2006 18:44:12 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161099585.5024.48.camel@domain.hid>	<1161157955.5093.3.camel@domain.hid>
	<4536038A.4000002@domain.hid>	<1161174276.5093.22.camel@domain.hid>
	<1161442569.5007.25.camel@domain.hid>
In-Reply-To: <1161442569.5007.25.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE0A3F94816BBF5176123547D"
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
--------------enigE0A3F94816BBF5176123547D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
> On Wed, 2006-10-18 at 14:24 +0200, Schl=E4gl Manfred jun. wrote:
>> On Wed, 2006-10-18 at 12:35 +0200, Jan Kiszka wrote:
>>
>>> I vote for solution 4:
>>>
>>> --- include/rtdm/rttesting.h    (revision 1731)
>>> +++ include/rtdm/rttesting.h    (working copy)
>>> @@ -85,8 +85,8 @@ typedef struct rttst_overall_bench_res {
>>>
>>>  typedef struct rttst_tmbench_config {
>>>      int                     mode;
>>> -    nanosecs_rel_t          period;
>>>      int                     priority;
>>> +    nanosecs_rel_t          period;
>>>      int                     warmup_loops;
>>>      int                     histogram_size;
>>>      int                     histogram_bucketsize;
>>>
>>> Could you check if this helps?
>>>
>>> Thanks,
>>> Jan
>>>
>>
>> Thanks! It works. ioctls are working
>>
>> But there is another Problem: I've inserted debug messages
>>
>> // USER-PROCESS
>> -sh-3.00# ./run -- -t 1 -p 10000 -T 5
>> *
>> *
>> * Type ^C to stop this application.
>> *
>> *
>> Using /lib/modules/2.6.15.7/kernel/drivers/xenomai/testing/xeno_timerb=
ench.ko
>> =3D=3D Sampling period: 10000 us
>> =3D=3D Test mode: in-kernel periodic task
>> =3D=3D All results in microseconds
>> LATENCY: display send RTTST_RTIOC_TMBENCH_START:
>> mode    0
>> periode 1
>> pri     99
>> warmup  1
>> hist_s  0
>> hist_bs 1000
>> fmax    0
>> DEBUG: rt_dev_ioctl: request: 1075840528
>> warming up...
>> DEBUG: rt_dev_ioctl: request: -1070594560
>> RTT|  00:00:01  (in-kernel periodic task, 10000 us period, priority 99=
)
>> RTH|-----lat min|-----lat avg|-----lat max|-overrun|----lat best|---la=
t
>> worst
>> RTD|      29.369|      32.341|      35.879|       0|      29.369|
>> 35.879
>> DEBUG: rt_dev_ioctl: request: -1070594560
>> RTD|      22.135|      32.381|      36.241|       0|      22.135|
>> 36.241
>> DEBUG: rt_dev_ioctl: request: -1070594560
>> RTD|      21.050|      32.378|      37.326|       0|      21.050|
>> 37.326
>> DEBUG: rt_dev_ioctl: request: -1070594560
>> DEBUG: rt_dev_ioctl: request: -1071118831
>> ---|------------|------------|------------|--------|------------------=
-------
>> RTS|-1095770.696|       0.001|      93.660|   93748|
>> 00:00:05/00:00:05
>> -sh-3.00# =09
>>
>> // KERNEL-OUTPUT
>>
>> [42949410.980000] KERNEL: rt_tmbench_ioctl_nrt got request 1075840528
>> [42949410.990000] KERNEL: rt_tmbench_ioctl_nrt got
>> RTTST_RTIOC_TMBENCH_START:
>> [42949411.020000] mode    0
>> [42949411.020000] periode 10000000
>> [42949411.030000] pri     99
>> [42949411.040000] warmup  1
>> [42949411.050000] hist_s  0
>> [42949411.060000] hist_bs 1000
>> [42949411.070000] fmax    0
>> [42949411.080000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560=

>> [42949411.090000] rt_tmbench_ioctl_nrt: request
>> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
>> [42949411.120000] rt_tmbench_ioctl_rt -1070594560
>> [42949413.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560=

>> [42949413.090000] rt_tmbench_ioctl_nrt: request
>> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
>> [42949413.120000] rt_tmbench_ioctl_rt -1070594560
>> [42949414.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560=

>> [42949414.090000] rt_tmbench_ioctl_nrt: request
>> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
>> [42949414.120000] rt_tmbench_ioctl_rt -1070594560
>> [42949415.070000] KERNEL: rt_tmbench_ioctl_nrt got request -1070594560=

>> [42949415.090000] rt_tmbench_ioctl_nrt: request
>> -1070594560(RTTST_RTIOC_INTERM_BENCH_RES) -> ret =3D -ENOSYS(-38)
>> [42949415.120000] rt_tmbench_ioctl_rt -1070594560
>> [42949415.290000] KERNEL: rt_tmbench_ioctl_nrt got request -1071118831=

>> [42949415.310000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D=

>> -ENOTTY(-25)
>>
>>
>>
>> The RTTST_RTIOC_INTERM_BENCH_RES request is received by
>> rt_tmbench_ioctl_nrt and rt_tmbench_ioctl_rt. Is this normal on arm?
>> (on my x86 this happens only at the beginning of a test-run)
>>
>>
>> Thank you
>> 	Manfred Schlaegl
>>
>>
>> _______________________________________________
>> Xenomai-help mailing list
>> Xenomai-help@domain.hid
>> https://mail.gna.org/listinfo/xenomai-help
>=20
>=20
> Like above i had a problem using RTTST_RTIOC_TMBENCH_STOP too.
>=20
>=20
> typedef struct rttst_bench_res {
>     long long               avg;
>     long                    min;
>     long                    max;
>     long                    overruns;
>     long                    test_loops;
> } rttst_bench_res_t;
>=20
> typedef struct rttst_overall_bench_res {
>     struct rttst_bench_res  result;
>     long                    *histogram_avg;
>     long                    *histogram_min;
>     long                    *histogram_max;
> } rttst_overall_bench_res_t;
>=20
>=20
>=20
> sizeof(struct rttst_bench_res):
> Kernel	24
> User	24
>=20
> sizeof(struct rttst_overall_bench_res):
> Kernel	36
> User	40
>=20
>=20
> I used this Patch:
>=20
> typedef struct rttst_overall_bench_res {
>     struct rttst_bench_res  result;
> +   char                    __fill;	/* fill byte */
>     long                    *histogram_avg;
>     long                    *histogram_min;
>     long                    *histogram_max;
> } rttst_overall_bench_res_t;
>=20
> sizeof(struct rttst_overall_bench_res):
> Kernel	40
> User	40
>=20

Damn it. What alignment of the compiler is behind this? Fill up to
multiples of X bytes, ok. But how to find out what X is on some
platform? Anyone any hint on this?

Thanks for tracking down.

Jan


--------------enigE0A3F94816BBF5176123547D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFOk5cniDOoMHTA+kRAiMPAJwIxGVpQluThGwz/QrYX3rTXjpLagCcDPQT
+keISaHNHx79/D3RzVf1tD8=
=Xok+
-----END PGP SIGNATURE-----

--------------enigE0A3F94816BBF5176123547D--

