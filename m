Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4ADC2F99.2060405@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Mon, 19 Oct 2009 11:20:52 +0200
Message-ID: <20091019092051.2502.31525.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 0/2] Sem heap statistics & mutex auto-cleanup
	fixes
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

This series fixes the native mutex auto-cleanup issues I reported in
[1]. It does not yet address the issues around heaps and queues as I
stumbled over more cleanup-related races, also in the nucleus, and want
to go through this with more care. Expect further patches to follow.

Also included in this pull request is a statistic enhancement for
/proc/xenomai/heap: It was lacking the sem heaps so far.

Please pull the series from

    git://xenomai.org/xenomai-jki.git for-upstream

if there are no concerns.

Jan Kiszka (2):
      nucleus: Add semaphore heap statistics
      native: Release fastlock to the proper heap

 include/nucleus/sys_ppd.h |   11 +++++++++++
 ksrc/nucleus/heap.c       |   30 ++++++++++++++++++++++++++++++
 ksrc/nucleus/shadow.c     |   23 +++++++++++++++++++++++
 ksrc/skins/native/mutex.c |   14 ++++++++++++--
 4 files changed, 76 insertions(+), 2 deletions(-)

[1] http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/6559

