From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Fri,  7 Dec 2012 18:09:43 +0100
Message-Id: <cover.1354900184.git.jan.kiszka@siemens.com>
Subject: [Xenomai] [PATCH 0/3] [PULL] ipipe-2.6.38-x86
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

The following changes since commit ac565906d56ced004f39bc38a751466b2b5242ae:

  ipipe-2.6.38.8-x86-2.11-02 (2012-03-17 11:09:18 +0100)

are available in the git repository at:
  git://git.kiszka.org/ipipe queues/2.6.38-x86

Jan Kiszka (3):
      ipipe: Factor out ipipe_pin_vma
      ipipe: Pin potential COW pages before applying mprotect changes
      ipipe: Clear IRQ_MASKED from irq descriptor on setup

 include/linux/ipipe.h |    1 +
 kernel/irq/chip.c     |    2 +-
 kernel/irq/manage.c   |    2 +-
 mm/memory.c           |   43 +++++++++++++++++++++++++------------------
 mm/mprotect.c         |   18 ++++++++++++++++++
 5 files changed, 46 insertions(+), 20 deletions(-)

Jan Kiszka (3):
  ipipe: Factor out ipipe_pin_vma
  ipipe: Pin potential COW pages before applying mprotect changes
  ipipe: Clear IRQ_MASKED from irq descriptor on setup

 include/linux/ipipe.h |    1 +
 kernel/irq/chip.c     |    2 +-
 kernel/irq/manage.c   |    2 +-
 mm/memory.c           |   43 +++++++++++++++++++++++++------------------
 mm/mprotect.c         |   18 ++++++++++++++++++
 5 files changed, 46 insertions(+), 20 deletions(-)

-- 
1.7.3.4


