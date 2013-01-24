Message-ID: <51018787.3040603@siemens.com>
Date: Thu, 24 Jan 2013 20:12:07 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [GIT PULL] ipipe: stable 3.4 updates
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Just a reminder, now that my queue is rebased on top of the latest
release:

The following changes since commit 7b032e6d3c458a49e6419d098c54d90f2def9290:

  ipipe-core-3.4.6-powerpc-4 (2013-01-22 11:43:59 +0100)

are available in the git repository at:
  git://git.xenomai.org/ipipe-jki for-upstream/3.4

Gilles Chanteperdrix (1):
      ipipe: disable the root_only check with CONFIG_IPIPE_LEGACY

Jan Kiszka (4):
      ipipe: Rework and simplify __ipipe_pin_vma
      ipipe: Fault in locked vmas after changing the protection flags
      x86/ipipe: Fix registration of IRQ work vector
      x86/ipipe: Disallow transparent huge pages when I-pipe is active

 arch/x86/include/asm/hw_irq.h |    2 +-
 arch/x86/kernel/ipipe.c       |    2 +-
 kernel/ipipe/core.c           |    4 ++
 mm/Kconfig                    |    1 +
 mm/memory.c                   |   79 -----------------------------------------
 mm/mlock.c                    |   18 +++++++++
 mm/mprotect.c                 |   36 ++++---------------
 7 files changed, 32 insertions(+), 110 deletions(-)

