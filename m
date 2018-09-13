Date: Thu, 13 Sep 2018 04:17:42 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <1108941239.3612908.1536830262792.JavaMail.zimbra@wolfram.com>
In-Reply-To: <20180913105443.19a0ff74@md1pvb1c.ad001.siemens.net>
References: <a327adca-1576-0794-71cd-409b366dfdc8@alaxarxa.net>
 <20180913105443.19a0ff74@md1pvb1c.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Order options to build a Xenomai program
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai <xenomai@xenomai.org>


----- Den 13 sep 2018, p=C3=A5 kl 10:54, Henning Schild henning.schild@siem=
ens.com skrev:

> Hey,

> i personally am a bit overwhelmed with the amount of information, and i
> could not clearly spot the issue you seem to have.

> But you might want to have a look at:
> https://github.com/nolange/cmake_xenomai

> Henning

> Am Thu, 6 Sep 2018 11:52:39 +0200
> schrieb Leopold Palomo-Avellaneda <leo@alaxarxa.net>:

> > Hi,


> > I resend this message to the list now that it has again more
> > activity. Maybe some of you cold help me to understand what is wrong
> > here. I'm sorry if it's not appropriate to send again a message to
> > the list.

> > =3D=3D=3D=3D=3D

> > I have an strange problem and I would like to ask if some clever mind
> > can help me.

> > I'm trying to build with cmake (this story is for another mail) a
> > simple example [1] with xenomai 3.0.7. I have some custom macros that
> > basically uses the information from xeno-config.

> > I can build and run the example with the Makefile below in the email.
> > It just works.

> > Narrowing the problem I have obtained the exactly call made by the
> > Makefile created by cmake. It compiles the file using:

> > $ /usr/bin/cc -I/usr/include/xenomai/trank
> > -I/usr/include/xenomai/cobalt -I/usr/include/xenomai
> > -I/usr/include/xenomai/alchemy -D__XENO_COMPAT__ -g -O2
> > -fdebug-prefix-map=3D/build/xenomai-3.0.7+ds1=3D. -fstack-protector-str=
ong
> > -Wformat -Werror=3Dformat-security -Wdate-time -D_FORTIFY_SOURCE=3D2
> > -fno-omit-frame-pointer -D_GNU_SOURCE -D_REENTRANT
> > -fasynchronous-unwind-tables -D__COBALT__ -o
> > CMakeFiles/rtprint.dir/rtprint.c.o -c
> > /home/leopold.palomo/xenomai/cmake/src/native/rtprint.c


> > and links the file using:

> > $ /usr/bin/cc -Wl,--no-as-needed
> > -Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappers
> > /usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o -Wl,--wrap=3Dmain
> > -Wl,--dynamic-list=3D/usr/lib/x86_64-linux-gnu/dynlist.ld -Wl,-z,relro
> > -Wl,-z,now -Wl,--as-needed -pthread CMakeFiles/rtprint.dir/rtprint.c.o
> > -o rtprint -rdynamic -ltrank -lalchemy -lcopperplate -lcobalt
> > -lmodechk -lpthread -lrt -lfuse


> > Using the Makefile attached, to compile, make call gcc with:

> > $ make rtprint.o
> > gcc -c -o rtprint.o rtprint.c -I/usr/include/xenomai/trank
> > -D__XENO_COMPAT__ -I/usr/include/xenomai/cobalt -I/usr/include/xenomai
> > -g -O2 -fdebug-prefix-map=3D/build/xenomai-3.0.7+ds1=3D.
> > -fstack-protector-strong -Wformat -Werror=3Dformat-security -Wdate-time
> > -D_FORTIFY_SOURCE=3D2 -fno-omit-frame-pointer -D_GNU_SOURCE -D_REENTRAN=
T
> > -fasynchronous-unwind-tables -D__COBALT__
> > -I/usr/include/xenomai/alchemy

> > and link with:

> > $ make rtprint
> > gcc -o rtprint rtprint.o -Wl,--no-as-needed -ltrank
> > -Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappers -lalchemy
> > -lcopperplate /usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o
> > -Wl,--wrap=3Dmain
> > -Wl,--dynamic-list=3D/usr/lib/x86_64-linux-gnu/dynlist.ld
> > -L/usr/lib/x86_64-linux-gnu -lcobalt -lmodechk -lpthread -lrt
> > -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -lfuse -pthread


