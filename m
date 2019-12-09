From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.0.10 released
Message-ID: <5609e841-eb5c-b423-5b40-3d5a6e67ff23@siemens.com>
Date: Mon, 9 Dec 2019 17:55:29 +0100
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

Changes since 3.0.9:

Jan Kiszka (12):
      boilerplate: Fix non-conforming usage of typeof in interface headers
      drivers/autotune: Fix UBSAN warnings
      debian: Add config folder to xenomai-kernel-source
      debian: Enable SMP in userspace package
      drivers/can: Fix gcc-8 warning about improper string concatenation
      ci: Name matrix jobs, update x86 kernel, drop 4.14 head
      copperplate: Handle errors properly in get_session_label
      ci: Always build the latest release
      lib/cobalt: Fix help for --print-sync-delay
      alchemy: Fully initialize tcb->self
      ci: Do not stumble over annotated ipipe tags
      config: Bump version number

Norbert Lange via Xenomai (1):
      cobalt: remove call to sigprocmask

Philippe Gerum (11):
      cobalt: syscall: don't bark at internal syscalls
      cobalt/pipe: unblock read()/write() on disconnect
      drivers/net: Kconfig: fix tests for architecture
      cobalt/sched: tp: check partition id obtained from user
      lib/cobalt: init: do not call pthread_atfork() from atfork() handlers
      demo/posix: cyclictest: prevent spurious WARNSW events on exit
      cobalt/thread: update inline documentation
      cobalt/thread: fix scheduler breakage on thread suspension
      cobalt/process: exit_thread handlers should reschedule as needed
      cobalt/sched: quota: fix use-after-free in quota_remove operation
      cobalt/sched: guard against missed rescheduling upon CPU migration

Quirin Gylstorff (3):
      debian/control: Add dependencies for xenomai-testsuite
      debian/rules: Add missing bootstrap step
      testsuite/xeno-test: add --vm option

Richard Weinberger via Xenomai (2):
      demo/alchemy/altency: Use sigdebug_reason()
      alchemy/mutex: Fix typo in comment

Tormod Volden (1):
      trank/rtdm: Add rt_dev_recvfrom() compat wrapper

Wolfgang Grandegger via Xenomai (1):
      utils/can: fix error handling, use errno instead of -ret

Thanks to all the contributors!

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

