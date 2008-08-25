Message-ID: <48B33926.9060808@domain.hid>
Date: Tue, 26 Aug 2008 00:58:46 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48B313B5.9050308@domain.hid> <48B32E0C.7000105@domain.hid>
In-Reply-To: <48B32E0C.7000105@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1D6FEF106427CA0860AE3649"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xnregistry_fetch & friends
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
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1D6FEF106427CA0860AE3649
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> But then I wonder
>>
>>  a) why xnregistry_fetch uses nklock at all (even for totally uncritic=
al
>>     XNOBJECT_SELF!)
>>
>=20
> registry_validate() returns a pointer we want to dereference; we'd bett=
er keep
> this unpreemptable, although it's useless for the self-fetching op (whi=
ch is an
> unused calling mode so far). If using xnregistry_remove() while fetchin=
g the
> object, the worst case is that your action ends up acting upon an objec=
t of the
> same type, instead of the initially intended one. If that's a problem, =
goto safe;

I still don't see the benefit in picking up the object pointer under
nklock compared to the overhead of acquiring and releasing that lock.
That's all not truly safe anyway. Even if you ensure that handle and
object match, someone may change that pair before we can do the lookup
under nklock.

In my understanding, registry slots either contain NULL or a pointer to
some object. If that object is valid, that is checked _after_ releasing
the lock, so we are unsafe again, _nothing_ gained.

Jan


--------------enig1D6FEF106427CA0860AE3649
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkizOSoACgkQniDOoMHTA+nD8gCcCCuYNcMNjVmEPofoUxn67L3Q
iYUAn2sJMz1t9TTexR4Pe1a63pkdS6c7
=/epR
-----END PGP SIGNATURE-----

--------------enig1D6FEF106427CA0860AE3649--

