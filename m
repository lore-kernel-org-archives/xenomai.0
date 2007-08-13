Message-ID: <46C07005.8000504@domain.hid>
Date: Mon, 13 Aug 2007 16:51:49 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C02829.9020009@domain.hid>
	<46C04384.4030805@domain.hid>	<46C05180.5090302@domain.hid>
	<46C05690.2010108@domain.hid> <46C063E0.1010809@domain.hid>
In-Reply-To: <46C063E0.1010809@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigAE8D8D2259C18E8C11F1352C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] [Ethercatmaster-users] EML conflict with RTCAN?
 low_level_input	framebuilding failed.
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rolandtollenaar@domain.hid
Cc: Xenomai-help@domain.hid, EML users <ethercatmaster-users@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAE8D8D2259C18E8C11F1352C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
> All closing & shutting down has been perfected. There are no more error=
s=20
> on closing my application.
>=20
> Yet the problem persists very explicitly. Rtcan and EML can run=20
> separately and never throw up any errors. As soon as they are used in=20
> combination then in 50% of the cases the framebuilding in EML gets=20
> messed up (as per the error message)
>=20
> There is definitely something between the two that is not right.
>=20

In 9 of 10 cases (if not more): timing. Running both alone doesn't
expose some timing issue (race) or transient overload. I can't help with
EML complaints, maybe the FMTC guys have an idea what can trigger this
and how to debug it.

>=20
>>>>> RTnet:rtskb allocation from real-time cache failed.
>=20
> Could I get some tips as to what I can do about this? I seem to get it =

> even when I do not have rtcan activity running in my application and=20
> (because I am clueless) I would like to prevent this message which may =

> signify the root of the problem.

You have created the socket for some/all EML activity from primary mode
of some Xenomai thread, thus network buffer allocation is ought to run
against the real-time rtskb pool - which is by default empty :p. See
README.pools from the RTnet documentation on this.

I don't have the EML design at hand, but you might be able to avoid this
by initialising before creating the shadow task or by explicitly
switching to secondary mode before initialising. [Sorry for this issue,
it's at least partly due to some outdated RTnet design.]

Jan


--------------enigAE8D8D2259C18E8C11F1352C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwHAGniDOoMHTA+kRAgsOAJ9QnDfF7sP3l23JLKU/2FoEiBXPBQCffAda
XhA7ovkLK/b56Nx+rCNui4A=
=FU9m
-----END PGP SIGNATURE-----

--------------enigAE8D8D2259C18E8C11F1352C--

