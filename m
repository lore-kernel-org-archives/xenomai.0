Message-ID: <4B309BC7.3070607@domain.hid>
Date: Tue, 22 Dec 2009 11:13:27 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request: build fixes.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 0cb257bf7393b5a53eb35b021b95730bd40dd561:
  Philippe Gerum (1):
        Merge commit 'gilles'

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (3):
      arith: avoid ARM Linux do_div compile-time optimizations.
      analogy: do not compile pcimio on kernels without PCI support
      rtdm: include the new pci_ids driver through rtdm

 include/asm-generic/arith.h                       |   14 +++++++++++---
 include/rtdm/rtdm_driver.h                        |    3 +++
 ksrc/drivers/analogy/national_instruments/Kconfig |    2 +-
 ksrc/drivers/can/sja1000/rtcan_ems_pci.c          |    1 -
 ksrc/drivers/can/sja1000/rtcan_esd_pci.c          |    1 -
 ksrc/drivers/can/sja1000/rtcan_ixxat_pci.c        |    1 -
 ksrc/drivers/can/sja1000/rtcan_peak_pci.c         |    1 -
 7 files changed, 15 insertions(+), 8 deletions(-)

-- 
					    Gilles.

