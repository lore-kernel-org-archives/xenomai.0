Date: Mon, 9 Apr 2018 18:27:10 +0200
From: Henning Schild <henning.schild@siemens.com>
Message-ID: <20180409182710.0398abba@mmd1pvb1c.ad001.siemens.net>
In-Reply-To: <c4ba316c-946d-3247-e291-8fb5a9d1a83e@alaxarxa.net>
References: <99BAB48E90E86D42AD41F0BCE3225AEB019FC0631A@GRZSMS582.andritz.com>
 <bbb33d4c-e8d0-b383-0424-d99592486988@siemens.com>
 <99BAB48E90E86D42AD41F0BCE3225AEB019FC066DF@GRZSMS582.andritz.com>
 <20180406104729.0a46cb24@mmd1pvb1c.ad001.siemens.net>
 <c4ba316c-946d-3247-e291-8fb5a9d1a83e@alaxarxa.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] building Xenomai Apps with CMake (RFC)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: "Xenomai (xenomai@xenomai.org)" <xenomai@xenomai.org>, Jan Kiszka <jan.kiszka@siemens.com>

Am Fri, 6 Apr 2018 17:33:20 +0200
schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:

> Hi,
>=20
> On 06/04/18 10:47, Henning Schild wrote:
>=20
> [...]
>=20
> >>  >Thanks for sharing this. IIRC, we have some Xeommai user
> >>  >in-house as well who looked into cmake, need to check the status
> >>  >and scope again (maybe Henning knows more). Could be
> >>  >interesting, indeed.   =20
> >>
> >> If I may ask, are you using the "boostraps" from Xenomai or some
> >> own init-code? (that=E2=80=99s currently the biggest headache remainin=
g) =20
> >=20
> > No, i do not know anyone using CMake with Xenomai, so i would not
> > know how to deal with bootstrap there. =20
>=20
> I use CMake ...
>=20
> >>  >
> >>  >For my understanding: You need cmake upstream changes to make
> >>  >things work? Or is this project something that could eventually
> >>  >be carried in Xenomai upstream, just requiring some cmake
> >>  >version >=3D X?   =20
> >>
> >> No strict need to upstream the scripts in either Xenomai or CMake,
> >> the files just need to be in the search-path of CMake to be usable
> >> (likely doesnt need anything newer than CMake 3.0 but would need to
> >> test this). I value the feedback from both communities,
> >> particularly because I don=E2=80=99t use anything but the Posix/Cobalt
> >> Skin and getting it into CMake would be the best thing for
> >> maintenance. =20
> >=20
> > It would probably be a good idea to try and mainline it in one of
> > the two projects. And my guess is that CMake would not really fit
> > and they might not want such code.
> >  =20
> >> Nevertheless it could be really helpful to add a headerfile in the
> >> Xenomai distribution, replicating the steps that
> >> 'boilerplate/init/bootstrap.c' does, and allowing to disable parts
> >> of the functionality like the main wrapper. That glue code would
> >> ideally be built together with libraries/executables using it
> >> (identical flags and such). Right now the code is mostly
> >> duplicated and placed with the CMake Scripts, which is not ideal. =20
> >=20
> > I did not fully understand the bootstrap with regard to cmake yet.
> > But the magic wrapping is not pretty, also in other regards. So
> > patches that improve that, while actually targeting something like
> > CMake, would be welcome. =20
>=20
> Maybe I didn't understood deeply the problem here, but when I switch
> to Xenomai -3 I got it.
>=20
> When you were working with Xenomai-2, and you create your program,
> then using xeno-config you could obtain your main information to
> compile and link.
>=20
> So, if you want to build your posix program, xeno-config gave you:
>=20
> $ xeno-config --skin posix --ldflags
> -Wl,@/usr/lib/x86_64-linux-gnu/posix.wrappers
> -L/usr/lib/x86_64-linux-gnu -lpthread_rt -lxenomai -lpthread -lrt
>=20
> $ xeno-config --skin posix --cflags
> -I/usr/include/xenomai -D_GNU_SOURCE -D_REENTRANT -D__XENO__
> -I/usr/include/xenomai/posix
>=20
>=20
> With Xenomai-3, you obtain similar parameters with cflags:
>=20
> $ xeno-config --skin posix --cflags
> -I/usr/include/xenomai/cobalt -I/usr/include/xenomai -g -O2
> -fdebug-prefix-map=3D/build/xenomai-3.0.6+ds2rtnet=3D.
> -fstack-protector-strong -Wformat -Werror=3Dformat-security -Wdate-time
> -D_FORTIFY_SOURCE=3D2 -fno-omit-frame-pointer -D_GNU_SOURCE
> -D_REENTRANT -fasynchronous-unwind-tables -D__COBALT__
> -D__COBALT_WRAP__
>=20
> But, ldflags:
>=20
> $ xeno-config --skin posix --ldflags
> -Wl,--no-as-needed -Wl,@/usr/lib/x86_64-linux-gnu/cobalt.wrappers
> -Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappers
> /usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o -Wl,--wrap=3Dmain
> -Wl,--dynamic-list=3D/usr/lib/x86_64-linux-gnu/dynlist.ld
> -L/usr/lib/x86_64-linux-gnu -lcobalt -lmodechk -lpthread -lrt
> -Wl,-z,relro -Wl,-z,now -Wl,--as-needed   -lfuse -pthread
>=20
> Here note that to your program you must add and object:
> /usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o
>=20
> that depends on the --auto-init|auto-init-solib|no-auto-init option
> and could be:
>=20
> - none (--no-auto-init)
> - bootstrap-pic.o (--auto-init-solib)
> - bootstrap.o (--auto-init or default)
>=20
> To me the questions then are:
> - The code there could be encapsulated in a header?
> - or could be put in a lib?
> - only could be done in this way?

