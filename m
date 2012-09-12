From: Wolfgang Mauerer <wolfgang.mauerer@siemens.com>
Date: Wed, 12 Sep 2012 19:00:32 +0200
Message-Id: <1347469235-17712-1-git-send-email-wolfgang.mauerer@siemens.com>
Subject: [Xenomai] [PULL, PATCH 0/3] ipipe tracer fixes
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: wolfgang.mauerer@siemens.com

The first two patches are required to build core-4 on x86. The last patch
is necessary when the base kernel is >= 3.1. It can be applied to
3.x with a trivial offset.

The following changes since commit d21e8cdbdcf21ade9878c038e8bd55555ae1d210:

  ipipe: ipipe_timers_request -> ipipe_select_timers (2012-09-03 11:15:35 +0200)

are available in the git repository at:
  https://github.com/siemens/ipipe.git for-upstream

Wolfgang Mauerer (3):
      ipipe: Remove superfluous symbol export of irq_to_desc
      ipipe,x86: Introduce hard_irqs_disabled_flags
      Fix IRQs-off-tracer for x86_64

 arch/x86/include/asm/irqflags.h |    2 ++
 arch/x86/kernel/entry_64.S      |    8 ++++++--
 arch/x86/kernel/ipipe.c         |    3 ---
 3 files changed, 8 insertions(+), 5 deletions(-)

