Message-ID: <451943C2.4070104@domain.hid>
Date: Tue, 26 Sep 2006 17:14:10 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] [PATCH+HACK] optimise root stalling
References: <J67GO9$2B9117C0B95CB2D9676C399264D0207F@laposte.net>
In-Reply-To: <J67GO9$2B9117C0B95CB2D9676C399264D0207F@laposte.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1F2222391BB421627374C508"
Sender: jan.kiszka@domain.hid
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: "gilles.chanteperdrix" <gilles.chanteperdrix@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1F2222391BB421627374C508
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

gilles.chanteperdrix wrote:
> ---------- Debut du message initial -----------
>=20
> De     : adeos-main-bounces@domain.hid
> A      : adeos-main@gna.org
> Copies :=20
> Date   : Mon, 25 Sep 2006 12:44:02 +0200
> Objet  : Re: [Adeos-main] [PATCH+HACK] optimise root stalling
>=20
>> Jan Kiszka wrote:
>>> ...
>>> A further idea of mine was to inline light-weight parts of the
>>> __ipipe_*_root API on UP (no SMP at hand to judge on it as
> well).
>> BTW: I haven't looked at any detail yet, but would PER_CPU
> here and
>> there (e.g. for ipipe_percpu_domain) buy us something on SMP
> (2.6)?
>=20
> I think to remember that the PER_CPU support uses
> smp_processor_id(),=20
> and we know that smp_processor_id() must not be used over Xenomai
> stacks.
>=20

Not necessarily: per_cpu(var, cpu) retrieves a variable for the given
cpu without touching smp_processor_id.


--------------enig1F2222391BB421627374C508
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFGUPCniDOoMHTA+kRAtUNAJ9JujxGTkOBg/YajpNV3r5C+yr6XACeLOdc
MIk/WI427TSHmV4LuawsyRU=
=hR+V
-----END PGP SIGNATURE-----

--------------enig1F2222391BB421627374C508--

