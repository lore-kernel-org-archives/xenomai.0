Message-ID: <4BB1C51F.4010106@domain.hid>
Date: Tue, 30 Mar 2010 11:32:15 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [git pull] RTDM: Fix potential NULL pointer
	dereference
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

The following changes since commit 6b3e8f2e5c69397814cb2f4029cdfbaff16e113e:
  Gilles Chanteperdrix (1):
        doc: regenerate

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Unfortunately too late for 2.5.2, fortunately only relevant if something
else went wrong in create_instance (ENOMEM or application error).

Wolfgang Mauerer (1):
      RTDM: Fix potential NULL pointer dereference

 ksrc/skins/rtdm/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

