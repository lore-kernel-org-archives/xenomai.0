From: Giulio Moro <g.moro@qmul.ac.uk>
Date: Thu, 27 Jul 2017 16:36:36 +0000
Message-ID: <DB6PR0701MB2456927C81A5688BA1DEBFB3B5BE0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
References: <50d70e8f-3a85-456f-8eae-ae2616ba88b1@utpvision.it>
 <DB6PR0701MB2456FF86319FA5C6E4F5A005B5B90@DB6PR0701MB2456.eurprd07.prod.outlook.com>,
 <0a83d5b2-2cf2-fc19-6a79-3c85f4105a51@utpvision.it>
In-Reply-To: <0a83d5b2-2cf2-fc19-6a79-3c85f4105a51@utpvision.it>
Content-Language: en-GB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] Xenomai 2->3: gcc/makefile wrong include paths
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Simone Zucchi <simone.zucchi@utpvision.it>, "xenomai@xenomai.org" <xenomai@xenomai.org>

> I've obtained the (expected) result: no standard include path is included=
.

Good, can you force it to include them adding the appropriate `-I`  to CFLA=
GS?
Also, it may be that your compiler is invoked with `-nostdinc`, which preve=
nts it from using the standard include paths?

> Should I be doing that or the guidelines are obsolete?

Right I forgot about the guidelines. I think they are still valid, but note=
 that I am pretty new around here.
The way the text of your message was formatted though pretty=20
strange, like
breaking early to a new line
for=20
no apparent reason, like:
>       Configured with: ../src/configure -v --with-pkgversion=3D'Debian
> 6.3.0-18' --w
> ith-bugurl=3Dfile:///usr/share/doc/gcc-6/README.Bugs
> --enable-languages=3Dc,ada,c++,
> java,go,d,fortran,objc,obj-c++ --prefix=3D/usr --program-suffix=3D-6
> --program-prefi
> x=3Dx86_64-linux-gnu- --enable-shared --enable-linker-build-id
> --libexecdir=3D/usr/l
> ib --without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/li=
b

It's breaking words on newlines, and in the case of Makefiles, hard line br=
eaks actually break the syntax.

Giulio
________________________________________
From: Simone Zucchi <simone.zucchi@utpvision.it>
Sent: 26 July 2017 15:14
To: Giulio Moro; xenomai@xenomai.org
Subject: Re: Xenomai 2->3: gcc/makefile wrong include paths

Hello Giulio,
I've obtained the (expected) result: no standard include path is included.
Before posting that I'd like to have proper guidelines to post onto this
mailing list.
The site says:

     Please no top posting
     Please wrap lines at 75 characters
     Please no HTML, only plain text e-mails. Even the most hopeless
MUAs have a switch to turn off HTML in message composition, please use it.
     Please DO NOT SHOUT!!!!!! in e-mails, particularly when asking for
help. This tends to make people awake and grumpy.
     Please do not send screenshots when plain text pasted into your
message would suffice.

Actually I've made a mistake and wrapped the last mail to 80 chars.
Should I be doing that or the guidelines are obsolete?

Thanks,

Simone

