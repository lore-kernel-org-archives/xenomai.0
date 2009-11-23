Message-ID: <4B0AD497.6080605@domain.hid>
Date: Mon, 23 Nov 2009 19:29:43 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] RTDM: phys_addr mapping and ISA CAN
	driver fix
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit 3fded6232aad90e2c6799857a21aa492a0fa8e22:
  Philippe Gerum (1):
        Merge commit 'jan'

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Luis Herrera-Bendezu (1):
      rtdm: Extend rtdm_iomap_to_user to map phys addr > 4G

Sebastian Smolorz (1):
      can: Free I/O region when unloading the xeno_can_isa.ko driver

 include/asm-generic/system.h         |    2 +-
 include/asm-generic/wrappers.h       |    4 ++++
 include/rtdm/rtdm_driver.h           |    2 +-
 ksrc/drivers/can/sja1000/rtcan_isa.c |    5 +++--
 ksrc/skins/rtdm/drvlib.c             |    9 +++++----
 5 files changed, 14 insertions(+), 8 deletions(-)

