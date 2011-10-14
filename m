Message-ID: <4E981AFB.40106@domain.hid>
Date: Fri, 14 Oct 2011 13:20:27 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL] KVM awareness / tiny cleanup
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

The following changes since commit 31bdadef9018de586bc3fe8de0f37b62b2507785:

  testsuite: fix regression tests location (2011-10-14 01:46:08 +0200)

are available in the git repository at:
  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (2):
      nucleus: Privatize __xnpod_reset_thread
      x86: Fire root preemption notifier

 include/asm-generic/hal.h     |    5 +++++
 include/asm-x86/bits/pod_32.h |    2 ++
 include/asm-x86/bits/pod_64.h |    2 ++
 include/nucleus/pod.h         |    2 --
 ksrc/nucleus/pod.c            |    8 ++++----
 5 files changed, 13 insertions(+), 6 deletions(-)

Two trivial changes, though the second one actually adds a noteworthy
feature to Xenomai: co-location of KVM guests on x86. That feature
depends on I-pipe changes posted in [1].

Jan

[1] http://thread.gmane.org/gmane.linux.kernel.adeos.general/1898

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