> > The build result made by CMake is: rtprint (24816 bytes) and rtprint.o
> > (16408 bytes)

> > The build result make using the makefile: rtprint (24720 bytes) and
> > rtprint.o (16312 bytes).

> > If I call the gcc directly I obtain the same bytes. The difference is
> > the stored path. If I strip the executables the size is the same
> > (10224 bytes) but binaries differ.

> > But, and here is the problem. If I run the cmake product I obtain:

> > /rtprint
> > ./rtprint: symbol lookup error:
> > /usr/lib/x86_64-linux-gnu/libcopperplate.so.0: undefined symbol:
> > __real_malloc


> > and the produced with make runs.

> > The produced using cmake has:

> > $ ldd rtprint
> > linux-vdso.so.1 (0x00007ffd0e1e1000)
> > libtrank.so.0 =3D> /usr/lib/x86_64-linux-gnu/libtrank.so.0
> > (0x00007f7b5dec9000)
> > libalchemy.so.0 =3D> /usr/lib/x86_64-linux-gnu/libalchemy.so.0
> > (0x00007f7b5dcb7000)
> > libcopperplate.so.0
> > =3D> /usr/lib/x86_64-linux-gnu/libcopperplate.so.0 (0x00007f7b5da9f000)
> > libcobalt.so.2 =3D> /usr/lib/x86_64-linux-gnu/libcobalt.so.2
> > (0x00007f7b5d87d000)
> > libfuse.so.2 =3D> /lib/x86_64-linux-gnu/libfuse.so.2
> > (0x00007f7b5d63f000) libpthread.so.0
> > =3D> /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007f7b5d422000)
> > libc.so.6 =3D> /lib/x86_64-linux-gnu/libc.so.6
> > (0x00007f7b5d083000) /lib64/ld-linux-x86-64.so.2 (0x00007f7b5e2d0000)
> > librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> > (0x00007f7b5ce7b000) libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2
> > (0x00007f7b5cc77000)


> > and with make

> > $ ldd rtprint
> > linux-vdso.so.1 (0x00007ffffcfe2000)
> > libtrank.so.0 =3D> /usr/lib/x86_64-linux-gnu/libtrank.so.0
> > (0x00007f621304f000)
> > libalchemy.so.0 =3D> /usr/lib/x86_64-linux-gnu/libalchemy.so.0
> > (0x00007f6212e3d000)
> > libcopperplate.so.0
> > =3D> /usr/lib/x86_64-linux-gnu/libcopperplate.so.0 (0x00007f6212c25000)
> > libcobalt.so.2 =3D> /usr/lib/x86_64-linux-gnu/libcobalt.so.2
> > (0x00007f6212a03000)
> > libmodechk.so.0 =3D> /usr/lib/x86_64-linux-gnu/libmodechk.so.0
> > (0x00007f6212801000)
> > libpthread.so.0 =3D> /lib/x86_64-linux-gnu/libpthread.so.0
> > (0x00007f62125e4000)
> > librt.so.1 =3D> /lib/x86_64-linux-gnu/librt.so.1
> > (0x00007f62123dc000) libfuse.so.2
> > =3D> /lib/x86_64-linux-gnu/libfuse.so.2 (0x00007f621219e000) libc.so.6
> > =3D> /lib/x86_64-linux-gnu/libc.so.6
> > (0x00007f6211dff000) /lib64/ld-linux-x86-64.so.2 (0x00007f6213456000)
> > libdl.so.2 =3D> /lib/x86_64-linux-gnu/libdl.so.2 (0x00007f6211bfb000)


> > pay attention that first one is not linked against libmodechk,
> > although is specified in the call.


> > I have not found any difference, only the order, so I am really
> > overwhelmed. Any idea?


> > Best regards,


> > Leopold



> > Makefile
> > -------------------------------------------------------------------
> > ###### CONFIGURATION ######

