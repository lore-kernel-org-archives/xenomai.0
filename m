Message-ID: <4B0171B2.3060508@domain.hid>
Date: Mon, 16 Nov 2009 16:37:22 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request, extended] Added heap stats
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit cd3465f1862a4aa29e488a3876097d9e425ef907:
  Philippe Gerum (1):
        nios2: upgrade I-pipe support to 2.6.30-nios2-1.1-00

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki for-upstream

I implemented the heap statistics as discussed: /proc label strings are
set via a new service xnheap_set_label, the existing API is not touched.
And I think I even fixed some bugs of the previous version.

Jan Kiszka (2):
      rtdm: Fix copy&paste mistake in instrumentation
      nucleus: Include all heaps in statistics

 include/nucleus/heap.h    |    6 +++
 ksrc/drivers/ipc/iddp.c   |    1 +
 ksrc/drivers/ipc/xddp.c   |    3 +
 ksrc/nucleus/heap.c       |   99 ++++++++++++++++++++++++++++++++++++++++-----
 ksrc/nucleus/module.c     |    2 +
 ksrc/nucleus/pod.c        |    2 +
 ksrc/nucleus/shadow.c     |    2 +
 ksrc/skins/native/heap.c  |    1 +
 ksrc/skins/native/pipe.c  |    2 +
 ksrc/skins/native/queue.c |    1 +
 ksrc/skins/posix/shm.c    |    3 +
 ksrc/skins/psos+/rn.c     |    2 +
 ksrc/skins/rtai/shm.c     |    1 +
 ksrc/skins/rtdm/core.c    |    2 +-
 ksrc/skins/vrtx/heap.c    |    1 +
 ksrc/skins/vrtx/syscall.c |    2 +
 16 files changed, 119 insertions(+), 11 deletions(-)

