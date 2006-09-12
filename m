Message-ID: <4506AA48.8080304@domain.hid>
Date: Tue, 12 Sep 2006 14:38:32 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [PATCH] rtcan_mem - CAN driver for memory mapped
	SJA1000 controllers
References: <200609121330.16250.matthias.fuchs@domain.hid>
	<4506A66F.5080801@domain.hid>
In-Reply-To: <4506A66F.5080801@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBE7E77CD3B0EEB439DDBED43"
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
--------------enigBE7E77CD3B0EEB439DDBED43
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Grandegger wrote:
> Hi Matthias,
>=20
> Matthias Fuchs wrote:
>> Hi,
>>
>> attached you will find a patch that adds support for memory mapped
>> SJA1000 CAN controllers as they often can be found on embedded boards.=

>> The driver is based on the rtmen_isa driver.
>=20
> What about using request_mem_region()?=20

(and this would also give RTCAN_DRV_NAME some sense again :))

> While looking to the driver I now
> realize, that it's mainly duplicated code. Does it not make more sense
> to make a combined io/mem driver. If io address < 32K it's an io driver=

> else a mem driver.

And provide two sets of readreg/writereg? What about differences in
chip->irq_flags, are they always like io=3Dedge, mem=3Dlevel? What about
defaults for CDR and OCR? Are the arbitrary anyway or do they correlate
somehow to the access type?

When we do not find answers right now (maybe in other Linux CAN
stacks?), we may postpone the merge and keep is separated until more
hardware pops up with more use-cases.

>=20
>> The driver has been tested on esd's embedded PowerPC boards with AMCC
>> PPC405 CPUs.
>>
>> Thanks to Jan for giving me some introduction to Xenomai during a
>> nightly session last friday.
>>
>> There's one thing a I am not very satisfied with :-) Why passing half
>> of the external clock frequency to the module. Because of compatiblity=

>> reasons I kept this behavior of the clock paramter from the ISA driver=
=2E
>=20
> The attached patch fixes this and replaces the module parameter "isa"
> with "io". I also tend to rename the driver into rtcan_io instead
> rtcan_isa if we keep it.
>=20
> Wolfgang.
>=20

Jan


--------------enigBE7E77CD3B0EEB439DDBED43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFBqpIniDOoMHTA+kRAoelAJ9aStUuwm81CqbqLXh5/8YRDNbS5gCfdEhY
eiF85fk48Wgeu8XvgWEDm0Y=
=bFWi
-----END PGP SIGNATURE-----

--------------enigBE7E77CD3B0EEB439DDBED43--

