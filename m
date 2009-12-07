Message-ID: <4B1D2C18.8090708@domain.hid>
Date: Mon, 07 Dec 2009 17:23:52 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] A smarter watchdog
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

The following changes since commit 1d53d0298f6d50b5136080b3b3322efee8b05c8a:
  Philippe Gerum (1):
        doc: regenerate

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (1):
      nucleus: Try to send SIGXCPU to runaway threads first

 include/nucleus/thread.h |    8 ++++++++
 ksrc/nucleus/sched.c     |   19 +++++++++++++++++--
 ksrc/nucleus/shadow.c    |    4 +++-
 3 files changed, 28 insertions(+), 3 deletions(-)


