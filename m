Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 28 Oct 2009 01:27:11 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200910280127.11388.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PULL REQUEST] Analogy: many bugfixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi Philippe,

Sorry, I forgot the "prefix" rule for the short log for many commits. I will 
take more care starting from now.

Alexis.

The following changes since commit 39614e10be1d7fc5344b56646b8801cbf8756e08:
  Alexis Berlemont (1):
        Add error messages for the IOCTL interface (attach, instruction, cmd, 
etc.)

are available in the git repository at:

  ssh+git://git.xenomai.org/xenomai-abe.git analogy ..BRANCH.NOT.VERIFIED..

Alexis Berlemont (4):
      Fix testing drivers' renaming issues
      Some Comedi -> Analogy forgotten renamings
      Add modules descriptions and license specifications
      Fix comments

Breeje, R. (Remco) den (2):
      Add a missing dependency for the NI MIO driver (NI TIO)
      In cmd_read, fix received bytes storing

Philippe Gerum (1):
      analogy: fix debug options dependencies

 ksrc/drivers/analogy/Kconfig                       |    2 +
 ksrc/drivers/analogy/instruction.c                 |    2 +-
 ksrc/drivers/analogy/intel/8255.c                  |   10 +-
 ksrc/drivers/analogy/national_instruments/Kconfig  |    2 +-
 .../analogy/national_instruments/mio_common.c      |    3 +
 ksrc/drivers/analogy/national_instruments/mite.c   |    2 +-
 ksrc/drivers/analogy/national_instruments/pcimio.c |    2 +
 .../analogy/national_instruments/tio_common.c      |    2 +-
 ksrc/drivers/analogy/testing/Config.in             |    4 +-
 ksrc/drivers/analogy/testing/Kconfig               |    8 +-
 ksrc/drivers/analogy/testing/Makefile              |   26 ++--
 ksrc/drivers/analogy/testing/fake.c                |  116 +++++++++---------
 ksrc/drivers/analogy/testing/loop.c                |  136 
++++++++++----------
 src/utils/analogy/analogy_config.c                 |   22 ++--
 src/utils/analogy/cmd_read.c                       |   54 ++++----
 src/utils/analogy/cmd_write.c                      |   44 +++---
 src/utils/analogy/insn_read.c                      |   32 +++---
 17 files changed, 239 insertions(+), 228 deletions(-)

Alexis.

