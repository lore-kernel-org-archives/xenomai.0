Message-ID: <445F4E8E.2090007@domain.hid>
Date: Mon, 08 May 2006 15:58:38 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] /native/demos/satch hangs
References: <20060505121832.7e4ca460@domain.hid>
In-Reply-To: <20060505121832.7e4ca460@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Daniel Simon <Daniel.Simon@domain.hid>
Cc: xenomai@xenomai.org

Daniel Simon wrote:
> Hello,
> 
> I am trying xenomai on a Compaq N600c laptop, kernel 2.6.15 patched
> against xenomai-2.1.0 (config file attached).
> 
> Most tests run succesfully (i.e., /usr/xenomai/testsuite/*  and
> xenomai/ksrc/skins/posix/demos/accuracy*)
> 
> However, (and after complaining about libnative.so.0 and running
> ldconfig) the satch test found in $xenomai/ksrc/skins/native/demos/
> immediately hangs the pc... It seems to be definitively locked despite
> the watchdog.
> 
> What may be the reason?

The warnings when compiling the example give the answer. The patch below 
makes this code work; it has been fixed in later releases.

--- xenomai-2.1.0/ksrc/skins/native/demos/satch.c       2006-02-03 
23:34:14.000000000 +0100
+++ xenomai-2.1.50/ksrc/skins/native/demos/satch.c      2006-03-19 
18:30:34.000000000 +0100
@@ -1,3 +1,4 @@
+#include <sys/mman.h>
  #include <stdio.h>
  #include <unistd.h>
  #include <string.h>
@@ -88,7 +89,7 @@
  int root_thread_init (void)

  {
-    rt_timer_start(1000000);   /* 1ms periodic tick. */
+    rt_timer_set_mode(1000000);        /* Forc 1ms periodic tick. */

      rt_task_spawn(&consumer_task,
                   "ConsumerTask",
@@ -120,6 +121,7 @@
  int main (int ac, char *av[])

  {
+    mlockall(MCL_CURRENT|MCL_FUTURE);
      root_thread_init();
      pause();
      root_thread_exit();
-- 

Philippe.

