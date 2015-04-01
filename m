Message-ID: <551C37C2.8070803@siemens.com>
Date: Wed, 01 Apr 2015 20:24:02 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] ipipe: fixes for 3.16
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

The following changes since commit 3345565c64b9394729af9a2607e17869146e5415:

  Merge tag 'v3.16.7' into ipipe-3.16 (2015-03-17 12:14:50 +0100)

are available in the git repository at:

  git://git.xenomai.org/ipipe-jki for-upstream/3.16

for you to fetch changes up to 31c38e538af63cee541cb249121e931b05b1a3fc:

  arm/ipipe: Move ipipe_fault_entry past __ipipe_report_trap (2015-04-01 18:49:37 +0200)

These are just the most urgent or most harmless fixes that should go
into the next 3.16 stable release. There are still the exception
handling fixes and reworks, and 3.14 may need some of the patches as
well, but one after the other.

----------------------------------------------------------------
Jan Kiszka (5):
      ipipe: Disable PROVE_RCU when I-pipe is on
      x86/ipipe: Restore invocation of ipipe_unlock_irq from startup_ioapic_irq
      arm/ipipe: Fix logical inversion in ret_from_exception
      arm/ipipe: Fix I-pipe tracer for SMP_ON_UP
      arm/ipipe: Move ipipe_fault_entry past __ipipe_report_trap

 arch/arm/kernel/entry-armv.S   |  4 ++--
 arch/arm/kernel/ipipe.c        |  2 +-
 arch/arm/mm/fault.c            | 16 ++++++++--------
 arch/x86/kernel/apic/io_apic.c |  1 +
 lib/Kconfig.debug              |  2 +-
 5 files changed, 13 insertions(+), 12 deletions(-)

