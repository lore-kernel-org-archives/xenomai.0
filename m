Message-ID: <4BCD71C5.6080002@domain.hid>
Date: Tue, 20 Apr 2010 11:20:05 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [pit pull] uitron debug fix and rtdm_rt_capable
	refinement
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

The following changes since commit bc3fefdc8dccc5e77f48f708537d48ff01734a83:
  Jan Kiszka (1):
        Move schedule_delayed_work into wrapping header

are available in the git repository at:

  git://git.xenomai.org/xenomai-jki.git for-upstream

Jan Kiszka (2):
      uitron: Fix skin debug option
      RTDM: Restrict use of rtdm_rt_capable

 include/rtdm/rtdm_driver.h |    7 +++++--
 ksrc/skins/rtdm/drvlib.c   |    6 ++++--
 ksrc/skins/uitron/Kconfig  |    9 +++++++++
 ksrc/skins/uitron/ppd.h    |    4 ++--
 4 files changed, 20 insertions(+), 6 deletions(-)


