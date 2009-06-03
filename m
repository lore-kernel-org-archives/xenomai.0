Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A2681F5.9090105@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 15:59:12 +0200
Message-ID: <20090603135912.22120.29245.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH v2 0/4] Pull request: Build fix and RTDM
	improvements
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

Please pull from

    git://xenomai.org/xenomai-jki.git for-upstream

In v2, I added a rthal_local_irq_disabled wrapper and fixed the inverted
test in rtdm_lock_get.

Jan Kiszka (4):
      nucleus: Add missing header for isspace
      hal: Add rthal_local_irq_disabled wrapper
      RTDM: Instrument rtdm_lock_get for proper use
      RTDM: Avoid namespace pollution in RTDM_EXECUTE_ATOMICALLY

 include/asm-generic/hal.h  |    1 +
 include/rtdm/rtdm_driver.h |   22 +++++++++++++++-------
 ksrc/nucleus/intr.c        |    1 +
 ksrc/skins/rtdm/core.c     |   15 ++++++++++-----
 4 files changed, 27 insertions(+), 12 deletions(-)

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

