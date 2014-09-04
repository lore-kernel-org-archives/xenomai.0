Message-ID: <5408A860.3020002@gatech.edu>
Date: Thu, 04 Sep 2014 13:58:56 -0400
From: "Yogi A. Patel" <yapatel@gatech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] Error compiling on P4 machine
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi -

Compiling 32 bit machine with Ubuntu 14.04 and getting the following 
error during the kernel compile - can't seem to make sense of it:

  CC      kernel/trace/trace_event_perf.o
   CC      kernel/trace/trace_events_filter.o
   CC      kernel/trace/trace_kprobe.o
   CC      kernel/trace/power-traces.o
   CC      kernel/trace/rpm-traces.o
   CC      kernel/trace/trace_probe.o
   CC      kernel/trace/trace_uprobe.o
   LD      kernel/trace/built-in.o
   CC      kernel/xenomai/arch/generic/hal.o
In file included from kernel/xenomai/arch/generic/hal.c:44:0:
/opt/linux-3.8.13/arch/x86/include/asm/xenomai/hal.h:69:13: warning: ‘struct ipipe_tick_device’ declared inside parameter list [enabled by default]
       struct ipipe_tick_device *tdev);
              ^
/opt/linux-3.8.13/arch/x86/include/asm/xenomai/hal.h:69:13: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
/opt/linux-3.8.13/arch/x86/include/asm/xenomai/hal.h:71:12: warning: ‘struct ipipe_tick_device’ declared inside parameter list [enabled by default]
      struct ipipe_tick_device *tdev);
             ^
In file included from /opt/linux-3.8.13/arch/x86/include/asm/xenomai/hal_32.h:58:0,
                  from /opt/linux-3.8.13/arch/x86/include/asm/xenomai/hal.h:79,
                  from kernel/xenomai/arch/generic/hal.c:44:
include/asm-generic/xenomai/hal.h: In function ‘rthal_get_cpufreq’:
include/asm-generic/xenomai/hal.h:234:23: error: storage size of ‘sysinfo’ isn’t known
   struct ipipe_sysinfo sysinfo;
                        ^
include/asm-generic/xenomai/hal.h:235:2: error: implicit declaration of function ‘ipipe_get_sysinfo’ [-Werror=implicit-function-declaration]
   rthal_get_sysinfo(&sysinfo);
   ^
include/asm-generic/xenomai/hal.h:234:23: warning: unused variable ‘sysinfo’ [-Wunused-variable]
   struct ipipe_sysinfo sysinfo;
                        ^
include/asm-generic/xenomai/hal.h: In function ‘rthal_get_timerfreq’:
include/asm-generic/xenomai/hal.h:241:23: error: storage size of ‘sysinfo’ isn’t known
   struct ipipe_sysinfo sysinfo;
                        ^
include/asm-generic/xenomai/hal.h:241:23: warning: unused variable ‘sysinfo’ [-Wunused-variable]
In file included from /opt/linux-3.8.13/arch/x86/include/asm/atomic.h:8:0,
                  from include/linux/atomic.h:4,
                  from /opt/linux-3.8.13/arch/x86/include/asm/thread_info.h:24,
                  from include/linux/thread_info.h:54,

-- 
Yogi

