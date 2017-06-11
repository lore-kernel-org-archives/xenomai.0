MIME-Version: 1.0
In-Reply-To: <2d1d8708-2af0-9624-bd51-66cf78575f1f@xenomai.org>
References: <CAF06wtgG4OQ3ya2XkOx6B9gGAXrQpPT0xm2WQ9VvEoCvnxHR3Q@mail.gmail.com>
 <2d1d8708-2af0-9624-bd51-66cf78575f1f@xenomai.org>
From: Jim Langston <jim.langston@gmail.com>
Date: Sun, 11 Jun 2017 12:36:33 -0400
Message-ID: <CAF06wtiwhr5yLkCwMpuYeWwyanhvZZoO8np55_YoDYcOzZ0Ckg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Migrating 2.x projects to 3.x...
Reply-To: jlangston@panurgyinc.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Ok, opted for the compatibility layer (actual make file):

APP =3D rfiserver
XENOCONFIG:=3D../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linu=
x-uclibc/sysroot/usr/bin/xeno-config
CC =3D $(shell ${XENOCONFIG} --native --posix --compat --cc)
CFLAGS =3D $(shell ${XENOCONFIG} --native --posix --compat --cflags)
LDFLAGS =3D $(shell ${XENOCONFIG} --native --posix --compat --ldflags)

all: clean $(APP)
$(APP): $(APP).c sys_svr.c front_panel.c test.cpp
    $(CC) $(CFLAGS) $(LDFLAGS) sys_svr.c front_panel.c test.cpp -o $@ $<
    cp rfiserver ../root/bin/
clean:
    rm -f *.o $(APP) *~
.PHONY: clean


So now I get the following output when I run 'make':

/home/jlangston/mi/xenomai3/buildroot-2017.02.2/output/host/usr/bin/i686-bu=
ildroot-linux-uclibc-gcc
-I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/include/xenomai/trank/posix
-I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/include/xenomai/trank
-D__XENO_COMPAT__
-I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/include/xenomai/cobalt
-I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/include/xenomai
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -Os
-D_GNU_SOURCE -D_REENTRANT -D__COBALT__
-I../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/include/xenomai/alchemy
-D__COBALT_WRAP__ -Wl,--no-as-needed
-Wl,@../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/=
sysroot/usr/lib/cobalt.wrappers
-ltrank
-Wl,@../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/=
sysroot/usr/lib/modechk.wrappers
-lalchemy -lcopperplate
../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sysro=
ot/usr/lib/xenomai/bootstrap.o
-Wl,--wrap=3Dmain
-Wl,--dynamic-list=3D../../buildroot-2017.02.2/output/host/usr/i686-buildro=
ot-linux-uclibc/sysroot/usr/lib/dynlist.ld
-L../../buildroot-2017.02.2/output/host/usr/i686-buildroot-linux-uclibc/sys=
root/usr/lib
-lcobalt -lmodechk -lpthread -lrt    sys_svr.c front_panel.c test.cpp -o
rfiserver rfiserver.c

But I still get the 'undefined' references to the 'rt_dev_XXX()' calls.

If I replace all of the 'rt_dev_XXX' calls with the plain POSIX variants
(remove all of the 'rt_dev_ prefixes), then the errors go away, but is this
because I'm not enabling the compatibility layer correctly, and I'm linking
unwrapped APIs?



On Sun, Jun 11, 2017 at 11:57 AM, Philippe Gerum <rpm@xenomai.org> wrote:

> On 06/11/2017 04:02 PM, Jim Langston wrote:
> > Hello,
> >
> > I have been attempting to port over a project building using a quite ol=
d
> > version of Xenomai (2.4.10 on kernel 2.6.30.5) to 3.x on kernel 4.1.18.
> >
> > I have read through the Migration guide, and have made the following
> > changes based on what I saw needed changing:
> >
> > - Removed all references to 'native/intr.h', since that doesn't exist a=
ny
> > more
> > - 'T_PRIMARY' flag for 'rt_task_set_mode()' doesn't exist, so replace
> with
> > 'T_CONFORMING'
> > - In the makefiles, pass '--native --compat' to 'xeno-config'
> >
> > This seems to make everything build and link with a minimum of fuss, no
> > undefined items, link errors, etc.
> >
> > Unfortunately, for my applications that connect to drivers, I get the
> > following:
> >
> >
> > *front_panel.c:144:10: warning: implicit declaration of function
> > =E2=80=98rt_dev_ioctl=E2=80=99 [-Wimplicit-function-declaration]*
> > I get this for basically all functions starting with 'rt_dev_'.  There
> is a
> > mention of it in the Migration Guide.
> >
> > So my question is:  Do I need to manually replace all calls to 'rt_dev_=
'
> > with 'rt_' calls, or is my compatibility library not being linked in
> > properly?
> >
>
> You have three options:
>
> 1. convert the rt_dev* calls to their POSIX counterpart as provided by
> libcobalt. Assuming you don't use the symbol wrapping [1], you would
> need to explicitly pull the libcobalt symbols, e.g. __RT(ioctl(...)) for
> replacing calls to rt_dev_ioctl(). If you do wrap the symbols, then
> calling ioctl() would be enough.
>
> 2. enable the compat layer (aka libtrank), by passing the --compat flag
> to xeno-config. This would cause compat definitions and code to be
> interposed when building, including the obsolete rt_dev* API.
>
> 3. hack away by directly pulling include/trank/rtdm/rtdm.h, which
> defines what you need.
>
> The reasoning behind this change is that Xenomai 3 bases everything on
> libcobalt's POSIX implementation in dual kernel mode, so adding yet
> another interface such as rt_dev* only to wrap names became useless noise=
.
>
> [1]
> http://xenomai.org/2014/08/porting-a-linux-application-
> to-xenomai-dual-kernel/#Under_the_hood_the_8211wrap_flag
>
> --
> Philippe.
>
