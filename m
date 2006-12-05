Message-ID: <457584DD.90600@domain.hid>
Date: Tue, 05 Dec 2006 15:40:29 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH] I-pipe tracer for ARM
References: <E1GrHXk-00023w-Oq@domain.hid>	<E1GrWZ5-000089-Ou@domain.hid>
	<45753DAB.20207@domain.hid>	<E1Graz2-0003MR-Gl@domain.hid>
	<457582DA.2070700@domain.hid> <45758482.4070103@domain.hid>
In-Reply-To: <45758482.4070103@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFD1AB87331153EB62543D9B4"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main@gna.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD1AB87331153EB62543D9B4
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Sebastian Smolorz wrote:
>>
>>> Jan Kiszka wrote:
>>>> Are you tracing into vmalloc'ed memory?
>>> Yes, without CONFIG_IPIPE_TRACE_VMALLOC the system does not boot.
>>
>> Hmm, makes me wonder of some laziness of the page mapping or a missing=

>> lock-against-swapping causes this. Could you have a closer look at the=

>> tracer code if we are lacking some magic for the vmalloc trace buffer
>> (compare to the xnheap code, e.g.)?
>=20
> This is a known issue, the ARM architecture lacks the set_pgdir
> function, needed in mm/vmalloc.c to workaround the lazy page mapping of=

> vmalloced areas.
>=20

Would vmalloc+memset help to be safe for the remaining system runtime?


--------------enigFD1AB87331153EB62543D9B4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdYTdniDOoMHTA+kRAoTHAJ9W1wDdWEfcYSakfPslWUNCN6IMcwCfUWLh
KLhnbRXR5POGzSBcXEnQT44=
=WqGP
-----END PGP SIGNATURE-----

--------------enigFD1AB87331153EB62543D9B4--