Ok, i am starting to understand the issue here. A lib or header sounds
good, if that can be done.

> Regarding to CMake, I solved this passing this arguments to VARS to
> cmake. So, tge FindXenomai was a simple wrapper to xeno-config to
> obtain the correct values to build the xeno application.
>=20
> If my memory doesn't fail it was something that Gilles recommend some
> years ago. The best way to build a xenomai application is to use the
> xeno-config output to obtain the correct values.

Yes, no matter what build system you should call xeno-config from it,
and not copy and paste its output around.

> So, my point of view is that you don't have to modify anything from
> Xenomai to use it with CMake. Another thing is the bootstrap stuff
> that maybe it's a bit ugly.
>
>=20
> > Now regarding CMake itself. Is not one of its main purposes to be
> > platform independant, that does not seem to be too useful for
> > Xenomai. =20
>=20
> I don't understand exactly what do you want to say. CMake, from its
> webpage [1]
>=20
> "CMake is an open-source, cross-platform family of tools designed to
> build, test and package software."
>=20
> It's a cross-platform. I have used it in MacOSX, GNU/Linux and
> MSWindows, (of course that can work with all the Unix flavours) so, I
> don't understand why are you saying that "does not seem to be useful
> for Xenomai"

Sure i know cmake and use it myself, it can be useful. That comment was
to prepare an argument against merging cmake-specific changes into
Xenomai. Because there are many useful build-systems, tools etc. But it
is not the job of this project to cater for them.
Improve the bootstrap to enable cmake and others, Sure. Add
FindXenomai ... not so sure. ... IMHO

We had a similar discussion of whether or not to drop /debian/ because
it just caters for one of many distros. In this case i was actually for
keeping it ;).

>=20
> > And there is a zoo of such build systems out there, what about
> > bazel, scons, rake ... ? So i guess i am against adding support for
> > any such thing to xenomai, especially if its OS abstractions do not
> > match -- like it seems to be the case for CMake. =20
>=20
> Well, I would prefer that Xenomai works with any build system ...

Same here.

Henning

> Leopold
>=20
>=20
> [1] www.cmake.org


