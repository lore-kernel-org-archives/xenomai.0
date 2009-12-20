Message-ID: <4B2E043F.6080801@domain.hid>
Date: Sun, 20 Dec 2009 12:02:23 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] build tests pull request.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit e467b58dadfbb83adc41cdb79344412bf4f4b0ec:
  Philippe Gerum (1):
        blackfin: fix reference commit numbers

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

Alexis Berlemont (1):
      analogy: do not export static variables

Gilles Chanteperdrix (9):
      nmi: fix build for linux 2.4
      analogy: fix build for 2.4 kernel
      rtcan: make rtcan pci board depend on CONFIG_PCI
      posix: add missing space to Config.in
      xconfig 2.4: make xconfig work again with linux 2.4
      build: fix prepare-kernel.sh
      drivers: add a pci_ids.h driver
      x86: use the new pci_ids header for the smi module
      rtcan: use the new pci_ids header for pci rtcan drivers

Philippe Gerum (1):
      wrappers: fix definition of phys_addr_t

 include/asm-generic/Makefile.am                  |    1 +
 include/asm-generic/pci_ids.h                    |   25 ++++++++++++++++++++++
 include/asm-generic/wrappers.h                   |    6 -----
 include/asm-powerpc/wrappers.h                   |    4 +++
 include/asm-x86/wrappers_32.h                    |    4 +++
 ksrc/arch/x86/nmi.c                              |    8 +++++++
 ksrc/arch/x86/smi.c                              |   12 +---------
 ksrc/drivers/analogy/intel/Config.in             |    2 +-
 ksrc/drivers/analogy/intel/Makefile              |    6 +++-
 ksrc/drivers/analogy/national_instruments/mite.c |    1 -
 ksrc/drivers/can/sja1000/Kconfig                 |   10 ++++----
 ksrc/drivers/can/sja1000/rtcan_ems_pci.c         |    1 +
 ksrc/drivers/can/sja1000/rtcan_esd_pci.c         |    1 +
 ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c       |    1 +
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c        |    1 +
 ksrc/drivers/testing/Config.in                   |    4 +-
 ksrc/skins/posix/Config.in                       |    2 +-
 scripts/prepare-kernel.sh                        |    3 +-
 18 files changed, 62 insertions(+), 30 deletions(-)
 create mode 100644 include/asm-generic/pci_ids.h

-- 
					    Gilles.

