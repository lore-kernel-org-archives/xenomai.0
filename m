From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain
Date: Tue, 01 Sep 2009 10:48:58 +0200
Message-Id: <1251794938.3205.20.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.9.1
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


We had a couple of brown paper bag issues in v2.4.9, particularly in the
interrupt pipeline for the ARM port, but also a time conversion bug
which basically affects any architecture with high frequency CPUs
(x86-ers, this one is for you).

So, here is v2.4.9.1 to fix those bugs:
http://download.gna.org/xenomai/stable/xenomai-2.4.9.1.tar.bz2

Gilles Chanteperdrix (3):
      arm: map all heaps with XNARCH_SHARED_HEAP_FLAGS to avoid cache aliasing issues
      timeconv: fix xnarch_ns_to_tsc when using llmulshft
      arm: disable Xscale fpu switching code

Philippe Gerum (7):
      arm: upgrade I-pipe support to 2.6.30-arm-1.14-01
      arm: upgrade I-pipe support to 2.6.30-arm-1.14-02, 2.6.28-arm-1.12-05, 2.6.29-arm-1.13-03
      build: update version stamp
      native: fix (harmless) uninitialized reference
      doc: regenerate documentation
      powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-02

-- 
Philippe.



