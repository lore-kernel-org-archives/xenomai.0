Message-ID: <46C158BC.5030600@domain.hid>
Date: Tue, 14 Aug 2007 09:24:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid> <46C0D686.6000007@domain.hid>
	<46C13B91.6020801@domain.hid>
In-Reply-To: <46C13B91.6020801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF433336EB9D6AF031E7C8379"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rtcan bufferoverflow but no evidence
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
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF433336EB9D6AF031E7C8379
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Roland Tollenaar wrote:
> Hi,
>=20
>> Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (wit=
h
>> -EAGAIN) when some other thread is currently using it and doesn't
>> release it immediately when being "asked". That means for now you shou=
ld
>> loop over [rt_dev_]close as long as EAGAIN is returned.
>=20
> Excellent thanks. I did not know this. Is xenomai 2.4 stable yet? Would=

> you advise it as the version of choice at the moment?

2.4 is in -rc cycle, means there can still be bugs (ie. more bugs than
in stable ;) ). If you have more than just a few weeks to go until your
system role-out, having a look and giving it a try is not wrong. We'd
love to read your reports! ;) And you can quickly switch back again.

However, solely for the sake of this feature, I wouldn't throw 2.3.x away=
=2E

Jan


--------------enigF433336EB9D6AF031E7C8379
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwVi9niDOoMHTA+kRAmAYAJ0StMmdaRWlkTWnJ1czHxc4YTS85gCeJOEZ
ebOwqpSSKl/uC6z2cbz0JTo=
=YUns
-----END PGP SIGNATURE-----

--------------enigF433336EB9D6AF031E7C8379--

