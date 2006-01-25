Message-ID: <43D6D745.3070701@domain.hid>
Date: Wed, 25 Jan 2006 02:41:25 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] RTDM and possible bug
References: <200601242019.05696.lbocseg@domain.hid>
In-Reply-To: <200601242019.05696.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8CA56C829C5E18CFCBDAFC99"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8CA56C829C5E18CFCBDAFC99
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Hi Jan,
>=20
> I'm getting the following message from kernel:
> Xenomai: RTDM: no non-RT close handler
> Error registering RTDM device
>=20
> But I am using only a RT open handler and a RT close handler. The=20
> documentation states:
> "rtdm_close_handler_t 	close_nrt=09
>  	Close handler for non-real-time contexts, optional if close_rt is non=
-NULL."
> which is my case.
>=20
> Am I missing something?

Nope, it's bug in the documentation. Do you actually depend on RT
context for cleanup?

I recently decided to enforce a non-RT closure handler on registration.
This is required to be able to do the

    echo file_descriptor > /proc/xenomai/rtdm/open_fildes

dance on forgotten file descriptors and to implement on day an automatic
closure on process termination.

The doc is now fixed, thanks for reporting.

>=20
> I'll take a closer look at RTDM source-code, but maybe you can enlight =
me=20
> until there.
>=20
> Thanks,
>=20
> Rodrigo.
>=20
>=20

Jan


--------------enig8CA56C829C5E18CFCBDAFC99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD1tdGniDOoMHTA+kRAgj5AJ9I0tg9vyhxuaHMszE6UidFgj2/eACdGx97
dRYBUm+LGDrbudpGeKxaqZA=
=d5/m
-----END PGP SIGNATURE-----

--------------enig8CA56C829C5E18CFCBDAFC99--

