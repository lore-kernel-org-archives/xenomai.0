From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Thu,  8 Jul 2010 12:20:43 +0200
Message-Id: <1278584445-8162-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Adeos-main] [PATCH v2 0/2] Host realtime clock support
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: adeos-main@gna.org
Cc: jan.kiszka@domain.hid

(This is the ipipe part of the mechanism, please see the Xenomai
 mailing list for the patches that make use of the infrastructure)

This patch series extends Xenomai with a new clock, CLOCK_HOST_REALTIME.
It allows for sharing NTP-corrected real time timestamps between
Linux/ipipe and Xenomai. The data are also available in userspace and can
be read without switching to kernel mode. Notice, however, that the new
clock only enables to read to time, but cannot serve as a full time basis.
Some changes to the ipipe layer are required as basis.

Changes since the last submission:

- Use ipipe events for data exchange (this also includes a slighty
  modified locking scheme)
- Include some smaller review comments

The selection of Linux clocks suitable for our purposes remains
as in the last series.

Tested on x86_64, compile tested for all combinations of
IPIPE_HOSTRT, XENO_OPT_HOSTRT and XENO_OPT_PERVASIVE

 arch/x86/Kconfig                  |    1 +
 arch/x86/include/asm/ipipe.h      |    2 ++
 arch/x86/include/asm/ipipe_base.h |    3 ++-
 arch/x86/include/asm/system.h     |    5 +++++
 arch/x86/include/asm/tsc.h        |    1 +
 arch/x86/kernel/ipipe.c           |   10 ++++++++++
 arch/x86/kernel/tsc.c             |    4 ++--
 arch/x86/kernel/vsyscall_64.c     |    6 ++++++
 include/linux/ipipe_tickdev.h     |   23 +++++++++++++++++++++++
 kernel/ipipe/Kconfig              |    3 +++
 kernel/ipipe/core.c               |   26 ++++++++++++++++++++++++++
 11 files changed, 81 insertions(+), 3 deletions(-)


