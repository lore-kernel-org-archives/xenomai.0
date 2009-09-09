Message-ID: <4AA82D6E.8070909@domain.hid>
Date: Thu, 10 Sep 2009 00:34:22 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1252532920.10115.9.camel@domain.hid>
In-Reply-To: <1252532920.10115.9.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0262544346171E46D95BD6A9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] nucleus/pipe.c patch: check for lingering close
	at xnpipe_connect()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Andreas Glatz <andreasglatz@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0262544346171E46D95BD6A9
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Andreas Glatz wrote:
> Hi,
>=20
> Currently, you can destroy RT_PIPE while a non-rt application is
> connected. If that happens the pipe won't be fully closed but
> some parts will be leftover for cleanup when closing the RT_PIPE
> from the non-rt application (lingering close).
>=20
> For us it would be very convenient if we didn't have to close
> the non-rt side before restarting the rt-side (currently, the=20
> rt-side complains bc the non-rt side didn't resolve the lingering
> close).
>=20
> Here is a patch where the rt-side resolves the lingering close
> when connecting to the RT_PIPE. I tested it and it seems to work=20
> fine. Do you have any concerns?
>=20
> Andreas
>=20

Whenever possible, please post patches inline (I had to manually copy it
to allow commenting).

> --- pipe.orig.c	2009-09-09 17:23:10.000000000 -0400
> +++ pipe.c	2009-09-09 17:32:48.000000000 -0400
> @@ -309,17 +309,35 @@
>  int xnpipe_connect(int minor, struct xnpipe_operations *ops, void *xst=
ate)
>  {
>  	struct xnpipe_state *state;
> -	int need_sched =3D 0, ret;
> +	int need_sched =3D 0, test_lclose =3D 0, ret;
>  	spl_t s;
> =20
> -	minor =3D xnpipe_minor_alloc(minor);
> -	if (minor < 0)
> +	ret =3D xnpipe_minor_alloc(minor);
> +	if (ret >=3D 0)
> +		minor =3D ret;
> +	else=20
> +	if(ret =3D=3D -EBUSY)
> +		test_lclose =3D 1;
> +	else=20
>  		return minor;
> =20
>  	state =3D &xnpipe_states[minor];
> =20
>  	xnlock_get_irqsave(&nklock, s);
> =20
> +	if(test_lclose) {
> +		if(testbits(state->status, XNPIPE_KERN_LCLOSE)) {
> +			clrbits(state->status, XNPIPE_KERN_LCLOSE);
> +			xnlock_put_irqrestore(&nklock, s);
> +			state->ops.release(state->xstate);

You cannot bluntly call release() here. You may not run in Linux context
while that handler demands this. Moreover, releasing the state is the
job of the NRT user that opened it and obviously still has a hand on it.

(And the locking is imbalanced here, but that is shadowed by the other
flaws.)

> +		} else {
> +			xnlock_put_irqrestore(&nklock, s);
> +			return -EBUSY;
> +		}
> +	}
> +		=09
> +	xnlock_get_irqsave(&nklock, s);
> +
>  	ret =3D xnpipe_set_ops(state, ops);
>  	if (ret) {
>  		xnlock_put_irqrestore(&nklock, s);

IIUC, you are looking for a way to keep a pipe open on the NRT side
while the RT user is disappearing and re-appearing? Not sure if this is
feasible at all with current xnpipe. But if it is, I think you rather
have to introduce some kind of reset on the affected xnpipe_state.

Jan


--------------enig0262544346171E46D95BD6A9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkqoLXUACgkQniDOoMHTA+lrXQCfaoWRynZ6kzCv4qbO7Uxzqh7v
2s4An0FsWc86lCjWw1rsx5ssFEFE0BYC
=fud9
-----END PGP SIGNATURE-----

--------------enig0262544346171E46D95BD6A9--

