Resent-To: Xenomai-core@domain.hid
Resent-Message-Id: <48B3F2B4.8070400@domain.hid>
Message-ID: <48B3ED52.7080101@domain.hid>
Date: Tue, 26 Aug 2008 14:08:39 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 0/6] Registry-related cleanups and
	improvements
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Here comes the complete series of patches to improve the Xenomai
registry. #1, #5, and #6 are resends of already posted patches, the
middle part is fresh from the editor. The series reduces overhead
and simplifies the registry code. Overall diffstat:

 include/asm-generic/hal.h  |   10 +-
 include/nucleus/registry.h |   10 --
 ksrc/arch/generic/hal.c    |   18 +--
 ksrc/arch/generic/nmi.c    |    6 -
 ksrc/arch/x86/nmi_32.c     |    6 -
 ksrc/nucleus/module.c      |   58 ++++-------
 ksrc/nucleus/registry.c    |  223 ++++++++++++++++++++++-----------------------
 ksrc/skins/native/alarm.c  |   22 +---
 ksrc/skins/native/buffer.c |   15 ---
 ksrc/skins/native/cond.c   |   14 --
 ksrc/skins/native/event.c  |   15 ---
 ksrc/skins/native/heap.c   |   14 --
 ksrc/skins/native/intr.c   |   17 ---
 ksrc/skins/native/mutex.c  |   15 ---
 ksrc/skins/native/pipe.c   |   14 --
 ksrc/skins/native/queue.c  |   12 --
 ksrc/skins/native/sem.c    |   14 --
 ksrc/skins/native/task.c   |   16 ---
 18 files changed, 182 insertions(+), 317 deletions(-)

So a net gain of more than 130 LOC.

The series passed basic tests on my virtual target.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux



