From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>
References: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 Aug 2009 11:41:54 +0200
Message-Id: <1250242914.3019.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] rt_mutex_acquire returns -3
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "Hans =?ISO-8859-1?Q?S=F8ndergaard?= (HSO)" <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Fri, 2009-08-14 at 09:31 +0200, Hans S=C3=B8ndergaard (HSO) wrote:
> I use objects of type:
>=20
> =20
>=20
> typedef struct object {
>=20
>   RT_MUTEX *rt_lock;
>=20
>   ..
>=20
> } Object;
>=20
> =20
>=20
> int err =3D rt_mutex_create (ob->rt_lock, NULL);
>=20
> printf ("[alloc.c]: rt_mutex_create err: %d; #%d \n", err, __LINE__);
>=20
> =20
>=20
> err =3D rt_mutex_acquire (ob->rt_lock, TM_INFINITE);
>=20
> printf ("[lock.c]: rt_mutex_acquire, err: %d; #%d \n", err, __LINE__);
>=20
> =20
>=20
> On creation, rt_mutex_create returns 0 (as expected).
>=20
> On acquiring, rt_mutex_acquire returns -3,
>=20

-ESRCH. This means that for some reason, the internal handle copied by
rt_mutex_create() to ob->rt_lock could not be found back in the system
registry when calling rt_mutex_acquire().

Any chance ob->rt_lock may have been overwritten, or this mutex deleted
by another thread in the meantime?

In userland, RT_MUTEX is a structure containing an opaque long integer
value. Maybe you could check that value (printf("%ld",
ob->rt_lock.opaque)) right after rt_mutex_create() returns, and just
before rt_mutex_acquire() is invoked.

> but this return value is not included among the possible return values
> in the documentation of Mutex services.
>=20
> =20
>=20
> Could you please explain what this return value -3 means?
>=20
> =20
>=20
> Best regards
>=20
> Hans So =20
>=20
> =20
>=20
> =20
>=20
>=20
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
--=20
Philippe.



