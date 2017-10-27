MIME-Version: 1.0
From: C Smith <csmithquestions@gmail.com>
Date: Thu, 26 Oct 2017 19:08:28 -0700
Message-ID: <CA+K1mPGNsz-+Gc+YMRtEUa5ZfpWgQ3nDzUrx2hoUYWkNzBULWA@mail.gmail.com>
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

My xenomai application is segfaulting at startup, 1 in 10 times I run it.
When I catch it in a debugger or get a core file it says the segfault was
not in my code but in the xenomai sources:

rt_print.c line 685:
pthread_cond_wait(&printer_wakeup, &buffer_lock);

(gdb) bt
#O  Oxb77120db in pthread_cond_wait@@GLIBC_2.3.2 () from
/lib/libpthread.so.O
#1  Oxb77347de in printer_loop (arg=Ox0) at rt_print.c:685
#2  Oxb770eadf in start thread () from /lib/libpthread.so.O
#3  Oxb749f44e in clone () from /lib/libc.so.6
(gdb) info threads
 Id  Target Id         Frame
 2   Thread Oxb73a36cO (LWP 7235) Oxffffe424 in ?? ()
*1   Thread Oxb7730b40 (LWP 7238) Oxb77120db in pthread_cond_wait@
@GLZBC_2.3.2
() from /lib/libpthread.so.O

Note that there is no printing whatsover in my code. This is a mature
application which has been running sucessfully on xenomai 2.6.2 for a few
years - but now I am running it on xenomai 2.6.4 on kernel 3.14.17.
Another difference is that I am now using a faster motherboard. I have a
suspicion that there is a race condition which is causing uninitialized
thread variables. I believe this is during the creation of a thread where
xenomai prints the new thread info to stdout.

Could &printer_wakeup, &buffer_lock be invalid?
I was unable to evaluate them in the debugger, I think their values are
gone from the stack/heap by the time I get to them.

There are no differences in rt_print.c between xenomai 2.6.4 and 2.6.5.

Can you provide a way to modify the code of printer_loop() to detect and
work around the problem?
