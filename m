Message-ID: <48F34E5A.60209@domain.hid>
Date: Mon, 13 Oct 2008 15:34:18 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [BUG?] mem leak on slab size-1024 with Xenomai
	processes
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

Sigh, this is not my day: Can anyone confirm that we are leaking memory
with current SVN head? I'm seeing a constant increase on slab
"size-1024" on a x86_64 box when running arbitrary Xenomai apps in a loop.

[ Besides that, I have an occasional deadlock in xnpipe_wakeup_proc due
to an inconsistent xnpipe_sleepq - likely a different story... :-/ ]

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

