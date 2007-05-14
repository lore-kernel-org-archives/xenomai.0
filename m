Message-ID: <4648AC33.6090902@domain.hid>
Date: Mon, 14 May 2007 20:36:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46478F98.1040101@domain.hid> <4648A597.70600@domain.hid>
In-Reply-To: <4648A597.70600@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA40CADA9CB1747ED0E626F9E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Adeos-main] [BUG] pit clocksource broken under
 Xenomai
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA40CADA9CB1747ED0E626F9E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> just checked on real hardware (found in qemu originally):
>>
>> When Linux uses the pit clocksource AND Xenomai is attached, the syste=
m
>> time no longer makes progress. Observed under 2.6.20 with 1.7-03 and
>> newer patches, Xenomai trunk.
>>
>> I guess not many people will be affected by this and I'm lacking time =
to
>> debug, so I'm just dumping the report and running away...
>=20
> Somehow I hate open issues...
>=20
> I recalled some private thread with you, Philippe, about this particula=
r
> line in pid_read(). A look at it again revealed the reason for this bug=
=2E
>=20
> Jan
>=20
> PS: pending_patches++ ;)
>=20
>=20
> ---
>  arch/i386/kernel/i8253.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> Index: linux-2.6.20/arch/i386/kernel/i8253.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.20.orig/arch/i386/kernel/i8253.c
> +++ linux-2.6.20/arch/i386/kernel/i8253.c
> @@ -47,7 +47,8 @@ static cycle_t pit_read(void)
> =20
>  #ifdef CONFIG_IPIPE
>  	if (!__ipipe_pipeline_head_p(ipipe_root_domain))
> -		return 0;	/* We don't really own the PIT. */
> +		/* We don't own the PIT, fall back to jiffies. */
> +		return (cycle_t)(jiffies * LATCH);

I think even more correct would be

	return (cycle_t)(jiffies * LATCH) + (LATCH - 1) - old_count;

Should avoid the theoretical chance of a clock backward jump when
Xenomai attaches. I leave it up to the maintainer to decide. :)

Jan


--------------enigA40CADA9CB1747ED0E626F9E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGSKwzniDOoMHTA+kRAt/FAKCCnejjBw28Nbr0K/tYrYa8HBdl1wCfZhFm
Lhzda6KyyNGtog7Ax5CW2go=
=eQIX
-----END PGP SIGNATURE-----

--------------enigA40CADA9CB1747ED0E626F9E--

