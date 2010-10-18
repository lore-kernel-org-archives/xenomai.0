Message-ID: <4CBC5470.5080806@domain.hid>
Date: Mon, 18 Oct 2010 16:06:40 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Adeos-main] [git pull] Updates for ipipe-2.6.35-noarch
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

The following changes since commit f640b80cfef6b33ac8737b87994f46c0edcc2d91:

  ipipe: fix build with ipipe off (2010-10-14 16:43:18 +0200)

are available in the git repository at:
  git://git.kiszka.org/ipipe-2.6 queues/2.6.35-noarch

Jan Kiszka (3):
      ipipe: Remove unused local variables
      ipipe: Reinstall ipipe_nmi_enter/exit
      ipipe: Drop foreign stack test from nmi entry/exit

 include/linux/hardirq.h |   38 ++++++++++++++++++--------------------
 kernel/ipipe/core.c     |    2 +-
 2 files changed, 19 insertions(+), 21 deletions(-)

