Message-ID: <520A7E49.1020604@xenomai.org>
Date: Tue, 13 Aug 2013 20:43:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] pull request for core-3.5.7 branch
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

The following changes since commit c50835b0825e0531fae5675693d7f04d13cc5dd8:

  powerpc/ipipe: ipipe-core-3.5.7-powerpc-4 (2013-06-02 15:45:19 +0200)

are available in the git repository at:
  git://git.xenomai.org/ipipe-gch.git for-core-3.5.7

Gilles Chanteperdrix (6):
      ipipe/tracer: fix console messages alignment
      arm/ipipe: rework context switch with VIVT caches
      arm/ipipe: fix unlocked context switch with FCSE best-effort
      arm/ipipe: shut irqs off during armv6+ mm switch
      FCSE/debug: avoid error with CONFIG_ARM_FCSE_DEBUG
      ipipe-core-3.5.7-arm-4

 arch/arm/include/asm/fcse.h        |   27 ++++++++++----
 arch/arm/include/asm/ipipe.h       |    2 +-
 arch/arm/include/asm/mmu_context.h |   71 ++++++++++++++++++++++++++----------
 arch/arm/kernel/ipipe.c            |   57 ++++++++++++++++++++++-------
 arch/arm/mm/context.c              |    2 +-
 arch/arm/mm/fcse.c                 |   70 ++++++++++++++++++++++--------------
 kernel/ipipe/tracer.c              |    2 +-
 7 files changed, 161 insertions(+), 70 deletions(-)

-- 
                                                                Gilles.

