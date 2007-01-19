Message-ID: <45B1055B.2040505@domain.hid>
Date: Fri, 19 Jan 2007 18:52:27 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] problem inserting a kernel module
References: <495954.8561.qm@domain.hid>
In-Reply-To: <495954.8561.qm@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig641FFF9AC63736B47F3DD118"
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
To: mani bhatti <imranbashirbhatti@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig641FFF9AC63736B47F3DD118
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

mani bhatti wrote:
> I have got following message=20
>=20
> No module found in object
=2E..
> realtimedriver: Unknown symbol rtdm_event_signal
> realtimedriver: Unknown symbol rtdm_event_timedwait
> realtimedriver: Unknown symbol rtdm_dev_unregister
> realtimedriver: Unknown symbol rtdm_dev_register
>=20

Hmm, all this "rtdm", hmm, what the heck could this mean?

>=20
>=20
> Markus Franke <Markus.Franke@domain.hid> wrote: Well, so=
me symbols which are referenced by your module are not found in
> the kernel. A "dmesg()"-call should provide you some information about
> the missing symbols. Maybe you missed inserting the "RTDM"-kernel modul=
e?

But the solution is soooo close...

Jan


--------------enig641FFF9AC63736B47F3DD118
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFsQVbniDOoMHTA+kRAqCqAJ4syCT9ikRmOxkDZ4UiwTa/KkG+oACcDQ4J
rVjkvn142Tbf5brlTn5kvZE=
=37iO
-----END PGP SIGNATURE-----

--------------enig641FFF9AC63736B47F3DD118--

