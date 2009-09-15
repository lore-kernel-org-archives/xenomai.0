Sender: Alexis Berlemont <alexis.berlemont@domain.hid>
From: Alexis Berlemont <berlemont.hauw@domain.hid>
Date: Wed, 16 Sep 2009 01:41:45 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200909160141.46143.berlemont.hauw@domain.hid>
Subject: [Xenomai-core] Pull request for head
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 13d66eb4c8f1648614095d43dd529a3c98fc5278:
  Philippe Gerum (1):
        x86: upgrade I-pipe support to 2.6.31-x86-2.4-05

are available in the git repository at:

  ssh+git://git@domain.hid comedi

Alexis Berlemont (46):
      Replace comedi_channel_* char-typed fields by unsigned long fields.
      Update indentation, add flags related macros
      Add missing flags for instructions (configuration type, counter status 
bits, IO directions and events types).
      Fix indentation
      Fix indentation
      Add range_unknown declaration
      Add Comedi PCIMIO drivers set
      Review the subdevice registration system: get closer from Comedi 
upstream; Rework indentation in testing drivers; Remove useless drivers 
management functions (comedi_init_drv(), comedi_cleanup_drv())
      Replace the first argument type: comedi_cxt_t becomes comedi_dev_t; the 
context structure is meaningless for the driver developer.
      Change subdevice related callbacks: replace their first argument: 
comedi_cxt_t -> comedi_dev_t; the context is meaningless for drivers 
developers.
      Apply driver API change on testing drivers
      Slightly optimize the function comedi_get_chan()
      Change the second argument of the callback do_cmd() (in subdevice 
structure), the subdevice index is replaced by the command to apply (which 
contains the subdevice index).
      Fix typing mistake in the driver fake.c
      Review the tracing macros, mimic v4l2's system
      Add the subdevice registration index into the subdevice structure
      Simplify the declaration of comedi_get_chan
      Simplify munge function declaration
      Remove comedi_get_nbchan(), a specific function which became useless, 
and add comedi_get_subd(), a more general function which might be helpful at 
attach / detach time.
      Remove comedi_get_nbchan(), a specific function which became useless, 
and add comedi_get_subd(), a more general function which might be helpful at 
attach / detach time.
      Review trace macros
      Update 8255 driver
      Replace forgotten rtdm_printk() by comedi_err()
      Review traces
      Update NI TIO driver according to driver API changes
      Update NI MIO driver according to driver API changes
      Update NI PCIMIO driver according to driver API changes and fix a bug at 
the same time
      Minor indentation change in fake driver source
      Fix obvious bug in IRQ registering procedure
      Fix trivial compilation bug.
      Remove useless argument in the cancel callback
      Review comedi_get_cmd's arguments: the subdevice descriptor should be 
enough.
      Fix trace type (info -> err)
      Properly implement debug traces
      Fix minor initialization bugs
      Add more checks in chaninfo, rnginfo ioctls
      Add comedi_presetup_transfer() function to be called before attach 
procedure; this function was added to prevent IRQ descriptor overwrite.
      Add a fake range descriptor; Add basic checks in *_info ioctls
      Add fake range descriptor
      Add missing types flags into COMEDI_SUBD_TYPES
      Fix debug trace routines
      Fix MSeries_PLL_Enable_Bit wrong definition
      Add RTSI and clock precompilation constants
      Improve comedi_buf_evt(): remove ugly subdevice guessing based on flags.
      Apply modifications due to comedi_buf_evt() declaration change
      Add missing RTSI / clock configuration routines

 include/comedi/buffer.h                            |   19 +-
 include/comedi/channel_range.h                     |   25 +-
 include/comedi/command.h                           |   22 +-
 include/comedi/device.h                            |    7 +-
 include/comedi/driver.h                            |   24 +-
 include/comedi/instruction.h                       |   79 +
 include/comedi/os_facilities.h                     |   44 +-
 include/comedi/subdevice.h                         |   50 +-
 include/comedi/transfer.h                          |    1 +
 ksrc/drivers/comedi/Config.in                      |    2 +
 ksrc/drivers/comedi/Kconfig                        |   21 +
 ksrc/drivers/comedi/Makefile                       |    4 +-
 ksrc/drivers/comedi/buffer.c                       |  232 +-
 ksrc/drivers/comedi/command.c                      |   64 +-
 ksrc/drivers/comedi/device.c                       |  117 +-
 ksrc/drivers/comedi/driver.c                       |   39 +-
 ksrc/drivers/comedi/driver_facilities.c            |  112 +-
 ksrc/drivers/comedi/instruction.c                  |   20 +-
 ksrc/drivers/comedi/intel/8255.c                   |  331 ++
 ksrc/drivers/comedi/intel/8255.h                   |   61 +
 ksrc/drivers/comedi/intel/Config.in                |    8 +
 ksrc/drivers/comedi/intel/Kconfig                  |    5 +
 ksrc/drivers/comedi/intel/Makefile                 |   30 +
 ksrc/drivers/comedi/national_instruments/Config.in |    8 +
 ksrc/drivers/comedi/national_instruments/Kconfig   |   20 +
 ksrc/drivers/comedi/national_instruments/Makefile  |   54 +
 .../comedi/national_instruments/mio_common.c       | 5190 
++++++++++++++++++++
 ksrc/drivers/comedi/national_instruments/mite.c    |  810 +++
 ksrc/drivers/comedi/national_instruments/mite.h    |  435 ++
 ksrc/drivers/comedi/national_instruments/ni_mio.h  |  124 +
 ksrc/drivers/comedi/national_instruments/ni_stc.h  | 1420 ++++++
 ksrc/drivers/comedi/national_instruments/ni_tio.h  | 1184 +++++
 ksrc/drivers/comedi/national_instruments/pcimio.c  | 1591 ++++++
 .../comedi/national_instruments/tio_common.c       | 1982 ++++++++
 ksrc/drivers/comedi/rtdm_interface.c               |   29 +-
 ksrc/drivers/comedi/subdevice.c                    |  175 +-
 ksrc/drivers/comedi/testing/fake.c                 |  388 +-
 ksrc/drivers/comedi/testing/loop.c                 |  341 +-
 ksrc/drivers/comedi/transfer.c                     |  164 +-
 src/drvlib/comedi/descriptor.c                     |   19 +-
 40 files changed, 14338 insertions(+), 913 deletions(-)
 create mode 100644 ksrc/drivers/comedi/intel/8255.c
 create mode 100644 ksrc/drivers/comedi/intel/8255.h
 create mode 100644 ksrc/drivers/comedi/intel/Config.in
 create mode 100644 ksrc/drivers/comedi/intel/Kconfig
 create mode 100644 ksrc/drivers/comedi/intel/Makefile
 create mode 100644 ksrc/drivers/comedi/national_instruments/Config.in
 create mode 100644 ksrc/drivers/comedi/national_instruments/Kconfig
 create mode 100644 ksrc/drivers/comedi/national_instruments/Makefile
 create mode 100644 ksrc/drivers/comedi/national_instruments/mio_common.c
 create mode 100644 ksrc/drivers/comedi/national_instruments/mite.c
 create mode 100644 ksrc/drivers/comedi/national_instruments/mite.h
 create mode 100644 ksrc/drivers/comedi/national_instruments/ni_mio.h
 create mode 100644 ksrc/drivers/comedi/national_instruments/ni_stc.h
 create mode 100644 ksrc/drivers/comedi/national_instruments/ni_tio.h
 create mode 100644 ksrc/drivers/comedi/national_instruments/pcimio.c
 create mode 100644 ksrc/drivers/comedi/national_instruments/tio_common.c

Alexis.

