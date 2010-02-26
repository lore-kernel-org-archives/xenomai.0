Message-ID: <4B88128C.2090803@domain.hid>
Date: Fri, 26 Feb 2010 19:27:24 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pull request] RTDM+POSIX: Avoid leaking binding
	objects on errors
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

Jan Kiszka (1):
      RTDM+POSIX: Avoid leaking binding objects on errors

 ksrc/skins/posix/mq.c    |    1 +
 ksrc/skins/rtdm/drvlib.c |    6 ++++++
 2 files changed, 7 insertions(+), 0 deletions(-)

