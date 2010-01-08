Message-ID: <4B4755DA.3060201@domain.hid>
Date: Fri, 08 Jan 2010 16:57:14 +0100
From: Stefan Kisdaroczi <kisda@domain.hid>
MIME-Version: 1.0
References: <4B45F088.9010603@domain.hid>
	<4B45F163.4000504@domain.hid>	<4B460255.30200@domain.hid>
	<4B46125D.4010602@domain.hid>	<4B471B48.6040301@domain.hid>
	<4B471D96.7050001@domain.hid>	<4B473206.90209@domain.hid>
	<4B47338E.9080304@domain.hid>	<4B4735F4.6060503@domain.hid>
	<4B4738FE.4020605@domain.hid> <4B473A59.4090905@domain.hid>
In-Reply-To: <4B473A59.4090905@domain.hid>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigDEA9F47E4F85173319A57900"
Subject: Re: [Xenomai-help] native skin 2.5.0: rt_task_create() segfaults if
 stacksize parameter too small
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
Cc: xenomai@xenomai.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEA9F47E4F85173319A57900
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 08.01.2010 14:59, schrieb Stefan Kisdaroczi:
> Am 08.01.2010 14:54, schrieb Gilles Chanteperdrix:
>> Stefan Kisdaroczi wrote:
>>> Am 08.01.2010 14:30, schrieb Gilles Chanteperdrix:
>>>> Stefan Kisdaroczi wrote:
>>>>> Am 08.01.2010 12:57, schrieb Gilles Chanteperdrix:
>>>>>> Stefan Kisdaroczi wrote:
>>>>>>> Am 07.01.2010 17:57, schrieb Gilles Chanteperdrix:
>>>>>>>> Stefan Kisdaroczi wrote:
>>>>>>>>> Am 07.01.2010 15:36, schrieb Gilles Chanteperdrix:
>>>>>>>>>> Stefan Kisdaroczi wrote:
>>>>>>>>>>> hi,
>>>>>>>>>>>
>>>>>>>>>>> i have upgraded xenomai to 2.5.0 (x86,32bit). My application =
segfaults when I
>>>>>>>>>>> try to create a task with stacksize 2048, this worked with 2.=
4.10.
>>>>>>>>>>> Because my app is written in pascal i have reproduced the pro=
blem with the
>>>>>>>>>>> xenomai trivial-periodic.c example:
>>>>>>>>>>>
>>>>>>>>>>> -	rt_task_create(&demo_task, "trivial", 0, 99, 0);
>>>>>>>>>>> +	rt_task_create(&demo_task, "trivial",16911, 99, 0);
>>>>>>>>>>>
>>>>>>>>>>> Stacksize 0 -> default stack size : ok
>>>>>>>>>>> Stacksize > 0 and <=3D 16911 : Segmentation fault
>>>>>>>>>>> Stacksize >=3D 16912 : ok
>>>>>>>>>>>
>>>>>>>>>>> Any hints ?
>>>>>>>>>> What does the task do? If it uses printf, printf needs a lot o=
f room on
>>>>>>>>>> the stack.
>>>>>>>>>>
>>>>>>>>> To clarify:
>>>>>>>>> It does not depend on the task body, the task is not even start=
ed.
>>>>>>>>> The segfault happens when calling rt_task_create(), before rt_t=
ask_start()
>>>>>>>>> is called.
>>>>>>>> Actually, when calling rt_task_create, the thread is created, un=
der the
>>>>>>>> hood, and waits to be started. So the segmentation fault is most=

>>>>>>>> certainly due to a stack overflow in the newly created thread.
>>>>>>>>
>>>>>>>> And I am afraid I know why it happens: the newly merged user-spa=
ce
>>>>>>>> signals support requires roughly 16 * sizeof(struct siginfo) on =
stack.
>>>>>>>> But this amounts to two Kbytes here. Could you run the following=
 program
>>>>>>>> on your target ?
>>>>>>> salut gilles,
>>>>>>>
>>>>>>> as the stacksize is already checked and increased to PTHREAD_STAC=
K_MIN if
>>>>>>> the value is too small, i suggest to take the stacksize needed by=
 xenomai
>>>>>>> into account too. The attached patch is clearly wrong, but it sol=
ved the
>>>>>>> problem for me.
>>>>>> PTHREAD_STACK_MIN varies a lot depending on architectures and even=

>>>>>> depending on the glibc versions. Which is why we took 32 Kb as the=

>>>>>> default stack size. Since the default is enough even for struct xn=
sig,
>>>>>> if you are asking a smaller size, you may have good reasons to do =
so. We
>>>>>> should check that the size is at least sizeof(struct xnsig), but s=
ince
>>>>>> PTHREAD_STACK_MIN is larger than struct xnsig, it should work as i=
s.
>>>>>>
>>>>>> The point is that your system seems to require 16 Kb whereas
>>>>>> sizeof(struct xnsig) is only 2Kb. So, there is something wrong som=
ewhere
>>>>>> else.
>>>>>>
>>>>>> Could you run the segfaulting program inside gdb, and print the fr=
ames
>>>>>> infos ?
>>>>> gdb logfile attached
>>>> Ok. Could you get the value of the "esp" register at the time of the=

>>>> failure, as well as the contents of /proc/<pid>/smaps where <pid> is=
 the
>>>> pid of the failing application ? You can run the cat /proc/<pid>/sma=
ps
>>>> when the process is stopped in gdb.
>>
>> How much is PTHREAD_STACK_MIN on your system by the way ?
>>
>=20
> 16 kbyte defined in /usr/include/bits/local_lim.h

I still think that the idea behind my patch was not so bad and that the
problem is simply because the value is calculated to small.

I have found the following sentence at [1] & [2]:
"You can get the absolute minimum limit on stack size by calling the macr=
o
PTHREAD_STACK_MIN, which returns the amount of stack space required for a=

thread that executes a NULL procedure."

As the xnsig structure needs 2k on the stack, its not a "NULL procedure".=

For me that means that if _my_ main task function is a "NULL procedure",
I need at least PTHREAD_STACK_MIN + XN_STACK_MIN.
XN_STACK_MIN =3D sizeof(xnsig) + ? -> 4k ?

Finally, as I don't know and dont want to know that values in my app,
and they can change with newer glibc's and xenomai, I think the minimal
stacksize should be calculated like this ( if stksize !=3D 0 ) :

  stacksize =3D PTHREAD_STACK_MIN + XN_STACK_MIN + stksize;

This way, my main task function has always the same free stacksize when
called, and I know how much I need (at least I think I know ;-). If it
still segfaults, its in my code and its my fault.

But I may be completely wrong.
kisda

[1] http://nortul.com/linux/C_language_adv/node30.html
[2] http://docsun.cites.uiuc.edu/sun_docs/C/solaris_9/SUNWdev/MTP/p18.htm=
l


--------------enigDEA9F47E4F85173319A57900
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFLR1XfIPTw9rIdn6oRAipiAJ4+AipM4x6zQJdD/7lvk7lTDWvwqwCfdxfX
ocylLHekc1PX7DHVW+xysk8=
=5IHu
-----END PGP SIGNATURE-----

--------------enigDEA9F47E4F85173319A57900--