On 07/26/2017 01:20 PM, Giulio Moro wrote:
>> It seems that gcc doesn't include standard include paths
> I would suggest you add `--verbose` to your CFLAGS so you will see explic=
itly what is in the search path for that one invocation that fails.
>
> Giulio
>
> PS: note that the weird line wrapping of your message (possibly due to yo=
ur email client or termianl or both?) makes your message and the error log =
difficult to parse
>
>
> ________________________________________
> From: Xenomai <xenomai-bounces@xenomai.org> on behalf of Simone Zucchi <s=
imone.zucchi@utpvision.it>
> Sent: 26 July 2017 11:49
> To: xenomai@xenomai.org
> Subject: [Xenomai] Xenomai 2->3: gcc/makefile wrong include paths
>
> Hello everybody,
> thanks to your previous hints I've succesfully got Cobalt working.
> I'm trying to compile some (previously coded for Xenomai 2) code.
> I'm facing an odd issue which I don't think is related to Xenomai but
> rather to
> the way my Makefile is built.
> I'd be real grateful to anybody out there willing to help me because I'm
> no make
> file expert at all.
>
> It seems that gcc doesn't include standard include paths for no reasons
> apperant
> ly through my makefile.
> I'm working on Debian 9.
> Here's the include paths of gcc:
>
>       gcc -xc -E -v -
>       Using built-in specs.
>       COLLECT_GCC=3Dgcc
>       Target: x86_64-linux-gnu
>       Configured with: ../src/configure -v --with-pkgversion=3D'Debian
> 6.3.0-18' --w
> ith-bugurl=3Dfile:///usr/share/doc/gcc-6/README.Bugs
> --enable-languages=3Dc,ada,c++,
> java,go,d,fortran,objc,obj-c++ --prefix=3D/usr --program-suffix=3D-6
> --program-prefi
> x=3Dx86_64-linux-gnu- --enable-shared --enable-linker-build-id
> --libexecdir=3D/usr/l
> ib --without-included-gettext --enable-threads=3Dposix --libdir=3D/usr/li=
b
> --enable-
> nls --with-sysroot=3D/ --enable-clocale=3Dgnu --enable-libstdcxx-debug
> --enable-libs
> tdcxx-time=3Dyes --with-default-libstdcxx-abi=3Dnew
> --enable-gnu-unique-object --dis
> able-vtable-verify --enable-libmpx --enable-plugin --enable-default-pie
> --with-s
> ystem-zlib --disable-browser-plugin --enable-java-awt=3Dgtk
> --enable-gtk-cairo --w
> ith-java-home=3D/usr/lib/jvm/java-1.5.0-gcj-6-amd64/jre --enable-java-hom=
e
> --with-
> jvm-root-dir=3D/usr/lib/jvm/java-1.5.0-gcj-6-amd64
> --with-jvm-jar-dir=3D/usr/lib/jvm
> -exports/java-1.5.0-gcj-6-amd64 --with-arch-directory=3Damd64
> --with-ecj-jar=3D/usr/
> share/java/eclipse-ecj.jar --with-target-system-zlib
> --enable-objc-gc=3Dauto --ena
> ble-multiarch --with-arch-32=3Di686 --with-abi=3Dm64
> --with-multilib-list=3Dm32,m64,mx
> 32 --enable-multilib --with-tune=3Dgeneric --enable-checking=3Drelease
> --build=3Dx86_6
> 4-linux-gnu --host=3Dx86_64-linux-gnu --target=3Dx86_64-linux-gnu
>       Thread model: posix
>       gcc version 6.3.0 20170516 (Debian 6.3.0-18)
>       COLLECT_GCC_OPTIONS=3D'-E' '-v' '-mtune=3Dgeneric' '-march=3Dx86-64=
'
>        /usr/lib/gcc/x86_64-linux-gnu/6/cc1 -E -quiet -v -imultiarch
> x86_64-linux-g
> nu - -mtune=3Dgeneric -march=3Dx86-64
>       ignoring nonexistent directory "/usr/local/include/x86_64-linux-gnu=
"
>       ignoring nonexistent directory
> "/usr/lib/gcc/x86_64-linux-gnu/6/../../../../
> x86_64-linux-gnu/include"
>       #include "..." search starts here:
>       #include <...> search starts here:
>        /usr/lib/gcc/x86_64-linux-gnu/6/include
>        /usr/local/include
>        /usr/lib/gcc/x86_64-linux-gnu/6/include-fixed
>        /usr/include/x86_64-linux-gnu
>        /usr/include
>       End of search list.
>       # 1 "<stdin>"
>       # 1 "<built-in>"
>       # 1 "<command-line>"
>       # 31 "<command-line>"
>       # 1 "/usr/include/stdc-predef.h" 1 3 4
>       # 32 "<command-line>" 2
>       # 1 "<stdin>"
> COMPILER_PATH=3D/usr/lib/gcc/x86_64-linux-gnu/6/:/usr/lib/gcc/x86_64-linu=
x-gnu
> /6/:/usr/lib/gcc/x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/6/:/usr/=
lib/gcc
> /x86_64-linux-gnu/
> LIBRARY_PATH=3D/usr/lib/gcc/x86_64-linux-gnu/6/:/usr/lib/gcc/x86_64-linux=
-gnu/
> 6/../../../x86_64-linux-gnu/:/usr/lib/gcc/x86_64-linux-gnu/6/../../../../=
lib/:/l
> ib/x86_64-linux-gnu/:/lib/../lib/:/usr/lib/x86_64-linux-gnu/:/usr/lib/../=
lib/:/u
> sr/lib/gcc/x86_64-linux-gnu/6/../../../:/lib/:/usr/lib/
>       COLLECT_GCC_OPTIONS=3D'-E' '-v' '-mtune=3Dgeneric' '-march=3Dx86-64=
'
>
>
> My Makefile is:
>
>       ###### CONFIGURATION ######
>
>       ### List of applications to be build
>       APPLICATIONS =3D
>
>       ### Note: to override the search path for the xeno-config script,
> use "make
> XENO=3D..."
>
>
>       ### List of modules to be build
>       MODULES =3D myRtModule
>
>       ### Note: to override the kernel source path, use "make KSRC=3D..."
>
>
>
>       ###### USER SPACE BUILD (no change required normally) ######
>       ifeq ($(KERNELRELEASE),)
>       ifneq ($(APPLICATIONS),)
>
>       ### Default Xenomai installation path
>       XENO ?=3D /usr/local/xenomai
>
>       XENOCONFIG=3D$(shell PATH=3D$(XENO):$(XENO)/bin:$(PATH) which
> xeno-config 2>/dev
> /null)
>
>       ### Sanity check
>       ifeq ($(XENOCONFIG),)
>       all::
>           @echo ">>> Invoke make like this: \"make
> XENO=3D/path/to/xeno-config\" <<<
> "
>           @echo
>       endif
>
>
>       CC=3D$(shell $(XENOCONFIG) --cc)
>
>       CFLAGS=3D$(shell $(XENOCONFIG) --alchemy --cflags) $(MY_CFLAGS) -I
> /usr/local/
> src/mySource/include
>
>       LDFLAGS=3D$(shell $(XENOCONFIG) --alchemy --ldflags) $(MY_LDFLAGS)
> -lalchemy
>
>       # This includes the library path of given Xenomai into the binary
> to make li
> ve
>       # easier for beginners if Xenomai's libs are not in any default
> search path.
>
>       LDFLAGS+=3D-Xlinker -rpath -Xlinker $(shell $(XENOCONFIG) --libdir)
>
>       all:: $(APPLICATIONS)
>
>       clean::
>           $(RM) $(APPLICATIONS) *.o
>
>       endif
>       endif
>
>
>
>       ###### KERNEL MODULE BUILD (no change required normally) ######
>       ifneq ($(MODULES),)
>
>       ### Default to sources of currently running kernel
>       KSRC ?=3D /lib/modules/$(shell uname -r)/build
>
>       OBJS     :=3D ${patsubst %, %.o, $(MODULES)}
>       CLEANMOD :=3D ${patsubst %, .%*, $(MODULES)}
>       PWD      :=3D $(shell if [ "$$PWD" !=3D "" ]; then echo $$PWD; else
> pwd; fi)
>
>       obj-m        :=3D $(OBJS)
>       EXTRA_CFLAGS :=3D -I$(KSRC)/include/xenomai
> -I$(KSRC)/include/xenomai/posix $(
> ADD_CFLAGS) -I/usr/local/src/mySource/include
>
>       all::
>           $(MAKE) -C $(KSRC) SUBDIRS=3D$(PWD) modules
>
>       clean::
>           $(RM) $(CLEANMOD) *.o *.ko *.mod.c Module.markers modules.order
>           $(RM) -R .tmp*
>
>       endif
>
>
> When I run make this is what happens:
>
>       make -C /lib/modules/4.9.24-ipipe-xenomai-3.0.5-cobalt/build
> SUBDIRS=3D/usr/lo
> cal/src/my/source/rt_control modules
>       make[1]: Entering directory
> '/usr/local/src/linux-4.9.24-ipipe-xenomai-3.0.5
> -cobalt'
>         CC [M] /usr/local/src/mySource/source/rt_control/myRtModule.o
>       In file included from /usr/local/src/mySource/include/common.h:10:0=
,
>                        from
> /usr/local/src/mySource/source/rt_control/myRtModule.c
> :33:
>       include/xenomai/alchemy/task.h:21:23: fatal error: sys/types.h: No
> such file
>    or directory
>        #include <sys/types.h>
>                              ^
>       compilation terminated.
>       scripts/Makefile.build:299: recipe for target
> '/usr/local/src/mySource/sourc
> e/rt_control/myRtModule.o' failed
>       make[2]: ***
> [/usr/local/src/mySource/source/rt_control/myRtModule.o] Error
> 1
>       Makefile:1490: recipe for target
> '_module_/usr/local/src/mySource/source/rt_
> control' failed
>       make[1]: *** [_module_/usr/local/src/mySource/source/rt_control]
> Error 2
>       make[1]: Leaving directory
> '/usr/local/src/linux-4.9.24-ipipe-xenomai-3.0.5-
> cobalt'
>       Makefile:67: recipe for target 'all' failed
>       make: *** [all] Error 2
>
> If I explicit the (standard?) include path over gcc into make, adding
> "-I/usr/in
> clude/x86_64-linux-gnu" at the end of EXTRA_CFLAGS, I get this behaviour:
>
>       make -C /lib/modules/4.9.24-ipipe-xenomai-3.0.5-cobalt/build
> SUBDIRS=3D/usr/lo
> cal/src/mySource/source/rt_control modules
>       make[1]: Entering directory
> '/usr/local/src/linux-4.9.24-ipipe-xenomai-3.0.5
> -cobalt'
>         CC [M] /usr/local/src/mySource/source/rt_control/myRtModule.o
>       In file included from include/xenomai/alchemy/task.h:21:0,
>                        from /usr/local/src/mySource/include/common.h:10,
>                        from
> /usr/local/src/mySource/source/rt_control/myRtModule.c
> :33:
>       /usr/include/x86_64-linux-gnu/sys/types.h:25:22: fatal error:
> features.h: No
>    such file or directory
>        #include <features.h>
>                             ^
>       compilation terminated.
>       scripts/Makefile.build:299: recipe for target
> '/usr/local/src/mySource/sourc
> e/rt_control/myRtModule.o' failed
>       make[2]: ***
> [/usr/local/src/mySource/source/rt_control/myRtModule.o] Error
> 1
>       Makefile:1490: recipe for target
> '_module_/usr/local/src/mySource/source/rt_
> control' failed
>       make[1]: *** [_module_/usr/local/src/mySource/source/rt_control]
> Error 2
>       make[1]: Leaving directory
> '/usr/local/src/linux-4.9.24-ipipe-xenomai-3.0.5-
> cobalt'
>       Makefile:67: recipe for target 'all' failed
>       make: *** [all] Error 2
>
>
> Of course I do have libcv-dev installed and everything is in the right
> place:
>
>       ls -l /usr/include/x86_64-linux-gnu/sys/types.h
>       -rw-r--r-- 1 root root 6687 Jun 15 21:17
> /usr/include/x86_64-linux-gnu/sys/t
> ypes.h
>
>       ls -l /usr/include/features.h
>       -rw-r--r-- 1 root root 13069 Jun 15 21:17 /usr/include/features.h
>
> Hope anybody out there could/will help me :)
> Thanks,
>
> Simone
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> https://xenomai.org/mailman/listinfo/xenomai

