From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <55DF2E76.70501@siemens.com>
Date: Thu, 27 Aug 2015 17:36:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL 1/2] ipipe-3.18: Fixes for x86 and ftrace
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Xenomai <xenomai@xenomai.org>

The following changes since commit 0bd3c33c19974f113bf5edd4494c492774dcdc42:

  ipipe-core-3.18.12-arm-4 (2015-08-15 17:33:06 +0200)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki b115c409 (for-upstream/3.18)

for you to fetch changes up to b115c4094d734e19fa7a96be1bf3958b3d244b8b:

  Revert "ipipe: Register function tracer for direct and exclusive invocation" (2015-08-27 17:22:39 +0200)

This is part one, the second part on top will include stable kernel
updates which require validation on other archs than x86.

----------------------------------------------------------------
Henning Schild (1):
      x86/ipipe: reserve irq num we use for IRQ_MOVE_CLEANUP_VECTOR

Jan Kiszka (4):
      ipipe: Do not raise percpu-access alarm if preemption is off
      ipipe: Avoid rescheduling from __ftrace_ops_list_func in illegal contexts
      ipipe: Disable dynamic ftrace completely under I-pipe
      Revert "ipipe: Register function tracer for direct and exclusive invocation"

 arch/x86/kernel/irqinit.c |  7 ++++++-
 include/linux/ftrace.h    |  1 -
 kernel/ipipe/core.c       |  2 +-
 kernel/ipipe/tracer.c     |  2 +-
 kernel/trace/Kconfig      |  2 +-
 kernel/trace/ftrace.c     | 20 ++++++++++----------
 6 files changed, 19 insertions(+), 15 deletions(-)

