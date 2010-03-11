Message-ID: <4B99083C.20903@domain.hid>
Date: Thu, 11 Mar 2010 16:11:56 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] assert_nrt_fast / updated corruption
	warning
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

The following changes since commit 4277a0e209cc1226ef1e1bfa3fcea40a57fb1ff3:
  Gilles Chanteperdrix (1):
        arm: upgrade I-pipe support to 2.6.28.10-arm-1.12-07, 2.6.29-arm-1.13-05 and 2.6.30-arm-1.15-01

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (3):
      common: Introduce xeno_get_current_fast
      rtdk: Introduce assert_nrt_fast
      common: Restore memory corruption warning for non-leak case

 include/asm-generic/bits/current.h |   10 +++++++++
 src/rtdk/assert_context.c          |   39 ++++++++++++++++++++++++-----------
 src/skins/common/current.c         |   12 +++++++---
 3 files changed, 45 insertions(+), 16 deletions(-)

