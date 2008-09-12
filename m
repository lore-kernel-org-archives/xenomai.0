Message-ID: <48CA7E5D.3080608@domain.hid>
Date: Fri, 12 Sep 2008 16:36:13 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] __pse51_get_current_prio
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

Hi Gilles,

we've integrated your unit_mutex and our native test, but now we
stumbled over that __pse51_get_current_prio special syscall to check the
dynamic thread priority (during pi tests). I guess that service only
exists in your private patch queue? What are your plans about this in
case we want to push the mutex test into mainline? Or should we check
the thread prio indirectly (by waking up a lower-prio thread)?

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

