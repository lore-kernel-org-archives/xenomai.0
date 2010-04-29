From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 23:44:16 +0200
Message-ID: <1272577456.24705.19.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] Assorted fixes and I-pipe upgrades
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org


The following changes since commit fbc3b858ee728c1a6b03996e3285198caa7053c6:
  Gilles Chanteperdrix (1):
        debug: fix CONFIG_XENO_OPT_DEBUG_* issues

are available in the git repository at:

  git://git.xenomai.org/xenomai-rpm.git for-upstream

Philippe Gerum (10):
      nucleus: introduce bufd reset operation
      rtipc/bufp: reset buffer descriptor upon r/w preemption
      native/buffer: reset buffer descriptor upon r/w preemption
      powerpc: mention official URL to mainline kernel releases
      x86: upgrade I-pipe support to 2.6.32.11-x86-2.6-02
      scripts: fix xeno wrapper to consider --with-testdir
      nucleus: fix relaxing synch owner detector
      nucleus: reduce overhead of thread handle lookup
      x86: upgrade I-pipe support to 2.6.32.11-x86-2.6-03, 2.6.34-rc5-x86-2.6-03
      powerpc: upgrade I-pipe support to 2.6.34-rc5-powerpc-2.9-01

Stefan Kisdaroczi (1):
      debian: add init-script to package libxenomai1

 debian/libxenomai1.xenomai.init                    |   37 +
 debian/rules                                       |    1 +
 include/nucleus/bufd.h                             |    5 +
 include/nucleus/registry.h                         |   24 +
 include/nucleus/thread.h                           |    2 +-
 ksrc/arch/powerpc/patches/README                   |    2 +-
 .../adeos-ipipe-2.6.34-rc5-powerpc-2.9-01.patch}   | 9124 +++++++++++---------
 ...atch => adeos-ipipe-2.6.32.11-x86-2.6-03.patch} |  297 +-
 ...tch => adeos-ipipe-2.6.34-rc5-x86-2.6-03.patch} | 1718 +++--
 ksrc/drivers/ipc/bufp.c                            |    8 +-
 ksrc/nucleus/bufd.c                                |   20 +
 ksrc/nucleus/registry.c                            |   42 +-
 ksrc/nucleus/synch.c                               |   10 +-
 ksrc/skins/native/buffer.c                         |    8 +-
 scripts/xeno.in                                    |    5 +-
 15 files changed, 6118 insertions(+), 5185 deletions(-)

-- 
Philippe.



