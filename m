Message-ID: <4C6B146D.9010004@domain.hid>
Date: Wed, 18 Aug 2010 00:59:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>
In-Reply-To: <1282047938.5255.89.camel@domain.hid>
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
To: =?UTF-8?B?S3J6eXN6dG9mIELFgmFzemtvd3NraQ==?= <kb@domain.hid>
Cc: xenomai@xenomai.org

Krzysztof B=C5=82aszkowski wrote:
> Hello,
>=20
> I found recently that large application uses to segfault before fork()
> leaves its glibc wrapper.
>=20
> I included here a test suite which can be easily used to verify what
> goes wrong. It may be necessary to adjust makefile to compile the code.=

> So, the console is missing output from line #89. We can see instead a
> message that getpid couldn't be linked which is 1st sign of memory
> corruption.
>=20
> i used to think that this issue could be related to not unbinding heap
> before fork() but it turned out that it is enough to link userspace wit=
h
> xenomai libraries.
>=20
> I wonder if this is known issue and if there is any fix, does 2.5.4 wor=
k
> same ? or maybe there is something wrong with the kernel i use (or adeo=
s
> patch)
>=20
> Another question is why rt_task_create() is marked deprecated in native=

> skin. Does it mean that native skin is going to be removed from source
> tree ?

Ok. Tried your test on:
- 2.6.33 armv5
- 2.6.34 x86_64
- 2.6.31 x86_64
- 2.6.31 x86_32

And everything works fine.

The result of the last experience is:
# xeno-shmem-fork
main:43 heap 0xb76be000
/root
main:60 [4365] pid 4367
main:53
main:54 [4367] pid 0
main:63 [4365] pid 4367, status 00000b00
main:64 [4365] pid 4367, WIFSIGNALED 0, WIFEXITED 1, rc 11
0
# cat /proc/ipipe/version
2.4-09
# cat /proc/xenomai/version
2.5.4
# uname -a
Linux atom 2.6.31.8 #5 SMP Wed Aug 18 00:44:17 CEST 2010 i686 GNU/Linux

There does not seem to be anything wrong in xenomai rt_heap code, as
this code is platform-independent, so if there was something wrong with
it, we would see it on all platforms.

Some clues about what could be wrong:
- I am not sure your makefile works: the .o file has the same name for
the kernel module and the executable. I do not think this could matter
(if you could get it wrong, the module or the executable would not run),
but in any case, this is a bad idea, and since the kernel module and
user-space application do not share any code, it seems simpler to put
them in separate files.
- I have not really checked your user-space compilation flags, I am
using xeno-config to get the correct ones.
- your user-space code was missing #include <unistd.h>
- some subtle difference in the glibc
- some x86_32 specific I-pipe bug triggered by some kernel configuration
option
- some local patches in your kernel

In any case, without further information, it is hard for me to dig any
further tonight. Regards.

--=20
					    Gilles.


