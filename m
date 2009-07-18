Message-ID: <4A618239.90506@domain.hid>
Date: Sat, 18 Jul 2009 10:05:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1247750127.306081.22356.nullmailer@domain.hid>		<1247754601.4228.73.camel@domain.hid>		<1247829470.829653.30773.nullmailer@domain.hid>		<1247832340.4228.132.camel@domain.hid>		<1247837534.904271.19070.nullmailer@domain.hid>	<1247838733.4228.139.camel@domain.hid>
	<1247845909.586479.22758.nullmailer@domain.hid>
In-Reply-To: <1247845909.586479.22758.nullmailer@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2F1E7A333A0A6AF1086BAD57"
Sender: jan.kiszka@domain.hid
Subject: Re: [Xenomai-help] rt_task_shadow returns always -EFAULT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Petr Cervenka <grugh@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F1E7A333A0A6AF1086BAD57
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Petr Cervenka wrote:
>>>> Try instrumenting ksrc/skins/native/syscall.c, __rt_task_create(), t=
o
>>>> identify which spot returns -EFAULT. I can't reproduce this issue on=
 a
>>>> ppc target; I may try over x86 later, but this would speed up things=
 if
>>>> you could spot the failing test before I'm able to switch to this.
>>>>
>>> Meanwhile I tried to mess little bit with rt_task_shadow() function t=
o see, where is the source of -EFAULT. I planned to continue to follow it=
 inside syscall etc.
>>> But most attempts to confirm, that the value is returned by line:
>>> 	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &bul=
k,
>>> 				NULL);
>> This branches to __rt_task_create in kernel space.
>>
>=20
> The bulk variable is totally wrong in kernel space:
> for example (2, 0, 0, 0, 0, 134217728), perhaps always same values. Val=
ue 2 could be number of arguments of the skincall.
> It fails on following line (syscall.c:aprox. 193):
> 	if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph))) {=

>=20
>>> where suprisingly followed by correct behavior. For example following=
 (nothing doing) change in the attached patch solves the whole thing:
>>> --- /usr/src/xenomai/src/skins/native/task2.c   2009-04-13 19:20:18.0=
00000000 +0200
>>> +++ /usr/src/xenomai/src/skins/native/task.c    2009-07-17 15:06:20.0=
00000000 +0200
>>> @@ -241,6 +241,7 @@
>>>         pthread_setspecific(__native_tskey, NULL);
>>>         free(self);
>>>  #endif /* !HAVE___THREAD */
>>> +       rt_task_set_mode(0, 0, NULL);
>>>         return err;
>>>  }
>>>
>>> objdumps of original and changed rt_task_shadow() is in attachment
>>>
>>> I will continue in research, but I'm really not good in dissasembling=
 nor the register knowledge.
>>>
>> Try rebuilding the user-space libs passing --without-__thread to the
>> configure script.
>>
>=20
> After rebuilding with "./configure --enable-smp --without-__thread" it =
works without any problems.
> Do you already know, where the problem is? What does the "--without-__t=
hread" argument mean?

It's reproducible, will try to understand it. It's either a compiler bug
(your kubuntu version is fairly old and also unsupported due to security
flaws), or we actually still have a problems around TLS variables
(Thread Local Storage, that's what --without-__thread disables).

Jan


--------------enig2F1E7A333A0A6AF1086BAD57
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkphgjkACgkQniDOoMHTA+mhYwCbBYTMZsAfz+bOoSGyJVAS5ff9
v6MAnRHTWP5eqsy+7SvbLSmFoB2SXpgJ
=KR1f
-----END PGP SIGNATURE-----

--------------enig2F1E7A333A0A6AF1086BAD57--

