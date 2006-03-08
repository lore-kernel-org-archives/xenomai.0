Message-ID: <440F1D69.3090504@domain.hid>
Date: Wed, 08 Mar 2006 19:07:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Error on rtdm skin with --enable-dox-doc
References: <200603081421.10284.lbocseg@domain.hid> <440F15C9.1020509@domain.hid>
	<200603081503.18409.lbocseg@domain.hid>
In-Reply-To: <200603081503.18409.lbocseg@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig086C5703A30B6E235AE23721"
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
To: Rodrigo Rosenfeld Rosas <lbocseg@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig086C5703A30B6E235AE23721
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Rodrigo Rosenfeld Rosas wrote:
> Em Quarta 08 Mar=E7o 2006 14:35, Jan Kiszka escreveu:
>=20
>> Rodrigo Rosenfeld Rosas wrote:
>>> Hi Jan,
>>>
>>> When compiling svn xenomai I noticed the following error with
>>> --enable-dox-doc switch:
>>>
>>> CC [M]  kernel/xenomai/skins/rtdm/drvlib.o
>>> kernel/xenomai/skins/rtdm/drvlib.c:1513:1: error: unterminated #ifdef=

>> I just passed this stage with trunk revision 671 without problems
>> (doxygen 1.4.4). Moreover, there is no #ifdef or related preprocessor
>> stuff in the latest drvlib.c at line 1513.
>=20
> I think I still didn't learn how to use the svn tool. I downloaded xeno=
mai=20
> today with (xenomai dir already existed)
>    svn co http://svn.gna.org/svn/xenomai/trunk xenomai

"svn update" should already be enough, no need for yet another checkout.
"svn status" can show you if you have local differences or even conflicts=
=2E

> And I got 670 revision.
> Then I renamed xenomai to xenomai.old and did the same command again. T=
hen I=20
> got the 671 revision and that is working fine with --enable-dox-doc.
>=20
> Thanks,
>=20
> Rodrigo.
>=20

Jan


--------------enig086C5703A30B6E235AE23721
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEDx1pniDOoMHTA+kRAldpAJ9a8r4Um29CztmVB9JiSLUy1TKquACeMNgP
aw/XxGanRQkOg6Dkkvj9j7M=
=0XmN
-----END PGP SIGNATURE-----

--------------enig086C5703A30B6E235AE23721--

