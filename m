Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADC9F2F.6030103@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Oct 2009 19:16:11 +0200
Message-ID: <20091019171611.3332.24615.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 0/3] Sem heap statistics & mutex
	auto-cleanup fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

This version extends the heap statistics to include all heaps that are
intialized by the nucleus or some skip. Some internal API modifications
were required which makes the second patch a bit larger. Moreover, I
modified some internal locking of nucleus' heap to use plain Linux spin
locks instead of heavy nklock.

Please pull the series from

    git://xenomai.org/xenomai-jki.git for-upstream

if there are no concerns.

Jan Kiszka (3):
      nucleus: Use Linux spin lock for heap list management
      nucleus: Include all heaps in statistics
      native: Release fastlock to the proper heap

 include/nucleus/heap.h    |   12 ++++-
 ksrc/drivers/ipc/iddp.c   |    3 +-
 ksrc/drivers/ipc/xddp.c   |    6 ++-
 ksrc/nucleus/heap.c       |  132 ++++++++++++++++++++++++++++++++++----------
 ksrc/nucleus/module.c     |    2 +-
 ksrc/nucleus/pod.c        |    5 +-
 ksrc/nucleus/shadow.c     |    5 ++-
 ksrc/skins/native/heap.c  |    6 ++-
 ksrc/skins/native/mutex.c |   14 ++++-
 ksrc/skins/native/pipe.c  |    4 +-
 ksrc/skins/native/queue.c |    6 ++-
 ksrc/skins/posix/shm.c    |    4 +-
 ksrc/skins/psos+/rn.c     |    6 ++-
 ksrc/skins/rtai/shm.c     |    7 ++-
 ksrc/skins/vrtx/heap.c    |    6 ++-
 ksrc/skins/vrtx/syscall.c |    3 +-
 16 files changed, 167 insertions(+), 54 deletions(-)

[1] http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/6559

