Message-ID: <4B8CCE15.5060706@domain.hid>
Date: Tue, 02 Mar 2010 09:36:37 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <CF7FB0793253794F9F45991443E5FE2006483DE98C@us194mx002.tycoelectronics.net>	<4B86EDC2.7010905@domain.hid>	<4B86FCBB.10203@domain.hid>	<4B86FFA0.3000403@domain.hid>	<4B870134.2040802@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98D@us194mx002.tycoelectronics.net>	<4B87FC70.90903@domain.hid>	<CF7FB0793253794F9F45991443E5FE2006483DE98F@us194mx002.tycoelectronics.net>	<CF7FB0793253794F9F45991443E5FE2006483DE993@domain.hid>	<4B8C2490.1040604@domain.hid>
	<4B8C25B9.8090705@domain.hid>	<4B8C26F7.3020306@domain.hid>
	<4B8C2797.2000501@domain.hid>	<4B8C29E1.7070404@domain.hid>
	<4B8C2B3E.8020505@domain.hid>	<4B8C2C35.6030006@domain.hid>
	<4B8C2FE6.5000406@domain.hid>	<4B8C30DA.3000705@domain.hid>
	<4B8C33FC.3080806@domain.hid>	<4B8C358E.9050303@domain.hid>
	<4B8CCC56.3000709@domain.hid>
In-Reply-To: <4B8CCC56.3000709@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6FC880998E86FA005B1867D0"
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
--------------enig6FC880998E86FA005B1867D0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>> Jan Kiszka wrote:
>>>> Jan Kiszka wrote:
>>>>> Gilles Chanteperdrix wrote:
>>>>>> Jan Kiszka wrote:
>>>>>>> Same issue exists in user space. And rt_cond_wait_inner needs fix=
ing.
>>>>>>> And then there is a spurious sign inversion:
>>>>>>>
>>>>>>> diff --git a/src/skins/native/cond.c b/src/skins/native/cond.c
>>>>>>> index 478321d..f874678 100644
>>>>>>> --- a/src/skins/native/cond.c
>>>>>>> +++ b/src/skins/native/cond.c
>>>>>>> @@ -96,9 +96,9 @@ int rt_cond_wait_until(RT_COND *cond, RT_MUTEX =
*mutex, RTIME timeout)
>>>>>>>  				&saved_lockcnt, XN_REALTIME, &timeout);
>>>>>>> =20
>>>>>>>  	while (err =3D=3D -EINTR)
>>>>>>> -		err =3D -XENOMAI_SKINCALL2(__native_muxid,
>>>>>>> -					 __native_cond_wait_epilogue, mutex,
>>>>>>> -					 saved_lockcnt);
>>>>>>> +		err =3D XENOMAI_SKINCALL2(__native_muxid,
>>>>>>> +					__native_cond_wait_epilogue, mutex,
>>>>>>> +					saved_lockcnt);
>>>>>>>  #endif /* !CONFIG_XENO_FASTSYNCH */
>>>>>> Ok for the sign inversion, but in this case the status is Ok. We c=
all
>>>>>> cond_wait_epilogue only if prologue returned -EINTR, and update th=
e
>>>>>> status, this is what we want.
>>>>>>
>>>>>> There is only one way out which will not break the ABI: do not cal=
l
>>>>>> cond_wait_epilogue in the kernel-space cond_wait_prologue.
>>>>>>
>>>>> Unfortunately, that ABI is broken: If we get -ETIMEDOUT on cond wai=
t an
>>>>> -EINTR on mutex lock, we lose the former, don't we?
>>>>>
>>>>> If we can't find a workaround, I'm for breaking the ABI for this
>>>>> particular service - but let's search for an alternative first.
>>>>>
>>>> The only way around ABI changes: save the return code of cond_wait
>>>> /somewhere/ across prologue and epilogue syscalls - but where???
>>>>
>>> In-kernel RT_TASK, that's probably the only place. Once
>>> __rt_cond_wait_epilogue has acquired the mutex (or failed without
>>> receiving a -EINTR), it can then pick up the original error that this=

>>> task received from rt_cond_wait_prologue and return it. What do you t=
hink?
>> I was thinking about the same idea, by using the xnthread errno.
>> However, it is not reentrant, in the sense that if a signal handler
>> emits a syscall which overrides this value, we are toast.
>=20
> Right. But that's the price someone unable/unwilling to update their
> user space libs along with the next kernel update will have to pay. I
> don't expect there are many, though, and the sketched scenario is fairl=
y
> uncommon as well.
>=20
> So let's head this way: Install some workaround for the existing
> __rt_cond_wait_prologue syscall, but also introduce
> __rt_cond_wait_prologue2 which writes the cond-wait error code back lik=
e
> it already happens for lockcnt. That syscall is used by updated user
> space libs if they find it, otherwise we fall back to the old pattern.
>=20

Ah, and as it looks like, we also need a __pthread_cond_wait_prologue2.
Hope that's all then.

Jan


--------------enig6FC880998E86FA005B1867D0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkuMzhUACgkQitSsb3rl5xTw5wCg1JxuGiEOAUUs8vyUKhsRqV+i
rmIAoLPn/daSjD+uVJtLonV1FE2vp/wD
=fDAl
-----END PGP SIGNATURE-----

--------------enig6FC880998E86FA005B1867D0--

