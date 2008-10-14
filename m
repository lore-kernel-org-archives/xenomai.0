Message-ID: <48F4F197.2030207@domain.hid>
Date: Tue, 14 Oct 2008 21:23:03 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48F3B4D7.7070109@domain.hid> <48F4B453.9050700@domain.hid>
In-Reply-To: <48F4B453.9050700@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig789B44AD02B75034EA2EFF15"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] xnpipe: what's up with xnpipe_setup?
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
--------------enig789B44AD02B75034EA2EFF15
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> xnpipe_setup and the callbacks it sets is dead code for in-tree Xenoma=
i
>> users. Going back to, well, fusion-0.6.9 (the oldest version we have i=
n
>> LXR), it used to be dead meat already at that time. Can we remove it?
>>
>=20
> We can and should emulate the close handler using the input one, so we =
may get
> rid of the former.
>=20
> We need some way to fire a callback in a skin implementation when userl=
and
> connects, this is what the open handler was for; this may be required f=
or
> implementing more complex data channels over the generic message pipe c=
ode. Ok,
> we could also divert the input handler for that purpose as well, and it=
 makes
> little sense to keep a full interface just for that case.
>=20
> Go ahead, remove that code, but if a skin developer ever comes and comp=
lains
> about the terminal ugliness of our input handler looking like a kitchen=
 sink in
> a near future, I will ruthlessly direct him to YOU. Ah! Fair enough?

Yeah, just blame the street cleaner...

Jan


--------------enig789B44AD02B75034EA2EFF15
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkj08ZsACgkQniDOoMHTA+l23wCfY0NDIk4H1tVVODtDfzjGcNqR
Zg8An2Xn7SjyoHmsAuD+sex6bRdxlKVM
=BxtP
-----END PGP SIGNATURE-----

--------------enig789B44AD02B75034EA2EFF15--

