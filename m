Date: Tue, 26 Apr 2011 15:50:07 +0200 (CEST)
From: Mauro Salvini <mauro.salvini@domain.hid>
Message-ID: <21817662.201303825804906.JavaMail.SYSTEM@pc-msalvini>
In-Reply-To: <11882793.141303825258312.JavaMail.SYSTEM@pc-msalvini>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_Part_9_1393721.1303825804906"
Subject: [Xenomai-help] rt_task_join() call hangs in shared lib destructor
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

------=_Part_9_1393721.1303825804906
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

as from mail subject, I have an issue with rt_task_join() when called into shared object destructor.

I run xenomai 2.5.5.2 IPipe patch 2.7-4 on x86 2.6.35.7 kernel, Ubuntu Lucid 10.04.1. 
I have a simple code attached to mail, where main program opens a shared object with dlopen(). Shared object constructor launches a joinable real-time task. Main program sleeps 5 seconds and then calls dlclose(). Shared object destructor breaks real time task cycle and joins task, but rt_join_call() hangs application indefinitely. 

Initially it seems me to be due to this libc bug: 
https://bugzilla.redhat.com/show_bug.cgi?id=549813 

In facts my system originally has libc6 version 2.11.1 that contains this bug (attached example to bugtrace hangs on pthread_join() call). 
So I patched libc with suggested patch (that was applied on libc6 2.12, but unfortunately I cannot install it from .deb package because it was built for Ubuntu 10.10 only). Then I rebuild deb package with debuild command and updated my libc6 library: pthread_join() issue disappears, but rt_task_join() issue stills remain. 

I tried to run same xenomai-patched kernel on an Ubuntu 10.10 system (that comes with libc6 version 2.12), same result obtained (rt_task_join() hangs). 

I run test application under gdb, this is the backtrace for each task when it hangs: 

(gdb) info thread
  3 Thread 0xb7e34b70 (LWP 1684)  0xb7fe2424 in __kernel_vsyscall ()
  2 Thread 0xb7e42b70 (LWP 1683)  0xb7fe2424 in __kernel_vsyscall ()
* 1 Thread 0xb7e436d0 (LWP 1680)  0xb7fe2424 in __kernel_vsyscall ()


thread 1: 
(gdb) bt
#0  0xb7fe2424 in __kernel_vsyscall ()
#1  0xb7fb7b5d in pthread_join () from /lib/tls/i686/cmov/libpthread.so.0
#2  0xb7fd7181 in rt_task_join () from /usr/xenomai/lib/libnative.so.3
#3  0xb7e357ad in TestModExit () at TestMod.c:35
#4  0xb7e35668 in __do_global_dtors_aux () from ./libTestMod.so
#5  0xb7e35820 in _fini () from ./libTestMod.so
#6  0xb7ff578e in ?? () from /lib/ld-linux.so.2
#7  0xb7ff6247 in ?? () from /lib/ld-linux.so.2
#8  0xb7fa8ca4 in ?? () from /lib/tls/i686/cmov/libdl.so.2
#9  0xb7ff0836 in ?? () from /lib/ld-linux.so.2
#10 0xb7fa909c in ?? () from /lib/tls/i686/cmov/libdl.so.2
#11 0xb7fa8cda in dlclose () from /lib/tls/i686/cmov/libdl.so.2
#12 0x080486b1 in main (argc=1, argv=0xbffff864) at main.c:18


thread 2: 
(gdb) bt
#0  0xb7fe2424 in __kernel_vsyscall ()
#1  0xb7fbe736 in nanosleep () from /lib/tls/i686/cmov/libpthread.so.0
#2  0xb7fad92e in printer_loop () from /usr/xenomai/lib/librtdk.so.0
#3  0xb7fb696e in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
#4  0xb7f1ba4e in clone () from /lib/tls/i686/cmov/libc.so.6


thread 3: 
(gdb) bt
#0  0xb7fe2424 in __kernel_vsyscall ()
#1  0xb7fbdaf9 in __lll_lock_wait () from /lib/tls/i686/cmov/libpthread.so.0
#2  0xb7fb9149 in _L_lock_839 () from /lib/tls/i686/cmov/libpthread.so.0
#3  0xb7fb8fdb in pthread_mutex_lock () from /lib/tls/i686/cmov/libpthread.so.0
#4  0xb7ff45cd in ?? () from /lib/ld-linux.so.2
#5  0xb7f524a2 in ?? () from /lib/tls/i686/cmov/libc.so.6
#6  0xb7ff0836 in ?? () from /lib/ld-linux.so.2
#7  0xb7f525a1 in ?? () from /lib/tls/i686/cmov/libc.so.6
#8  0xb7f526bb in __libc_dlopen_mode () from /lib/tls/i686/cmov/libc.so.6
#9  0xb7fbfb47 in pthread_cancel_init () from /lib/tls/i686/cmov/libpthread.so.0
#10 0xb7fbfcbd in _Unwind_ForcedUnwind () from /lib/tls/i686/cmov/libpthread.so.0
#11 0xb7fbd788 in __pthread_unwind () from /lib/tls/i686/cmov/libpthread.so.0
#12 0xb7fb79e0 in pthread_exit () from /lib/tls/i686/cmov/libpthread.so.0
#13 0xb7fd8665 in rt_task_trampoline () from /usr/xenomai/lib/libnative.so.3
#14 0xb7fb696e in start_thread () from /lib/tls/i686/cmov/libpthread.so.0
#15 0xb7f1ba4e in clone () from /lib/tls/i686/cmov/libc.so.6


It seems to be another issue into libc6. Or my Xenomai system could be corrupted/misconfigured elsewhere?

Thanks in advance, regards.


------=_Part_9_1393721.1303825804906
Content-Type: application/x-zip-compressed; name=sample.zip
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=sample.zip

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
AwAyAQAAjgQAAAAA
------=_Part_9_1393721.1303825804906--

