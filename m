Message-ID: <469549AF.5090102@domain.hid>
Date: Wed, 11 Jul 2007 23:20:47 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <2404.194.199.21.225.1181233422.squirrel@domain.hid>	<4668440F.7020706@domain.hid>	<20070608124927.1b789a9e@domain.hid>	<46693B6B.1010201@domain.hid>	<20070625175107.438849fa@domain.hid>	<467FF391.8020401@domain.hid>	<20070627105726.7db7a459@domain.hid>	<46825054.7030800@domain.hid>	<20070629164326.15579570@domain.hid>	<4690B86C.1000907@domain.hid>	<20070711155932.4b88699e@domain.hid>	<4694E96B.5020801@domain.hid>	<20070711173545.709225f1@domain.hid>	<4694FD99.3030405@domain.hid>
	<20070711185529.62544380@domain.hid>
In-Reply-To: <20070711185529.62544380@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED9ACBFBCE1FFF580E9A1E8E"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] measuring tasks execution time
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigED9ACBFBCE1FFF580E9A1E8E
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Daniel Simon wrote:
> On Wed, 11 Jul 2007 17:56:09 +0200
> Jan Kiszka <jan.kiszka@domain.hid> wrote:
>=20
>> Let's find a compromise: I will try to role out -v2 of this patch with=

>> your fixes soon. And you will try to do the in-depth tests of exectime=

>> reporting once you have a Xenomai box again? Hacking is cheap, testing=

>> takes the time... :) Or does the test code you once submitted report
>> clear results /wrt the correctness of the exectime data?
>=20
> What I mean is that I can perform tests _only on a Pentium3 UP_, and on=
 this
> machine I upto now get consistent results on the basic tests using the =
last
> fixes (and I will do further testing with various applications).

Ah, ok, /me should have read more thoroughly.

>=20
> I cannot (and will not be able in a previsible future) perform tests
> neither on a SMP nor on not_i386 architectures...
>=20
> In attachment:=20
> the full exectime-V2.patch (including all the fixes we discussed
> today) against a vanilla 2758 release, which compiled and behaves well =
on my
> basic examples and UP machine. (it also patches with no hunk against
> last release 2764),=20
> and the add-on against your original patch (I don't know what
> is the easiest way for you...)
>=20

I've merge you changes (whitespaces...), reformatted it a bit, and
uploaded the result. See

http://www.rts.uni-hannover.de/rtaddon/patches/xenomai/enhance-thread-sta=
ts-v2.patch

Hope I didn't messed anything up, it was just compile-tested in a hurry.
If the patch happens to work fine, I would start advertising it for
merge into trunk.

Jan


--------------enigED9ACBFBCE1FFF580E9A1E8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGlUmvniDOoMHTA+kRAsPiAJ9zqcMmHpAM8VGYEamAyVBxwVmJpwCfTBcF
U2kXem6qejZSp4gH707WR8A=
=9icR
-----END PGP SIGNATURE-----

--------------enigED9ACBFBCE1FFF580E9A1E8E--

