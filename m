From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 18 Jun 2010 18:57:56 +0200
Message-ID: <1276880276.12743.73.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL REQUEST] fixes for 2.5.4
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


This series is mainly about fixing the shared heap management for nommu,
and introducing a way to break out from syscall-less runaway loops, in
primary mode.

Regarding the shared heaps, we have no choice but break the 2.5.x ABI
for blackfin and nios2 for fixing them, but for a good reason: they just
could not work on any earlier release.

Recovery from runaway loops in primary mode is introduced by the mayday
patch series; the faulty thread gets relaxed, instead of being killed,
when the nucleus watchdog triggers.

Gilles, please merge.

      uitron: fix wait flag helper
      hal/generic: always track switch to foreign stack
      compat: provide linux/err.h wrapper to linux/fs.h
      nucleus: silence deprecated warnings on __builtin_expect for old compilers
      rtai: mark as deprecated
      skins: sanitize heap binding
      build: check for CONFIG_MMU in user-space
      nucleus: fix heap mapping for nommu
      wrappers: no need to reserve pages passed to vm_insert_page
      x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-00, 2.6.34-x86-2.7-00
      powerpc: upgrade I-pipe support to 2.6.33.5-powerpc-2.10-01, 2.6.34-powerpc-2.10-00
      x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-00, 2.6.34-x86-2.7-00
      arm: upgrade I-pipe support to 2.6.33-arm-1.17-00
      blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.14-00
      nucleus: introduce generic bits for MAYDAY support
      powerpc: enable MAYDAY support
      x86: enable MAYDAY support
      arm: enable MAYDAY support
      blackfin: enable MAYDAY support
      nios2: enable MAYDAY support
      arm: upgrade I-pipe support to 2.6.33-arm-1.17-01
      blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.14-01
      powerpc: upgrade I-pipe support to 2.6.33.5-powerpc-2.10-02, 2.6.34-powerpc-2.10-01
      x86: upgrade I-pipe support to 2.6.32.15-x86-2.7-01, 2.6.34-x86-2.7-01
      common: warn early about missing /dev/rtheap
      nucleus: fix uninit variable
      nios2: upgrade I-pipe support to 2.6.30-nios2-1.2-00
      rtai: disable for MMU-less and 64bit builds
      rtdm: fix memory mapping services for nommu platforms
      powerpc: upgrade I-pipe support to 2.6.34-powerpc-2.10-02
      x86: upgrade I-pipe support to 2.6.34-x86-2.7-02
      blackfin: upgrade I-pipe support to 2.6.34-blackfin-1.14-02
      powerpc: upgrade I-pipe support to 2.6.34-powerpc-2.10-02

-- 
Philippe.



