Message-ID: <4C70079D.4010502@domain.hid>
Date: Sat, 21 Aug 2010 19:06:37 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>	
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>	
	<4C6BCB51.4010805@domain.hid>
	<1282133876.5255.296.camel@domain.hid>	
	<4C6BD403.4030902@domain.hid>
	<1282136147.5255.306.camel@domain.hid>	
	<4C6BE297.4060706@domain.hid>
	<1282140262.5255.313.camel@domain.hid>	
	<4C6BE9D3.1080907@domain.hid>
	<1282141537.5255.315.camel@domain.hid>	
	<4C6BEE9B.1080000@domain.hid>
	<1282144162.5255.325.camel@domain.hid>	
	<4C6BF8B1.8080206@domain.hid>
	<1282297638.5255.373.camel@domain.hid>	
	<4C6E50C1.9040700@domain.hid>
	<1282319427.5255.400.camel@domain.hid>
In-Reply-To: <1282319427.5255.400.camel@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-core] xenomai 2.5.3/native, kernel 2.6.31.8 and fork()
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Krzysztof B=C5=82aszkowski wrote:
> On Fri, 2010-08-20 at 11:54 +0200, Gilles Chanteperdrix wrote:
>> Krzysztof B=C5=82aszkowski wrote:
>>>> Yes, now if you find the culprit option, it would be nice to report =
here
>>>> so that we can fix the I-pipe patch.
>>>>
>>>
>>> I do know it still. All i have are two configs. One which does not wo=
rk
>>> and one working. I have tried so far breaking working one and also
>>> fixing broken. Both attempts have been unsuccessful.
>>>
>>> I tried many "obvious" settings mainly in "processor type and feature=
s"
>>> with no luck.
>>>
>>> This process must take some time ( i can't spend whole days on trying=

>>> one-by-one each difference, recompile kernel,ync target's rootfs,
>>> reboot target and run fork regression test even that many steps i hav=
e
>>> automated)
>> ever heard about bisecting ?
>=20
> sure i had.
>=20
>=20
>>  List the diffs between the two configs
>> apply half of them
>> if it still works, apply half of the rest
>> if it does not unapply half of the one you applied
>> etc...
>> if there are 65000 differences, you will get to the result in 16 steps=
=2E
>> you can keep the same rootfs, all you have to do is rebuild the kernel=

>> (without "make clean", so that only what changed in the .config is
>> re-compiled).
>>
>=20
> i used to use more fine grained changes set until it made me tired.
>=20
> and i as you may know most changes in "processor features" lead to
> recompile whole kernel - by not cleaning won't save anything.
>=20
>=20
>> It should take just an hour or two.
>=20
> poss. but i don't think so.

Well actually, bisecting was not the right approach, debugging the
segfault directly worked much better. We have only two atfork handlers,
and one is in the posix skin which Krzysztof test does not use, so we
knew where the bug was...

Anyway, here is the explanation: it is a big fastsync bug. In the atfork
handler, we unmap the father's private semaphore heap, in order to map
the child's private semaphore heap. In order to find the heap size, the
unmapping code issues a system call wich ends up looking for the thread
ppd, in order to find its private heap. The problem is that the thread
has not yet bound any skin, so it has no ppd, and it ends up using the
global ppd instead.

As long as the two heaps use the same size, it works, however, if they
have different sizes, we get a segmentation fault upon the call to munmap=
=2E

But that is not the worse: after unmapping the father's private heap, we
try and map the child's private heap. Here again, we issue the system
call, and here again, we get the global semaphore heaps data, this means
that the global semaphore heap gets used instead of the child's private
semaphore heap. That is definitely a bug, and would cause all sorts of bu=
gs.

Even worse yet, we find that since the child process has not bound any
skin, it is unable to use skins services properly. Only the posix skin
rebinds itself at fork.

So, I propose the following fix:
- in the semaphore heaps atfork handler, unmap the private heap (using
the size which was used at map time), do not remap it.
- register atfork handlers for all skins, in order to rebind them after
fork, so that the skin services may be used in the child, the fork
handler will

There are other issues to consider, such as detecting that a private
mutex created in the father continues to be used in the child.

Any comments, anyone?

--=20
					    Gilles.


