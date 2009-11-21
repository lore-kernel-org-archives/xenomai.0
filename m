Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Sat, 21 Nov 2009 02:12:08 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200911210212.08757.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] [PULL REQUEST] analogy: many bugfixes,
	doxygen updates, parport driver, insn_write
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit e6e21a3e183f145dd1c583e60fbecda982e00c70:
  Alexis Berlemont (1):
        analogy: improve ioctl error handling

are available in the git repository at:

  ssh+git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (21):
      analogy: fix a bug in the attach procedure
      analogy: remove EXPERIMENTAL flag from 2.4 Config.in files
      analogy: fix a mistyping error
      analogy: fix functions declarations in the 8255 driver
      analogy: add an analogy driver for standard parallel port
      analogy: add default attach options for analogy_parport driver
      analogy: make analogy_parport compile only for x86 architectures
      analogy: use the A4L_INSN_* constants to configure the DIO subdevice
      analogy: minor cosmetic change in instruction header
      analogy: change prefix for traces (a4l -> Analogy)
      analogy: some coding style corrections
      analogy: fix a minor bug (filename management) in insn_read
      analogy: add a test program which performs synchronous write
      analogy: fix missing renamings for testing drivers
      analogy: fix doxygen documentation generation for analogy
      analogy: minor indentation fix
      analogy: fix positive error code in transfer cleanup
      analogy: add some details on the error codes for the syscall API
      analogy: add error codes descriptions for the asynchronous API
      analogy: fix a scan size miscalculation in cmd_read
      analogy: report scan size miscalculation fix in cmd_write and insn_*

 doc/doxygen/Doxyfile.in                            |   10 +-
 include/analogy/instruction.h                      |   10 +-
 include/analogy/os_facilities.h                    |    2 +-
 ksrc/drivers/analogy/buffer.c                      |    7 +-
 ksrc/drivers/analogy/intel/8255.c                  |    4 +-
 ksrc/drivers/analogy/intel/Config.in               |    6 +-
 ksrc/drivers/analogy/intel/Kconfig                 |    9 +-
 ksrc/drivers/analogy/intel/Makefile                |   15 +-
 ksrc/drivers/analogy/intel/parport.c               |  452 
++++++++++++++++++++
 .../drivers/analogy/national_instruments/Config.in |    4 +-
 ksrc/drivers/analogy/testing/fake.c                |    2 +-
 ksrc/drivers/analogy/testing/loop.c                |   14 +-
 ksrc/drivers/analogy/transfer.c                    |    2 +-
 src/drvlib/analogy/async.c                         |   78 +++-
 src/drvlib/analogy/sys.c                           |   41 ++-
 src/utils/analogy/Makefile.am                      |    5 +-
 src/utils/analogy/Makefile.in                      |   18 +-
 src/utils/analogy/analogy_config.c                 |   20 +-
 src/utils/analogy/cmd_read.c                       |    3 +-
 src/utils/analogy/cmd_write.c                      |    3 +-
 src/utils/analogy/insn_read.c                      |   14 +-
 src/utils/analogy/insn_write.c                     |  274 ++++++++++++
 22 files changed, 925 insertions(+), 68 deletions(-)
 create mode 100644 ksrc/drivers/analogy/intel/parport.c
 create mode 100644 src/utils/analogy/insn_write.c

Alexis.

