Message-ID: <4B8D04C7.9040403@domain.hid>
Date: Tue, 02 Mar 2010 13:29:59 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NmR5I-0003k9-N5@domain.hid> <4B8D0359.4070504@domain.hid>
	<4B8D0466.7040403@domain.hid>
In-Reply-To: <4B8D0466.7040403@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5AA1FBE002B8D4D4F8EF55B9"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [Xenomai-git] Jan Kiszka : Native: Fix return
 code of in-kernel rt_cond_wait[_until]
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5AA1FBE002B8D4D4F8EF55B9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> GIT version control wrote:
>>> Module: xenomai-jki
>>> Branch: for-upstream
>>> Commit: f1dfda551b6997f74141986759932e2723a9f024
>>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3Df1=
dfda551b6997f74141986759932e2723a9f024
>>>
>>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>>> Date:   Tue Mar  2 13:17:35 2010 +0100
>>>
>>> Native: Fix return code of in-kernel rt_cond_wait[_until]
>>>
>>> In rt_cond_wait_inner, do not let rt_cond_wait_epilogue overwrite the=

>>> primary error code of rt_cond_wait_prologue. This restores the in-ker=
nel
>>> semantics of rt_cond_wait[_until] that were valid before 97323b3287.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>>
>>> ---
>>>
>>>  ksrc/skins/native/cond.c |    8 ++++----
>>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/ksrc/skins/native/cond.c b/ksrc/skins/native/cond.c
>>> index 10727d1..2dc0069 100644
>>> --- a/ksrc/skins/native/cond.c
>>> +++ b/ksrc/skins/native/cond.c
>>> @@ -472,10 +472,10 @@ static int rt_cond_wait_inner(RT_COND *cond, RT=
_MUTEX *mutex,
>>>  	err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt,=20
>>>  				    timeout_mode, timeout);
>>> =20
>>> -	if(!err || err =3D=3D -ETIMEDOUT || err =3D=3D -EINTR)
>>> -		do {
>>> -			err =3D rt_cond_wait_epilogue(mutex, lockcnt);
>>> -		} while (err =3D=3D -EINTR);
>>> +	if (!err || err =3D=3D -ETIMEDOUT || err =3D=3D -EINTR) {
>>> +		while (rt_cond_wait_epilogue(mutex, lockcnt) =3D=3D -EINTR)
>>> +			; /* empty */
>>> +	}
>> Not ok. If rt_cond_wait_epilogue returns an error other than -EINTR, w=
e
>> want this error to be returned.
>=20
> As I said: This is what we used to do in 2.4 (and early 2.5-rc), and du=
e
> to the absence of spec on this topic, I would vote for restoring old
> behavior.
>=20

It's also what pthread_cond_wait does internally, BTW.

Jan


--------------enig5AA1FBE002B8D4D4F8EF55B9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuNBMcACgkQitSsb3rl5xR5jACg6wLtmeGqit8uvPfBcspeuIXH
sZsAn0ux0igZucZAD5yknXu09BXhKt8N
=8ccm
-----END PGP SIGNATURE-----

--------------enig5AA1FBE002B8D4D4F8EF55B9--

