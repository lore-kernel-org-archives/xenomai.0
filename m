MIME-Version: 1.0
Date: Mon, 6 Apr 2015 18:27:39 +0430
Message-ID: <CAKKWdtdUN=FxONoqC5qMdJZPQjFFeosehRdLnY-b1jq_msU02Q@mail.gmail.com>
From: ali hagigat <hagigatali@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] why there are errors compiling the kernel, 3.16.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: buildroot@buildroot.net
Cc: xenomai <xenomai@xenomai.org>

linux-3.16.7.tar.xz
ipipe-core-3.16.7-arm-5.patch  + xenomai user space applications and libraries
target-board: wandboard-quad


  CHK     include/generated/compile.h
  CC      arch/arm/xenomai/hal.o
  CC      net/socket.o
  AS      arch/arm/xenomai/switch.o
arch/arm/xenomai/hal.c:47:24: fatal error: asm/system.h: No such file
or directory
 #include <asm/system.h>
                        ^
compilation terminated.
make[2]: *** [arch/arm/xenomai/hal.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [arch/arm/xenomai] Error 2
make[1]: *** Waiting for unfinished jobs....
  LD      net/802/built-in.o
  CC      net/core/sock.o
  CC      net/dns_resolver/dns_key.o
  CC      net/dns_resolver/dns_query.o
  LD      net/dns_resolver/dns_resolver.o
  LD      net/dns_resolver/built-in

