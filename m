Message-ID: <4AFA8A4A.9030603@domain.hid>
Date: Wed, 11 Nov 2009 10:56:26 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] DEBUG_SYNCH_RELAX fix and some
	cleanups
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

The following changes since commit 3b0152276752561805bf113eaa7b699d93c473c5:
  Bernhard Walle (1):
        hal: check CPU frequency

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Specifically the last patch is important for us as hell broke loose
here once we enabled it for our customer. The first one is a resend, the
other two are a cleanup and a minor instrumentation fix.

Jan Kiszka (4):
      hal: Ensure atomicity of rthal_local_irq_disabled
      nucleus: Cosmetic cleanup of lostage_handler
      nucleus: Improve lostage_work instrumentation
      nucleus: Fix endless loop of DEBUG_SYNCH_RELAX

 include/asm-generic/hal.h |   19 ++++++++++++++++++-
 include/nucleus/thread.h  |    1 +
 ksrc/nucleus/shadow.c     |   28 +++++++++++++++++-----------
 ksrc/nucleus/synch.c      |   11 ++++++++---
 4 files changed, 44 insertions(+), 15 deletions(-)

