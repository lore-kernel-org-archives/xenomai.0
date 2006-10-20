Subject: Re: [Xenomai-help] rt_queue_read switch to secondary mode
From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <20db7b520dafb8.20dafb820db7b5@domain.hid>
References: <20db7b520dafb8.20dafb820db7b5@domain.hid>
Content-Type: text/plain
Date: Sat, 21 Oct 2006 01:11:34 +0200
Message-Id: <1161385895.4988.172.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: sbhuller@domain.hid
Cc: xenomai@xenomai.org

On Fri, 2006-10-20 at 16:00 -0600, Sunny Bhuller wrote:
> Hi Philippe,
>   I am including some code below that will produce the problem I am seeing. 
> I must be missing something because if remove the force to primary mode in the
>  function task_procedure the signal will not be caught.  This tells me that
>  without the rt_task_set_mode the task is starting off in secondary mode.  
> 

The backtrace of your program is this one when SIGXCPU is caught:

(gdb) r
Starting program: /home/rpm/frags/secondary/main
[Thread debugging using libthread_db enabled]
[New Thread -1210504992 (LWP 18784)]
[New Thread -1209074768 (LWP 18787)]

Program received signal SIGXCPU, CPU time limit exceeded.
[Switching to Thread -1209074768 (zombie)]
0xb7f02634 in calloc () from /lib/ld-linux.so.2
(gdb) bt
#0  0xb7f02634 in calloc () from /lib/ld-linux.so.2
#1  0xb7ef9110 in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
#2  0xb7ef8b01 in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
#3  0xb7e93200 in _dl_open () from /lib/tls/i686/cmov/libc.so.6
#4  0xb7efd43f in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
#5  0xb7e92c6f in _dl_open () from /lib/tls/i686/cmov/libc.so.6
#6  0xb7e9548d in __libc_dlsym () from /lib/tls/i686/cmov/libc.so.6
#7  0xb7efd43f in _dl_rtld_di_serinfo () from /lib/ld-linux.so.2
#8  0xb7e954ee in __libc_dlopen_mode ()
from /lib/tls/i686/cmov/libc.so.6
#9  0xb7ed7398 in pthread_cancel_init ()
from /lib/tls/i686/cmov/libpthread.so.0
#10 0xb7ed74c1 in _Unwind_ForcedUnwind ()
from /lib/tls/i686/cmov/libpthread.so.0
#11 0xb7ed51f1 in __pthread_unwind ()
from /lib/tls/i686/cmov/libpthread.so.0
#12 0xb7ed1210 in pthread_exit ()
from /lib/tls/i686/cmov/libpthread.so.0
#13 0xb7ec832a in rt_task_trampoline (cookie=0xbfcbb750)
    at /home/rpm/xenomai-2.2.4/src/skins/native/task.c:93
#14 0xb7ed0240 in start_thread ()
from /lib/tls/i686/cmov/libpthread.so.0
#15 0xb7e5e29e in clone () from /lib/tls/i686/cmov/libc.so.6
(gdb)

This means that the signal was sent as a result of performing a calloc()
call, during the late binding of some dynamic library on behalf of
pthread_exit(), which gets called as your real-time task exits
immediately after the non-blocking call to rt_queue_read(). So this is
ok. The following patch should better illustrate the issue:

--- main.c~	2006-10-21 00:15:19.000000000 +0200
+++ main.c	2006-10-21 00:27:52.000000000 +0200
@@ -18,7 +18,7 @@
         some_data data;
 
         rt_queue_read( msq_q, &data, sizeof ( some_data ), TM_NONBLOCK);        
-        
+	rt_task_suspend(NULL);
 }
 
 void signal_handler(int sig)

PS: the call to rt_task_set_mode() in the main() function always fails,
since the main routine is not a Xenomai-thread when started. Therefore,
the call - which requires to be invoked by Xenomai threads - always
returns with -EPERM. Note: this behaviour may differ depending on the
skin bound to the application; for instance, the POSIX skin
automatically promotes the main code as a Xenomai-controlled thread, but
the native skin does not (maybe we should, though).

-- 
Philippe.



