Date: Thu, 13 Jan 2011 00:35:57 +0100
From: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <20110112233555.GB3049@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Xenomai-core] [PULL REQUEST] analogy: bug fixes in buffer size
	config
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

The following changes since commit c0993894a7ab56d9c3f5444e90e68602673288de:

  16550A: Disable PCI configuration option for platforms without PCI (2011-01-08 01:05:02 +0100)

are available in the git repository at:
  ssh+git://git.xenomai.org/xenomai-abe.git analogy 

Alexis Berlemont (5):
      analogy: fix the default size of the buffer
      analogy: [pcimio] minor fix in log messages
      analogy: implement configuration of buffer default size
      analogy: add a "sys" function for the ioctl BUFCONFIG
      analogy: add buffer configuration facility in analogy_config

 include/analogy/analogy.h                        |    2 +
 include/analogy/buffer.h                         |    8 +
 include/analogy/transfer.h                       |    3 +
 include/analogy/types.h                          |    4 +-
 ksrc/drivers/analogy/buffer.c                    |   17 +-
 ksrc/drivers/analogy/national_instruments/mite.c |    2 +-
 ksrc/drivers/analogy/rtdm_interface.c            |   10 +-
 ksrc/drivers/analogy/transfer.c                  |    4 +
 src/drvlib/analogy/async.c                       |    9 +-
 src/drvlib/analogy/sys.c                         |   33 +++
 src/utils/analogy/analogy_config.c               |  241 ++++++++++++++--------
 11 files changed, 223 insertions(+), 110 deletions(-)

-- 
Alexis.

