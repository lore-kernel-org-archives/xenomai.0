Message-ID: <4B8C2C40.1070209@domain.hid>
Date: Mon, 01 Mar 2010 22:06:08 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>	<4B8C2490.1040604@domain.hid>
	<4B8C25B9.8090705@domain.hid>	<4B8C26F7.3020306@domain.hid>
	<4B8C2797.2000501@domain.hid> <4B8C29E1.7070404@domain.hid>
	<4B8C2B08.8080907@domain.hid> <4B8C2B76.9020405@domain.hid>
In-Reply-To: <4B8C2B76.9020405@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigADAE7417B3B4FDC35AAA9BDC"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] mlockall error after calling mlockall()
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADAE7417B3B4FDC35AAA9BDC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Gilles Chanteperdrix wrote:
>>> Try this:
>>>
>>> diff --git a/ksrc/skins/native/syscall.c b/ksrc/skins/native/syscall.=
c
>>> index 40e5cfd..d4e885c 100644
>>> --- a/ksrc/skins/native/syscall.c
>>> +++ b/ksrc/skins/native/syscall.c
>>> @@ -1869,9 +1869,12 @@ static int __rt_cond_wait_prologue(struct pt_r=
egs *regs)
>>>
>>>         err =3D rt_cond_wait_prologue(cond, mutex, &lockcnt, timeout_=
mode, timeout);
>>>
>>> -       if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT)
>>> -               err =3D rt_cond_wait_epilogue(mutex, lockcnt);
>>> -
>>> +       if (err =3D=3D 0 || err =3D=3D -ETIMEDOUT) {
>>> +               int loc_err =3D rt_cond_wait_epilogue(mutex, lockcnt)=
;
>>> +               if (loc_err < 0)
>>> +                       err =3D loc_err;
>>> +       }
>>> +
>>>         if (err =3D=3D -EINTR && __xn_reg_arg3(regs)
>>>             && __xn_safe_copy_to_user((void __user *)__xn_reg_arg3(re=
gs),
>>>                                       &lockcnt, sizeof(lockcnt)))
>> No. That is not ok either. We need to store the first status somewhere=

>> for returning it to user-space after looping several times in the
>> epilogue function.
>=20
> Precisely (also in user space).
>=20

As we do not specify if rt_cond_wait behaves like pthread_cond_wait on
signals or errors of the cond variable, I checked the 2.4 behavior
again: we used to ignore all errors of the final rt_mutex_lock. Guess we
should restore that for all contexts (except for -EINTR).

Jan


--------------enigADAE7417B3B4FDC35AAA9BDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMLEAACgkQitSsb3rl5xR5yACbBxZAECQWf4nb6sii4pMkk88R
BvIAn2eVr8mBMAEhNtSWBpiYiX27lOQT
=4qdm
-----END PGP SIGNATURE-----

--------------enigADAE7417B3B4FDC35AAA9BDC--

