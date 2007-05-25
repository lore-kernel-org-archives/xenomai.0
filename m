Message-ID: <4656ADCE.2090106@domain.hid>
Date: Fri, 25 May 2007 11:35:10 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4656A529.5000405@domain.hid>
	<4656A71C.2010801@domain.hid>	<4656A7FA.9000408@domain.hid>
	<4656A938.9000501@domain.hid> <4656AA8D.9070607@domain.hid>
In-Reply-To: <4656AA8D.9070607@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] problem compiling for user space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Rodolfo Bamberg <rolfetas@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

Rodolfo Bamberg wrote:
> Gilles Chanteperdrix wrote:
> 
>>Rodolfo Bamberg wrote:
>>  
>>
>>>I thought I did compile xenomai for the same target by passing the
>>>--build=i386-linux-uclibc option to .configure.
>>>    
>>
>>No, to cross compile, you should pass --host=i386-linux-uclibc not
>>--build. For informations on cross-compiling Xenomai, see README.INSTALL.
>>
>>  
> 
> I runned now configure with the correct --host option, and when I run
> make install i get
> this error:
> 
> Making install in cyclic
> make[3]: Entering directory
> `/home/rodolfo/xenomai/xenomai-2.3.1/src/testsuite/cyclic'
> if i386-linux-uclibc-gcc -DHAVE_CONFIG_H -I. -I. -I../../../src/include 
> -I../../../include/posix -O2 -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -fstrict-aliasing -Wno-strict-aliasing -D__XENO__ -D__IN_XENO__
> -Wstrict-prototypes -DIPIPE_TRACE=1 -I../../../include    -MT
> cyclictest-cyclictest.o -MD -MP -MF ".deps/cyclictest-cyclictest.Tpo" -c
> -o cyclictest-cyclictest.o `test -f 'cyclictest.c' || echo
> './'`cyclictest.c; \
>         then mv -f ".deps/cyclictest-cyclictest.Tpo"
> ".deps/cyclictest-cyclictest.Po"; else rm -f
> ".deps/cyclictest-cyclictest.Tpo"; exit 1; fi
> /bin/sh ../../../libtool --tag=CC --mode=link i386-linux-uclibc-gcc    
> -o cyclictest
> -Wl,@/home/rodolfo/xenomai/xenomai-2.3.1/src/skins/posix/posix.wrappers 
> cyclictest-cyclictest.o ../../skins/posix/libpthread_rt.la -lpthread -lrt
> i386-linux-uclibc-gcc -o .libs/cyclictest
> -Wl,@/home/rodolfo/xenomai/xenomai-2.3.1/src/skins/posix/posix.wrappers
> cyclictest-cyclictest.o  ../../skins/posix/.libs/libpthread_rt.so
> -lpthread -lrt -Wl,--rpath -Wl,/tftpboot/192.168.0.2//lib
> collect2: ld terminated with signal 11 [Segmentation fault]
> 
> Is this a bug in my toolchain?? Tanks Gilles.

I am afraid yes. Maybe the @ option is not supported by your version of
ld? Could you try using the @ option to ld on a simple hello world program?

-- 
                                                 Gilles Chanteperdrix

