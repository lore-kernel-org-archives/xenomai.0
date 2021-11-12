From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.2 released
Message-ID: <4d0a4fd3-baa3-0e84-acaa-f33092e3ecda@siemens.com>
Date: Fri, 12 Nov 2021 16:20:40 +0100
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

Changes since 3.1.1:

Jan Kiszka (22):
      drivers/ipc: bufp: Add missing initialization of rdsem/wrsem
      cobalt/rtdm/fd: Fix default handler setups
      cobalt/select: Add proper handling of EADV
      cobalt/kevent: ipipe: Check for FPU events before debug events
      testsuite/smokey: rtdm: Give delayed close more time for running in QEMU
      testsuite/smokey: posix-mutex: Expand mutex holding time when running in VM
      drivers/gpio: Add support for selecting real-time clock timestamps
      build: Disable -Wformat-truncation
      ci: Drop 4.14 from target list
      ci: Switch to bullseye and gcc-10
      ci: Add 32-bit x86 compat userland build
      ci: Enable gpiolib
      doc: Fix copy&paste mistake in corectl man page
      cobalt/arch/arm: fptest: Add missing SIMD register clobbering
      cobalt/posix/thread: Properly discard xnthread on registration error
      drivers/testing/switchtest: Properly clean up xnthread on error
      lib/alchemy: Fix rt_pipe_read* with timeouts
      lib/alchemy/testsuite: Fix pipe-1 test case
      lib/alchemy/testsuite: Extend pipe-1 test by timeout checks
      lib/alchemy: Fix/clarify documentation of *_timed functions regarding abs_timeout
      testsuite/latency: Use corresponding pclose for popen
      config: Bump version number

Richard Weinberger (1):
      kernel: syscall: Correctly check for x32

Wolfgang Grandegger (1):
      cobalt/rtdm: fix memory leak in rtdm_irq_free()

Download available under
https://gitlab.denx.de/Xenomai/xenomai/-/archive/v3.1.2/xenomai-v3.1.2.tar.bz2

Thanks to all contributors!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

