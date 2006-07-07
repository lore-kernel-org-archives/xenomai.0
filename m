Message-ID: <44AE37DA.9080205@domain.hid>
Date: Fri, 07 Jul 2006 12:30:50 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC, PATCH] per-thread exec-time stats
References: <44ACF5FA.2050205@domain.hid>	<1152196379.4978.74.camel@domain.hid>	<17581.41221.527736.416354@domain.hid>	<1152258866.5017.4.camel@domain.hid>
	<17582.13798.272437.979081@domain.hid>
In-Reply-To: <17582.13798.272437.979081@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig95738B9C0DBCDF58F4F89537"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig95738B9C0DBCDF58F4F89537
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>  > On Fri, 2006-07-07 at 01:47 +0200, Gilles Chanteperdrix wrote:
>  > > Philippe Gerum wrote:
>  > >  > > +#ifdef CONFIG_XENO_OPT_STATS
>  > >  > > +static inline void xnpod_acc_exec_time(xnsched_t *sched,
>  > >  > > +                                       xnthread_t *threadout=
)
>  > >  > > +{
>  > >  > > +    xnticks_t now =3D xntimer_get_rawclock();
>  > >  > > +    threadout->stat.exec_time +=3D now - sched->last_csw;
>  > >  > > +    sched->last_csw =3D now;
>  > >  > > +}
>  > >  >=20
>  > >  > It would be better to only pass the thread pointer, then use th=
e
>  > >  > thread->sched member. This would clearly explain the relationsh=
ip
>  > >  > between both, and prevent any bugous attempt at mixing things.
>  > >=20
>  > > Beware, when xnpod_schedule is called from within
>  > > xnpod_migrate_thread(), the sched pointer of the switched out thre=
ad is
>  > > the one of the destination cpu. So, passing the sched and threadou=
t
>  > > pointers to xnpod_acc_exec_time is safer.
>  >=20
>  > Nope, the nklock is held by the migrating thread all along until the=

>  > switch has actually occured.
>=20
> xnpod_acc_exec_time() is called from within xnpod_schedule() that is
> called from within xnpod_migrate_thread() at a time where
> threadout->sched is the wrong pointer.
>=20

True, will revert this.

Thanks,
Jan


--------------enig95738B9C0DBCDF58F4F89537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFErjfaniDOoMHTA+kRAnHlAJ4y4KOvThwUeSqGrTSRynxKXaj0GwCeONV+
iEnCy6dR2D+X/9zULbtKzq8=
=rJpe
-----END PGP SIGNATURE-----

--------------enig95738B9C0DBCDF58F4F89537--

