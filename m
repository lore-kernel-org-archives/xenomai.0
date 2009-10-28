From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Oct 2009 10:33:30 +0100
Message-ID: <1256722410.2065.81.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.4.10
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org


Here is the tenth maintenance release for the v2.4.x branch.

http://download.gna.org/xenomai/stable/xenomai-2.4.10.tar.bz2

--

Gilles Chanteperdrix (2):
      build: provide front-end script to link static POSIX apps
      Do not use the 2 stages build for building non-posix applications

Jan Kiszka (2):
      native: Fix memory leak on heap/queue auto-deletion
      native: Avoid double release on queue/heap auto-cleanup

Philippe Gerum (12):
      scripts: install wrap-link.sh
      scripts: allow concurrent invocations of wrap-link.sh
      x86: fix 64bit build for SMP kernels < 2.6.31
      x86: upgrade I-pipe support to 2.6.30.8-x86-2.4-06
      powerpc: upgrade legacy I-pipe support to 2.6.20-powerpc-1.9-03
      nucleus: call post-release handlers w/ irqs on
      native/{queue, heap}: fix locking in post-release handlers
      x86: remove obsolete I-pipe patch
      powerpc: upgrade I-pipe support to 2.6.30.3-powerpc-2.7-02
      build: update version stamp
      doc: fix removal rule
      doc: rebuild documentation

Sebastian Smolorz (1):
      can: add support for SJA1000 based PCI CAN interface cards from
ESD GmbH

Stephen Sinclair (1):
      Copy the udev rules into rules.d if it exists.

-- 
Philippe.



