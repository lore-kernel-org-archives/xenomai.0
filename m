Message-ID: <472F6C17.2070100@domain.hid>
Date: Mon, 05 Nov 2007 20:16:39 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] i386: switch to root domain on unhandled
	non-root faults
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: adeos-main@gna.org
Cc: Xenomai-core@domain.hid

This patch addresses the recently discovered issue that I-pipe actually
need to deal with faults over non-root domain in which the current
domain shows no interest in. Such faults could be triggered inside
copy_*_user, thus can cleanly be handled by Linux - if we only allow for
this. Currently, if debugging is on, we warn about a potential bug, and
corrupt the pipeline states otherwise.

The new approach is to unconditionally drop to root domain in such
cases, but - for debugging purposes of non-fixable faults - keep track
of the original domain and report it on oops.

Similar patches are required for other archs. Maybe I can look into
x86_64 later.

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

