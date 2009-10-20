Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADDA26D.8040007@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Tue, 20 Oct 2009 13:37:25 +0200
Message-ID: <20091020113724.9069.23594.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v3 0/9] heap setup/cleanup fixes,
	refactorings & more
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

Third round of this series. This time I dug deeper into the heap
management, trying to simplify its use which should remove a few race
conditions of the existing code.

The central change is patch 5: xnheap_destroy_mapped will no longer
return an error, it will always start deferred deletion in case the
heap's memory is still in use. This simplifies the use a lot, allowing
among other things to drop -EBUSY from the list of possible return codes
of rt_queue/heap_delete.

The series furthermore contains an attempt to fix RTAI's shm code, fixes
the know leakages of rt_mutex/queue/heap auto-deletion and introduces
complete heap statistics (this time without using a Linux spin lock).

Please pull the series (or cherry-pick individual patches) from

    git://xenomai.org/xenomai-jki.git for-upstream

if there are no concerns.

Jan Kiszka (9):
      native: Release fastlock to the proper heap
      nucleus: Use Linux spin lock for heap list management
      nucleus: Fix race window in heap mapping procedure
      nucleus: xnheap_destroy does not fail
      nucleus: Avoid returning errors from xnheap_destroy_mapped
      rtai: Try to fix _shm_free
      native: Do not requeue on auto-cleanup errors
      native: Fix memory leak on heap/queue auto-deletion
      nucleus: Include all heaps in statistics

 include/asm-generic/bits/heap.h |    2 +-
 include/asm-generic/system.h    |    2 +-
 include/native/ppd.h            |   16 +--
 include/nucleus/heap.h          |   32 +++--
 ksrc/drivers/ipc/iddp.c         |    3 +-
 ksrc/drivers/ipc/xddp.c         |    6 +-
 ksrc/nucleus/heap.c             |  258 +++++++++++++++++++++++++++------------
 ksrc/nucleus/module.c           |    2 +-
 ksrc/nucleus/pod.c              |    5 +-
 ksrc/nucleus/shadow.c           |    5 +-
 ksrc/skins/native/heap.c        |   41 +++---
 ksrc/skins/native/mutex.c       |   14 ++-
 ksrc/skins/native/pipe.c        |    4 +-
 ksrc/skins/native/queue.c       |   34 +++---
 ksrc/skins/native/syscall.c     |   25 +---
 ksrc/skins/posix/shm.c          |    4 +-
 ksrc/skins/psos+/rn.c           |    6 +-
 ksrc/skins/rtai/shm.c           |   47 ++++---
 ksrc/skins/vrtx/heap.c          |    6 +-
 ksrc/skins/vrtx/syscall.c       |    3 +-
 20 files changed, 317 insertions(+), 198 deletions(-)

[1] http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/6559

