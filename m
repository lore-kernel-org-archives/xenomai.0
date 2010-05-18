Message-ID: <4BF2C3C7.9010406@domain.hid>
Date: Tue, 18 May 2010 18:43:51 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4BF268DE.1080809@domain.hid> <4BF273ED.2070802@domain.hid>
	<4BF29943.3010309@domain.hid>
In-Reply-To: <4BF29943.3010309@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4F559E88A850A57DD265B92C"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] rtdm_dev_register oops
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F559E88A850A57DD265B92C
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Stefan Kisdaroczi wrote:
> Am 18.05.2010 13:03, schrieb Jan Kiszka:
>> Stefan Kisdaroczi wrote:
>>> hi,
>>>
>>> i got a exception in rtdm_dev_register(). I didnt call rtdm_dev_unreg=
ister in my driver
>>> and after insmodding the module again I got a oops.
>> And that is surprising to you? :)
>=20
> A bit.
>=20
>> If you leave the previous device registered on rmmod, oopses are
>> programmed to occur: You leave references to unallocated memory behind=
=2E
>=20
> If one device fails to unregister i can't register any other device any=
more,

Then you have to find the bug that prevents proper deregistration.

> the rtdm registry is broken (cat /proc/xenomai/rtdm/names_devices hangs=
).

That hanging of /proc output is fixed in a series of mine that is yet
unmerged (as it is on hold, waiting for /proc infrastructure
refactorings by Philippe).

> That was surprising. If I have one corrupt file on my disk i can still
> create/access other files or list the filenames without exception.

If your filesystem hangs due to some bug of its own or in the underlying
layers, you won't be able to touch any further file on that system as wel=
l.

>=20
> Please don't get me wrong, but its not obvious for me that a registry
> behaves like that, but i can life with it. Sorry for the noise.

Again, the problem is that the deregistration hangs. That needs to be
understood and resolved.

Jan


--------------enig4F559E88A850A57DD265B92C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvyw8oACgkQitSsb3rl5xSZjQCdEBvnpslJqhgCw6QGLYokUs1i
U2wAn3T2iZhjOH7OIjTZ2uS1/G+pWn6p
=y9lh
-----END PGP SIGNATURE-----

--------------enig4F559E88A850A57DD265B92C--

