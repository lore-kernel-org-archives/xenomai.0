Message-ID: <4B8C30DA.3000705@domain.hid>
Date: Mon, 01 Mar 2010 22:25:46 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>
	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>
	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>
	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>
	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>
	<4B8C2490.1040604@domain.hid> <4B8C25B9.8090705@domain.hid>
	<4B8C26F7.3020306@domain.hid> <4B8C2797.2000501@domain.hid>
	<4B8C29E1.7070404@domain.hid> <4B8C2B3E.8020505@domain.hid>
	<4B8C2C35.6030006@domain.hid> <4B8C2FE6.5000406@domain.hid>
In-Reply-To: <4B8C2FE6.5000406@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF0D070D584B268E76912FDD3"
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
--------------enigF0D070D584B268E76912FDD3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Same issue exists in user space. And rt_cond_wait_inner needs fixing.=

>>> And then there is a spurious sign inversion:
>>>
>>> diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c
>>> index 478321d..f874678 100644
>>> --- a/src/skins/native/cond.c
>>> +++ b/src/skins/native/cond.c
>>> @@ -96,9 +96,9 @@ int rt_cond_wait_until(RT_COND *cond, RT_MUTEX *mut=
ex, RTIME timeout)
>>>  				&saved_lockcnt, XN_REALTIME, &timeout);
>>> =20
>>>  	while (err =3D=3D -EINTR)
>>> -		err =3D -XENOMAI_SKINCALL2(__native_muxid,
>>> -					 __native_cond_wait_epilogue, mutex,
>>> -					 saved_lockcnt);
>>> +		err =3D XENOMAI_SKINCALL2(__native_muxid,
>>> +					__native_cond_wait_epilogue, mutex,
>>> +					saved_lockcnt);
>>>  #endif /* !CONFIG_XENO_FASTSYNCH */
>> Ok for the sign inversion, but in this case the status is Ok. We call
>> cond_wait_epilogue only if prologue returned -EINTR, and update the
>> status, this is what we want.
>>
>> There is only one way out which will not break the ABI: do not call
>> cond_wait_epilogue in the kernel-space cond_wait_prologue.
>>
>=20
> Unfortunately, that ABI is broken: If we get -ETIMEDOUT on cond wait an=

> -EINTR on mutex lock, we lose the former, don't we?
>=20
> If we can't find a workaround, I'm for breaking the ABI for this
> particular service - but let's search for an alternative first.
>=20

The only way around ABI changes: save the return code of cond_wait
/somewhere/ across prologue and epilogue syscalls - but where???

Jan


--------------enigF0D070D584B268E76912FDD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMMNoACgkQitSsb3rl5xT4jQCgxH1ZSFIWRage+s5DkA3mgXi7
NiQAoJr3wntw82DNwx/18l0SG8okxfIT
=mJLY
-----END PGP SIGNATURE-----

--------------enigF0D070D584B268E76912FDD3--

