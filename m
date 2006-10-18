Subject: Re: [Xenomai-help] Adeos/Xenomai Arm Port
From: =?ISO-8859-1?Q?Schl=E4gl?= "Manfred jun." <manfred.schlaegl@domain.hid>
In-Reply-To: <1161099585.5024.48.camel@domain.hid>
References: <1161099585.5024.48.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Qq8l7grjYlH15VZLtZDX"
Date: Wed, 18 Oct 2006 09:52:34 +0200
Message-Id: <1161157955.5093.3.camel@domain.hid>
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


--=-Qq8l7grjYlH15VZLtZDX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 17:39 +0200, Schl=E4gl Manfred jun. wrote:

> 5. latency
>=20
> For periodic user-mode task i need very high periods > 1000us.
>=20
>=20
> Here are the latency-checks with printk's of the ioctls:
>=20
> -sh-3.00# ./run -- -t 1
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel periodic task
> =3D=3D All results in microseconds
> [42949519.180000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
> -ENOTTY(-25)
> latency: failed to start in-kernel timer benchmark, code -25
> [42949523.000000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
> -ENOTTY(-25)
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|-1096532.504|       0.001|      93.252|   93340|
> 00:00:03/00:00:03
>=20
> -sh-3.00# ./run -- -t 2
> *
> *
> * Type ^C to stop this application.
> *
> *
> =3D=3D Sampling period: 100 us
> =3D=3D Test mode: in-kernel timer handler
> =3D=3D All results in microseconds
> [42949529.090000] rt_tmbench_ioctl_rt: request 1076364816 -> ret =3D
> -ENOTTY(-25)
> latency: failed to start in-kernel timer benchmark, code -25
> [42949534.680000] rt_tmbench_ioctl_nrt: request -1071118831 -> ret =3D
> -ENOTTY(-25)
> ---|------------|------------|------------|--------|---------------------=
----
> RTS|-1093751.320|       0.001|      93.252|   93340|
> 00:00:04/00:00:04
>=20
>=20
> Userspace-codes differ from kernelspace-codes, I think...



Yes it does!!!



#define RTTST_RTIOC_TMBENCH_START \
    _IOW(RTIOC_TYPE_TESTING, 0x10, struct rttst_tmbench_config)=20

two different results in kernel-/user-space

sizeof(struct rttst_tmbench_config)=20
-> kernel 	32
-> user		40


typedef struct rttst_tmbench_config {
    int                     mode;
    uint64_t                period;
    int                     priority;
    int                     warmup_loops;
    int                     histogram_size;
    int                     histogram_bucketsize;
    int                     freeze_max;
} rttst_tmbench_config_t;

sizeof(struct rttst_tmbench_config_t)
-> kernel	32	(uses packed-structure)
-> user		40	(uses unpacked-structure)

sizeof(uint64_t)
-> kernel	8
-> user		8

sizeof(int)
-> kernel	4
-> user		4


Difference has something to do with the internal structure of
rttst_tmbench_config.


Solution 1: Force userspace-app and kernel to use packed structure
--------------
typedef struct rttst_tmbench_config {
    int                     mode;
    uint64_t                period;
    int                     priority;
    int                     warmup_loops;
    int                     histogram_size;
    int                     histogram_bucketsize;
    int                     freeze_max;
} __attribute__((packed)) rttst_tmbench_config_t;

sizeof(struct rttst_tmbench_config_t)
-> kernel	32	(uses packed-structure)
-> user		32	(uses packed-structure)

Has to be done to all structures! (compiler-flag -fpack-struct)

Problems:=20
 * problems with libs (see
http://gcc.gnu.org/ml/gcc-help/2005-01/msg00257.html)
 * possibly problems with typedef ????


Solution 2: Force userspace-app and kernel to use unpacked structure
--------------
typedef struct rttst_tmbench_config {
    int                     mode;
    uint64_t                period;
    int                     priority;
    int                     warmup_loops;
    int                     histogram_size;
    int                     histogram_bucketsize;
    int                     freeze_max;
} __attribute__((unpacked)) rttst_tmbench_config_t;


Kernel ignores the attribute!

Theoretically:
sizeof(struct rttst_tmbench_config_t)
-> kernel	40	(uses unpacked-structure)
-> user		40	(uses unpacked-structure)

Has to be done to all structures!=20




Solution 3:
--------------
change kernel-configuration to use unpacked structures by default.



	- Manfred Schlaegl


--=-Qq8l7grjYlH15VZLtZDX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBFNd1CbMvu5jIEpfsRAr4aAJ4tkWq6ZWChqb3QW6AEd8S21roTZQCeNu9O
yv7uDAdgjMuiAIhO9D6DWjM=
=Aw3x
-----END PGP SIGNATURE-----

--=-Qq8l7grjYlH15VZLtZDX--


