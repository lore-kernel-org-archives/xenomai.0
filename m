From: Philippe Gerum <rpm@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Sep 2010 19:29:56 +0200
Message-ID: <1283362196.1709.1952.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PULL-REQUEST] urgent scheduler fix for 2.5.x head
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


The following changes since commit afc0eac7e4989f4134b18a256b5c5e1ca1c56a39:
  Gilles Chanteperdrix (1):
        posix: add a magic to internal structures.

are available in the git repository at:

  ssh+git://git@domain.hid for-upstream

Philippe Gerum (2):
      nucleus/sched: fix race in non-atomic suspend path
      nucleus/sched: raise self-resched condition when unlocking scheduler

 ksrc/nucleus/pod.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

-- 
Philippe.



