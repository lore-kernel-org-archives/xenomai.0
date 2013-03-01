MIME-Version: 1.0
Date: Fri, 1 Mar 2013 01:59:30 -0800
Message-ID: <CAJjOJya=dP9EB737Sx3L=rMneryZwBiJYmGPJQq0B93iF6Sx0w@mail.gmail.com>
From: Jonathan Wallace <jonmon6691@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Undefined references when using xeno-config
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

This is probably an easy question, I'm not very experienced using the
GNU build tools. I'm trying to cross compile the trivial-periodic
example for my board using the following makefile

XENO_DESTDIR:=/home/jon/bone
XENO_CONFIG:=$(XENO_DESTDIR)/usr/xenomai/bin/xeno-config
XENO_CFLAGS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin
native --cflags)
XENO_LDFLAGS:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin
native --ldflags)
CC:=$(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin native --cc)

objs += trivial-periodic.c

CFLAGS := -march=armv7-a -mfpu=vfp3

main:
        $(CC) $(CFLAGS) $(XENO_CFLAGS) $(XENO_LDFLAGS) $(objs)

Which results in the following build command on my system

jon@ubuntu:~/xeno/beaglebone-xenomai/driver_test/native$ make
arm-linux-gnueabi-gcc -march=armv7-a -mfpu=vfp3
-I/home/jon/bone/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT
-D__XENO__ -lnative -L/home/jon/bone/usr/xenomai/lib -lxenomai
-lpthread -lrt trivial-periodic.c
/tmp/ccCuIb83.o: In function `demo':
trivial-periodic.c:(.text+0x1e): undefined reference to `rt_task_set_periodic'
trivial-periodic.c:(.text+0x22): undefined reference to `rt_timer_read'
trivial-periodic.c:(.text+0x2e): undefined reference to `rt_task_wait_period'
trivial-periodic.c:(.text+0x32): undefined reference to `rt_timer_read'
/tmp/ccCuIb83.o: In function `main':
trivial-periodic.c:(.text+0x10c): undefined reference to `rt_task_create'
trivial-periodic.c:(.text+0x124): undefined reference to `rt_task_start'
trivial-periodic.c:(.text+0x134): undefined reference to `rt_task_delete'
collect2: ld returned 1 exit status
make: *** [main] Error 1

But it looks like the linker isn't actually finding the xenomai
libraries. Or isn't finding the symbols within them. I'll paste the
output of nm below, but the libraries look fine, and I'm not sure what
else to try at this point.

jon@ubuntu:~/bone/usr/xenomai/lib$ nm libnative.so | grep rt_t
00004051 T rt_task_bind
00003e41 T rt_task_create
00004349 T rt_task_delete
0000428d T rt_task_inquire
000043ed T rt_task_join
000042c1 T rt_task_notify
0000445d T rt_task_receive
00004495 T rt_task_reply
000040bd T rt_task_resume
000044c9 T rt_task_same
00004331 T rt_task_self
00004405 T rt_task_send
000042f5 T rt_task_set_mode
00004119 T rt_task_set_periodic
00004199 T rt_task_set_priority
00003f8d T rt_task_shadow
000041cd T rt_task_sleep
00004215 T rt_task_sleep_until
000043b5 T rt_task_slice
00003f55 T rt_task_start
0000408d T rt_task_suspend
00003d5d t rt_task_trampoline
0000425d T rt_task_unblock
00004155 T rt_task_wait_period
000040ed T rt_task_yield
000045dd T rt_timer_inquire
0000455d T rt_timer_ns2ticks
000045d5 T rt_timer_ns2tsc
0000450d T rt_timer_read
000044d9 T rt_timer_set_mode
0000460d T rt_timer_spin
00004599 T rt_timer_ticks2ns
00004541 T rt_timer_tsc
000045d9 T rt_timer_tsc2ns

Like I said, I'm probably forgetting something obvious, this is first
time I've tried to link to cross-compiled libraries so forgive my
ignorance.

Thanks for any help,
Jon Wallace

