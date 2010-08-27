Message-ID: <4C7783C9.5090501@domain.hid>
Date: Fri, 27 Aug 2010 11:22:17 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] False positive XENO_BUGON(NUCLEUS,
	need_resched == 0)?
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

I'm hitting that bug check in __xnpod_schedule after
xnintr_clock_handler issued a xnpod_schedule like this:

	if (--sched->inesting == 0) {
		__clrbits(sched->status, XNINIRQ);
		xnpod_schedule();
	}

Either the assumption behind the bug check is no longer correct (no call
to xnpod_schedule() without a real need), or we should check for
__xnpod_test_resched(sched) in xnintr_clock_handler (but under nklock then).

Comments?

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

