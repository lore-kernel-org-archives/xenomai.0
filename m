Date: Mon, 20 Sep 2010 11:43:28 +0200
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20100920094328.GA29405@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [PULL REQUEST] analogy: bugfixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The following changes since commit 9d70c373eee0ac43a1b5869600e33ec6bff89868:

  rtcan: Mask the SJA_MOD register when probing for channels (2010-09-16 20:43:34 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (9):
      analogy: minor change in analogy Kconfig text
      analogy: add comments in the buffer management code
      analogy: fix a bug in the DIO subdevice's mite configuration
      analogy: minor changes in cmd_bits
      analogy: comsetic change in mite.c
      analogy: [pcimio] rework the mite setup procedures
      analogy: [pcimio] fix a forgotten warning
      analogy: [pcimio] add the initialization of the ring for gpct subd
      analogy: fix compilation warnings with gcc-4.4.1

 include/analogy/buffer.h                           |   52 ++++++-
 ksrc/drivers/analogy/Kconfig                       |    2 +-
 ksrc/drivers/analogy/buffer.c                      |   23 +++-
 .../analogy/national_instruments/mio_common.c      |  155 +++++++++++++-------
 ksrc/drivers/analogy/national_instruments/mite.c   |    4 +-
 src/drvlib/analogy/sync.c                          |   44 ++++--
 src/utils/analogy/cmd_bits.c                       |    6 +-
 src/utils/analogy/insn_bits.c                      |    9 +-
 8 files changed, 213 insertions(+), 82 deletions(-)

-- 
Alexis.

