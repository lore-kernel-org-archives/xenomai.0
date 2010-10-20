Message-ID: <4CBE7473.9080706@domain.hid>
Date: Wed, 20 Oct 2010 06:47:47 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai 2.5.5.2
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>, Xenomai core <Xenomai-core@domain.hid>


Hi,

Philippe found the hard way that two of the last-minute commits which
were added to 2.5.5 broke Xenomai on some ARM machines. Here is a new
re-re-release to fix them. Hopefully. Three times is a charm, they say.

shortlog:
Gilles Chanteperdrix (1):
      arm: fix typo in armv6+ xnarch_xchg implementation
Philippe Gerum (1):
      hal/arm: do not assume single global timer chip

Tarball available here:
http://download.gna.org/xenomai/stable/xenomai-2.5.5.2.tar.bz2

Regards.

-- 
                                                                Gilles.

