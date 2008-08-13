Message-ID: <48A2BEF7.20707@domain.hid>
Date: Wed, 13 Aug 2008 13:01:11 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48733483.2050204@domain.hid>
	<200807091719.17625@domain.hid>	<4874E1D8.6020307@domain.hid>
	<200807111518.16150@domain.hid>	<200807151642.18829@domain.hid>
	<487CBC4A.5050309@domain.hid>	<200807161039.8828@domain.hid>
	<487F1D25.5080508@domain.hid>	<200807211258.30164@domain.hid>
	<48847272.3080605@domain.hid>
In-Reply-To: <48847272.3080605@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1C0A079257338349FCC10FF6"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH] Fix stat overruns on 64-bit (was:
 [Xenomai-help] Kernel panic: not syncing)
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1C0A079257338349FCC10FF6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Petr Cervenka wrote:
>> I ran a test during last weekend (and nothing wrong happened). But the=
 /proc/xenomai/stat output is strange. Probably some type cast error, bec=
ause 18446744071739514846 =3D 0xFFFFFFFF8A939FDE and the appropriate valu=
e perhaps should be 0x000000008A939FDE =3D 2324930526.
>>
>> CPU  PID    MSW        CSW        PF    STAT       %CPU  NAME
>>   0  0      0          18446744071739514846 0     00500088   69.8  ROO=
T/0
>>   1  0      0          18446744071675175740 0     00500080   23.2  ROO=
T/1
>>   0  5299   0          351459     0     00300182    0.0  LOGGER_TASK_1=
804289383
>>   0  5100   8          283613     0     00300186    0.0
>>   0  5317   0          40591      0     00300182    0.0
>>   0  5034   2          2330696    0     00300184    0.0  MAIN_TASK_205=
6
>>   0  5318   5          18446744071736105613 3     00300180   29.5  REG=
_TASK_2056
>>   0  5319   28         36         0     00300182    0.0  WORK_TASK_205=
6
>>   0  5321   38926      39159      0     00300380    0.0  CERECV_2056
>>   0  5323   1159385    2438330    0     00300181    0.0  CESEND_2056
>>   1  5710   0          18446744071675175740 0     00300184   76.8  HAR=
DWARE_KERNEL
>>   0  0      0          18446744071964064315 0     00000000    0.7  IRQ=
520: [timer]
>>   1  0      0          232145209  0     00000000    0.0  IRQ520: [time=
r]=20
>=20
> OK, at least this bug is a bit easier to fix. Please try this patch
> (which also takes the chance and extends the range of our stat counters=

> a bit):
>=20
> Index: xenomai/include/nucleus/stat.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- xenomai/include/nucleus/stat.h	(Revision 4060)
> +++ xenomai/include/nucleus/stat.h	(Arbeitskopie)
> @@ -84,20 +84,20 @@ do { \
> =20
> =20
>  typedef struct xnstat_counter {
> -	int counter;
> +	unsigned long counter;
>  } xnstat_counter_t;
> =20
> -static inline int xnstat_counter_inc(xnstat_counter_t *c)
> +static inline unsigned long xnstat_counter_inc(xnstat_counter_t *c)
>  {
>  	return c->counter++;
>  }
> =20
> -static inline int xnstat_counter_get(xnstat_counter_t *c)
> +static inline unsigned long xnstat_counter_get(xnstat_counter_t *c)
>  {
>  	return c->counter;
>  }
> =20
> -static inline void xnstat_counter_set(xnstat_counter_t *c, int value)
> +static inline void xnstat_counter_set(xnstat_counter_t *c, unsigned lo=
ng value)
>  {
>  	c->counter =3D value;
>  }

OK to apply those bits?

Jan


--------------enig1C0A079257338349FCC10FF6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkiivvcACgkQniDOoMHTA+kDxACdEgaVcMN9pHx0TjdxirkQ0yHO
yFgAmwYY9EcPi+3UDNbzt5hTiNMjKKmU
=P7Dp
-----END PGP SIGNATURE-----

--------------enig1C0A079257338349FCC10FF6--

