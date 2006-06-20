Message-ID: <44985239.2070000@domain.hid>
Date: Tue, 20 Jun 2006 21:53:29 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Nucleus Documentation
References: <d87da8330606201027m19044b68lfa29d352297fa77a@domain.hid>
	<f48df4840606201226m4d6979eevcd4e730198b42875@domain.hid>
In-Reply-To: <f48df4840606201226m4d6979eevcd4e730198b42875@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3DA370BDA8A1F7E440F6E2A6"
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
To: Pramode C E <pramode@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3DA370BDA8A1F7E440F6E2A6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Bruno Rouchouse wrote:
> Hi !
>=20
> On 6/20/06, Pramode C E <pramode@domain.hid> wrote:
>>
>> Hello,
>>
>> Is there some documentation (other than the API reference) which
>> describes
>> the Xenomai nucleus? I am trying to learn how to write an RTOS skin us=
ing
>> the Nucleus and am finding the going a bit tough .... any help will be=

>> greatly appreciated.
>>
>=20
> Check this link (
> http://wiki.rtai.dk/cgi-bin/gratiswiki.pl?How_To_Implement_A_New_Skin)
> which
> may give you some information about how to start writing a new skin.
>=20
> "Writing a Xenomai skin" is another piece of doc missing and the topics=
 to
> address are varied such as implementing the kernel part, writing the us=
er
> space layer and also how to use the simulator in order to develop and d=
ebug
> the model.
>=20
> A good exercise is maybe to start from a public specification (e.g. VRT=
X or
> uiTRON) and read the source code of the model to understand how it has =
been
> implemented.

Even a bit simpler in some regards is the RTDM skin, more specifically
its driver development API providing basic task, mutex, event, or
semaphore services.

>=20
> For sure people who have already written complete skins will be able to=

> give
> you other advices ;)

Learning by doing. :)

What kind of API do you plan to implement?

Jan


--------------enig3DA370BDA8A1F7E440F6E2A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEmFI5niDOoMHTA+kRAgOQAJ9IttsGRYID5SJ2l/ZRR8IR9QLQhQCggYsG
lnmhGFiNhslJlY05RaovZ7c=
=sR6g
-----END PGP SIGNATURE-----

--------------enig3DA370BDA8A1F7E440F6E2A6--

