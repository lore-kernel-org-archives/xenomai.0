Message-ID: <4416AD0E.9040703@domain.hid>
Date: Tue, 14 Mar 2006 12:46:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] another question
References: <44169F39.2060904@domain.hid>
In-Reply-To: <44169F39.2060904@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig9BDE82F766E38118F3AF0225"
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
To: marcellin <marcellin.fotze@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9BDE82F766E38118F3AF0225
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

marcellin wrote:
> Sorry, but with this tiny program i have the same error : Operation not=

> permitted. What is wrong ?
>=20
> ...
> int main (int argc, char **argv)
> {
>=20
>  mlockall(MCL_CURRENT | MCL_FUTURE);
>    rt_timer_set_mode(TM_ONESHOT);
>=20
>  err =3D rt_cond_create(&cond,"condition");
>  if(err !=3D 0){
>    printf("\nrt_cond_create : %s",strerror(-err));
>  }
>  err =3D rt_mutex_create(&mutextest,"mut");
>  if(err !=3D 0){
>    printf("\nrt_mutex_create : %s",strerror(-err));
>  }
>=20
>  err =3D rt_task_create(&task,"SecondTask",0,99,0);
>  if(err !=3D 0){
>    printf("\nrt_task_create : %s",strerror(-err));
>  }
>  err =3D rt_task_start(&task,&mytask,NULL);
>  if(err !=3D 0){
>    printf("\nrt_task_start : %s",strerror(-err));
>  }
>=20
>=20
>  err =3D rt_cond_wait(&cond,&mutextest,TM_INFINITE);

You have to map your main thread to a native thread before you can
invoke a blocking RT service. Check rt_task_shadow() (and don't forget
to clean it up on exit).

>  if(err !=3D 0){
>    printf("\nrt_cond_wait : %s",strerror(-err));
>  }
>  printf("\nend \n");
>=20
>  retrurn(0);
>=20
> }
>=20
> regards
>=20
> Marcell1
>=20

Jan


--------------enig9BDE82F766E38118F3AF0225
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEFq0OniDOoMHTA+kRAo+gAJ97UZY5mHhyw+2GOgNxtUmYDRKN4wCeLWJT
HZ2PZlhQz1cf7lhs2iJDBVY=
=3cvl
-----END PGP SIGNATURE-----

--------------enig9BDE82F766E38118F3AF0225--

