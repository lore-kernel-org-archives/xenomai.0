From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <200910192318.03968.berlemont.hauw@domain.hid>
References: <200910192318.03968.berlemont.hauw@domain.hid>
Content-Type: text/plain
Date: Tue, 20 Oct 2009 15:22:34 +0200
Message-Id: <1256044954.2862.124.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PULL REQUEST] analogy renaming + many bugfixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

On Mon, 2009-10-19 at 23:18 +0200, Alexis Berlemont wrote:
> The following changes since commit 8c847c4bf43fa65c3ec541850ecdb7e96113e94f:
>   Philippe Gerum (1):
>         powerpc: fix commit number for 2.6.30.3-DENX
> 
> are available in the git repository at:
> 
>   ssh+git://git@domain.hid analogy
> 

Please rebase on the current head first, the merge is unclean.

> Alexis Berlemont (18):
>       Remove useless wrappers (comedi_copy_*_user())
>       Initialize the freshly allocated device's private area
>       Fix obvious typo mistake
>       Fix some error checkings in analog output command test function
>       Fix various minor bugs
>       Fix internal trigger via instruction (we do not need any data in the 
> instruction structure)
>       Add ai / ao trigger callback
>       Add a trigger instruction
>       Replace an info message by an error message
>       Fix a problem in the mite configuration (only for AI)
>       Add a missing EXPORT_SYMBOL() comedi_alloc_subd.
>       Align fake macro declarations with real functions declarations
>       Fix modules compilations issues
>       Comedi4RTDM -> Analogy (first part)
>       Comedi4RTDM -> Analogy (second part)
>       Comedi4RTDM -> Analogy (third part, kernel side compiles)
>       Comedi4RTDM -> Analogy (last part, user side compiles and runs)
>       Update *_alloc_subd() after bugfix backport from comedi branch
> 
>  Makefile.in                                        |    1 +
>  aclocal.m4                                         |    4 +-
>  config/Makefile.in                                 |    1 +
>  configure                                          | 5454 
> +++++++-------------
>  configure.in                                       |    6 +-
>  doc/Makefile.in                                    |    1 +
>  doc/docbook/Makefile.in                            |    1 +
>  doc/docbook/custom-stylesheets/Makefile.in         |    1 +
>  doc/docbook/custom-stylesheets/xsl/Makefile.in     |    1 +
>  .../custom-stylesheets/xsl/common/Makefile.in      |    1 +
>  doc/docbook/custom-stylesheets/xsl/fo/Makefile.in  |    1 +
>  .../custom-stylesheets/xsl/html/Makefile.in        |    1 +
>  doc/docbook/xenomai/Makefile.in                    |    1 +
>  doc/doxygen/Makefile.in                            |    1 +
>  doc/man/Makefile.in                                |    1 +
>  doc/txt/Makefile.in                                |    1 +
>  include/Makefile.am                                |    2 +-
>  include/Makefile.in                                |    3 +-
>  include/{comedi => analogy}/Makefile.am            |    6 +-
>  include/{comedi => analogy}/Makefile.in            |   13 +-
>  include/analogy/analogy.h                          |  152 +
>  .../comedi_driver.h => analogy/analogy_driver.h}   |   16 +-
>  include/{comedi => analogy}/buffer.h               |  192 +-
>  include/{comedi => analogy}/channel_range.h        |  162 +-
>  include/{comedi => analogy}/command.h              |   34 +-
>  include/{comedi => analogy}/context.h              |   32 +-
>  include/{comedi => analogy}/descriptor.h           |   28 +-
>  include/{comedi => analogy}/device.h               |   58 +-
>  include/{comedi => analogy}/driver.h               |   34 +-
>  include/analogy/instruction.h                      |  225 +
>  include/{comedi => analogy}/ioctl.h                |   40 +-
>  include/analogy/os_facilities.h                    |  191 +
>  include/analogy/subdevice.h                        |  271 +
>  include/analogy/transfer.h                         |  105 +
>  include/{comedi => analogy}/types.h                |   14 +-
>  include/asm-arm/Makefile.in                        |    1 +
>  include/asm-arm/bits/Makefile.in                   |    1 +
>  include/asm-blackfin/Makefile.in                   |    1 +
>  include/asm-blackfin/bits/Makefile.in              |    1 +
>  include/asm-generic/Makefile.in                    |    1 +
>  include/asm-generic/bits/Makefile.in               |    1 +
>  include/asm-nios2/Makefile.in                      |    1 +
>  include/asm-nios2/bits/Makefile.in                 |    1 +
>  include/asm-powerpc/Makefile.in                    |    1 +
>  include/asm-powerpc/bits/Makefile.in               |    1 +
>  include/asm-sim/Makefile.in                        |    1 +
>  include/asm-sim/bits/Makefile.in                   |    1 +
>  include/asm-x86/Makefile.in                        |    1 +
>  include/asm-x86/bits/Makefile.in                   |    1 +
>  include/comedi/comedi.h                            |  151 -
>  include/comedi/instruction.h                       |  225 -
>  include/comedi/os_facilities.h                     |  211 -
>  include/comedi/subdevice.h                         |  271 -
>  include/comedi/transfer.h                          |  105 -
>  include/native/Makefile.in                         |    1 +
>  include/nucleus/Makefile.in                        |    1 +
>  include/posix/Makefile.in                          |    1 +
>  include/posix/sys/Makefile.in                      |    1 +
>  include/psos+/Makefile.in                          |    1 +
>  include/rtai/Makefile.in                           |    1 +
>  include/rtdm/Makefile.in                           |    1 +
>  include/uitron/Makefile.in                         |    1 +
>  include/vrtx/Makefile.in                           |    1 +
>  include/vxworks/Makefile.in                        |    1 +
>  ksrc/drivers/Config.in                             |    2 +-
>  ksrc/drivers/Kconfig                               |    2 +-
>  ksrc/drivers/Makefile                              |    6 +-
>  ksrc/drivers/analogy/Config.in                     |   16 +
>  ksrc/drivers/analogy/Kconfig                       |   34 +
>  ksrc/drivers/{comedi => analogy}/Makefile          |   28 +-
>  ksrc/drivers/{comedi => analogy}/buffer.c          |  373 +-
>  ksrc/drivers/{comedi => analogy}/command.c         |   99 +-
>  ksrc/drivers/{comedi => analogy}/device.c          |  272 +-
>  ksrc/drivers/{comedi => analogy}/driver.c          |   40 +-
>  .../{comedi => analogy}/driver_facilities.c        |  353 +-
>  ksrc/drivers/{comedi => analogy}/instruction.c     |  157 +-
>  ksrc/drivers/{comedi => analogy}/intel/8255.c      |  116 +-
>  ksrc/drivers/{comedi => analogy}/intel/8255.h      |   27 +-
>  ksrc/drivers/analogy/intel/Config.in               |    8 +
>  ksrc/drivers/analogy/intel/Kconfig                 |    5 +
>  ksrc/drivers/{comedi => analogy}/intel/Makefile    |   14 +-
>  .../drivers/analogy/national_instruments/Config.in |    8 +
>  ksrc/drivers/analogy/national_instruments/Kconfig  |   20 +
>  ksrc/drivers/analogy/national_instruments/Makefile |   54 +
>  .../national_instruments/mio_common.c              | 2014 ++++----
>  .../national_instruments/mite.c                    |  159 +-
>  .../national_instruments/mite.h                    |   19 +-
>  .../national_instruments/ni_mio.h                  |   26 +-
>  .../national_instruments/ni_stc.h                  |   22 +-
>  .../national_instruments/ni_tio.h                  |   32 +-
>  .../national_instruments/pcimio.c                  |   82 +-
>  .../national_instruments/tio_common.c              |  114 +-
>  ksrc/drivers/{comedi => analogy}/os_facilities.c   |   60 +-
>  ksrc/drivers/{comedi => analogy}/proc.h            |   10 +-
>  ksrc/drivers/analogy/rtdm_interface.c              |  323 ++
>  ksrc/drivers/{comedi => analogy}/subdevice.c       |  237 +-
>  ksrc/drivers/{comedi => analogy}/testing/Config.in |    0
>  ksrc/drivers/{comedi => analogy}/testing/Kconfig   |    0
>  ksrc/drivers/{comedi => analogy}/testing/Makefile  |    0
>  ksrc/drivers/{comedi => analogy}/testing/fake.c    |    0
>  ksrc/drivers/{comedi => analogy}/testing/loop.c    |    0
>  ksrc/drivers/{comedi => analogy}/transfer.c        |  232 +-
>  ksrc/drivers/comedi/Config.in                      |   16 -
>  ksrc/drivers/comedi/Kconfig                        |   37 -
>  ksrc/drivers/comedi/intel/Config.in                |    8 -
>  ksrc/drivers/comedi/intel/Kconfig                  |    5 -
>  ksrc/drivers/comedi/national_instruments/Config.in |    8 -
>  ksrc/drivers/comedi/national_instruments/Kconfig   |   20 -
>  ksrc/drivers/comedi/national_instruments/Makefile  |   54 -
>  ksrc/drivers/comedi/rtdm_interface.c               |  322 --
>  scripts/Makefile.in                                |    1 +
>  src/Makefile.in                                    |    1 +
>  src/drvlib/Makefile.am                             |    2 +-
>  src/drvlib/Makefile.in                             |    3 +-
>  src/drvlib/{comedi => analogy}/Makefile.am         |    8 +-
>  src/drvlib/{comedi => analogy}/Makefile.in         |  110 +-
>  src/drvlib/{comedi => analogy}/async.c             |  191 +-
>  src/drvlib/{comedi => analogy}/descriptor.c        |  211 +-
>  src/drvlib/{comedi => analogy}/info.c              |   47 +-
>  src/drvlib/{comedi => analogy}/range.c             |   55 +-
>  src/drvlib/{comedi => analogy}/root_leaf.h         |   27 +-
>  src/drvlib/{comedi => analogy}/sync.c              |  127 +-
>  src/drvlib/{comedi => analogy}/sys.c               |   61 +-
>  src/drvlib/{comedi => analogy}/syscall.h           |    9 +-
>  src/include/Makefile.in                            |    1 +
>  src/include/xeno_config.h.in                       |    3 +
>  src/rtdk/Makefile.in                               |    1 +
>  src/skins/Makefile.in                              |    1 +
>  src/skins/native/Makefile.in                       |    1 +
>  src/skins/posix/Makefile.in                        |    1 +
>  src/skins/psos+/Makefile.in                        |    1 +
>  src/skins/rtai/Makefile.in                         |    1 +
>  src/skins/rtdm/Makefile.in                         |    1 +
>  src/skins/uitron/Makefile.in                       |    1 +
>  src/skins/vrtx/Makefile.in                         |    1 +
>  src/skins/vxworks/Makefile.in                      |    1 +
>  src/testsuite/Makefile.in                          |    1 +
>  src/testsuite/clocktest/Makefile.in                |    1 +
>  src/testsuite/cyclic/Makefile.in                   |    1 +
>  src/testsuite/irqbench/Makefile.in                 |    1 +
>  src/testsuite/klatency/Makefile.in                 |    1 +
>  src/testsuite/latency/Makefile.in                  |    1 +
>  src/testsuite/switchtest/Makefile.in               |    1 +
>  src/testsuite/unit/Makefile.in                     |    1 +
>  src/utils/Makefile.am                              |    2 +-
>  src/utils/Makefile.in                              |    3 +-
>  src/utils/{comedi => analogy}/Makefile.am          |   14 +-
>  src/utils/{comedi => analogy}/Makefile.in          |   43 +-
>  .../comedi_config.c => analogy/analogy_config.c}   |   61 +-
>  src/utils/{comedi => analogy}/cmd_read.c           |  101 +-
>  src/utils/{comedi => analogy}/cmd_write.c          |  153 +-
>  src/utils/{comedi => analogy}/insn_read.c          |   49 +-
>  src/utils/can/Makefile.in                          |    1 +
>  src/utils/ps/Makefile.in                           |    1 +
>  154 files changed, 6733 insertions(+), 8046 deletions(-)
>  rename include/{comedi => analogy}/Makefile.am (74%)
>  rename include/{comedi => analogy}/Makefile.in (98%)
>  create mode 100644 include/analogy/analogy.h
>  rename include/{comedi/comedi_driver.h => analogy/analogy_driver.h} (76%)
>  rename include/{comedi => analogy}/buffer.h (55%)
>  rename include/{comedi => analogy}/channel_range.h (62%)
>  rename include/{comedi => analogy}/command.h (89%)
>  rename include/{comedi => analogy}/context.h (64%)
>  rename include/{comedi => analogy}/descriptor.h (79%)
>  rename include/{comedi => analogy}/device.h (62%)
>  rename include/{comedi => analogy}/driver.h (71%)
>  create mode 100644 include/analogy/instruction.h
>  rename include/{comedi => analogy}/ioctl.h (52%)
>  create mode 100644 include/analogy/os_facilities.h
>  create mode 100644 include/analogy/subdevice.h
>  create mode 100644 include/analogy/transfer.h
>  rename include/{comedi => analogy}/types.h (82%)
>  delete mode 100644 include/comedi/comedi.h
>  delete mode 100644 include/comedi/instruction.h
>  delete mode 100644 include/comedi/os_facilities.h
>  delete mode 100644 include/comedi/subdevice.h
>  delete mode 100644 include/comedi/transfer.h
>  create mode 100644 ksrc/drivers/analogy/Config.in
>  create mode 100644 ksrc/drivers/analogy/Kconfig
>  rename ksrc/drivers/{comedi => analogy}/Makefile (51%)
>  rename ksrc/drivers/{comedi => analogy}/buffer.c (62%)
>  rename ksrc/drivers/{comedi => analogy}/command.c (70%)
>  rename ksrc/drivers/{comedi => analogy}/device.c (50%)
>  rename ksrc/drivers/{comedi => analogy}/driver.c (73%)
>  rename ksrc/drivers/{comedi => analogy}/driver_facilities.c (58%)
>  rename ksrc/drivers/{comedi => analogy}/instruction.c (60%)
>  rename ksrc/drivers/{comedi => analogy}/intel/8255.c (70%)
>  rename ksrc/drivers/{comedi => analogy}/intel/8255.h (67%)
>  create mode 100644 ksrc/drivers/analogy/intel/Config.in
>  create mode 100644 ksrc/drivers/analogy/intel/Kconfig
>  rename ksrc/drivers/{comedi => analogy}/intel/Makefile (52%)
>  create mode 100644 ksrc/drivers/analogy/national_instruments/Config.in
>  create mode 100644 ksrc/drivers/analogy/national_instruments/Kconfig
>  create mode 100644 ksrc/drivers/analogy/national_instruments/Makefile
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/mio_common.c 
> (71%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/mite.c (85%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/mite.h (96%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/ni_mio.h (86%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/ni_stc.h (98%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/ni_tio.h (97%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/pcimio.c (94%)
>  rename ksrc/drivers/{comedi => analogy}/national_instruments/tio_common.c 
> (95%)
>  rename ksrc/drivers/{comedi => analogy}/os_facilities.c (75%)
>  rename ksrc/drivers/{comedi => analogy}/proc.h (84%)
>  create mode 100644 ksrc/drivers/analogy/rtdm_interface.c
>  rename ksrc/drivers/{comedi => analogy}/subdevice.c (53%)
>  rename ksrc/drivers/{comedi => analogy}/testing/Config.in (100%)
>  rename ksrc/drivers/{comedi => analogy}/testing/Kconfig (100%)
>  rename ksrc/drivers/{comedi => analogy}/testing/Makefile (100%)
>  rename ksrc/drivers/{comedi => analogy}/testing/fake.c (100%)
>  rename ksrc/drivers/{comedi => analogy}/testing/loop.c (100%)
>  rename ksrc/drivers/{comedi => analogy}/transfer.c (59%)
>  delete mode 100644 ksrc/drivers/comedi/Config.in
>  delete mode 100644 ksrc/drivers/comedi/Kconfig
>  delete mode 100644 ksrc/drivers/comedi/intel/Config.in
>  delete mode 100644 ksrc/drivers/comedi/intel/Kconfig
>  delete mode 100644 ksrc/drivers/comedi/national_instruments/Config.in
>  delete mode 100644 ksrc/drivers/comedi/national_instruments/Kconfig
>  delete mode 100644 ksrc/drivers/comedi/national_instruments/Makefile
>  delete mode 100644 ksrc/drivers/comedi/rtdm_interface.c
>  rename src/drvlib/{comedi => analogy}/Makefile.am (50%)
>  rename src/drvlib/{comedi => analogy}/Makefile.in (79%)
>  rename src/drvlib/{comedi => analogy}/async.c (55%)
>  rename src/drvlib/{comedi => analogy}/descriptor.c (57%)
>  rename src/drvlib/{comedi => analogy}/info.c (52%)
>  rename src/drvlib/{comedi => analogy}/range.c (80%)
>  rename src/drvlib/{comedi => analogy}/root_leaf.h (73%)
>  rename src/drvlib/{comedi => analogy}/sync.c (63%)
>  rename src/drvlib/{comedi => analogy}/sys.c (61%)
>  rename src/drvlib/{comedi => analogy}/syscall.h (90%)
>  rename src/utils/{comedi => analogy}/Makefile.am (51%)
>  rename src/utils/{comedi => analogy}/Makefile.in (95%)
>  rename src/utils/{comedi/comedi_config.c => analogy/analogy_config.c} (76%)
>  rename src/utils/{comedi => analogy}/cmd_read.c (80%)
>  rename src/utils/{comedi => analogy}/cmd_write.c (74%)
>  rename src/utils/{comedi => analogy}/insn_read.c (86%)
> 
> Alexis.
> 
> _______________________________________________
> Xenomai-core mailing list
> Xenomai-core@domain.hid
> https://mail.gna.org/listinfo/xenomai-core
-- 
Philippe.



