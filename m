Message-ID: <43EFB868.60305@domain.hid>
Date: Sun, 12 Feb 2006 23:36:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <43ECD570.5000704@domain.hid>	
	<b647ffbd0602110331i400d7ff5k@domain.hid>	
	<43EDDF9E.4030309@domain.hid>
	<b647ffbd0602111058v3e8c6790w@domain.hid>
In-Reply-To: <b647ffbd0602111058v3e8c6790w@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig406E89375FC3B37C81C8A2F7"
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] Re: [shirq] first test results
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig406E89375FC3B37C81C8A2F7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Dmitry Adamushko wrote:
>>> Then I stumbled over the xnintr structure. Why do you keep a copy of =
the
>>>> device name?
>>>> A "const char *" should be enough, we just have to demand
>>>> that it will remain valid as long as the xnintr structure itself (i.=
e.
>>>> during the IRQ being attached). Saves a few bytes. :)
>>> Could be if all the users of it are initially kernel-mode entities.
>>>
>>> But e.g. there is a version of rt_intr_create() that may be called by=

>>> user-space
>>> apps and I extended it to support the "name" parameter too :
>>>
>>> int rt_intr_create(RT_INTR *intr, const char *name, unsigned irq, int=

>> mode);
>>> In such a case, the kernel-side rt_intr_create() is called with the
>> "name"
>>> allocated on the stack in skins/native/syscall.c : __rt_intr_create()=
)
>>> so the initial copy of the name can not remain valid.
>> But you could create buffer space for a copy of the name in the same
>> block already allocated for RT_INTR. Should be straightforward.
>=20
>=20
> RT_INTR does not have the "name" field any more. I have removed it afte=
r
> adding the same field to the xnintr_t as it became redundant.
>=20
> To access the "name", any code in native skin does "intr->intr_base.nam=
e"
> (intr_base is of "xnintr_t" type).
>=20

I was rather thinking of allocating RT_INTR + some additional space to
take the name passed from user-space. Then intr_base.name could point to
this buffer instead of static memory in the kernel use case.

Jan


--------------enig406E89375FC3B37C81C8A2F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFD77honiDOoMHTA+kRAruhAJwLIM8DNecvdF9i+q4VhsF8aKJk9gCggXLL
W3v3yJLe101aLS6krGYCjkA=
=+z92
-----END PGP SIGNATURE-----

--------------enig406E89375FC3B37C81C8A2F7--

