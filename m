Message-ID: <4C6A8332.5050308@domain.hid>
Date: Tue, 17 Aug 2010 14:40:18 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6A8194.80008@domain.hid>
	<1282048491.5255.92.camel@domain.hid>
In-Reply-To: <1282048491.5255.92.camel@domain.hid>
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
> On Tue, 2010-08-17 at 14:33 +0200, Gilles Chanteperdrix wrote:
>> Krzysztof B=C5=82aszkowski wrote:
>>> Hello,
>>>
>>> I found recently that large application uses to segfault before fork(=
)
>>> leaves its glibc wrapper.
>>>
>>> I included here a test suite which can be easily used to verify what
>>> goes wrong. It may be necessary to adjust makefile to compile the cod=
e.
>>> So, the console is missing output from line #89. We can see instead a=

>>> message that getpid couldn't be linked which is 1st sign of memory
>>> corruption.
>>>
>>> i used to think that this issue could be related to not unbinding hea=
p
>>> before fork() but it turned out that it is enough to link userspace w=
ith
>>> xenomai libraries.
>>>
>>> I wonder if this is known issue and if there is any fix, does 2.5.4 w=
ork
>>> same ? or maybe there is something wrong with the kernel i use (or ad=
eos
>>> patch)
>>>
>>> Another question is why rt_task_create() is marked deprecated in nati=
ve
>>> skin. Does it mean that native skin is going to be removed from sourc=
e
>>> tree ?
>> The libc on the system you run the test is not the same as the one of
>> the compiler. Please re-run the test when using the same libc on the
>> test board as on the machine where you are compiling.
>=20
>=20
> I reckon you missed the clue. On the other hand: how can you explain
> that main process even started ? and only child failed ?
>=20
> and indeed i compile code on one box but run on another anyway both
> rootfs'es are "bit equal".

No. As witnessed by the message:
=2E/xeno-shmem-fork: relocation error: ./xeno-shmem-fork: symbol getpid,
version GLIBC_2.0 not defined in file libc.so.6 with link time reference

The run-time glibc is not the same as the compile-time glibc. The glibc
are mostly ABI compatible, but maybe not the fork wrapper, so, to rule
this out, please re-run the test with the correct glibc.

--=20
					    Gilles.


