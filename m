Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4B6DF76A.1090408@domain.hid>
Date: Sun, 07 Feb 2010 00:12:42 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: bug fixes + insn_bits
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 4a5b93dabf66529e665c8f8422902347d4f6158f:
   Jan Kiszka (1):
         RTDM: Split up application and driver debugging

are available in the git repository at:

   git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (19):
       analogy: fix a declaration issue, a4l_sizeof_subd was not in 
analogy.h
       analogy: add the function a4l_sync_dio
       analogy: clean the fake driver and add a DIO subdevice
       analogy: [fake] fix a bad access in the attach procedure
       analogy: fix a bug in a4l_sync_dio
       analogy: add the program insn_bits to test digital subdevices
       analogy: [pcimio] fix a bug in the management of attach options
       analogy: print a kernel error message if an instruction failed
       analogy: add a missing error message in insn_read
       analogy: add a missing error message in insn_write
       analogy: [fake] fix a bad access in the detach procedure
       analogy: [fake] minor change in debug messages
       analogy: remove a useless locking during the detach procedure
       analogy: remove a forgotten variable which became useless
       analogy: add a4l_flush_sync()
       analogy: read() and poll() return no more -ENOENT when 
acquisition is over
       analogy: reinitialize events flags before accepting commands
       analogy: [fake] send events only if data are sent to userspace
       analogy: adapt cmd_read after having fixed read and poll syscalls

  include/analogy/analogy.h                          |    5 +
  include/analogy/os_facilities.h                    |    1 +
  ksrc/drivers/analogy/buffer.c                      |   29 ++-
  ksrc/drivers/analogy/device.c                      |    9 +-
  ksrc/drivers/analogy/instruction.c                 |   12 +-
  ksrc/drivers/analogy/national_instruments/pcimio.c |    4 +-
  ksrc/drivers/analogy/os_facilities.c               |   18 ++-
  ksrc/drivers/analogy/testing/fake.c                |  255 
+++++++++++---------
  ksrc/drivers/analogy/transfer.c                    |    7 +-
  src/drvlib/analogy/sync.c                          |   80 ++++++
  src/utils/analogy/Makefile.am                      |    5 +-
  src/utils/analogy/Makefile.in                      |   15 +-
  src/utils/analogy/cmd_read.c                       |   19 +-
  src/utils/analogy/insn_bits.c                      |  204 ++++++++++++++++
  src/utils/analogy/insn_read.c                      |    6 +-
  src/utils/analogy/insn_write.c                     |    5 +-
  16 files changed, 529 insertions(+), 145 deletions(-)
  create mode 100644 src/utils/analogy/insn_bits.c

