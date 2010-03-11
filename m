From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Mar 2010 18:18:22 +0100
Message-ID: <1268327902.27899.106.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] Blackfin upgrade and minor fixes for
	2.5.x
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


The following changes since commit 55b0aa9de28891fcfd4b4ab097583bd7619223ab:
  Philippe Gerum (1):
        native: introduce rt_task_same()

are available in the git repository at:

  git://xenomai.org/xenomai-rpm.git for-upstream

Philippe Gerum (5):
      testsuite/latency: fix false positive in mode switch detection
      powerpc: remove dandling reference
      blackfin: upgrade I-pipe support to 2.6.33-blackfin-1.13-00
      scripts/xeno-config: fix --skin=posix --ldflags call form
      nucleus: warn about denied syscalls

 ksrc/arch/blackfin/patches/README                  |   58 +-
 .../adeos-ipipe-2.6.33-blackfin-1.13-00.patch      | 7596 +++++++++++++++++
 .../adeos-ipipe-2008R1.5-RC3-bf5xx-1.8-00.patch    | 8629 --------------------
 ksrc/arch/powerpc/patches/README                   |    8 +-
 ksrc/nucleus/shadow.c                              |   13 +-
 scripts/xeno-config.in                             |    3 +-
 src/testsuite/latency/latency.c                    |   27 +-
 7 files changed, 7664 insertions(+), 8670 deletions(-)
 create mode 100644 ksrc/arch/blackfin/patches/adeos-ipipe-2.6.33-blackfin-1.13-00.patch
 delete mode 100644 ksrc/arch/blackfin/patches/adeos-ipipe-2008R1.5-RC3-bf5xx-1.8-00.patch

-- 
Philippe.



