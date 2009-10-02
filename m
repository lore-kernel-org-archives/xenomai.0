Message-ID: <4AC5F98B.2030708@domain.hid>
Date: Fri, 02 Oct 2009 15:00:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <47a3101a0910011923t7a002c9av7f7df5c666f0cf1@domain.hid>
	<47a3101a0910020554n39297325x72cd9b7adde9ab9f@domain.hid>
In-Reply-To: <47a3101a0910020554n39297325x72cd9b7adde9ab9f@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Fwd: Xenomai 2.4.9.1
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Linus Casassa <linus@domain.hid>
Cc: xenomai@xenomai.org

Linus Casassa wrote:
> Hi.
> 
> I am installing xenomai on a Gumstix Verdex pro (Marvell PXA270 with
> XScale). I am fowling this wiki:
> http://www.gumstix.net/wiki/index.php?title=Xenomai_-_Mini_Howto
> 
> It compiles fine and works fine.
> But it would be nice to have at least 2.4.8 because it hangs when doing the
> xeno-test on the latency part. I read that it is an overflow bug already
> fixed.
> So now I am trying to update to xenomai 2.4.9.1 and I'm getting this error:
> 
> (bitbake xenomai)
> 
> | Making all in rtdk
> | make[2]: Entering directory
> `/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.8-r0/xenomai-2.4.8/src/rtdk'
> | if /bin/sh ../../libtool --tag=CC --mode=compile
> arm-angstrom-linux-gnueabi-gcc -march=armv5te -mtune=xscale -DHAVE_CONFIG_H
> -I. -I. -I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -march=armv5 -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include
> -isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnueabi/include
> -isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnueabi/include
> -fexpensive-optimizations -fomit-frame-pointer -frename-registers -Os -MT
> librtdk_la-init.lo -MD -MP -MF ".deps/librtdk_la-init.Tpo" -c -o
> librtdk_la-init.lo `test -f 'init.c' || echo './'`init.c; \
> |     then mv -f ".deps/librtdk_la-init.Tpo" ".deps/librtdk_la-init.Plo";
> else rm -f ".deps/librtdk_la-init.Tpo"; exit 1; fi
> | ../../libtool: line 761: X--tag=CC: command not found
> | ../../libtool: line 794: libtool: ignoring unknown tag : command not found
> | ../../libtool: line 761: X--mode=compile: command not found
> | ../../libtool: line 911: *** Warning: inferring the mode of operation is
> deprecated.: command not found
> | ../../libtool: line 912: *** Future versions of Libtool will require
> -mode=MODE be specified.: command not found
> | ../../libtool: line 1055: Xarm-angstrom-linux-gnueabi-gcc: command not
> found
> | ../../libtool: line 1055: X-march=armv5te: command not found
> | ../../libtool: line 1055: X-mtune=xscale: command not found
> | ../../libtool: line 1055: X-DHAVE_CONFIG_H: command not found
> | ../../libtool: line 1055: X-I.: command not found
> | ../../libtool: line 1055: X-I.: command not found
> | ../../libtool: line 1055: X-I../../src/include: No such file or directory
> | ../../libtool: line 1055: X-O2: command not found
> | ../../libtool: line 1055: X-D_GNU_SOURCE: command not found
> | ../../libtool: line 1055: X-D_REENTRANT: command not found
> | ../../libtool: line 1055: X-Wall: command not found
> | ../../libtool: line 1055: X-pipe: command not found
> | ../../libtool: line 1055: X-march=armv5: command not found
> | ../../libtool: line 1055: X-D__XENO__: command not found
> | ../../libtool: line 1055: X-D__IN_XENO__: command not found
> | ../../libtool: line 1055: X-Wstrict-prototypes: command not found
> | ../../libtool: line 1055: X-I../../include: No such file or directory
> | ../../libtool: line 1055:
> X-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnueabi/include:
> No such file or directory
> | ../../libtool: line 1055:
> X-isystem/home/linus/gumstix/gumstix-oe/tmp/staging/arm-angstrom-linux-gnueabi/include:
> No such file or directory
> | ../../libtool: line 1055: X-fexpensive-optimizations: command not found
> | ../../libtool: line 1055: X-fomit-frame-pointer: command not found
> | ../../libtool: line 1055: X-frename-registers: command not found
> | ../../libtool: line 1055: X-Os: command not found
> | ../../libtool: line 1055: X-MT: command not found
> | ../../libtool: line 1055: Xlibrtdk_la-init.lo: command not found
> | ../../libtool: line 1055: X-MD: command not found
> | ../../libtool: line 1055: X-MP: command not found
> | ../../libtool: line 1055: X-MF: command not found
> | ../../libtool: line 1055: X.deps/librtdk_la-init.Tpo: No such file or
> directory
> | ../../libtool: line 1055: X-c: command not found
> | ../../libtool: line 1103: Xlibrtdk_la-init.lo: command not found
> | ../../libtool: line 1108: libtool: compile: cannot determine name of
> library object from `': command not found
> | make[2]: *** [librtdk_la-init.lo] Error 1
> | make[2]: Leaving directory
> `/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.8-r0/xenomai-2.4.8/src/rtdk'
> | make[1]: *** [all-recursive] Error 1
> | make[1]: Leaving directory
> `/home/linus/gumstix/gumstix-oe/tmp/work/armv5te-angstrom-linux-gnueabi/xenomai-2.4.8-r0/xenomai-2.4.8/src'
> | make: *** [all-recursive] Error 1
> | FATAL: oe_runmake failed
> 
> Same error with versions 2.4.9 and 2.4.8.

Do you have the same error if you compile Xenomai using the instructions
in README.INSTALL?

-- 
					    Gilles.

