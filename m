Message-ID: <4B59D952.30202@domain.hid>
Date: Fri, 22 Jan 2010 17:58:58 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Domain switch during page fault handling
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>, xenomai-core <xenomai@xenomai.org>

Hi guys,

we are currently trying to catch an ugly Linux pipeline state corruption
on x86-64.

Conceptual question: If a Xenomai task causes a fault, we enter
ipipe_trap_notify over the primary domain and leave it over the root
domain, right? Now, if the root domain happened to be stalled when the
exception happened, where should it normally be unstalled again,
*for_that_task*? Our problem is that we generate a code path where this
does not happen.

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux

