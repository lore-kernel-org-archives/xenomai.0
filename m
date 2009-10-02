Message-ID: <4AC5C8C4.9060806@domain.hid>
Date: Fri, 02 Oct 2009 11:32:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] Various fixes
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

The following changes since commit 50ee47db78117e8711d4d2f5310dff262a425eb7:
  Gilles Chanteperdrix (1):
        Do not use the 2 stages build for building non-posix applications

are available in the git repository at:

  git://xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      POSIX: Fix error reporting of __real_accept

Wolfgang Mauerer (3):
      Fix handling of deleted message queue objects
      Make marker string for faults less ambiguous
      Document -EWOULDBLOCK for rtdm_event_wait

 ksrc/nucleus/pod.c          |    2 +-
 ksrc/skins/native/queue.c   |    2 ++
 ksrc/skins/native/syscall.c |    6 ++++++
 ksrc/skins/rtdm/drvlib.c    |    3 +++
 src/skins/posix/rtdm.c      |   13 ++++++++-----
 5 files changed, 20 insertions(+), 6 deletions(-)

