Message-ID: <4506C350.1050509@domain.hid>
Date: Tue, 12 Sep 2006 16:25:20 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>	<4506A66F.5080801@domain.hid>	<200609121513.40749.matthias.fuchs@domain.hid>
	<4506BCCB.9010105@domain.hid>
In-Reply-To: <4506BCCB.9010105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig904D380622A92F3B6E3F3FD7"
Sender: jan.kiszka@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig904D380622A92F3B6E3F3FD7
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Matthias Fuchs wrote:
>> Hi Wolfgang,
>>
>> On Tuesday 12 September 2006 14:22, Wolfgang Grandegger wrote:
>>> What about using request_mem_region()? While looking to the driver I =
now=20
>> ... will be added, of course.
>>> realize, that it's mainly duplicated code. Does it not make more
>>> sense to make a combined io/mem driver. If io address < 32K it's an
>>> io driver
>>> else a mem driver.
>> Yes, that's possible. We can also decide on the used module parameter
>> (mem or io) what is to do. Passing both results in an error.
>>
>> You are right that its duplicated code. But the driver is very simple.=

>> It nearly does nothing but mapping, implementing register access
>> callbacks, registering and cleanup when unloading. But the driver
>> differs in all these points from the isa/io colleague. I like shot an
>> simple drivers, so that you do not have to care about breaking the
>> isa/io part when modifying the mem part.
>>
>>>> There's one thing a I am not very satisfied with :-) Why passing
>>>> half of=20
>> the
>>>> external clock frequency to the module. Because of compatiblity
>>>> reasons I kept this behavior of the clock paramter from the ISA driv=
er.
>>> The attached patch fixes this and replaces the module parameter "isa"=

>>> with "io". I also tend to rename the driver into rtcan_io instead
>>> rtcan_isa if we keep it.
>> Sounds good.
>=20
> Jan, could you apply this patch to avoid further confusion? The real CA=
N
> clock frequency listed also in the proc file system is half of the
> oscillator clock. Some more doc might help to avoid further confusion.
>=20

Done (with minor modification to avoid compiler warning).

Jan


--------------enig904D380622A92F3B6E3F3FD7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBsNQniDOoMHTA+kRAn85AJ4odUikvO4vb2AVzhkLxrZZdpyL2QCfQQdd
6LEIkLdEXxEMiqRNOAeSEbQ=
=lg61
-----END PGP SIGNATURE-----

--------------enig904D380622A92F3B6E3F3FD7--

