From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] Xenomai 3.1.1 released
Message-ID: <9b20f6a7-8f35-531a-989b-bd71874d81f3@siemens.com>
Date: Tue, 1 Jun 2021 08:04:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Changes since 3.1:

Fino Meng (3):
      scripts/prepare-kernel.sh: add $(srctree) to the include path of ccflags
      cobalt/kernel: adapt adjtime syscall with upstream kernel
      cobalt/kernel: fix compile error for incompatible pointer type

Florian Bezdeka (3):
      lib/boilerplate/iniparser: Allow building with GCC 10.2 2020101
      lib/cobalt: Rename cobalt_check_features to cobalt_arch_check_features
      lib/cobalt: Introduce generic feature initialization and check API

François LEGAL (4):
      RTNet builtin kernel - Fix IP protocols
      rtnet: af_packet: Remove duplicate copy_from/to_user
      rtnet: udp: Remove duplicate copy_from/to_user
      rtnet: tcp: Remove duplicate copy_from/to_user

Greg Gallagher (2):
      Add RTDM gpio driver for the OMAP family of SOCs
      kernel: cobalt: Remove header file for newer kernels

Greg Gallagher via Xenomai (1):
      kernel: cobalt: Fix up elf_hwcap

Jan Kiszka (27):
      smokey: Close tmp file at end of sigdebug test
      testsuite: Fix installation path of smokey_net_server
      libs: Add linking dependencies to libraries
      posix/compat: Avoid get/put_compat_sigset
      cobalt/posix/sem: Fix invalid parameter in tracepoint
      demo/posix/cobalt: Avoid ancillaries header
      demo: Remove obsolete includes
      cobalt/x86: Account for FPU changes in kernel 5.2
      drivers/ipc: Account for renaming of SO_RCVTIMEO/SO_SNDTIMEO
      driver/net: Update to kernel 5.4
      wrappers: Add mmiowb stub for kernels >= 5.2
      drivers/analogy: Fix unintended fallthrough
      drivers/e1000: Fix unintended fallthrough
      cobalt/posix: Address -Wimplicit-fallthrough
      testsuite/switchtest: Fix help output
      ci: Add x86 5.4 kernel to CI
      ci: Drop Travis CI
      ci: Add 5.4 release builds for arm and arm64, drop 4.14
      ci: Update URL to source.denx.de
      ci: Do not install unneeded crosstools
      ci: Trigger xenomai-images child pipeline corresponding to main branches
      testsuite/smokey/sched-quote: Make more deterministic and simplify
      testsuite/smokey/sched-quote: Fix throttling
      cobalt/posix/mqueue: Avoid returning internal EADV as error
      cobalt: Avoid reading time twice via xnstat_exectime_update
      drivers/net/igb: Make sure CONFIG_IGB_HWMON is off
      config: Bump version number

Jan Leupold (1):
      lib/cobalt: Wrap __open_2/__open64_2 to support _FORTIFY_SOURCE

Joshua Karch (1):
      Enable zynq gpio and xilinx gpio support for the Zynq MP platform.

Laurentiu-Cristian Duca (1):
      Avoid a possible too early interrupt from the omap mcSPI controller

Matúš Olekšák (1):
      Fixed long size in UDP port bitmap index

Norbert Lange (1):
      cobalt: allow to compile without __USE_LARGEFILE64

Philippe Gerum (8):
      cobalt/kernel: vfile_snapshot: fix seq_file leakage on race detection
      build: fix make distcheck
      demo/posix/cobalt: add missing __STD() annotation to sigwait()
      lib: remove remaining likely/unlikely branch annotations
      boilerplate: drop likely/unlikely annotations
      cobalt/synch: uapi: silence pedantic warning (signed/unsigned)
      copperplate/timerobj: fix start/start, start/stop races
      cobalt/vfile: seq_file seek index must progress

Pintu Kumar (1):
      kernel:cobalt:heap: replace kzalloc with vzalloc

Quirin Gylstorff (3):
      ci: Add gitlab-ci.yml
      gitlab-ci: add cache to decrease build times
      ci: Increase default of CCACHE_MAXSIZE to 1 gigabyte

Stephen Freyder (1):
      Restore proper operation of ioctl(SET_CONFIG)

Vitaly Chikunov (5):
      testsuite/smokey: Do not load .gdbinit in gdb test
      libs: Add linking dependencies to libcopperplate and libsmokey
      libs: Add linking dependency for libmodechk
      Multi-library support with core suffix in soname
      rt_e1000e: Fix __bad_udelay linking error

chensong (1):
      testsuite: App of gpio loopback/react benchmark

Thanks to all the contributors!

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux


