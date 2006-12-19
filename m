Message-ID: <45881A69.1040704@domain.hid>
Date: Tue, 19 Dec 2006 17:59:21 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: [RFC] git workflow
References: <20061219164222.EB5D735261B@atlas.denx.de>
In-Reply-To: <20061219164222.EB5D735261B@atlas.denx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4A79BA39E88524954269DB80"
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
--------------enig4A79BA39E88524954269DB80
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Wolfgang Denk wrote:
> In message <4587F9CE.3060403@domain.hid> you wrote:
>> Once there is a public tree with 2.6.20-rc1 + ipipe + -rc2, you cannot=

>> simply turn that tree into 2.6.20-rc1 + -rc2 + ipipe. The order of
>> patches is practically frozen once published. In your private tree you=

>> are, of course, free to do this and then extract some patch to post
>> upstream.
>=20
> I'm not sure if it really makes sense to maintain this as a git
> repository - that would be OK if we wanted to provide a pre-patched
> tree to the public (which might be a good thing to have, btw.).

This is one of my motivations to push git forward. Having
2.6.20-rcX+ipipe already available for download and testing may help to
follow the kernel development on the bleeding edge more closely.

The other aspect is that when you merge the kernel patches into a
working ipipe tree and you get a conflict, you also directly obtain
information about what change caused it and maybe what the background of
that patch was. That's at least my theory which still needs to be proven
in practice.

>=20
> As long as we're basicly trying to manage the patches in a way that
> integrates well with git we should do exactly that: manage the
> patches under git, i. e. use stgit (see http://www.procode.org/stgit/).=


I heard about it before, but I still have to take a closer look. Does
this generate also some kind of publishable git tree with history for
the managed patches? One problem with a stack might be that we loose
information about ipipe changes themselves. My idea is that some
modification to the ipipe core stored as commit in the reference tree
could directly be pulled by other arch maintainers.

Jan


--------------enig4A79BA39E88524954269DB80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFiBppniDOoMHTA+kRAvANAJ4mPJSkublQynsj2Ok3U2gDUukFLgCfQOCj
v1sAtUdDsF+cIOe9TPx/pEU=
=UaFK
-----END PGP SIGNATURE-----

--------------enig4A79BA39E88524954269DB80--

