Message-ID: <4B253028.10607@domain.hid>
Date: Sun, 13 Dec 2009 19:19:20 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4B240D0B.50603@domain.hid>	
	<1260723757.2216.2.camel@domain.hid>
	<4B252909.9090304@domain.hid>
	<1260727502.2216.19.camel@domain.hid>
In-Reply-To: <1260727502.2216.19.camel@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC55779BE74258F9783B68649"
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
--------------enigC55779BE74258F9783B68649
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Philippe Gerum wrote:
> On Sun, 2009-12-13 at 18:48 +0100, Jan Kiszka wrote:
>> Philippe Gerum wrote:
>>> On Sat, 2009-12-12 at 22:37 +0100, Jan Kiszka wrote:
>>>> Recent moving of ipipe_suspend_domain finally exposed a deeper flaw =
in
>>>> cpu_idle on x86: We failed to check the pipeline log before issuing =
the
>>>> real hlt. This caused IRQ latencies or even drops for Linux,
>>>> specifically on SMP. Credits go to plain QEMU whose slow SMP mode ca=
used
>>>> ipipe_critical_enter to deadlock frequently enough.
>>>>
>>>> The first patch of this series fixes this (see below), the second on=
e
>>>> simply removes the two useless ipipe_suspend_domain calls.
>>>>
>>> What your patch does as well, is killing the ability to run low prior=
ity
>>> domains below the root level.
>> Yes, I'm killing the dream.
>>
>> I heavily doubt that the functions I removed in the second patch ever
>> contributed something good to this. It's always the job of the lowest
>> domain to issue hardware halt, not of some arbitrary mid-prio domain.
>> Moreover, what would be the practical use for such model in the contex=
t
>> of Linux?
>=20
> That is _not_ the point. The point is, when submitting a patch, please
> make sure to raise all the concerns it might introduce wrt to changing
> the base features. I'm not opposed to make the feature set evolve, but =
I
> don't want this to happen "by mistake".

Just pushed

"x86: Drop redundant ipipe_suspend_domain from cpu_idle

Allowing domains below root always required more than these calls (Linux
would have to give up idle management). And syncing the root domain now
takes place in __ipipe_halt_root. So remove these suspension calls."

as commit message for the second patch. Is that what you are looking for?=


Jan


--------------enigC55779BE74258F9783B68649
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkslMCwACgkQitSsb3rl5xRwPgCgm8yBf7CUcYCMqyqRoampWqji
9ycAoNt+F5PY9QsP+MGnqJFRF05cWzzT
=Mj+e
-----END PGP SIGNATURE-----

--------------enigC55779BE74258F9783B68649--

