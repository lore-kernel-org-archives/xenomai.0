Message-ID: <49AD800B.4040201@domain.hid>
Date: Tue, 03 Mar 2009 20:07:55 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000001c99c31$aa5d46a0$ff17d3e0$@com>
In-Reply-To: <000001c99c31$aa5d46a0$ff17d3e0$@com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Segmentation Fault
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: wcall@domain.hid
Cc: "'Xenomai-help@domain.hid'" <xenomai@xenomai.org>

Wayne Call wrote:
> Hi,
> 
> When the Xenomai is built, there is a segmentation fault.  What are the
> possible scenarios that would cause this error?  There is an "ld terminated
> with signal 11" error associated with this fault. 
> 
>  
> 
> Making all in cyclic
> 
> make[3]: Entering directory
> `/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/src/
> testsuite/cyclic'
> 
> /bin/sh ../../../libtool --tag=CC --mode=link bfin-linux-uclibc-gcc     -o
> cyclictest
> -Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/
> src/skins/posix/posix.wrappers -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -mfdpic -mfdpic cyclictest-cyclictest.o ../../skins/posix/libpthread_rt.la
> -lpthread -lrt
> 
> bfin-linux-uclibc-gcc -o .libs/cyclictest
> -Wl,@/home/jordanelle/3Star/potomac/Software/magnolia/Kryptic/xenomai-2.3.1/
> src/skins/posix/posix.wrappers -D_GNU_SOURCE -D_REENTRANT -Wall -pipe
> -mfdpic -mfdpic cyclictest-cyclictest.o
> ../../skins/posix/.libs/libpthread_rt.so -lpthread -lrt -Wl,--rpath
> -Wl,/usr/xenomai/lib
> 
> collect2: ld terminated with signal 11 [Segmentation fault]

The most frequent cause of gcc segmentation faults are faulty processors
 (due to over-heating for instance) or RAM. You can run memtest to check
your RAM, or use lm-sensors to check your CPU temperature.

If the error always happens when compiling the same program, then there
may be a bug in your toolchain.

-- 
					    Gilles.

