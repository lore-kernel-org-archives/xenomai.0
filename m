Message-ID: <48B2994A.1050708@domain.hid>
Date: Mon, 25 Aug 2008 13:36:42 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Native skin: user space handles sharable between
	processes?
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

what is the policy for the user space handles the native skin generates:
Can the user share them between processes via putting them into shared
memory (like it is allowed for some POSIX objects)?

I'm wondering if I have to use the POSIX pattern to resolve the address
of a fast mutex: If shared, look to global heap, otherwise use
process-local heap. If native handle structures were only valid within a
single context, I could use absolute pointers instead, saving some code
and data.

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

