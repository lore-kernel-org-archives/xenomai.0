Message-ID: <2ff1a98a0803120923m76f75bder857abac049c22e4d@domain.hid>
Date: Wed, 12 Mar 2008 17:23:01 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-core] New I-pipe patch for ARM.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>, xenomai-help <xenomai@xenomai.org>, adeos-main <adeos-main@gna.org>

Hi,

as you may have already noticed, the ARM I-pipe patch for linux 2.6.24
is available on Adeos download site and in Xenomai svn.

This patch incorporates modifications of all boards code to adapt to
the ipipe_tickdev system which couples timer requests with Linux
clockevent/clocksource framework.

As usual, it is tested only on AT91RM9200 and only compile-tested for
other boards. So, it would be nice if people could test this new patch
on their board.

Thanks and regards.

-- 
 Gilles Chanteperdrix

