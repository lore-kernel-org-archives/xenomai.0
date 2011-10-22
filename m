Message-ID: <4EA2B5B0.3060209@domain.hid>
Date: Sat, 22 Oct 2011 14:23:12 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.6.0-rc5
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

Xenomai 2.6.0-rc5 is available at the usual place:
http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc5.tar.bz2

The major change since 2.6.0-rc4 is in analogy drivers sources. A new
patch for the ARM architecture was also added, for kernel 2.6.38,
including patches for imx51 and imx53 using the freescale linux-2.6-imx
git. And finally there are a few minor fixes and cosmetic changes here
and there.

Here is the shortlog:
Alexis Berlemont (1):
      analogy: quick fix to keep the async buffer below 4GB

Daniele Nicolodi (3):
      build: restore building of xeno-config man page
      testsuite: add missing include
      analogy: [ni_pcimio] replace noisy info messages by debug ones

Gilles Chanteperdrix (15):
      wrappers: fix compilation of HOSTRT without TICKDEV
      arm: fix context switch for linux 2.6.38
      testsuite: fix xeno-regression-test help string
      native: free buffer outside critical section in rt_buffer_delete
      arm: fix leftover from 392989f410f10ffc228b974ffe26787dff0734f2
      arm: change help message for --enable-arm-tsc option
      nucleus: change default configuration
      testsuite: fix regression tests location
      Merge remote branch 'alex/analogy'
      arm: upgrade patches
      psos: long/short names issue, take #2
      doc: fix README.INSTALL
      testsuite: various fixes
      build: bootstrap
      doc: regenerate

Regards.

-- 
                                                                Gilles.

