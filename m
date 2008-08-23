Message-ID: <48AFF4FB.1020702@domain.hid>
Date: Sat, 23 Aug 2008 13:31:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48AFCB3F.6070902@domain.hid>
	<48AFE498.2060805@domain.hid>	<48AFEC44.8000407@domain.hid>
	<48AFEF7C.8090503@domain.hid>
In-Reply-To: <48AFEF7C.8090503@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0321CBF5EDA8D6E8FC87ABE"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] Racy pse51_mutex_check_init?
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
Cc: Xenomai-core@domain.hid

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF0321CBF5EDA8D6E8FC87ABE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Philippe Gerum wrote:
>> Gilles Chanteperdrix wrote:
>>> Hi Jan,
>>>
>>> Please do not use my address at gmail, gna does not want me to post f=
rom
>>> this address:
>>>
>>> 2008-08-23 12:10:19 1KWq4T-0000zD-9E ** xenomai@xenomai.org <Xenomai=
-core@domain.hid
>>>> R=3Ddnslookup T=3Dremote_smtp: SMTP error from remote mailer after R=
CPT TO:<Xenomai-
>>> core@domain.hid>: host mail.gna.org [88.191.250.46]: 550 rejected becaus=
e gmail.com i
>>> s in a black list at dsn.rfc-ignorant.org
>>>
>>> so, here is a repost of my answer:
>>>
>>> Jan Kiszka wrote:
>>>>> Hi Gilles,
>>>>>
>>>>> trying to understand the cb_read/write lock usage, some question ca=
me up
>>>>> here: What prevents that the mutexq iteration in pse51_mutex_check_=
init
>>>>> races against pse51_mutex_destroy_internal?
>>> Well, I am afraid the mechanism used is not 100% safe. Anyway, the ai=
m
>>> is to catch most of invalid usages, it seems we can not catch them al=
l.
>>>
>>>>> If nothing, then I wonder if we actually have to iterate over the w=
hole
>>>>> queue to find out whether a given object has been initialized and
>>>>> registered already or not. Can't this be encoded differently?
>>>>>
>>>>> BTW, shadow_mutex.mutex is a kernel pointer sitting in a user-reach=
able
>>>>> memory region? Why not using a handle here, like the native skin do=
es?
>>>>> Won't that allow to resolve the issue above as well?
>>> This has been so from the beginning, and I did not change it.
>>>
>> To get registry handles, you first need to register objects. The POSIX=
 skin
>> still does not use the built-in registry, that's why.
>=20
> Well the registry is about associating objects with their name, and
> since most posix skin objects have no name, I did not see the point of
> using the registry. And for the named objects, the nucleus registry was=

> not compatible with the posix skin requirements, which is why I did not=

> use it...

The registry is also about providing user-safe handles for unnamed
object - so that you don't risk accepting borken kernel pointers from
user space.

Jan


--------------enigF0321CBF5EDA8D6E8FC87ABE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkiv9PwACgkQniDOoMHTA+l5pACeNdBohK/4u53+P5Ii96w/Rpr7
OVUAnR5zGWs50y/jf9GYQ9ntkM03Trxw
=+1OG
-----END PGP SIGNATURE-----

--------------enigF0321CBF5EDA8D6E8FC87ABE--

