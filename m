Message-ID: <4536038A.4000002@domain.hid>
Date: Wed, 18 Oct 2006 12:35:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
References: <1161099585.5024.48.camel@domain.hid>
	<1161157955.5093.3.camel@domain.hid>
In-Reply-To: <1161157955.5093.3.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5222E9E430FF2BCD9F72D11F"
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
To: =?ISO-8859-15?Q?=22Schl=E4gl_=5C=22Manfred_jun=2E=5C=22=22?= <manfred.schlaegl@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5222E9E430FF2BCD9F72D11F
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Schl=E4gl Manfred jun. wrote:
> On Tue, 2006-10-17 at 17:39 +0200, Schl=E4gl Manfred jun. wrote:
>=20
>> 5. latency
>>
>> For periodic user-mode task i need very high periods > 1000us.
>>
>>
>> Here are the latency-checks with printk's of the ioctls:
>>
>> -sh-3.00# ./run -- -t 1
>> *
>> *
>> * Type ^C to stop this application.
>> *
>> *
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: in-kernel periodic task
>> =3D=3D All results in microseconds
>> [42949519.180000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
>> -ENOTTY(-25)
>> latency: failed to start in-kernel timer benchmark, code -25
>> [42949523.000000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D=

>> -ENOTTY(-25)
>> ---|------------|------------|------------|--------|------------------=
-------
>> RTS|-1096532.504|       0.001|      93.252|   93340|
>> 00:00:03/00:00:03
>>
>> -sh-3.00# ./run -- -t 2
>> *
>> *
>> * Type ^C to stop this application.
>> *
>> *
>> =3D=3D Sampling period: 100 us
>> =3D=3D Test mode: in-kernel timer handler
>> =3D=3D All results in microseconds
>> [42949529.090000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
>> -ENOTTY(-25)
>> latency: failed to start in-kernel timer benchmark, code -25
>> [42949534.680000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D=

>> -ENOTTY(-25)
>> ---|------------|------------|------------|--------|------------------=
-------
>> RTS|-1093751.320|       0.001|      93.252|   93340|
>> 00:00:04/00:00:04
>>
>>
>> Userspace-codes differ from kernelspace-codes, I think...
>=20
>=20
>=20
> Yes it does!!!
>=20
>=20
>=20
> #define RTTST_RTIOC_TMBENCH_START \
>     _IOW(RTIOC_TYPE_TESTING, 0x10, struct rttst_tmbench_config)=20
>=20
> two different results in kernel-/user-space
>=20
> sizeof(struct rttst_tmbench_config)=20
> -> kernel 	32
> -> user		40
>=20
>=20
> typedef struct rttst_tmbench_config {
>     int                     mode;
>     uint64_t                period;
>     int                     priority;
>     int                     warmup_loops;
>     int                     histogram_size;
>     int                     histogram_bucketsize;
>     int                     freeze_max;
> } rttst_tmbench_config_t;
>=20
> sizeof(struct rttst_tmbench_config_t)
> -> kernel	32	(uses packed-structure)
> -> user		40	(uses unpacked-structure)
>=20
> sizeof(uint64_t)
> -> kernel	8
> -> user		8
>=20
> sizeof(int)
> -> kernel	4
> -> user		4
>=20
>=20
> Difference has something to do with the internal structure of
> rttst_tmbench_config.
>=20
>=20
> Solution 1: Force userspace-app and kernel to use packed structure
> --------------
> typedef struct rttst_tmbench_config {
>     int                     mode;
>     uint64_t                period;
>     int                     priority;
>     int                     warmup_loops;
>     int                     histogram_size;
>     int                     histogram_bucketsize;
>     int                     freeze_max;
> } __attribute__((packed)) rttst_tmbench_config_t;
>=20
> sizeof(struct rttst_tmbench_config_t)
> -> kernel	32	(uses packed-structure)
> -> user		32	(uses packed-structure)
>=20
> Has to be done to all structures! (compiler-flag -fpack-struct)
>=20
> Problems:=20
>  * problems with libs (see
> http://gcc.gnu.org/ml/gcc-help/2005-01/msg00257.html)
>  * possibly problems with typedef ????
>=20
>=20
> Solution 2: Force userspace-app and kernel to use unpacked structure
> --------------
> typedef struct rttst_tmbench_config {
>     int                     mode;
>     uint64_t                period;
>     int                     priority;
>     int                     warmup_loops;
>     int                     histogram_size;
>     int                     histogram_bucketsize;
>     int                     freeze_max;
> } __attribute__((unpacked)) rttst_tmbench_config_t;
>=20
>=20
> Kernel ignores the attribute!
>=20
> Theoretically:
> sizeof(struct rttst_tmbench_config_t)
> -> kernel	40	(uses unpacked-structure)
> -> user		40	(uses unpacked-structure)
>=20
> Has to be done to all structures!=20
>=20
>=20
>=20
>=20
> Solution 3:
> --------------
> change kernel-configuration to use unpacked structures by default.
>=20

I vote for solution 4:

--- include/rtdm/rttesting.h    (revision 1731)
+++ include/rtdm/rttesting.h    (working copy)
@@ -85,8 +85,8 @@ typedef struct rttst_overall_bench_res {

 typedef struct rttst_tmbench_config {
     int                     mode;
-    nanosecs_rel_t          period;
     int                     priority;
+    nanosecs_rel_t          period;
     int                     warmup_loops;
     int                     histogram_size;
     int                     histogram_bucketsize;

Could you check if this helps?

Thanks,
Jan


--------------enig5222E9E430FF2BCD9F72D11F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFNgOKniDOoMHTA+kRAqVVAJ0aF+AGXXphj+9w2klfokh9i9SgKgCcDr6D
bEAFWXk6NnUvlLvl31KFCPs=
=V+BL
-----END PGP SIGNATURE-----

--------------enig5222E9E430FF2BCD9F72D11F--

