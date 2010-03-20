Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
Message-ID: <4BA416AA.6050603@domain.hid>
Date: Sat, 20 Mar 2010 01:28:26 +0100
From: Alexis Berlemont <berlemont.hauw@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] analogy: bug fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 8cfc1103fe1cf9e700698e8230baf562ffb5cf06:
   Gilles Chanteperdrix (1):
         x86 syscalls: make __xn_get_eip a macro

are available in the git repository at:

   git://git.xenomai.org/xenomai-abe.git analogy

Alexis Berlemont (16):
       analogy: in insn_read, no more real-time mode and automatic subd 
selection
       analogy: in insn_write, no more real-time mode and automatic subd 
selection
       analogy: improve robustness of the detach procedure
       analogy: minor changes in comments
       analogy: fix a potential missing initialization of the subd 
descriptor
       analogy: make a4l_config_subd support open drain configuration
       analogy: [pcimio] fix many race conditions in DMA output transfers
       analogy: make __pre_abs_get more robust at ends of acquisitions
       analogy: fix a bug in cmd_read with real-time mode enabled
       analogy: remove rt_task_set_mode from test programs
       analogy: change the error code in case of context error (-EPERM 
-> -ENOSYS)
       analogy: [loop] add the asynchronous callbacks for the write 
subdevice
       analogy: in cmd_{read, write}, replace a4l_sys_* by a4l_async_*
       analogy: declare a4l_async_read and a4l_async_write in analogy.h
       analogy: add a description of TRIG_WAKE_EOS
       analogy: at close time, cancel any busy subdevice

Daniele Nicolodi (2):
       analogy: [pcimio] enable subdevice buffer mmapping
       analogy: fix a bug in a4l_ioctl_bufinfo when idle

Stefan Schaal (1):
       analogy: add a4l_config_subd() declaration in analogy.h

  include/analogy/analogy.h                          |    9 +
  include/analogy/buffer.h                           |   28 ++++-
  include/analogy/command.h                          |    2 +-
  include/analogy/transfer.h                         |    3 +
  ksrc/drivers/analogy/buffer.c                      |   17 ++-
  ksrc/drivers/analogy/device.c                      |   37 +++--
  .../analogy/national_instruments/mio_common.c      |  102 ++++++++------
  ksrc/drivers/analogy/national_instruments/mite.c   |   17 ++-
  ksrc/drivers/analogy/rtdm_interface.c              |    5 +-
  ksrc/drivers/analogy/testing/loop.c                |   23 ++-
  ksrc/drivers/analogy/transfer.c                    |   69 ++++++++--
  src/drvlib/analogy/sync.c                          |    3 +-
  src/utils/analogy/cmd_read.c                       |   33 +----
  src/utils/analogy/cmd_write.c                      |   13 +--
  src/utils/analogy/insn_bits.c                      |   20 +++
  src/utils/analogy/insn_read.c                      |  145 
++++++++----------
  src/utils/analogy/insn_write.c                     |  154 
+++++++++-----------
  17 files changed, 374 insertions(+), 306 deletions(-)

