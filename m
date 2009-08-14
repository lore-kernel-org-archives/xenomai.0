Message-ID: <4A851FAB.1060800@domain.hid>
Date: Fri, 14 Aug 2009 10:26:19 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>
In-Reply-To: <0AB95BFCF14F984980DE7149C21D6B90065D58B59F@FND-MAILB03.VIA.DK>
Content-Type: text/plain; charset="iso-8859-1"
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
To: =?ISO-8859-1?Q?=22Hans_S=F8ndergaard_=28HSO=29=22?= <HSO@VIAUC.DK>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hans S=F8ndergaard (HSO) wrote:
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

A question that may look stupid, is ob->rt_lock correctly initialised?
Also, why using a malloc for this, why not doing:

typedef struct object {
   RT_MUTEX rt_lock;
   /* ... */
} Object;

int err =3D rt_mutex_create (&ob->rt_lock, NULL);

err =3D rt_mutex_acquire (&ob->rt_lock, TM_INFINITE);

> On creation, rt_mutex_create returns 0 (as expected).
>=20
> On acquiring, rt_mutex_acquire returns -3,
>=20
> but this return value is not included among the possible return values
> in the documentation of Mutex services.
> =20
>=20
> Could you please explain what this return value -3 means?

3 is ESRCH, what version of Xenomai are you using?

--=20
                                          Gilles


