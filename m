Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4A265441.6060605@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Wed, 03 Jun 2009 12:40:15 +0200
Message-ID: <20090603104015.13268.34073.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 0/3] Pull request: Build fix and RTDM
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


Jan Kiszka (3):
      nucleus: Add missing header for isspace
      RTDM: Instrument rtdm_lock_get for proper use
      RTDM: Avoid namespace pollution in RTDM_EXECUTE_ATOMICALLY

 include/rtdm/rtdm_driver.h |   22 +++++++++++++++-------
 ksrc/nucleus/intr.c        |    1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

