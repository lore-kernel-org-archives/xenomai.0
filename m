From: Peter Feuerer <peter.feuerer@domain.hid>
In-Reply-To: <4652F58D.2070305@domain.hid>
References: <1179838106.6050.46.camel@domain.hid>
	<4652F58D.2070305@domain.hid>
Content-Type: multipart/mixed; boundary="=-KATLCZVka7M9/APJgSrX"
Date: Tue, 22 May 2007 16:41:58 +0200
Message-Id: <1179844918.6050.64.camel@domain.hid>
Mime-Version: 1.0
Subject: Re: [Xenomai-help] ppc crosscompilation, missing headers
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai@xenomai.org


--=-KATLCZVka7M9/APJgSrX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Wolfgang,

On Tue, 2007-05-22 at 15:52 +0200, Wolfgang Grandegger wrote:
> 
> Hm, ppc_8xx is not the right tool-chain for this board. Please use 
> ppc_6xx instead.

Yes, you are right, i was using the wrong one. Now I installed the
toolchain for 6xx and use the env-variable:
export CROSS_COMPILE=ppc_82xx-

- kernel compiled as before and is booting (again configured with the
xenomai prepare script and the adeos patch)

But when compiling xenomai, still the same issue.

> > ./configure -host=ppc-linux
> > 
> > But the make fails because of missing headers:
> > [..]
> >  error: asm/errno.h: No such file or directory
> > [..]
> >  error: asm/param.h: No such file or directory
> > [..]
> > 
> > I took a look at the kernel/include/asm-ppc/ folder and actually these
> > headers are missing. But they do exist for the "powerpc" architecture.
> > So I just copied all missing headers from asm-powerpc/ to asm-ppc/ to
> > try if the xenomai userspace things can be compiled. It worked. But I
> > think that is not the way it has to be done.
> 
> Of course not and I'm also surprised that it fixed your problem.

> > Does anybody know why these headers are missing in asm-ppc? Do I have to
> > install some kind of BSP-kernel-patch for my specific board? Why are
> > these headers available for powerpc?
> 
> No, when compiling for "ppc", the include files in "asm-powerpc" are 
> included as well.

it does not seem like that :-(

> 
> > And btw, maybe someone of you knows, why are there 2 architectures for
> > the powerpc architecture in the kernel tree?
> 
> Traditionally, there was the "arch/ppc" tree for 32-bit PowerPC and 
> "arch/ppc64" for 64-bit PowerPC. Both are merged already since a while 
> into the new tree "arch/powerpc" ... and the old trees will become 
> obsolete sooner than later.

Thanks for this information having ppc and powerpc is little confusing.

> Concerning your problem, I'm unable to reproduce it on my setup. What 
> exact version of the ELDK do you use.

I'm using the ELDK 4.1 Toolchain (ppc-2007-01-19.iso) 

The complete log is attached.

--peter

--=-KATLCZVka7M9/APJgSrX
Content-Disposition: attachment; filename=xenomai-ppc.txt
Content-Type: text/plain; name=xenomai-ppc.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

mount -o loop ppc-2007-01-19.iso /mnt/tmp
cd ppc_6
/mnt/tmp/install ppc_6xx
export CROSS_COMPILE=ppc_82xx-
export ARCH=ppc
PATH=$PATH:$(pwd)/usr/bin:$(pwd)/bin
cd ppc_82xx/usr/src/
tar xfj ~/linux-2.6.19.tar.bz2
rm linux
ln -s linux-2.6.19 linux
cd linux
make TQM8260_defconfig
make menuconfig #(nothing changed, just saved and exited)
cd ..
tar xfj ~/xenomai-2.3.1.tar.bz2
cd xenomai-2.3.1
scripts/prepare-kernel.sh --arch=ppc --linux=../linux/ --adoes=ksrc/arch/powerpc/patches/adeos-ipipe-2.6.19-ppc-1.5-01.patch
cd ../linux
make menuconfig #(checked if xenomai is enabled to be built in, saved and exited)
make uImage
cd ../xenomai-2.3.1
./configure --host=ppc-linux
make


crosscompile:~/toolchains/ppc_6/ppc_82xx/usr/src/xenomai-2.3.1 # make
Making all in src
make[1]: Entering directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src'
Making all in include
make[2]: Entering directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/include'
make  all-am
make[3]: Entering directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/include'
make[3]: Nothing to be done for `all-am'.
make[3]: Leaving directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/include'
make[2]: Leaving directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/include'
Making all in skins
make[2]: Entering directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/skins'
Making all in native
make[3]: Entering directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/skins/native'
if /bin/sh ../../../libtool --tag=CC --mode=compile ppc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include    -MT libnative_la-alarm.lo -MD -MP -MF ".deps/libnative_la-alarm.Tpo" -c -o libnative_la-alarm.lo `test -f 'alarm.c' || echo './'`alarm.c; \
then mv -f ".deps/libnative_la-alarm.Tpo" ".deps/libnative_la-alarm.Plo"; else rm -f ".deps/libnative_la-alarm.Tpo"; exit 1; fi
 ppc-linux-gcc -DHAVE_CONFIG_H -I. -I. -I../../../src/include -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../../include -MT libnative_la-alarm.lo -MD -MP -MF .deps/libnative_la-alarm.Tpo -c alarm.c  -fPIC -DPIC -o .libs/libnative_la-alarm.o
In file included from /root/toolchains/ppc_6/usr/../ppc_82xx/usr/include/bits/errno.h:25,
                 from /root/toolchains/ppc_6/usr/../ppc_82xx/usr/include/errno.h:36,
                 from ../../../include/nucleus/types.h:32,
                 from ../../../include/nucleus/queue.h:24,
                 from ../../../include/nucleus/timer.h:23,
                 from ../../../include/native/alarm.h:25,
                 from alarm.c:20:
/root/toolchains/ppc_6/usr/../ppc_82xx/usr/include/linux/errno.h:4:23: error: asm/errno.h: No such file or directory
In file included from ../../../src/include/asm/xenomai/system.h:145,
                 from ../../../include/nucleus/types.h:39,
                 from ../../../include/nucleus/queue.h:24,
                 from ../../../include/nucleus/timer.h:23,
                 from ../../../include/native/alarm.h:25,
                 from alarm.c:20:
../../../include/nucleus/system.h:25:23: error: asm/param.h: No such file or directory
make[3]: *** [libnative_la-alarm.lo] Error 1
make[3]: Leaving directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/skins/native'
make[2]: *** [all-recursive] Error 1
make[2]: Leaving directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src/skins'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/root/toolchains/ppc_6/ppc_6xx/usr/src/xenomai-2.3.1/src'
make: *** [all-recursive] Error 1
crosscompile:~/toolchains/ppc_6/ppc_82xx/usr/src/xenomai-2.3.1 #

--=-KATLCZVka7M9/APJgSrX--


