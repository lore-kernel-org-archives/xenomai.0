Message-ID: <4A1DBFD6.9050606@domain.hid>
Date: Thu, 28 May 2009 00:33:58 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request for 2.4 branch.
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>


Hi,

The following changes since commit 7790ec248f04581ca1194c5f48a82df51864761b:
  Philippe Gerum (1):
        Fix signedness of divisor

are available in the git repository at:

  git+ssh://git.xenomai.org/xenomai-gch.git for-2.4

Gilles Chanteperdrix (3):
      x86 FPU fixes
      Fix computation of heap overhead
      Adapt to preemptible context switch proposed by newer I-pipe patches

 include/asm-x86/bits/pod_32.h |   15 ++-------------
 include/asm-x86/bits/pod_64.h |    3 ++-
 include/nucleus/heap.h        |   22 +++++++++++++++++-----
 ksrc/arch/arm/Kconfig         |    4 ++++
 ksrc/nucleus/heap.c           |    2 +-
 5 files changed, 26 insertions(+), 20 deletions(-)

Regards.

-- 
					    Gilles.

