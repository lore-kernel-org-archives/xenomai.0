Message-ID: <4A036C0F.6090202@domain.hid>
Date: Fri, 08 May 2009 01:17:35 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <4A0335C4.6070004@domain.hid> <4A0365B5.7030207@domain.hid>
In-Reply-To: <4A0365B5.7030207@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig32EFE28045BA8E78C21BE192"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-core] [PATCH][STABLE] posix: Fix access checks in
	select
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@domain.hid>, xenomai-core <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32EFE28045BA8E78C21BE192
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> [ Please pull from git://git.xenomai.org/xenomai-jki.git for-2.4.x ]
>>
>> The test for __xn_access_ok was inverted, thus rejected valid requests=
=2E
>> Fix this and refactor the code in order to check for the actual size o=
f
>> the passed fd sets.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
>> ---
>>
>>  ksrc/skins/posix/syscall.c |   21 +++++++++------------
>>  1 files changed, 9 insertions(+), 12 deletions(-)
>>
>> diff --git a/ksrc/skins/posix/syscall.c b/ksrc/skins/posix/syscall.c
>> index 5c62a45..f0111f8 100644
>> --- a/ksrc/skins/posix/syscall.c
>> +++ b/ksrc/skins/posix/syscall.c
>> @@ -2384,17 +2384,16 @@ static int __select(struct task_struct *curr, =
struct pt_regs *regs)
>>  	struct timeval tv;
>>  	pthread_t thread;
>>  	int i, err, nfds;
>> +	size_t fds_size;
>> =20
>>  	thread =3D pse51_current_thread();
>>  	if (!thread)
>>  		return -EPERM;
>> =20
>>  	if (__xn_reg_arg5(regs)) {
>> -		if (__xn_access_ok(curr, VERIFY_WRITE,
>> -				   __xn_reg_arg5(regs), sizeof(tv)))
>> -			return -EFAULT;
>> -
>> -		if (__xn_copy_from_user(curr, &tv,
>> +		if (!__xn_access_ok(curr, VERIFY_WRITE,
>> +				    __xn_reg_arg5(regs), sizeof(tv)) ||
>> +		    __xn_copy_from_user(curr, &tv,
>>  					(void __user *)__xn_reg_arg5(regs),
>>  					sizeof(tv)))
>>  			return -EFAULT;
>=20
> Ok.
>=20
>> @@ -2407,19 +2406,17 @@ static int __select(struct task_struct *curr, =
struct pt_regs *regs)
>>  	}
>> =20
>>  	nfds =3D __xn_reg_arg1(regs);
>> +	fds_size =3D __FDELT(nfds + __NFDBITS - 1) * sizeof(long);
>> =20
>>  	for (i =3D 0; i < XNSELECT_MAX_TYPES; i++)
>>  		if (ufd_sets[i]) {
>>  			in_fds[i] =3D &in_fds_storage[i];
>>  			out_fds[i] =3D & out_fds_storage[i];
>> -			if (__xn_access_ok(curr, VERIFY_WRITE,
>> -					   ufd_sets[i], sizeof(fd_set)))
>> -				return -EFAULT;
>> -
>> -			if (__xn_copy_from_user(curr, in_fds[i],
>> +			if (!__xn_access_ok(curr, VERIFY_WRITE,
>> +					    ufd_sets[i], fds_size) ||
>=20
> I do not think this is a good idea. There is no special mention to it i=
n
> select specification, but at least select prototype suggests that the
> user-space structure should be a valid fd_set, not a partial subset of =
it.

Yeah, and we copy a full set back. Missed that, will update both patches.=


Jan


--------------enig32EFE28045BA8E78C21BE192
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkoDbBMACgkQniDOoMHTA+m9kwCfTh4KCQy4u8xEtrDiod4D8zVi
STcAnjsWmvJ+p73MJkIC51iv2JOZq8Er
=LX8a
-----END PGP SIGNATURE-----

--------------enig32EFE28045BA8E78C21BE192--

