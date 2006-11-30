Message-ID: <456F208E.90008@domain.hid>
Date: Thu, 30 Nov 2006 19:18:54 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] [RFC] Xenomai examples repository
References: <456D6451.3030705@domain.hid> <1164824900.4973.262.camel@domain.hid>	
	<456E122F.5030406@domain.hid> <1164910373.4952.34.camel@domain.hid>
In-Reply-To: <1164910373.4952.34.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5EFDF8F2EF2629998CDD9EAF"
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
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5EFDF8F2EF2629998CDD9EAF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Thu, 2006-11-30 at 00:05 +0100, Jan Kiszka wrote:
>=20
> [...]
>=20
>> To give it a start (and finally establish the infrastructure), I
>> copied/reformatted some existing examples and created a simple,
>> self-contained build system around them. The directory structure would=

>> be as I suggested:
>>
>> /examples/native/...
>> /examples/posix/...
>> /examples/...
>> /examples/rtdm/generic/...
>> /examples/rtdm/serial/...
>> /examples/rtdm/...
>>
>> I derived a generic Makefiles from my own one for tests (which was in
>> turn derived from previous work by Hannes Mayer). It can compile a giv=
en
>> list of user space applications and kernel modules (2.4 and 2.6)=20
>=20
> The 2.4 section looks x86-dependent. Compiling out-of-tree modules with=

> 2.4 over ppc would require a bit more magic to find the actual flags
> needed.

It's just the arch-independent set of flags. And, yes, this happens to
work for good old x86. :)

We have a nice but complex flag catcher in RTnet (I think it was once
developed for RTAI), but I really wanted to keep this simple. Still, any
patches/hints about additionally required flags for PPC are welcome!

>=20
>> against
>> some Xenomai installation (make XENO=3D..., unless xeno-config is alre=
ady
>> in $PATH) or a Xenomai-kernel (make KSRC=3D...). Moreover, there is si=
mple
>> Makefile under /examples just to kick building/cleaning of all subdirs=

>> at once.
>>
>> If it's OK for everyone, I would check this into trunk. We could then
>> migrate existing demo code and snippets over and add new stuff as it
>> pops up, both hopefully with the help of interested users.
>=20
> Ok, let's merge this.
>=20

Will do.

Jan


--------------enig5EFDF8F2EF2629998CDD9EAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFbyCOniDOoMHTA+kRAl+NAJwI+eCDnddiHd+01uFZCKUrEnmCwACfbXVF
25p7a/uUgsNNCvnGAbVYv1M=
=I+UZ
-----END PGP SIGNATURE-----

--------------enig5EFDF8F2EF2629998CDD9EAF--

