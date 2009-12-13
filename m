Message-ID: <4B252909.9090304@domain.hid>
Date: Sun, 13 Dec 2009 18:48:57 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B240D0B.50603@domain.hid>
	<1260723757.2216.2.camel@domain.hid>
In-Reply-To: <1260723757.2216.2.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0C2533DC30F91DACD1235D27"
Sender: jan.kiszka@domain.hid
Subject: Re: [Adeos-main] [pull request] x86: critical fix for
	native_safe_halt
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0C2533DC30F91DACD1235D27
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
>> Recent moving of ipipe_suspend_domain finally exposed a deeper flaw in=

>> cpu_idle on x86: We failed to check the pipeline log before issuing th=
e
>> real hlt. This caused IRQ latencies or even drops for Linux,
>> specifically on SMP. Credits go to plain QEMU whose slow SMP mode caus=
ed
>> ipipe_critical_enter to deadlock frequently enough.
>>
>> The first patch of this series fixes this (see below), the second one
>> simply removes the two useless ipipe_suspend_domain calls.
>>
>=20
> What your patch does as well, is killing the ability to run low priorit=
y
> domains below the root level.

Yes, I'm killing the dream.

I heavily doubt that the functions I removed in the second patch ever
contributed something good to this. It's always the job of the lowest
domain to issue hardware halt, not of some arbitrary mid-prio domain.
Moreover, what would be the practical use for such model in the context
of Linux?

Jan


--------------enig0C2533DC30F91DACD1235D27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkslKRMACgkQitSsb3rl5xS3pgCeMiBsLVYnZjXE3XXv1Rcsy9xL
028AoLLK5X6vODykUjYdl0bdlX6iEgxi
=oTCg
-----END PGP SIGNATURE-----

--------------enig0C2533DC30F91DACD1235D27--

