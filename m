Message-ID: <4E76DB36.5060203@domain.hid>
Date: Mon, 19 Sep 2011 08:03:34 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.6.0-rc3
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>, Xenomai help <xenomai@xenomai.org>


Hi,

here comes xenomai v2.6.0-rc3:
http://download.gna.org/xenomai/testing/xenomai-2.6.0-rc3.tar.bz2

New since -rc2:
- fix of vxworks services taskDelete and taskDeleteForce;
- SCHED_FIFO threads switching to SCHED_OTHER while holding a mutex are
sent a SIGDEBUG signal when releasing the mutex;
- add the beginning of a regression tests suite.

Known remaining issues:
- mscan driver not building on mpc5xxx with linux 3.0, see:
http://sisyphus.hd.free.fr/~gilles/bx/lite5200/3.0.4-ppc_6xx-gcc-4.2.2/log.html#1
- issue with 4 characters ids in the psos skin.

Regards.

-- 
                                                                Gilles.

