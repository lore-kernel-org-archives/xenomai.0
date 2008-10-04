Message-ID: <48E77F57.9010604@domain.hid>
Date: Sat, 04 Oct 2008 16:36:07 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <48E76494.9030901@domain.hid> <48E778B3.8040004@domain.hid>
In-Reply-To: <48E778B3.8040004@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig785A6890CFE3641AFB3DF7B5"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] gdb lockup on multi-threaded process exit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig785A6890CFE3641AFB3DF7B5
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> I'm banging my head against this issue for several days now, first
>> trying to sort out an unrelated bug I also came across at this chance,=

>> then trying to understand what happens, and finally getting mad about
>> why this may only happen with Xenomai:
>=20
> I have not tried to understand your problem (yet). But do you happen to=

> work with the latest TASK_ATOMICSWITCH changes? If yes, could you try t=
o
> revert them?

Yes, I'm on latest trunk. During my debug endeavour, I haven't seen this
task state being involved. Also, if I got this correctly, it only
concerns the secondary->primary migration, and that one appears to be
out of scope here. Nevertheless, it's easy to verify if you tell me
which revision(s) I should revert.

Jan


--------------enig785A6890CFE3641AFB3DF7B5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjnf1cACgkQniDOoMHTA+kTsQCfR3EPiVeqOLC1XNmsvPxbqzf8
paMAn0xOhgbb5yv9VrQHKrfzfsitmoA8
=x3mk
-----END PGP SIGNATURE-----

--------------enig785A6890CFE3641AFB3DF7B5--

