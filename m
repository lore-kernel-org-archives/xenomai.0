Message-ID: <498085C2.7090604@domain.hid>
Date: Wed, 28 Jan 2009 17:20:18 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] trunk: xnsched_set_policy seems to set only cprio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Hi,

unfortunately I'm forced to switch to other bugs, but I found out a bit
more about the issue that pthread_getschedparam doesn't return the
correct policy&prio under trunk - at least when called from threads
created via pthread_create as SCHED_FIFO:

Such threads start with SCHED_OTHER, but then the propagation via
do_setsched_event and finally xnsched_set_policy only seems to affect
thread.cprio, not bprio. Will see if I can continue debugging this
later, but maybe /someone/ already knows what goes wrong...

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

