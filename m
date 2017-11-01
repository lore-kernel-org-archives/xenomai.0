MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Tue, 31 Oct 2017 23:29:10 -0700
Message-ID: <CA+K1mPHeJwOLhPcuJGmsf9A3yrcp_aNxS=4qXVLVU67Cw_14Eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] segfault in printer_loop()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

I finally caught all the variables in a corefile in gdb:
(gdb) bt
#0  0xb76d70db in pthread_cond_wait@@GLIBC_2.3.2 () from
/lib/libpthread.so.0
#1  0xb76f97f4 in printer_loop (arg=0x0) at rt_print.c:685
#2  0xb76d3adf in start_thread () from /lib/libpthread.so.0
#3  0xb746444e in clone () from /lib/libc.so.6
(gdb) print printer_wakeup
$1 = {__data = {__lock = 0, __futex = 0, __total_seq = 0, __wakeup_seq = 0,
__woken_seq = 0, __mutex = 0x0, __nwaiters = 0, __broadcast_seq = 0},
__size = '\000' <repeats 47 times>, __align = 0}
(gdb) print buffer_lock
$2 = {__data = {__lock = 0, __count = 0, __owner = 0, __kind = 0, __nusers
= 0, {__spins = 0, __list = {__next = 0x0}}}, __size = '\000' <repeats 23
times>, __align = 0}
(gdb) print buffers
$3 = 4
(gdb) print arg
No symbol "arg" in current context.
(gdb) print mask
No symbol "mask" in current context.
(gdb) print unlock
$4 = {void (void *)} 0xb76f96f9 <unlock>
(gdb) info threads
  Id   Target Id         Frame
  2    Thread 0xb73686c0 (LWP 20462) 0xffffe424 in ?? ()
* 1    Thread 0xb76f5b40 (LWP 20464) 0xb76d70db in
pthread_cond_wait@@GLIBC_2.3.2
() from /lib/libpthread.so.0
(gdb) print &printer_wakeup
$5 = (pthread_cond_t *) 0xb76fda20
(gdb) print &buffer_lock
$6 = (pthread_mutex_t *) 0xb76fd9fc

I see now that all variables used in this function are static on the heap,
and thus they are not null pointers, so what could cause a segfault?

Thanks, -C Smith
