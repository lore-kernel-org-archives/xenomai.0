Message-ID: <45890361.7000709@domain.hid>
Date: Wed, 20 Dec 2006 10:33:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <20061219213010.AF2A4352664@domain.hid>
In-Reply-To: <20061219213010.AF2A4352664@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig89A3820FDA54C67A36B0A54B"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>, adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig89A3820FDA54C67A36B0A54B
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wolfgang Denk wrote:
> Dear Jan,
>=20
> in message <45881A69.1040704@domain.hid> you wrote:
>> This is one of my motivations to push git forward. Having
>> 2.6.20-rcX+ipipe already available for download and testing may help t=
o
>> follow the kernel development on the bleeding edge more closely.
>=20
> Agreed.
>=20
>> The other aspect is that when you merge the kernel patches into a
>> working ipipe tree and you get a conflict, you also directly obtain
>> information about what change caused it and maybe what the background =
of
>> that patch was. That's at least my theory which still needs to be prov=
en
>> in practice.
>=20
> THis will work, but if you go this route you will sonn have the git
> repo only, as it will become more and more difficult to extract the
> ipipe patches which you need anyway.
>=20
> That's why I recommend to use stgit to maintain the ipipe patches. So
> you have a clearly defined flow of information.
>=20
>> I heard about it before, but I still have to take a closer look. Does
>> this generate also some kind of publishable git tree with history for
>> the managed patches? ...
>=20
> Yes, it does.
>=20
>>                  ... One problem with a stack might be that we loose
>> information about ipipe changes themselves. ...
>=20
> No, that's not true, as the patches itself are managed under git,  so
> you have the full power of git for the patch history, too.
>=20
> This will be much more powerful than the  other  approach  -  if  you
> maintain  a  patched  tree  under git, it will be pretty difficult to
> find out which changes make up the ipipe patch, and which  are  other
> stuff.

Might be true when you browse the log. But I guess some magic can be
applied in that case as well, or we put a unique tag into the commit
name ("[IPIPE] optimise IRQ fast-path").

>=20
>>                                         ... My idea is that some
>> modification to the ipipe core stored as commit in the reference tree
>> could directly be pulled by other arch maintainers.
>=20
> That sounds as if you are planning  to  use  stgit  already,  without
> knowing it yet :-)

Well, I may still oversee something, but after having a first look and
also reading the tutorial it seems to me that there is actually no magic
behind stgit. Means, it just works with the same mechanism plain git
does. When you "stg pull", you remove your patches from the stack, apply
the upstream changes, and then add your patches again - git rebase. So
when you want to publish your stgit tree, you still need to merge your
patches (stg commit). And at that moment you set the whole tree ordering
in stone. Back to #1.

stgit is surely useful for managing private trees, but I don't see how
it can help us when we want to publish our working trees.

Jan


--------------enig89A3820FDA54C67A36B0A54B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiQNhniDOoMHTA+kRApSAAJwMYmT98amVygoABmIRi+SE5KDRqgCeJ19Z
pd8ft9lclLwSM603v3QFEWA=
=hKb0
-----END PGP SIGNATURE-----

--------------enig89A3820FDA54C67A36B0A54B--

