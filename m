References: <27482c83-6428-30df-52a6-b2fa9c61c98b@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: [PATCH] Remove analogy support
In-reply-to: <27482c83-6428-30df-52a6-b2fa9c61c98b@siemens.com>
Date: Tue, 13 Jul 2021 14:52:21 +0200
Message-ID: <87r1g274vu.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org


Jan Kiszka via Xenomai <xenomai@xenomai.org> writes:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> This has been unmaintained for a long while, and its removal came up
> several times already. Now is a good point as we are approaching a new
> major release.
>

Full ack.

> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  .gitlab-ci.yml                                |    6 -
>  configure.ac                                  |    3 -
>  debian/libxenomai1.lintian                    |    2 +-
>  doc/asciidoc/MIGRATION.adoc                   |   32 -
>  doc/doxygen/xeno3prm-common.conf.in           |    1 -
>  include/cobalt/kernel/rtdm/Makefile.am        |    2 -
>  .../cobalt/kernel/rtdm/analogy/Makefile.am    |   12 -
>  include/cobalt/kernel/rtdm/analogy/buffer.h   |  461 --
>  .../kernel/rtdm/analogy/channel_range.h       |  272 -
>  include/cobalt/kernel/rtdm/analogy/command.h  |   35 -
>  include/cobalt/kernel/rtdm/analogy/context.h  |   48 -
>  include/cobalt/kernel/rtdm/analogy/device.h   |   67 -
>  include/cobalt/kernel/rtdm/analogy/driver.h   |   74 -
>  .../cobalt/kernel/rtdm/analogy/instruction.h  |   45 -
>  .../cobalt/kernel/rtdm/analogy/rtdm_helpers.h |  143 -
>  .../cobalt/kernel/rtdm/analogy/subdevice.h    |  118 -
>  include/cobalt/kernel/rtdm/analogy/transfer.h |   78 -
>  include/rtdm/Makefile.am                      |    1 -
>  include/rtdm/analogy.h                        |  264 -
>  include/rtdm/uapi/Makefile.am                 |    1 -
>  include/rtdm/uapi/analogy.h                   |  743 ---
>  kernel/drivers/Kconfig                        |    1 -
>  kernel/drivers/Makefile                       |    2 +-
>  kernel/drivers/analogy/Kconfig                |   56 -
>  kernel/drivers/analogy/Makefile               |   16 -
>  kernel/drivers/analogy/buffer.c               | 1145 ----
>  kernel/drivers/analogy/command.c              |  392 --
>  kernel/drivers/analogy/device.c               |  458 --
>  kernel/drivers/analogy/driver.c               |  104 -
>  kernel/drivers/analogy/driver_facilities.c    |  608 --
>  kernel/drivers/analogy/instruction.c          |  427 --
>  kernel/drivers/analogy/intel/8255.c           |  331 -
>  kernel/drivers/analogy/intel/8255.h           |   60 -
>  kernel/drivers/analogy/intel/Kconfig          |   10 -
>  kernel/drivers/analogy/intel/Makefile         |   10 -
>  kernel/drivers/analogy/intel/parport.c        |  457 --
>  .../analogy/national_instruments/Kconfig      |   42 -
>  .../analogy/national_instruments/Makefile     |   16 -
>  .../analogy/national_instruments/mio_common.c | 5590 -----------------
>  .../analogy/national_instruments/mite.c       |  839 ---
>  .../analogy/national_instruments/mite.h       |  435 --
>  .../analogy/national_instruments/ni_660x.c    | 1481 -----
>  .../analogy/national_instruments/ni_670x.c    |  443 --
>  .../analogy/national_instruments/ni_mio.h     |  122 -
>  .../analogy/national_instruments/ni_stc.h     | 1417 -----
>  .../analogy/national_instruments/ni_tio.h     | 1192 ----
>  .../analogy/national_instruments/pcimio.c     | 1603 -----
>  .../analogy/national_instruments/tio_common.c | 1999 ------
>  kernel/drivers/analogy/proc.h                 |   33 -
>  kernel/drivers/analogy/rtdm_helpers.c         |  214 -
>  kernel/drivers/analogy/rtdm_interface.c       |  308 -
>  kernel/drivers/analogy/sensoray/Kconfig       |    5 -
>  kernel/drivers/analogy/sensoray/Makefile      |    6 -
>  kernel/drivers/analogy/sensoray/s526.c        |  756 ---
>  kernel/drivers/analogy/subdevice.c            |  449 --
>  kernel/drivers/analogy/testing/Kconfig        |   13 -
>  kernel/drivers/analogy/testing/Makefile       |    8 -
>  kernel/drivers/analogy/testing/fake.c         |  686 --
>  kernel/drivers/analogy/testing/loop.c         |  285 -
>  kernel/drivers/analogy/transfer.c             |  259 -
>  lib/Makefile.am                               |    2 -
>  lib/analogy/COPYING                           |  458 --
>  lib/analogy/Makefile.am                       |   23 -
>  lib/analogy/async.c                           |  471 --
>  lib/analogy/calibration.c                     |  473 --
>  lib/analogy/calibration.h                     |   68 -
>  lib/analogy/descriptor.c                      |  503 --
>  lib/analogy/info.c                            |   84 -
>  lib/analogy/internal.h                        |   58 -
>  lib/analogy/math.c                            |  457 --
>  lib/analogy/range.c                           |  638 --
>  lib/analogy/root_leaf.h                       |   54 -
>  lib/analogy/sync.c                            |  426 --
>  lib/analogy/sys.c                             |  213 -
>  utils/Makefile.am                             |    2 +-
>  utils/analogy/Makefile.am                     |  100 -
>  utils/analogy/analogy_calibrate.c             |  124 -
>  utils/analogy/analogy_calibrate.h             |  150 -
>  utils/analogy/analogy_config.c                |  305 -
>  utils/analogy/calibration_ni_m.c              | 1282 ----
>  utils/analogy/calibration_ni_m.h              |  260 -
>  utils/analogy/cmd_bits.c                      |  279 -
>  utils/analogy/cmd_read.c                      |  435 --
>  utils/analogy/cmd_write.c                     |  551 --
>  utils/analogy/insn_bits.c                     |  227 -
>  utils/analogy/insn_read.c                     |  462 --
>  utils/analogy/insn_write.c                    |  279 -
>  utils/analogy/wf_facilities.c                 |  177 -
>  utils/analogy/wf_facilities.h                 |   56 -
>  utils/analogy/wf_generate.c                   |  251 -
>  90 files changed, 3 insertions(+), 33551 deletions(-)
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/Makefile.am
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/buffer.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/channel_range.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/command.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/context.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/device.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/driver.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/instruction.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/subdevice.h
>  delete mode 100644 include/cobalt/kernel/rtdm/analogy/transfer.h
>  delete mode 100644 include/rtdm/analogy.h
>  delete mode 100644 include/rtdm/uapi/analogy.h
>  delete mode 100644 kernel/drivers/analogy/Kconfig
>  delete mode 100644 kernel/drivers/analogy/Makefile
>  delete mode 100644 kernel/drivers/analogy/buffer.c
>  delete mode 100644 kernel/drivers/analogy/command.c
>  delete mode 100644 kernel/drivers/analogy/device.c
>  delete mode 100644 kernel/drivers/analogy/driver.c
>  delete mode 100644 kernel/drivers/analogy/driver_facilities.c
>  delete mode 100644 kernel/drivers/analogy/instruction.c
>  delete mode 100644 kernel/drivers/analogy/intel/8255.c
>  delete mode 100644 kernel/drivers/analogy/intel/8255.h
>  delete mode 100644 kernel/drivers/analogy/intel/Kconfig
>  delete mode 100644 kernel/drivers/analogy/intel/Makefile
>  delete mode 100644 kernel/drivers/analogy/intel/parport.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/Kconfig
>  delete mode 100644 kernel/drivers/analogy/national_instruments/Makefile
>  delete mode 100644 kernel/drivers/analogy/national_instruments/mio_common.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/mite.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/mite.h
>  delete mode 100644 kernel/drivers/analogy/national_instruments/ni_660x.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/ni_670x.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/ni_mio.h
>  delete mode 100644 kernel/drivers/analogy/national_instruments/ni_stc.h
>  delete mode 100644 kernel/drivers/analogy/national_instruments/ni_tio.h
>  delete mode 100644 kernel/drivers/analogy/national_instruments/pcimio.c
>  delete mode 100644 kernel/drivers/analogy/national_instruments/tio_common.c
>  delete mode 100644 kernel/drivers/analogy/proc.h
>  delete mode 100644 kernel/drivers/analogy/rtdm_helpers.c
>  delete mode 100644 kernel/drivers/analogy/rtdm_interface.c
>  delete mode 100644 kernel/drivers/analogy/sensoray/Kconfig
>  delete mode 100644 kernel/drivers/analogy/sensoray/Makefile
>  delete mode 100644 kernel/drivers/analogy/sensoray/s526.c
>  delete mode 100644 kernel/drivers/analogy/subdevice.c
>  delete mode 100644 kernel/drivers/analogy/testing/Kconfig
>  delete mode 100644 kernel/drivers/analogy/testing/Makefile
>  delete mode 100644 kernel/drivers/analogy/testing/fake.c
>  delete mode 100644 kernel/drivers/analogy/testing/loop.c
>  delete mode 100644 kernel/drivers/analogy/transfer.c
>  delete mode 100644 lib/analogy/COPYING
>  delete mode 100644 lib/analogy/Makefile.am
>  delete mode 100644 lib/analogy/async.c
>  delete mode 100644 lib/analogy/calibration.c
>  delete mode 100644 lib/analogy/calibration.h
>  delete mode 100644 lib/analogy/descriptor.c
>  delete mode 100644 lib/analogy/info.c
>  delete mode 100644 lib/analogy/internal.h
>  delete mode 100644 lib/analogy/math.c
>  delete mode 100644 lib/analogy/range.c
>  delete mode 100644 lib/analogy/root_leaf.h
>  delete mode 100644 lib/analogy/sync.c
>  delete mode 100644 lib/analogy/sys.c
>  delete mode 100644 utils/analogy/Makefile.am
>  delete mode 100644 utils/analogy/analogy_calibrate.c
>  delete mode 100644 utils/analogy/analogy_calibrate.h
>  delete mode 100644 utils/analogy/analogy_config.c
>  delete mode 100644 utils/analogy/calibration_ni_m.c
>  delete mode 100644 utils/analogy/calibration_ni_m.h
>  delete mode 100644 utils/analogy/cmd_bits.c
>  delete mode 100644 utils/analogy/cmd_read.c
>  delete mode 100644 utils/analogy/cmd_write.c
>  delete mode 100644 utils/analogy/insn_bits.c
>  delete mode 100644 utils/analogy/insn_read.c
>  delete mode 100644 utils/analogy/insn_write.c
>  delete mode 100644 utils/analogy/wf_facilities.c
>  delete mode 100644 utils/analogy/wf_facilities.h
>  delete mode 100644 utils/analogy/wf_generate.c
>
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 7644861104..4acb59afc3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -136,12 +136,6 @@ variables:
>      - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
>      - ./scripts/config -m XENO_DRIVERS_NET_ADDON_PROXY
>      - ./scripts/config -e XENO_DRIVERS_NET_ADDON_PROXY_ARP
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY_DEBUG_FTRACE
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY_FAKE
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY_NI_PCIMIO
> -    - ./scripts/config -e XENO_DRIVERS_ANALOGY_S526
>      - ./scripts/config -e XENO_DRIVERS_RTIPC
>      - ./scripts/config -e XENO_DRIVERS_UDD
>      - ./scripts/config -e XENO_DRIVERS_GPIO
> diff --git a/configure.ac b/configure.ac
> index bd5fd5ba9a..179afc5cca 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -949,7 +949,6 @@ AC_CONFIG_FILES([ \
>  	lib/alchemy/Makefile \
>  	lib/vxworks/Makefile \
>  	lib/psos/Makefile \
> -	lib/analogy/Makefile \
>  	lib/smokey/Makefile \
>  	lib/trank/Makefile \
>  	testsuite/Makefile \
> @@ -996,7 +995,6 @@ AC_CONFIG_FILES([ \
>  	utils/Makefile \
>  	utils/hdb/Makefile \
>  	utils/can/Makefile \
> -	utils/analogy/Makefile \
>  	utils/ps/Makefile \
>  	utils/slackspot/Makefile \
>  	utils/corectl/Makefile \
> @@ -1018,7 +1016,6 @@ AC_CONFIG_FILES([ \
>  	include/cobalt/sys/Makefile \
>  	include/cobalt/kernel/Makefile \
>  	include/cobalt/kernel/rtdm/Makefile \
> -	include/cobalt/kernel/rtdm/analogy/Makefile \
>  	include/cobalt/boilerplate/Makefile \
>  	include/rtdm/Makefile \
>  	include/rtdm/uapi/Makefile \
> diff --git a/debian/libxenomai1.lintian b/debian/libxenomai1.lintian
> index 951aa93980..00af08cbcc 100644
> --- a/debian/libxenomai1.lintian
> +++ b/debian/libxenomai1.lintian
> @@ -4,4 +4,4 @@
>  # downgrading the number in the package name is probably a bad idea, and
>  # synchronizing the package name with the SO version number isn't easily
>  # possible anyway since the package contains several libraries.
> -libxenomai1: package-name-doesnt-match-sonames libanalogy1 libnative3 libpthread-rt1 librtdk0 librtdm1 libxenomai0
> +libxenomai1: package-name-doesnt-match-sonames libnative3 libpthread-rt1 librtdk0 librtdm1 libxenomai0
> diff --git a/doc/asciidoc/MIGRATION.adoc b/doc/asciidoc/MIGRATION.adoc
> index dce7f40e9c..b32d8d27c7 100644
> --- a/doc/asciidoc/MIGRATION.adoc
> +++ b/doc/asciidoc/MIGRATION.adoc
> @@ -1025,38 +1025,6 @@ straightforward naming for the RTDM-to-RTDM API, keeping the +rtdm_+
>  prefix.
>  ******************************************************************
>  
> -== Analogy interface changes ==
> -
> -=== Files renamed ===
> -
> -- DAQ drivers in kernel space now pull all Analogy core header files
> -  from <rtdm/analogy/*.h>. In addition:
> -
> -[normal]
> -analogy/analogy_driver.h -> rtdm/analogy/driver.h
> -[normal]
> -analogy/driver.h -> rtdm/analogy/driver.h
> -[normal]
> -analogy/analogy.h -> rtdm/analogy.h
> -
> -- DAQ drivers in kernel space should include <rtdm/analogy/device.h>
> -  instead of <rtdm/analogy/driver.h>.
> -
> -- Applications need to include only a single file for pulling all
> -  routine declarations and constant definitions required for invoking
> -  the Analogy services from user-space, namely <rtdm/analogy.h>, i.e.
> -
> -[normal]
> -analogy/types.h
> -analogy/command.h
> -analogy/device.h
> -analogy/subdevice.h
> -analogy/instruction.h
> -analogy/ioctl.h -> all files merged into rtdm/analogy.h
> -
> -As a consequence of these changes, the former include/analogy/ file
> -tree has been entirely removed.
> -
>  == RTnet changes ==
>  
>  RTnet is integrated into Xenomai 3, but some of its behaviour and
> diff --git a/doc/doxygen/xeno3prm-common.conf.in b/doc/doxygen/xeno3prm-common.conf.in
> index cd77650533..774d948966 100644
> --- a/doc/doxygen/xeno3prm-common.conf.in
> +++ b/doc/doxygen/xeno3prm-common.conf.in
> @@ -855,7 +855,6 @@ INPUT                  =						\
>   		       @top_srcdir@/lib/cobalt				\
>   		       @top_srcdir@/lib/copperplate			\
>   		       @top_srcdir@/lib/smokey				\
> - 		       @top_srcdir@/lib/analogy				\
>   		       @top_srcdir@/lib/alchemy				\
>   		       @top_srcdir@/lib/vxworks				\
>   		       @top_srcdir@/lib/psos				\
> diff --git a/include/cobalt/kernel/rtdm/Makefile.am b/include/cobalt/kernel/rtdm/Makefile.am
> index fe2e4d5c99..adf8124e00 100644
> --- a/include/cobalt/kernel/rtdm/Makefile.am
> +++ b/include/cobalt/kernel/rtdm/Makefile.am
> @@ -13,5 +13,3 @@ noinst_HEADERS =	\
>  	serial.h	\
>  	testing.h	\
>  	udd.h
> -
> -SUBDIRS = analogy
> diff --git a/include/cobalt/kernel/rtdm/analogy/Makefile.am b/include/cobalt/kernel/rtdm/analogy/Makefile.am
> deleted file mode 100644
> index 9b2b34f013..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/buffer.h b/include/cobalt/kernel/rtdm/analogy/buffer.h
> deleted file mode 100644
> index e1a0cc9762..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/channel_range.h b/include/cobalt/kernel/rtdm/analogy/channel_range.h
> deleted file mode 100644
> index 2a16e30ea9..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/command.h b/include/cobalt/kernel/rtdm/analogy/command.h
> deleted file mode 100644
> index 89f7cca521..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/context.h b/include/cobalt/kernel/rtdm/analogy/context.h
> deleted file mode 100644
> index f619f9c885..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/device.h b/include/cobalt/kernel/rtdm/analogy/device.h
> deleted file mode 100644
> index 93ecf660af..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/driver.h b/include/cobalt/kernel/rtdm/analogy/driver.h
> deleted file mode 100644
> index 08a75464ab..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/instruction.h b/include/cobalt/kernel/rtdm/analogy/instruction.h
> deleted file mode 100644
> index 2e8245afbf..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h b/include/cobalt/kernel/rtdm/analogy/rtdm_helpers.h
> deleted file mode 100644
> index 1de219f967..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/subdevice.h b/include/cobalt/kernel/rtdm/analogy/subdevice.h
> deleted file mode 100644
> index 21c09dfb92..0000000000
> diff --git a/include/cobalt/kernel/rtdm/analogy/transfer.h b/include/cobalt/kernel/rtdm/analogy/transfer.h
> deleted file mode 100644
> index c62c22a195..0000000000
> diff --git a/include/rtdm/Makefile.am b/include/rtdm/Makefile.am
> index 989c46fd33..d86c7d5461 100644
> --- a/include/rtdm/Makefile.am
> +++ b/include/rtdm/Makefile.am
> @@ -4,7 +4,6 @@ includesub_HEADERS = rtdm.h
>  
>  if XENO_COBALT
>  includesub_HEADERS +=	\
> -	analogy.h	\
>  	autotune.h	\
>  	can.h		\
>  	gpio.h		\
> diff --git a/include/rtdm/analogy.h b/include/rtdm/analogy.h
> deleted file mode 100644
> index 066d05af57..0000000000
> diff --git a/include/rtdm/uapi/Makefile.am b/include/rtdm/uapi/Makefile.am
> index 726eb1c598..33d978292a 100644
> --- a/include/rtdm/uapi/Makefile.am
> +++ b/include/rtdm/uapi/Makefile.am
> @@ -4,7 +4,6 @@ includesub_HEADERS = rtdm.h
>  
>  if XENO_COBALT
>  includesub_HEADERS +=	\
> -	analogy.h	\
>  	autotune.h	\
>  	can.h		\
>  	gpio.h		\
> diff --git a/include/rtdm/uapi/analogy.h b/include/rtdm/uapi/analogy.h
> deleted file mode 100644
> index 2d53168017..0000000000
> diff --git a/kernel/drivers/Kconfig b/kernel/drivers/Kconfig
> index 197a48eef6..68571095db 100644
> --- a/kernel/drivers/Kconfig
> +++ b/kernel/drivers/Kconfig
> @@ -25,7 +25,6 @@ source "drivers/xenomai/serial/Kconfig"
>  source "drivers/xenomai/testing/Kconfig"
>  source "drivers/xenomai/can/Kconfig"
>  source "drivers/xenomai/net/Kconfig"
> -source "drivers/xenomai/analogy/Kconfig"
>  source "drivers/xenomai/ipc/Kconfig"
>  source "drivers/xenomai/udd/Kconfig"
>  source "drivers/xenomai/gpio/Kconfig"
> diff --git a/kernel/drivers/Makefile b/kernel/drivers/Makefile
> index b8fe1b3f6a..21d5400182 100644
> --- a/kernel/drivers/Makefile
> +++ b/kernel/drivers/Makefile
> @@ -1 +1 @@
> -obj-$(CONFIG_XENOMAI) += autotune/ serial/ testing/ can/ net/ analogy/ ipc/ udd/ gpio/ gpiopwm/ spi/
> +obj-$(CONFIG_XENOMAI) += autotune/ serial/ testing/ can/ net/ ipc/ udd/ gpio/ gpiopwm/ spi/
> diff --git a/kernel/drivers/analogy/Kconfig b/kernel/drivers/analogy/Kconfig
> deleted file mode 100644
> index 858762bda1..0000000000
> diff --git a/kernel/drivers/analogy/Makefile b/kernel/drivers/analogy/Makefile
> deleted file mode 100644
> index 8dcb7e7bbc..0000000000
> diff --git a/kernel/drivers/analogy/buffer.c b/kernel/drivers/analogy/buffer.c
> deleted file mode 100644
> index df228943ff..0000000000
> diff --git a/kernel/drivers/analogy/command.c b/kernel/drivers/analogy/command.c
> deleted file mode 100644
> index 7420bc51ed..0000000000
> diff --git a/kernel/drivers/analogy/device.c b/kernel/drivers/analogy/device.c
> deleted file mode 100644
> index 5033c5d663..0000000000
> diff --git a/kernel/drivers/analogy/driver.c b/kernel/drivers/analogy/driver.c
> deleted file mode 100644
> index a857dea92d..0000000000
> diff --git a/kernel/drivers/analogy/driver_facilities.c b/kernel/drivers/analogy/driver_facilities.c
> deleted file mode 100644
> index 7d2d8832d0..0000000000
> diff --git a/kernel/drivers/analogy/instruction.c b/kernel/drivers/analogy/instruction.c
> deleted file mode 100644
> index 1cbdb14ad4..0000000000
> diff --git a/kernel/drivers/analogy/intel/8255.c b/kernel/drivers/analogy/intel/8255.c
> deleted file mode 100644
> index 1abe250e0c..0000000000
> diff --git a/kernel/drivers/analogy/intel/8255.h b/kernel/drivers/analogy/intel/8255.h
> deleted file mode 100644
> index 31b1ed8939..0000000000
> diff --git a/kernel/drivers/analogy/intel/Kconfig b/kernel/drivers/analogy/intel/Kconfig
> deleted file mode 100644
> index 6907c837c2..0000000000
> diff --git a/kernel/drivers/analogy/intel/Makefile b/kernel/drivers/analogy/intel/Makefile
> deleted file mode 100644
> index 94beedc9bd..0000000000
> diff --git a/kernel/drivers/analogy/intel/parport.c b/kernel/drivers/analogy/intel/parport.c
> deleted file mode 100644
> index eb0743486e..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/Kconfig b/kernel/drivers/analogy/national_instruments/Kconfig
> deleted file mode 100644
> index bd1687a9d9..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/Makefile b/kernel/drivers/analogy/national_instruments/Makefile
> deleted file mode 100644
> index b4c93d2332..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/mio_common.c b/kernel/drivers/analogy/national_instruments/mio_common.c
> deleted file mode 100644
> index 6c5bba0568..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/mite.c b/kernel/drivers/analogy/national_instruments/mite.c
> deleted file mode 100644
> index be4b268c11..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/mite.h b/kernel/drivers/analogy/national_instruments/mite.h
> deleted file mode 100644
> index 93eff4dec4..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/ni_660x.c b/kernel/drivers/analogy/national_instruments/ni_660x.c
> deleted file mode 100644
> index 40a4b2678d..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/ni_670x.c b/kernel/drivers/analogy/national_instruments/ni_670x.c
> deleted file mode 100644
> index 35749be698..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/ni_mio.h b/kernel/drivers/analogy/national_instruments/ni_mio.h
> deleted file mode 100644
> index 7fee167f98..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/ni_stc.h b/kernel/drivers/analogy/national_instruments/ni_stc.h
> deleted file mode 100644
> index d600a3204c..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/ni_tio.h b/kernel/drivers/analogy/national_instruments/ni_tio.h
> deleted file mode 100644
> index deef6529c1..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/pcimio.c b/kernel/drivers/analogy/national_instruments/pcimio.c
> deleted file mode 100644
> index 8a3cccc813..0000000000
> diff --git a/kernel/drivers/analogy/national_instruments/tio_common.c b/kernel/drivers/analogy/national_instruments/tio_common.c
> deleted file mode 100644
> index bcce728eb5..0000000000
> diff --git a/kernel/drivers/analogy/proc.h b/kernel/drivers/analogy/proc.h
> deleted file mode 100644
> index a10e07a8d8..0000000000
> diff --git a/kernel/drivers/analogy/rtdm_helpers.c b/kernel/drivers/analogy/rtdm_helpers.c
> deleted file mode 100644
> index 6755941523..0000000000
> diff --git a/kernel/drivers/analogy/rtdm_interface.c b/kernel/drivers/analogy/rtdm_interface.c
> deleted file mode 100644
> index 765c176c0b..0000000000
> diff --git a/kernel/drivers/analogy/sensoray/Kconfig b/kernel/drivers/analogy/sensoray/Kconfig
> deleted file mode 100644
> index ce5aa51659..0000000000
> diff --git a/kernel/drivers/analogy/sensoray/Makefile b/kernel/drivers/analogy/sensoray/Makefile
> deleted file mode 100644
> index 51bad4ddd5..0000000000
> diff --git a/kernel/drivers/analogy/sensoray/s526.c b/kernel/drivers/analogy/sensoray/s526.c
> deleted file mode 100644
> index 8ecda7e911..0000000000
> diff --git a/kernel/drivers/analogy/subdevice.c b/kernel/drivers/analogy/subdevice.c
> deleted file mode 100644
> index a6c97804dc..0000000000
> diff --git a/kernel/drivers/analogy/testing/Kconfig b/kernel/drivers/analogy/testing/Kconfig
> deleted file mode 100644
> index 15db78289d..0000000000
> diff --git a/kernel/drivers/analogy/testing/Makefile b/kernel/drivers/analogy/testing/Makefile
> deleted file mode 100644
> index e92e5bc906..0000000000
> diff --git a/kernel/drivers/analogy/testing/fake.c b/kernel/drivers/analogy/testing/fake.c
> deleted file mode 100644
> index c80c1cc183..0000000000
> diff --git a/kernel/drivers/analogy/testing/loop.c b/kernel/drivers/analogy/testing/loop.c
> deleted file mode 100644
> index aaef81dee7..0000000000
> diff --git a/kernel/drivers/analogy/transfer.c b/kernel/drivers/analogy/transfer.c
> deleted file mode 100644
> index bf19c8c199..0000000000
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index e909030564..f71e9284a5 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -15,13 +15,11 @@ SUBDIRS +=		\
>  
>  if XENO_COBALT
>  SUBDIRS += 		\
> -	analogy		\
>  	trank
>  endif
>  
>  DIST_SUBDIRS = 		\
>  	alchemy		\
> -	analogy		\
>  	boilerplate	\
>  	cobalt		\
>  	copperplate	\
> diff --git a/lib/analogy/COPYING b/lib/analogy/COPYING
> deleted file mode 100644
> index 3b204400cf..0000000000
> diff --git a/lib/analogy/Makefile.am b/lib/analogy/Makefile.am
> deleted file mode 100644
> index 4c6f0de013..0000000000
> diff --git a/lib/analogy/async.c b/lib/analogy/async.c
> deleted file mode 100644
> index 39d2109ab4..0000000000
> diff --git a/lib/analogy/calibration.c b/lib/analogy/calibration.c
> deleted file mode 100644
> index b50cb2f9cf..0000000000
> diff --git a/lib/analogy/calibration.h b/lib/analogy/calibration.h
> deleted file mode 100644
> index 5d881b51c6..0000000000
> diff --git a/lib/analogy/descriptor.c b/lib/analogy/descriptor.c
> deleted file mode 100644
> index bc4d7bd258..0000000000
> diff --git a/lib/analogy/info.c b/lib/analogy/info.c
> deleted file mode 100644
> index a68e4a33f8..0000000000
> diff --git a/lib/analogy/internal.h b/lib/analogy/internal.h
> deleted file mode 100644
> index da8b6585bf..0000000000
> diff --git a/lib/analogy/math.c b/lib/analogy/math.c
> deleted file mode 100644
> index 2e6e47555e..0000000000
> diff --git a/lib/analogy/range.c b/lib/analogy/range.c
> deleted file mode 100644
> index d9f7a4872b..0000000000
> diff --git a/lib/analogy/root_leaf.h b/lib/analogy/root_leaf.h
> deleted file mode 100644
> index 6c58001855..0000000000
> diff --git a/lib/analogy/sync.c b/lib/analogy/sync.c
> deleted file mode 100644
> index fee5fc9e20..0000000000
> diff --git a/lib/analogy/sys.c b/lib/analogy/sys.c
> deleted file mode 100644
> index 165c41d790..0000000000
> diff --git a/utils/Makefile.am b/utils/Makefile.am
> index 81dbfda7c9..2786952a17 100644
> --- a/utils/Makefile.am
> +++ b/utils/Makefile.am
> @@ -1,4 +1,4 @@
>  SUBDIRS = hdb
>  if XENO_COBALT
> -SUBDIRS += analogy autotune can net ps slackspot corectl
> +SUBDIRS += autotune can net ps slackspot corectl
>  endif
> diff --git a/utils/analogy/Makefile.am b/utils/analogy/Makefile.am
> deleted file mode 100644
> index f8a304b601..0000000000
> diff --git a/utils/analogy/analogy_calibrate.c b/utils/analogy/analogy_calibrate.c
> deleted file mode 100644
> index c5990a7b9f..0000000000
> diff --git a/utils/analogy/analogy_calibrate.h b/utils/analogy/analogy_calibrate.h
> deleted file mode 100644
> index aeb6355d09..0000000000
> diff --git a/utils/analogy/analogy_config.c b/utils/analogy/analogy_config.c
> deleted file mode 100644
> index 96bc66ad08..0000000000
> diff --git a/utils/analogy/calibration_ni_m.c b/utils/analogy/calibration_ni_m.c
> deleted file mode 100644
> index 6f9be6fc98..0000000000
> diff --git a/utils/analogy/calibration_ni_m.h b/utils/analogy/calibration_ni_m.h
> deleted file mode 100644
> index 6612d21797..0000000000
> diff --git a/utils/analogy/cmd_bits.c b/utils/analogy/cmd_bits.c
> deleted file mode 100644
> index 17dc496107..0000000000
> diff --git a/utils/analogy/cmd_read.c b/utils/analogy/cmd_read.c
> deleted file mode 100644
> index 86522f4057..0000000000
> diff --git a/utils/analogy/cmd_write.c b/utils/analogy/cmd_write.c
> deleted file mode 100644
> index 7b8870f2b1..0000000000
> diff --git a/utils/analogy/insn_bits.c b/utils/analogy/insn_bits.c
> deleted file mode 100644
> index f3ff8001f6..0000000000
> diff --git a/utils/analogy/insn_read.c b/utils/analogy/insn_read.c
> deleted file mode 100644
> index 8aa0740ed5..0000000000
> diff --git a/utils/analogy/insn_write.c b/utils/analogy/insn_write.c
> deleted file mode 100644
> index b2bbf6668e..0000000000
> diff --git a/utils/analogy/wf_facilities.c b/utils/analogy/wf_facilities.c
> deleted file mode 100644
> index 2281bcf1e6..0000000000
> diff --git a/utils/analogy/wf_facilities.h b/utils/analogy/wf_facilities.h
> deleted file mode 100644
> index f3df82f12d..0000000000
> diff --git a/utils/analogy/wf_generate.c b/utils/analogy/wf_generate.c
> deleted file mode 100644
> index e9373097d6..0000000000


-- 
Philippe.

