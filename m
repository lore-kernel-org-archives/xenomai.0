Message-ID: <51DD7302.2010809@gmail.com>
Date: Wed, 10 Jul 2013 16:43:14 +0200
From: Sagar Behere <sagar.behere@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] failing compile of kernel-3.8 on arm
Reply-To: sagar.behere@gmail.com
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I patched the vanilla linux-3.8 kernel sources with=20
ipipe-core-3.8-arm-1.patch. The patch was applied cleanly, but while=20
compiling the kernel, I get two problems

Problem 1: This is the same as=20
http://www.mail-archive.com/xenomai@xenomai.org/msg02719.html

Problem 2: The compilation halts with

----

In file included from=20
/home/sagar/kernels/linux-3.8/arch/arm/include/asm/xenomai/syscall.h:29,
                  from include/xenomai/nucleus/shadow.h:27,
                  from include/asm-generic/xenomai/system.h:42,
                  from=20
/home/sagar/kernels/linux-3.8/arch/arm/include/asm/xenomai/system.h:29,
                  from include/xenomai/nucleus/types.h:36,
                  from include/xenomai/nucleus/queue.h:24,
                  from include/xenomai/nucleus/heap.h:25,
                  from kernel/xenomai/nucleus/bufd.c:144:
include/asm-generic/xenomai/syscall.h: In function=20
=91__xn_safe_strncpy_from_user=92:
include/asm-generic/xenomai/syscall.h:147: error: implicit declaration=20
of function =91__strncpy_from_user=92
make[3]: *** [kernel/xenomai/nucleus/bufd.o] Error 1
make[2]: *** [kernel/xenomai/nucleus] Error 2
make[1]: *** [kernel/xenomai] Error 2
make: *** [kernel] Error 2

----

compiler is: arm-linux-gnueabi-gcc (Debian 4.4.5-8) 4.4.5

Any ideas how to fix these issues? I'll be running this kernel on the=20
gumstix overo, if that matters..

Thanks and regards,
Sagar

