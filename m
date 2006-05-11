From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Kernel panic on rmmod xeno_vxworks
Date: Thu, 11 May 2006 13:15:18 +0200
References: <200605102227.09892.niklaus.giger@domain.hid>
	<17506.23072.289428.72701@domain.hid>
In-Reply-To: <17506.23072.289428.72701@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605111315.19638.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Am Mittwoch, 10. Mai 2006 23:24 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Hi
>  >
>  > I compiled and started my test with a recent xenomai/trunk (revision
>  > 1068). I booted into single user mode, did a "modprobe xeno_vxworks" (no
>  > problem) and then a "rmmod xeno_vxworks" and got as response on my
>  > PowerBook only "Kernel panic: -not syncing: Aiee, killing interrupt
>  > handler".
>  >
>  >
>  > Also when I try to run ksrc/skins/vxworks/demos/satch (after a make std)
>  > I get the following info (using gdb):
>  > (gdb) run
>  > Starting
>  > program:
>  > /mnt/data.ng/hcu/kernel/xenomai-head/ksrc/skins/vxworks/demos/satch
>  > [Thread debugging using libthread_db enabled]
>  > [New Thread 805415264 (LWP 4168)]
>  > [New Thread 805434592 (LWP 4171)]
>  > [New Thread 805450976 (LWP 4172)]
>  >
>  > Program received signal SIGSEGV, Segmentation fault.
>  > [Switching to Thread 805434592 (LWP 4171)]
>  > 0x0fe76094 in vfprintf () from /lib/tls/libc.so.6
>  > (gdb) info stack
>  > #0  0x0fe76094 in vfprintf () from /lib/tls/libc.so.6
>  > #1  0x0fe7e760 in printf () from /lib/tls/libc.so.6
>  > #2  0x10001a6c in consumer_task (a0=269287424, a1=268894208,
>  > a2=269477288, a3=0, a4=0, a5=0, a6=269482760, a7=805474048,
>  >     a8=2144297840, a9=268064096) at satch.c:99
>  > #3  0x0ffa7714 in wind_task_trampoline (cookie=0x7fcf632c)
>  > at /mnt/data.ng/hcu/kernel/xenomai-head/src/skins/vxworks/taskLib.c:99
>  > #4  0x0ffd08e8 in start_thread () from /lib/tls/libpthread.so.0
>  > #5  0x0ffd08e8 in start_thread () from /lib/tls/libpthread.so.0
>  > Previous frame inner to this frame (corrupt stack?)
>
> I observed such an error when the stack size is to small, I guess
> vfprintf uses alloca.
This fixed my problem. Task crashes with 18 kB stack, but not with
20 kB. Therefore I propose 24 kB to have some margine for the future.

Please apply the following patch:
Index: ksrc/skins/vxworks/demos/satch.c
===================================================================
--- ksrc/skins/vxworks/demos/satch.c    (Revision 1068)
+++ ksrc/skins/vxworks/demos/satch.c    (Arbeitskopie)
@@ -21,10 +21,10 @@
 #include <vxworks/vxworks.h>

 #define CONSUMER_TASK_PRI    115
-#define CONSUMER_STACK_SIZE  8192
+#define CONSUMER_STACK_SIZE  24*1024

 #define PRODUCER_TASK_PRI    110
-#define PRODUCER_STACK_SIZE  8192
+#define PRODUCER_STACK_SIZE  24*1024

 #define CONSUMER_WAIT 150
 #define PRODUCER_TRIG 40

Thanks in advance.

Best regards

-- 
Niklaus Giger

