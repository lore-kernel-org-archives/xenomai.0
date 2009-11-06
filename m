Message-ID: <4AF3FCEC.80708@domain.hid>
Date: Fri, 06 Nov 2009 11:39:40 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Pull request..
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>

The following changes since commit 8ade06dd81c89f3938294527e86907417291ba94:
  Jan Kiszka (1):
        native: Properly update lockcnt on recursive call from secondary mode

are available in the git repository at:

  git://git.xenomai.org/xenomai-gch.git for-head

Gilles Chanteperdrix (1):
      nucleus: defer selector block deletion to an APC.

Peter Soetens (1):
      nucleus: move posix selector in nucleus for every skin to use.

 include/nucleus/select.h   |    5 +++
 include/nucleus/thread.h   |    5 +++
 ksrc/nucleus/module.c      |   18 +++++++++--
 ksrc/nucleus/pod.c         |    8 +++++
 ksrc/nucleus/select.c      |   69 +++++++++++++++++++++++++++++++++++---------
 ksrc/nucleus/thread.c      |    3 ++
 ksrc/skins/posix/syscall.c |    4 +-
 ksrc/skins/posix/thread.c  |   16 ----------
 ksrc/skins/posix/thread.h  |    4 --
 9 files changed, 93 insertions(+), 39 deletions(-)

-- 
                                          Gilles


