Message-ID: <4A61CEAF.6060902@domain.hid>
Date: Sat, 18 Jul 2009 15:31:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <1247750127.306081.22356.nullmailer@domain.hid>		<1247754601.4228.73.camel@domain.hid>		<1247829470.829653.30773.nullmailer@domain.hid>		<1247832340.4228.132.camel@domain.hid>		<1247837534.904271.19070.nullmailer@domain.hid>	<1247838733.4228.139.camel@domain.hid>	<1247845909.586479.22758.nullmailer@domain.hid>
	<4A618239.90506@domain.hid> <4A61A4BE.5070308@domain.hid>
	<4A61C690.3030306@domain.hid> <4A61C7B6.2080704@domain.hid>
In-Reply-To: <4A61C7B6.2080704@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigB10F8ABB797BC3E4291BB749"
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
--------------enigB10F8ABB797BC3E4291BB749
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gilles Chanteperdrix wrote:
> Jan Kiszka wrote:
>> Gilles Chanteperdrix wrote:
>>> Jan Kiszka wrote:
>>>> Petr Cervenka wrote:
>>>>>>>> Try instrumenting ksrc/skins/native/syscall.c, __rt_task_create(=
), to
>>>>>>>> identify which spot returns -EFAULT. I can't reproduce this issu=
e on a
>>>>>>>> ppc target; I may try over x86 later, but this would speed up th=
ings if
>>>>>>>> you could spot the failing test before I'm able to switch to thi=
s.
>>>>>>>>
>>>>>>> Meanwhile I tried to mess little bit with rt_task_shadow() functi=
on to see, where is the source of -EFAULT. I planned to continue to follo=
w it inside syscall etc.
>>>>>>> But most attempts to confirm, that the value is returned by line:=

>>>>>>> 	err =3D XENOMAI_SKINCALL2(__native_muxid, __native_task_create, =
&bulk,
>>>>>>> 				NULL);
>>>>>> This branches to __rt_task_create in kernel space.
>>>>>>
>>>>> The bulk variable is totally wrong in kernel space:
>>>>> for example (2, 0, 0, 0, 0, 134217728), perhaps always same values.=
 Value 2 could be number of arguments of the skincall.
>>>>> It fails on following line (syscall.c:aprox. 193):
>>>>> 	if (__xn_safe_copy_to_user((void __user *)bulk.a1, &ph, sizeof(ph)=
)) {
>>>>>
>>>>>>> where suprisingly followed by correct behavior. For example follo=
wing (nothing doing) change in the attached patch solves the whole thing:=

>>>>>>> --- /usr/src/xenomai/src/skins/native/task2.c   2009-04-13 19:20:=
18.000000000 +0200
>>>>>>> +++ /usr/src/xenomai/src/skins/native/task.c    2009-07-17 15:06:=
20.000000000 +0200
>>>>>>> @@ -241,6 +241,7 @@
>>>>>>>         pthread_setspecific(__native_tskey, NULL);
>>>>>>>         free(self);
>>>>>>>  #endif /* !HAVE___THREAD */
>>>>>>> +       rt_task_set_mode(0, 0, NULL);
>>>>>>>         return err;
>>>>>>>  }
>>>>>>>
>>>>>>> objdumps of original and changed rt_task_shadow() is in attachmen=
t
>>>>>>>
>>>>>>> I will continue in research, but I'm really not good in dissasemb=
ling nor the register knowledge.
>>>>>>>
>>>>>> Try rebuilding the user-space libs passing --without-__thread to t=
he
>>>>>> configure script.
>>>>>>
>>>>> After rebuilding with "./configure --enable-smp --without-__thread"=
 it works without any problems.
>>>>> Do you already know, where the problem is? What does the "--without=
-__thread" argument mean?
>>>> It's reproducible, will try to understand it. It's either a compiler=
 bug
>>> That would be the second compiler bug with __thread (we have a bug on=

>>> arm). If we add this to the fact that supporting __thread clutters th=
e
>>> code with many #ifdefs, and does not improve performances on other
>>> platforms than x86 where so many cycles are executed by nanosecond th=
at
>>> it does not matter that much, I'd say let's get rid of __thread.
>>>
>>> Besides, it really looks like C++ syntactic sugar where the compiler
>>> makes things behind my back when I use a seemingly simple syntax, it
>>> does not conform with what I would expect from a C compiler.
>>>
>> TLS was just the catalyst. The x86_64 syscall interface is defined in =
a
>> too fragile way. As Petr already noticed, the core of the problem is
>> that the syscall argument &bulk does not reach the kernel. And if you
>> look at the disassembly kubuntu's gcc-4.3.1 generates, it's obvious wh=
y:
>> rdi is not initialized at all with &bulk. For some reason, the compile=
r
>> thinks it could leave this out or rdi would already contain the correc=
t
>> address.
>=20
> Just like the ARM bug.
>=20

What was the precise brokenness you saw? Also a missing syscall argument
initialization? Can you easily reproduce the ARM issue? Would be
interesting to know if '+r' makes a difference there, too.

This is what the xen/hypercall.h states on the "+r":

>  * - Avoid compiler bugs.
>  *    This is the tricky part.  Because x86_32 has such a constrained
>  *    register set, gcc versions below 4.3 have trouble generating
>  *    code when all the arg registers and memory are trashed by the
>  *    asm.  There are syntactically simpler ways of achieving the
>  *    semantics below, but they cause the compiler to crash.
>  *
>  *    The only combination I found which works is:
>  *     - assign the __argX variables first
>  *     - list all actually used parameters as "+r" (__argX)
>  *     - clobber the rest

This does not really match to bug we see on x86_64, but it points into a
more or less similar direction (BTW, it was gcc 4.1.3 on kubuntu, not
4.3.1).

Is it possible that other arch (so far silently) suffer from such issues
with older gcc versions, too?

Jan


--------------enigB10F8ABB797BC3E4291BB749
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkphzrMACgkQniDOoMHTA+kroQCfR45MWtpxx/+V3zZr4+undnzv
jeMAnj9h5Sb1EKmbxveYSTfwz9cUjw+G
=FZQw
-----END PGP SIGNATURE-----

--------------enigB10F8ABB797BC3E4291BB749--

