Message-ID: <4B8D0466.7040403@domain.hid>
Date: Tue, 02 Mar 2010 13:28:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <E1NmR5I-0003k9-N5@domain.hid> <4B8D0359.4070504@domain.hid>
In-Reply-To: <4B8D0359.4070504@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1A81C1D1B81C3807EBB60D05"
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
--------------enig1A81C1D1B81C3807EBB60D05
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> GIT version control wrote:
>> Module: xenomai-jki
>> Branch: for-upstream
>> Commit: f1dfda551b6997f74141986759932e2723a9f024
>> URL:    http://git.xenomai.org/?p=3Dxenomai-jki.git;a=3Dcommit;h=3Df1d=
fda551b6997f74141986759932e2723a9f024
>>
>> Author: Jan Kiszka <jan.kiszka@domain.hid>
>> Date:   Tue Mar  2 13:17:35 2010 +0100
>>
>> Native: Fix return code of in-kernel rt_cond_wait[_until]
>>
>> In rt_cond_wait_inner, do not let rt_cond_wait_epilogue overwrite the
>> primary error code of rt_cond_wait_prologue. This restores the in-kern=
el
>> semantics of rt_cond_wait[_until] that were valid before 97323b3287.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>>
>> ---
>>
>>  ksrc/skins/native/cond.c |    8 ++++----
>>  1 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/ksrc/skins/native/cond.c b/ksrc/skins/native/cond.c
>> index 10727d1..2dc0069 100644
>> --- a/ksrc/skins/native/cond.c
>> +++ b/ksrc/skins/native/cond.c
>> @@ -472,10 +472,10 @@ static int rt_cond_wait_inner(RT_COND *cond, RT_=
MUTEX *mutex,
>>  	err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt,=20
>>  				    timeout_mode, timeout);
>> =20
>> -	if(!err || err =3D=3D -ETIMEDOUT || err =3D=3D -EINTR)
>> -		do {
>> -			err =3D rt_cond_wait_epilogue(mutex, lockcnt);
>> -		} while (err =3D=3D -EINTR);
>> +	if (!err || err =3D=3D -ETIMEDOUT || err =3D=3D -EINTR) {
>> +		while (rt_cond_wait_epilogue(mutex, lockcnt) =3D=3D -EINTR)
>> +			; /* empty */
>> +	}
>=20
> Not ok. If rt_cond_wait_epilogue returns an error other than -EINTR, we=

> want this error to be returned.

As I said: This is what we used to do in 2.4 (and early 2.5-rc), and due
to the absence of spec on this topic, I would vote for restoring old
behavior.

Jan


--------------enig1A81C1D1B81C3807EBB60D05
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuNBG4ACgkQitSsb3rl5xR49ACg0rreEN8hu5ktJF+tZYiDMfLw
1gsAoLXV9iLgGllq0eu5kIBX6J141PMw
=MAlM
-----END PGP SIGNATURE-----

--------------enig1A81C1D1B81C3807EBB60D05--

