Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B4BAACB.7040005@domain.hid>
Date: Mon, 11 Jan 2010 23:48:43 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: sensoray s526 and bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 3c6b84c9ca7cfc0a9551fd835861f4a05ce7e649:
   Gilles Chanteperdrix (1):
         skins: factor user-space tacks sizes handling code

are available in the git repository at:

   ssh+git://git.xenomai.org/xenomai-abe.git analogy

Alessio Margan (1):
       analogy: rename s526 driver (analogy_s526)

Alexis Berlemont (3):
       analogy: fix the tests of the subdevice flags in the basic checks
       analogy: do not check the range if no range descriptor is found
       analogy: fix an ugly access in NI MIO driver

Simon Boulay (8):
       analogy: add s526 driver
       analogy: some cosmetic change in s526 driver
       analogy: fix misuses of the instruction field data_size
       analogy: [s526] Remove dead code from attach function.
       analogy: [s526] Remove dead code from gpct_insn_config function.
       analogy: [s526] Cleanups; mainly generic comments from skel.c
       analogy: [s526] Remove useless HAVE_DIO option
       analogy: [s526] Cleanups; remove unused defines and variables

  ksrc/drivers/analogy/Config.in                     |    3 +-
  ksrc/drivers/analogy/Kconfig                       |    1 +
  ksrc/drivers/analogy/Makefile                      |    3 +-
  ksrc/drivers/analogy/command.c                     |    3 +-
  ksrc/drivers/analogy/instruction.c                 |    2 +-
  .../analogy/national_instruments/mio_common.c      |    7 +-
  ksrc/drivers/analogy/sensoray/Config.in            |    2 +
  ksrc/drivers/analogy/sensoray/Kconfig              |    5 +
  ksrc/drivers/analogy/sensoray/Makefile             |   30 +
  ksrc/drivers/analogy/sensoray/s526.c               |  755 
++++++++++++++++++++
  ksrc/drivers/analogy/subdevice.c                   |   29 +-
  ksrc/drivers/analogy/transfer.c                    |    3 +-
  12 files changed, 825 insertions(+), 18 deletions(-)
  create mode 100644 ksrc/drivers/analogy/sensoray/Config.in
  create mode 100644 ksrc/drivers/analogy/sensoray/Kconfig
  create mode 100644 ksrc/drivers/analogy/sensoray/Makefile
  create mode 100644 ksrc/drivers/analogy/sensoray/s526.c

