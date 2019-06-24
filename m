From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.9 released
Message-ID: <83773016-ff9c-ea77-4bd0-40fb70320c00@siemens.com>
Date: Mon, 24 Jun 2019 09:48:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Changes since 3.0.8:

Jan Kiszka (16):
      cobalt: x86: Use ipipe_root_nr_syscalls
      rtnet: Add kernel/rtdm/net.h to packaged header list
      cobalt: Improve cobalt_copy_from/to_user
      cobalt/wrappers: Fix version level for cobalt_gpiochip_dev
      ci: Add userspace build
      rtnet: e1000e: Fix build on 4.12+
      ci: Pull kernels from git and enhance coverage
      ci: Tune config
      ci: Update to latest 4.14-110-arm-7
      ci: Add a powerpc target
      cobalt/thread: Clear XNSYSRST when migrating to Linux
      testsuite/smokey/sigdebug: Fix check_no_error and some callers
      rtnet: Remove rtskbs also from mapwait list on destruction
      rtnet: Fix leak on failing rtdev_map_rtskb in rtskb_pool_extend
      cobalt/posix/signal: Fix iteration over sigwaiters
      config: Bump version number

Jeff Webb (1):
      drivers/serial: 16550A: fix tx timeout bug in rt_16550_write

Norbert Lange via Xenomai (3):
      cobalt: mode argument from open forwarded for O_TMPFILE
      lib/cobalt: start helper thread with signals blocked
      lib/cobalt: set name for printf thread to help debugging

Philippe Gerum (32):
      utils/can: prevent unterminated destination buffer with strncpy()
      demos/posix: prevent unterminated destination buffer with strncpy()
      boilerplate/ancillaries: prevent false positive with -Wstringop-truncation
      cobalt/ancillaries: prevent false positive with -Wstringop-truncation
      cobalt/sched: add per-policy handler for early parameter checking
      cobalt/sched: quota: add early parameter checking handler
      cobalt/sched: sporadic: add early parameter checking handler
      cobalt/sched: tp: add early parameter checking handler
      cobalt/sched: weak: add early parameter checking handler
      cobalt/intr: vfile: do not assume all irqs are cobalt-managed
      drivers/autotune: do not read user data we should not expect
      cobalt/thread: skip boundary check for infinite round-robin time slice
      testsuite/smokey: posix_clock: prevent false positive in time-dependent test
      net/stack: fresh rtskb should have ip_summed set to CHECKSUM_NONE
      net/rtdev: ensure per-device skbs get mapped at registration
      net/udp: getfrag: fix frag preparation status
      net/udp: getfrag: remove direct reference to user memory
      testsuite/smokey: net: do not unload pre-loaded modules
      testsuite/smokey: net: do not down a previously running test interface
      drivers/ipc: bufp: fix read-write, write-write preemption cases
      drivers/serial: imx: fix locking imbalance upon -EBADF
      drivers/serial: imx: fix transmit interrupt handling
      drivers/serial: imx: robustify device setup/cleanup
      drivers/serial: always propagate -EINTR downstream
      drivers/serial: imx: simplify RX loop
      drivers/serial: imx: dismiss noisy IRQ events
      drivers/udd: fix spurious select() read events
      testsuite/smokey: sched-quota: allow up to 1.5% deviation from plan
      testsuite/smokey: reset main()'s SCHED_OTHER policy before each test
      cobalt/thread: send backtracing request only when XNWARN is set
      cobalt/thread: fix error status (-EINTR) of xnthread_killall()
      lib/cobalt: kickstart backtrace() from safe context

Philippe Gerum via Xenomai (1):
      cobalt/intr: fix interrupt stat iterator

Roman Stratiienko (3):
      travis: add basic CI support
      travis: use ccache
      travis: add more build options

Sebastian Smolorz via Xenomai (1):
      net/ip_sock: ioctl: fix unsafe accesses from/to userspace


Thanks to all the contributors!

Note again that the 3.0.x series works up to kernel 4.14. For 4.19
support, please switch to master, the source of upcoming 3.1. And now
let's work on finishing that!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

