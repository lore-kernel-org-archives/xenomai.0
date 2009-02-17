Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <499AEE78.4060603@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 17 Feb 2009 18:04:19 +0100
Message-ID: <20090217170418.1425.56126.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 0/4] Various fixes and cleanups
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This is a rework/rebase of the patch series I sent last December,
addressing the concerns and suggestions brought up during our discussion
in January.


Find the patches also at git://git.kiszka.org/xenomai.git queues/assorted

Jan Kiszka (4):
      POSIX: Fix SCHED_RR thread creation
      Mark libs nodlopen on initial-exec TLS
      Add --enable-dlopen-skins configure switch
      POSIX: Do not auto-shadow main with dlopen enabled

 configure.in                  |   22 +++++++++++++++++++-
 ksrc/skins/posix/syscall.c    |    4 +-
 src/skins/native/Makefile.am  |    2 +-
 src/skins/posix/Makefile.am   |    2 +-
 src/skins/posix/init.c        |   43 ++++++++++++++++++++++++++--------------
 src/skins/posix/thread.c      |   11 +++++----
 src/skins/psos+/Makefile.am   |    2 +-
 src/skins/rtai/Makefile.am    |    2 +-
 src/skins/rtdm/Makefile.am    |    2 +-
 src/skins/uitron/Makefile.am  |    2 +-
 src/skins/vrtx/Makefile.am    |    2 +-
 src/skins/vxworks/Makefile.am |    2 +-
 12 files changed, 64 insertions(+), 32 deletions(-)

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

