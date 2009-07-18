Message-ID: <4A61C690.3030306@domain.hid>
Date: Sat, 18 Jul 2009 14:56:48 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1247750127.306081.22356.nullmailer@domain.hid>		<1247754601.4228.73.camel@domain.hid>		<1247829470.829653.30773.nullmailer@domain.hid>		<1247832340.4228.132.camel@domain.hid>		<1247837534.904271.19070.nullmailer@domain.hid>	<1247838733.4228.139.camel@domain.hid>	<1247845909.586479.22758.nullmailer@domain.hid>
	<4A618239.90506@domain.hid> <4A61A4BE.5070308@domain.hid>
In-Reply-To: <4A61A4BE.5070308@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig19F67C5092935045CD1DDFAD"
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Petr Cervenka <grugh@domain.hid>, xenomai-help <xenomai@xenomai.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig19F67C5092935045CD1DDFAD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Petr Cervenka wrote:
>>>>>> Try instrumenting ksrc/skins/native/syscall.c, __rt_task_create(),=
 to
>>>>>> identify which spot returns -EFAULT. I can't reproduce this issue =
on a
>>>>>> ppc target; I may try over x86 later, but this would speed up thin=
gs if
>>>>>> you could spot the failing test before I'm able to switch to this.=

>>>>>>
>>>>> Meanwhile I tried to mess little bit with rt_task_shadow() function=
 to see, where is the source of -EFAULT. I planned to continue to follow =
it inside syscall etc.
>>>>> But most attempts to confirm, that the value is returned by line:
>>>>> 	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, &b=
ulk,
>>>>> 				NULL);
>>>> This branches to __rt_task_create in kernel space.
>>>>
>>> The bulk variable is totally wrong in kernel space:
>>> for example (2, 0, 0, 0, 0, 134217728), perhaps always same values. V=
alue 2 could be number of arguments of the skincall.
>>> It fails on following line (syscall.c:aprox. 193):
>>> 	if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph)))=
 {
>>>
>>>>> where suprisingly followed by correct behavior. For example followi=
ng (nothing doing) change in the attached patch solves the whole thing:
>>>>> --- /usr/src/xenomai/src/skins/native/task2.c   2009-04-13 19:20:18=
=2E000000000 +0200
>>>>> +++ /usr/src/xenomai/src/skins/native/task.c    2009-07-17 15:06:20=
=2E000000000 +0200
>>>>> @@ -241,6 +241,7 @@
>>>>>         pthread_setspecific(__native_tskey, NULL);
>>>>>         free(self);
>>>>>  #endif /* !HAVE___THREAD */
>>>>> +       rt_task_set_mode(0, 0, NULL);
>>>>>         return err;
>>>>>  }
>>>>>
>>>>> objdumps of original and changed rt_task_shadow() is in attachment
>>>>>
>>>>> I will continue in research, but I'm really not good in dissasembli=
ng nor the register knowledge.
>>>>>
>>>> Try rebuilding the user-space libs passing --without-__thread to the=

>>>> configure script.
>>>>
>>> After rebuilding with "./configure --enable-smp --without-__thread" i=
t works without any problems.
>>> Do you already know, where the problem is? What does the "--without-_=
_thread" argument mean?
>> It's reproducible, will try to understand it. It's either a compiler b=
ug
>=20
> That would be the second compiler bug with __thread (we have a bug on
> arm). If we add this to the fact that supporting __thread clutters the
> code with many #ifdefs, and does not improve performances on other
> platforms than x86 where so many cycles are executed by nanosecond that=

> it does not matter that much, I'd say let's get rid of __thread.
>=20
> Besides, it really looks like C++ syntactic sugar where the compiler
> makes things behind my back when I use a seemingly simple syntax, it
> does not conform with what I would expect from a C compiler.
>=20

TLS was just the catalyst. The x86_64 syscall interface is defined in a
too fragile way. As Petr already noticed, the core of the problem is
that the syscall argument &bulk does not reach the kernel. And if you
look at the disassembly kubuntu's gcc-4.3.1 generates, it's obvious why:
rdi is not initialized at all with &bulk. For some reason, the compiler
thinks it could leave this out or rdi would already contain the correct
address.

However, I successfully applied the pattern Xen hypercalls use ("+r"
in/out arguments). Will switch Xenomai to this scheme (which is also
easier readable) and will fold in the 32-bit version at this chance, too.=


Jan


--------------enig19F67C5092935045CD1DDFAD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkphxpcACgkQniDOoMHTA+m1cACePVZohJgISRDCXp42NDGgPyOX
c70AniEOr+eU2OXCJo9EiJvCH+7SC/qD
=iFQQ
-----END PGP SIGNATURE-----

--------------enig19F67C5092935045CD1DDFAD--

