Message-ID: <46C0D686.6000007@domain.hid>
Date: Tue, 14 Aug 2007 00:09:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <46C0719B.1010102@domain.hid>
	<46C07AF2.60402@domain.hid>	<46C07D73.7070302@domain.hid>
	<46C080C8.10906@domain.hid>	<46C0835E.8010105@domain.hid>
	<46C0B036.3030306@domain.hid>	<46C0B1DF.6090509@domain.hid>
	<46C0B9F7.9060103@domain.hid>
In-Reply-To: <46C0B9F7.9060103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEA10609D0C387BD11F2E4897"
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
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEA10609D0C387BD11F2E4897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Roland Tollenaar wrote:
>> Hi Wolfgang,
>>
>>>> See below. This does not look good. Does it mean that I am only=20
>>>> always reading out the last socket and the rest are having their=20
>>>> buffers pumped full? Should I be unbinding somehow?
>>> Don't know, check your code ;-).
>> Thanks that is exactly what I did because I thought I was unbinding.=20
>> rt_dev_close () should do that for me correct? Its not. At least not=20
>> reliably. :(
>=20
> That's wired. You mean you called rt_dev_close() and the socket still=20
> does show up in /proc/rtcan_sockets? Is it possible that there is=20
> another task still using that socket? Could you show the code fragment =

> doing that.

Recall that up to Xenomai 2.4 RTDM device/socket closing may fail (with
-EAGAIN) when some other thread is currently using it and doesn't
release it immediately when being "asked". That means for now you should
loop over [rt_dev_]close as long as EAGAIN is returned.

Jan


--------------enigEA10609D0C387BD11F2E4897
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGwNaGniDOoMHTA+kRAvwBAJ0QwT64bCBfrMCtlr95Yy3zjVwcjwCeNr6H
yH5T4chWetApBBixwHa0JnQ=
=Kg0O
-----END PGP SIGNATURE-----

--------------enigEA10609D0C387BD11F2E4897--

