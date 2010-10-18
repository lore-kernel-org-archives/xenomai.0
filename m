Message-ID: <4CBC547E.1030101@domain.hid>
Date: Mon, 18 Oct 2010 16:06:54 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [git pull] IRQ virtualization fixes and noarch merge
	for ipipe-2.6.35-x86
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit d6040e695e40a9cbac2507690100b6e95b555d7d:

  ipipe-2.6.35.7-x86-2.7-04 (2010-10-04 12:47:15 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe-2.6 queues/2.6.35-x86

Jan Kiszka (6):
      ipipe: Remove unused local variables
      ipipe: Reinstall ipipe_nmi_enter/exit
      ipipe: Drop foreign stack test from nmi entry/exit
      Merge branch 'queues/2.6.35-noarch' into queues/2.6.35-x86
      ipipe: x86: Fix virtualization of perf_pending_interrupt
      ipipe: x86: Fix x86_platform_ipi virtualization

Philippe Gerum (3):
      ipipe: enable back ftrace at startup
      ipipe: detect damage of hw interrupt state via spin_unlock_irqrestore
      ipipe: fix build with ipipe off

 arch/x86/include/asm/hw_irq.h |    1 +
 arch/x86/kernel/ipipe.c       |    8 ++++----
 include/linux/hardirq.h       |   38 ++++++++++++++++++--------------------
 include/linux/ipipe_lock.h    |   18 ++++++++++++++----
 kernel/ipipe/core.c           |   16 +++++++++++++++-
 kernel/ipipe/tracer.c         |    1 +
 6 files changed, 53 insertions(+), 29 deletions(-)

