Message-ID: <4C6BCB51.4010805@domain.hid>
Date: Wed, 18 Aug 2010 14:00:17 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1282047938.5255.89.camel@domain.hid>	
	<4C6B146D.9010004@domain.hid>
	<1282126974.5255.262.camel@domain.hid>	
	<4C6BBD62.3050907@domain.hid>
	<1282131617.5255.286.camel@domain.hid>
In-Reply-To: <1282131617.5255.286.camel@domain.hid>
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
> On Wed, 2010-08-18 at 13:00 +0200, Gilles Chanteperdrix wrote:
>> Krzysztof B=C5=82aszkowski wrote:
>>> On Wed, 2010-08-18 at 00:59 +0200, Gilles Chanteperdrix wrote:
>>>> - I have not really checked your user-space compilation flags, I am
>>>> using xeno-config to get the correct ones.
>>> xeno-config --skin=3Dnative --cflags gives:
>>>
>>> -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XEN=
O__
>>>
>>>
>>> note that there is no xenomai installed on my r&d server
>>> in /usr/xenomai/
>>>
>>> i build xenomai per kernel and install it in kernel's INSTALL sub-dir=

>>> (DESTDIR=3D) as well as kernel's modules and other related stuff for =
this
>>> particular kernel.
>>> (otherwise i would go mad soon due to various versions ..)
>> xeno-config handles the DESTDIR environment variable (failing to do th=
is
>> would be kind of silly, because a lot of people, including the
>> maintainers, use Xenomai mostly in cross-compiled environment).
>=20
> no, it does not.
>=20
> ./xeno-config
> xeno-config --verbose
>         --version=3D"2.5.4"
>         --cc=3D"gcc"
>         --arch=3D"x86"
>         --prefix=3D"/usr/xenomai"
>         --xeno-cflags=3D"-I/usr/xenomai/include -D_GNU_SOURCE -D_REENTR=
ANT
> -Wall -pipe -D__XENO__"
>         --xeno-ldflags=3D"-L/usr/xenomai/lib -lxenomai -lpthread "
>         --posix-cflags=3D""
> POSIX support is not available
>         --posix-ldflags=3D""
>         --library-dir=3D"/usr/xenomai/lib"
> Usage xeno-config --skin=3Dskinname OPTIONS
> Options :
>         --help
>         --v,--verbose
>         --version
>         --cc
>         --arch
>         --prefix
>         --skin native|posix|psos|rtai|rtdm|uitron|vrtx|vxworks
>         --cflags
>         --ldflags
>         --lib*-dir,--libdir,--user-libdir
>=20
> Deprecated options:
>         --xeno-cflags
>         --xeno-ldflags
>         --posix-cflags
>         --posix-ldflags
>=20
>=20
> while it was built like this:
>=20
> make DESTDIR=3D/root/... install

You are not paying attention. I said it "handles the DESTDIR environment
 variable". So, you should pass DESTDIR as an environment variable to
xeno-config. As in:

DESTDIR=3D/root/.... xeno-config --skin=3Dnative --cflags

The xeno-config script is built when Xenomai is compiled, not installed,
at this point, it would be against the rules to assume that a DESTDIR is
set, and hardcode a DESTDIR value into xeno-config.

See GNU make documentation:
http://www.gnu.org/software/make/manual/html_node/DESTDIR.html

And for a good reason, the final destination of Xenomai on your system
may be different from where you initially installed it. So, handling
DESTDIR dynamically in xeno-config makes things more flexible.

> but there is still a difference in xeno-shmem-fork behavior when linked=

> with pthread or not from command line.

Ok. But linking with pthread is the only supported way of using Xenomai. =
A
>> What version of opensuse?
>=20
> 11.1 - 32. i do not crosscompile on x86_64 to x86 because i have
> encountered various strange mismatches in the past.
>=20
> rather i use native clean x86 environment (on e.g. x86_64)

I do this all the time, and never had any problem.
Also, why not running 64 bits code on your atom? There are some x86_32
only atoms? What about SMP?

By the way, did you forget to semd me your .config ?

--=20
					    Gilles.