> > ### List of applications to be build
> > APPLICATIONS =3D rtprint

> > ### Default Xenomai installation path
> > XENO ?=3D /usr/xenomai

> > XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which xeno-conf=
ig
> > 2>/dev/null)

> > CC=3D$(shell $(XENOCONFIG) --cc)

> > CFLAGS=3D$(shell $(XENOCONFIG) --skin=3Dnative --cflags)

> > LDFLAGS=3D$(shell $(XENOCONFIG) --skin=3Dnative --ldflags)

> > %.o: %.c
> > $(CC) -c -o $@ $< $(CFLAGS)

> > rtprint: rtprint.o
> > $(CC) -o $@ rtprint.o $(LDFLAGS)

> > clean:
> > $(RM) $(APPLICATIONS) *.o

> > all: $(APPLICATIONS)
> > -------------------------------------------------------------------


> > [1]
> > https://gitlab.denx.de/Xenomai/xenomai/blob/eol/v2.6.x/examples/native/=
rtprint.c




> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

I also think that this is an interesting question, and not specifically rel=
ated to cmake. I too build with cmake but I never considered the command li=
ne order to be of much importance (in case it compiles).

Isn't he asking: What is the difference between=20

gcc -c -o rtprint.o rtprint.c -I/usr/include/xenomai/trank  -D__XENO_COMPAT=
__ -I/usr/include/xenomai/cobalt -I/usr/include/xenomai  -g -O2 -fdebug-pre=
fix-map=3D/build/xenomai-3.0.7+ds1=3D.  -fstack-protector-strong -Wformat=
=20
 -Werror=3Dformat-security -Wdate-time -D_FORTIFY_SOURCE=3D2 -fno-omit-fram=
e-pointer -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-tables -D__COBAL=
T__ -I/usr/include/xenomai/alchemy =20

gcc -o rtprint rtprint.o -Wl,--no-as-needed -ltrank -Wl,@/usr/lib/x86_64-li=
nux-gnu/modechk.wrappers -lalchemy -lcopperplate /usr/lib/x86_64-linux-gnu/=
xenomai/bootstrap.o -Wl,--wrap=3Dmain -Wl,--dynamic-list=3D/usr/lib/x86_64-=
linux-gnu/dynlist.ld -L/usr/lib/x86_64-linux-gnu -lcobalt -lmodechk -lpthre=
ad -lrt -Wl,-z,relro -Wl,-z,now -Wl,--as-needed   -lfuse -pthread

instead of:

/usr/bin/cc   -I/usr/include/xenomai/trank -I/usr/include/xenomai/cobalt -I=
/usr/include/xenomai -I/usr/include/xenomai/alchemy  -D__XENO_COMPAT__ -g -=
O2 -fdebug-prefix-map=3D/build/xenomai-3.0.7+ds1=3D. -fstack-protector-stro=
ng -Wformat -Werror=3Dformat-security -Wdate-time -D_FORTIFY_SOURCE=3D2 -fn=
o-omit-frame-pointer -D_GNU_SOURCE -D_REENTRANT -fasynchronous-unwind-table=
s -D__COBALT__ -o CMakeFiles/rtprint.dir/rtprint.c.o   -c /home/leopold.pal=
omo/xenomai/cmake/src/native/rtprint.c
=20
usr/bin/cc -Wl,--no-as-needed -Wl,@/usr/lib/x86_64-linux-gnu/modechk.wrappe=
rs /usr/lib/x86_64-linux-gnu/xenomai/bootstrap.o -Wl,--wrap=3Dmain -Wl,--dy=
namic-list=3D/usr/lib/x86_64-linux-gnu/dynlist.ld -Wl,-z,relro -Wl,-z,now -=
Wl,--as-needed -pthread CMakeFiles/rtprint.dir/rtprint.c.o -o rtprint -rdyn=
amic -ltrank -lalchemy -lcopperplate -lcobalt -lmodechk -lpthread -lrt -lfu=
se =20


I can't spot the differences directly because I too am confused by the size=
 of the command.
If it was me, I would try to purify this down to where I get a minimal exam=
ple that shows the difference, and perhaps then its obvious.

Per =C3=96berg=20

