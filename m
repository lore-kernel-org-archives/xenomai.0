MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Sun, 12 Nov 2017 22:39:17 -0800
Message-ID: <CA+K1mPEPbvV2TxO0iqFs32ZpDkFEgy+2JFSiN_8q112LAKC+MA@mail.gmail.com>
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

Hi Jan,

I have found a workaround for the problem. Instead of the startup segfault
happening 10% of the time, I have now started my RT app 90 times with a
single RT thread, and 80 times with its original three RT threads - with no
segfaults.

Per your question: I don't think the problem is that __rt_print_init() is
getting called twice. The normal order of execution is like this:

. printer_loop() gets called first when a xenomai RT app starts up

. pthread_mutex_lock() sets the buffer_lock struct so __lock and __owner
are nonzero:
(gdb) p buffer_lock
$4 = {__data = {__lock = 1, __count = 0, __owner = 18681, __kind = 0,
__nusers = 1, {__spins = 0, __list = {__next = 0x0}}}, __size =
"\001\000\000\000\000\000\000\000\371H\000\000\000\000\000\000\001\000\000\000\000\000\000",
__align = 1}

. then pthread_cond_wait() calls __rt_print_init()

. inside  __rt_print_init(), printer_wakeup has a valid __mutex:
(gdb) print printer_wakeup
$5 = {__data = {__lock = 0, __futex = 1, __total_seq = 1, __wakeup_seq = 0,
__woken_seq = 0, __mutex = 0xb7fd4a1c, __nwaiters = 2, __broadcast_seq =
0}, __size = "\000\000\000\000\001\000\000\000\001", '\000' <repeats 23
times>, "\034J\375\267\002\000\000\000\000\000\000\000\000\000\000",
__align = 4294967296}

. Then continuing, we get to first line of main() OK with no segfault.

You had advised to watch for corruption of the vars pthread_cond_wait()
uses.
In contrast to the above, when the segfault occurs, the vars buffer_lock
and printer_wakeup, which get passed into pthread_cond_wait(), contain all
zeros:

(gdb) print buffer_lock
$6 = {__data = {__lock = 0, __count = 0, __owner = 0, __kind = 0, __nusers
= 0, {__spins = 0, __list = {__next = 0x0}}}, __size = '\000' <repeats 23
times>, __align = 0}
(gdb) print printer_wakeup
$7 = {__data = {__lock = 0, __futex = 0, __total_seq = 0, __wakeup_seq = 0,
__woken_seq = 0, __mutex = 0x0, __nwaiters = 0, __broadcast_seq = 0},
__size = '\000' <repeats 47 times>, __align = 0}

There is one pointer in the pthread_cond_t structure:
printer_wakeup.__data.__mutex
So perhaps pthread_cond_wait() dereferences this null mutex pointer ? The
segfault always happens on access of address 0xC.

This segfault first appeared when I compiled my app for SMP, and it goes
away if I use kernel arg maxcpus=1. Perhaps some SMP race condition is
occasionally preventing the data structures (buffer_lock,printer_wakeup)
from being ready for pthread_cond_wait()?

As a protection against this I have patched the rt_print.c printer_loop()
code, skipping the call to pthread_cond_wait() if those two structures
(buffer_lock,printer_wakeup) are not ready. There is no reason to wait on a
thread which is not locked and where the mutex is nonexistent, right?

This is the patch:

--- rt_print_A.c    2014-09-24 13:57:49.000000000 -0700
+++ rt_print_B.c    2017-11-11 23:24:34.309832301 -0800
@@ -680,9 +680,10 @@
     while (1) {
         pthread_cleanup_push(unlock, &buffer_lock);
         pthread_mutex_lock(&buffer_lock);
-
-        while (buffers == 0)
-            pthread_cond_wait(&printer_wakeup, &buffer_lock);
+
+        if ((buffer_lock.__data.__lock != 0) &&
(printer_wakeup.__data.__mutex != 0))
+            while (buffers == 0)
+                pthread_cond_wait(&printer_wakeup, &buffer_lock);

         print_buffers();

Can you verify that this patch is safe?

thanks,
-C Smith
