Message-ID: <4AD57CE3.4050206@domain.hid>
Date: Wed, 14 Oct 2009 09:25:23 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
In-Reply-To: <1f3e02580910132319v3ce08b2frb811d749def9f17@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Support for ARCH_MV88F6290
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Didenko Sergey <didenkos@domain.hid>
Cc: xenomai@xenomai.org

Didenko Sergey wrote:
> Dear Gilles
> 
> when I did change the HW Timer interrupt number (__ipipe_mach_timerint) from
> 0 to 1
> Patched kernel is able to boot up...but I'm not sure whether Xenomai is
> running or not even I can see the messages that it is started...
> To verify whether it is running or not I want to do latency test ..for
> that..I'm following the HOWTO which says that I have to
> 1) configure Xenomai
> $ ./configure --build=i686-pc-linux-gnu --host=arm-linux
> --enable-arm-mach=generic --enable-arm-tsc
> 
> 2) make Install
> When I do "make DESTDIR=/nfs install" where /nfs - is the NFS path to rootfs
> mounted by board.
> I have next situation...
> 
> ===
> 
> [d.sergey@domain.hid xenomai-2.4.9.1]$ make DESTDIR=/nfs install
> Making install in src
> make[1]: Entering directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
> Making install in include
> make[2]: Entering directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> make[3]: Entering directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> make[3]: Nothing to be done for `install-exec-am'.
> make[3]: Nothing to be done for `install-data-am'.
> make[3]: Leaving directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> make[2]: Leaving directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/include'
> Making install in rtdk
> make[2]: Entering directory
> `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
> /bin/sh ../../libtool  --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I.
> -I../../src/include  -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4
> -D__XENO__ -D__IN_XENO__ -Wstrict-prototypes -I../../include    -MT
> librtdk_la-init.lo -MD -MP -MF .deps/librtdk_la-init.Tpo -c -o
> librtdk_la-init.lo `test -f 'init.c' || echo './'`init.c
> libtool: compile:  gcc -DHAVE_CONFIG_H -I. -I../../src/include -O2
> -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -march=armv4 -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -I../../include -MT librtdk_la-init.lo -MD -MP -MF
> .deps/librtdk_la-init.Tpo -c init.c  -fPIC -DPIC -o .libs/librtdk_la-init.o
> init.c:1: error: bad value (armv4) for -march= switch
> init.c:1: error: bad value (armv4) for -mtune= switch
> make[2]: *** [librtdk_la-init.lo] Error 1
> make[2]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src/rtdk'
> make[1]: *** [install-recursive] Error 1
> make[1]: Leaving directory `/home/d.sergey/xemomai/xenomai-2.4.9.1/src'
> make: *** [install-recursive] Error 1
> [d.sergey@domain.hid xenomai-2.4.9.1]$

Your problem here is that you are trying to use gcc (that is probably an
x86 gcc) with options for an ARM gcc. It does not work. You have to
ensure that the build system uses your cross-compiler.

> 
> ====
> 
> What is wrong?
> How can I patch the rootfs with Xenomai libraries correctly?

I have no idea. But I can tell you that you do not need to patch
anything. It should work out of the box.

-- 
					    Gilles.

