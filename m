Message-ID: <465D2BE1.1080302@domain.hid>
Date: Wed, 30 May 2007 09:46:41 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Rodolfo Bamberg <rolfetas@domain.hid>
Subject: [Xenomai-help] [Newbie question]Segmentation fault with user-space
	binary
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

Hi
I get a segmentation fault when I run my user-space RT app (native skin).
I did the following steps:
- Cross-Compiled the Kernel with Xenomai support for an i386 target.
- I Cross - Compiled Xenomai with uClibc: run ./configure using the
--host=i386-linux-uclibc option, and using the new configure.in I read
about in the uClibC discussion.
- I wrote a test program that includes <native/task.h> and
<native/timer.h>.
- I then got this segmentation faults and I reduced my program to not
using xenomai and only printing something. I igured out that the
"-lnative" lib directive in the makefile was causing the problem.
Do you know what might be the problem??
Thanks!

Rodolfo Bamberg

Here's my makefile:

    obj-m            := hallo.o    rt_process.o
    RTAI_INCLUDE_DIR
:=/home/rodolfo/kernel/linux-2.6.20-xenomai/include/xenomai
    XENOMAI_INCLUDE_DIR_USP
:=/home/rodolfo/xenomai/xenomai-2.3.1/src/include
    XENOMAI_INCLUDE_DIR_USP2:=/home/rodolfo/xenomai/xenomai-2.3.1/include
    XENOMAI_INCLUDE_LIB_USP :=/tftpboot/192.168.0.2/usr/xenomai/lib


default:

    i386-linux-uclibc-gcc -I$(XENOMAI_INCLUDE_DIR_USP)
-I$(XENOMAI_INCLUDE_DIR_USP2) -lnative -L$(XENOMAI_INCLUDE_LIB_USP) -o
rt_process_user rt_process_user.c
    chmod a+x rt_process_user

clean:
    rm -f *.mod.c *.o *.ko rt_process



