From: =?ISO-8859-1?Q?Beno=EEt?= CAMUS <benoit.camus@domain.hid>
Content-Type: text/plain
Date: Thu, 05 Apr 2007 15:08:24 +0200
Message-Id: <1175778504.26947.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Error at compilation of examples
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi all,

I got errors in headers while trying to compile basical programs
(sigcpu.c and a posix thread one). I use ELDK 4.1 cross-compiler for ARM
architecture and 2.6.19 kernel. So here is error i got:


$> arm-linux-gcc -I/opt/eldk/arm/usr/include/ -I/opt/eldk/arm/include/
-D_GNU_SOURCE -D_REENTRANT -L/opt/eldk/arm/lib/ -lpthread -lnative
-Xlinker -rpath -Xlinker /opt/eldk/arm/lib/ -o t_posix ./test_thread.c

In file included from /opt/eldk/arm/include/nucleus/queue.h:24,
                 from /opt/eldk/arm/include/nucleus/timer.h:23,
                 from /opt/eldk/arm/include/nucleus/thread.h:23,
                 from /opt/eldk/arm/include/posix/pthread.h:149,
                 from ./test_thread.c:1:
/opt/eldk/arm/include/nucleus/types.h:75: error: parse error before
'xnflags_t'
/opt/eldk/arm/include/nucleus/types.h:75: warning: data definition has
no type or storage class

Is there something i missed in xenomai's configuration ?

That's parameters i put:
configure --prefix=/ --build=i686-linux-gnu --host=arm-linux
--enable-arm-arch=4 --disable-dox-doc --disable-dbx
--disable-dbx-network --disable-x86-tsc

Thanks,
Benoit


