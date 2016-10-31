From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <550719c6-8d3d-1cb1-fc74-d0922b80deb3@siemens.com>
Date: Mon, 31 Oct 2016 16:55:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PULL] Trying to flushing my queue...
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Philippe,

The following changes since commit 641827d0c029e3c2cf42cb02fdaa845da98b0619:

  rtcan: ems_pci driver update to support more devices (2016-10-30 18:07:19 +0100)

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-forge

for you to fetch changes up to 8e74b54833473a96e813f787ba34980525dddf02:

  boilerplate: Fix enabling Xenomai only in shared libs (2016-10-31 16:40:40 +0100)


Sorry in advance if I should have missed addressing some comment given
on one or the other patch before - some are now very old because I
didn't find the time to go after them. Let's retry.

Jan

----------------------------------------------------------------
Jan Kiszka (6):
      testsuite/smokey: Add test case for setschedparam & Co,
      cobalt/kernel: Allow to restart clock_nanosleep and select after signal processing
      lib/cobalt: Provide RT-capable usleep
      cobalt/autotune: Rework autotune_ioctl_nrt/rt for more robust request handling
      cobalt/rtdm: Restore return code tracing
      boilerplate: Fix enabling Xenomai only in shared libs

 configure.ac                                       |   1 +
 include/cobalt/uapi/kernel/thread.h                |   1 +
 include/cobalt/unistd.h                            |   2 +
 .../include/asm-generic/xenomai/ancillaries.h      |  27 ++++
 .../cobalt/include/asm-generic/xenomai/wrappers.h  |   4 +
 kernel/cobalt/posix/clock.c                        |  36 +++++-
 kernel/cobalt/posix/internal.h                     |   2 +
 kernel/cobalt/posix/io.c                           |  40 ++++--
 kernel/cobalt/posix/syscall.c                      |   5 +
 kernel/cobalt/rtdm/fd.c                            |  40 +++---
 kernel/drivers/autotune/autotune.c                 |  72 +++++++----
 lib/boilerplate/wrappers.c                         |   5 +-
 lib/cobalt/clock.c                                 |  14 +++
 lib/cobalt/cobalt.wrappers                         |   1 +
 lib/cobalt/wrappers.c                              |   6 +
 testsuite/smokey/Makefile.am                       |   1 +
 testsuite/smokey/setsched/Makefile.am              |   9 ++
 testsuite/smokey/setsched/setsched.c               | 137 +++++++++++++++++++++
 18 files changed, 357 insertions(+), 46 deletions(-)
 create mode 100644 kernel/cobalt/include/asm-generic/xenomai/ancillaries.h
 create mode 100644 testsuite/smokey/setsched/Makefile.am
 create mode 100644 testsuite/smokey/setsched/setsched.c

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

