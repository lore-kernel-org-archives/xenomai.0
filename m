Message-ID: <49BFFBB8.3070409@domain.hid>
Date: Tue, 17 Mar 2009 20:36:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <49BFED6E.4090009@domain.hid>
	<49BFEEE4.6020204@domain.hid>	<49BFF0C7.7010001@domain.hid>
	<49BFF131.7070607@domain.hid>	<49BFF332.9080809@domain.hid>
	<49BFF38B.1000509@domain.hid>	<49BFF579.3020408@domain.hid>
	<49BFF664.8090607@domain.hid>
In-Reply-To: <49BFF664.8090607@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig87B738BF5FDF2CAEAF614200"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH] posix: Fix error checks when copying
	user strings
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig87B738BF5FDF2CAEAF614200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Gilles Chanteperdrix wrote:
>>>>> Jan Kiszka wrote:
>>>>>> Gilles Chanteperdrix wrote:
>>>>>>> Jan Kiszka wrote:
>>>>>>>> Obviously a conversion error while switching to __xn_safe*.
>>>>>>>>
>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>>>>> Well, I have just checked the kernel code, and 0 as a return valu=
e of
>>>>>>> strncpy_from_user is treated as a value in most places, even if n=
ot -EFAULT.
>>>>>>>
>>>>>> Better check our code: :) __xn_safe_strncpy_from_user works differ=
ently.
>>>>> Then I would tend to consider that xn_safe_strncpy is broken.
>>>> No, because it not a derivate of strncpy_from_user, but an internal
>>>> service optimized for the most common use cases (where you don't car=
e
>>>> about the precise return value).
>>> So, what should I call if I care about the return value ?
>> The old combo of access_rok() and __xn_strncpy_from_user() - ah, I see=

>> the issue: POSIX requires the length to report overflows to the users.=

>> Hmm, then back to the old code, just adding the missing address range =
check.
>>
>=20
> Forget that, now I should have looked into our code: The "safe" version=

> transparently calls __xn_strncpy_from_user, no need to go by foot here.=

>=20

Here is the real bug:

>         long res;
>         __do_strncpy_from_user(dst, src, count, res);
> ffffffff804505cc:       48 85 c9                test   %rcx,%rcx
> ffffffff804505cf:       74 0e                   je     ffffffff804505df=
 <rthal_strncpy_from_user+0x1f>
> ffffffff804505d1:       ac                      lods   %ds:(%rsi),%al
> ffffffff804505d2:       aa                      stos   %al,%es:(%rdi)
> ffffffff804505d3:       84 c0                   test   %al,%al
> ffffffff804505d5:       74 05                   je     ffffffff804505dc=
 <rthal_strncpy_from_user+0x1c>
> ffffffff804505d7:       48 ff c9                dec    %rcx
> ffffffff804505da:       75 f5                   jne    ffffffff804505d1=
 <rthal_strncpy_from_user+0x11>
> ffffffff804505dc:       48 29 c9                sub    %rcx,%rcx
                                                         ^^^^^^^^^

>         return res;
> }
> ffffffff804505df:       48 89 c8                mov    %rcx,%rax
> ffffffff804505e2:       c9                      leaveq
> ffffffff804505e3:       c3                      retq

And that is due to us lacking kernel commit
e0a96129db574d6365e3439d16d88517c437ab33.

Nevertheless, the existing checks against 0 in the POSIX layer weren't
correct either. We need to fix both, but less ad-hoc than I tried.

Jan


--------------enig87B738BF5FDF2CAEAF614200
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkm/+8cACgkQniDOoMHTA+m6/ACfZ0JVC0Z4UNvrf5RCGsv5UUnU
+L8An0Y1VLBURl/6PubKQFruFWAGHZ3F
=n9H1
-----END PGP SIGNATURE-----

--------------enig87B738BF5FDF2CAEAF614200--

