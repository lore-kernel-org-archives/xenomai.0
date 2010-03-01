Message-ID: <4B8BF542.6040308@domain.hid>
Date: Mon, 01 Mar 2010 18:11:30 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] RTDM fixes and cleanups
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

The following changes since commit 95412b8c10ba7ba199089a3cbb60c67c8d718186:
  Gilles Chanteperdrix (1):
        timeconv: revert 97b78d45bf4c5571fccd9675fae8bb008a341769

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (5):
      RTDM+POSIX: Avoid leaking binding objects on errors
      RTDM: Bind deleted sem/event objects, but mark them pending
      RTDM: Consistently use xnsynch_test_flags to test for RTDM_SYNCH_DELETED
      RTDM: Avoid calling cleanup_instance with held spin lock
      RTDM: Add smp barrier to rtdm_context_unlock

 include/rtdm/rtdm_driver.h |    1 +
 ksrc/skins/posix/mq.c      |    1 +
 ksrc/skins/rtdm/core.c     |   45 ++++++++++++++++++++++---------------------
 ksrc/skins/rtdm/drvlib.c   |   40 ++++++++++++++++++++------------------
 4 files changed, 46 insertions(+), 41 deletions(-)

