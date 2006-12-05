Message-ID: <457582DA.2070700@domain.hid>
Date: Tue, 05 Dec 2006 15:31:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>
	<E1GrWZ5-000089-Ou@domain.hid> <45753DAB.20207@domain.hid>
	<E1Graz2-0003MR-Gl@domain.hid>
In-Reply-To: <E1Graz2-0003MR-Gl@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE017CFFF17C0254B8BA6EFB3"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Sebastian Smolorz <ssm@domain.hid>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE017CFFF17C0254B8BA6EFB3
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Sebastian Smolorz wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>>>> <    +freeze  0xffffffff     0   97.444N __ipipe_frozen_ctrl+0x108
>>>>> (vfs_write+0xc4)
>>>> Hmm, takes quite a long time to complete the freeze though you only =
have
>>>> 10 post-trace points (which defines its complexity). Unusual, also w=
hen
>>>> comparing with other traced functions.
>>> It seems that it doesn't depend on post-trace-points. When I reduce t=
hem
>>> to 2 the value for the freeze does not get smaller. Maybe it has
>>> something to do with the following lines?
>> Are you tracing into vmalloc'ed memory?
>=20
> Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.

Hmm, makes me wonder of some laziness of the page mapping or a missing
lock-against-swapping causes this. Could you have a closer look at the
tracer code if we are lacking some magic for the vmalloc trace buffer
(compare to the xnheap code, e.g.)?

>=20
>> And what results do you get with=20
>> latency -f?
>=20
> These seem to be better (see attachment).

This might shadow earlier page faults, i.e. during the first triggerings.=


Jan


--------------enigE017CFFF17C0254B8BA6EFB3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdYLaniDOoMHTA+kRApRnAJ4ubM39z+UxE24ZyM9N9rYOzFSvRQCeM+ja
6glzM81gXScwTEp3v3rcznE=
=neDG
-----END PGP SIGNATURE-----

--------------enigE017CFFF17C0254B8BA6EFB3--

