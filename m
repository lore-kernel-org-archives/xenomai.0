Resent-To: xenomai-core <xenomai@xenomai.org>
Resent-Message-Id: <48F756EB.8000007@domain.hid>
Message-Id: <20081016145757.935266172@domain.hid>
Date: Thu, 16 Oct 2008 16:57:57 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
Subject: [Xenomai-core] [PATCH 0/2] Fix and improve task/thread inquire
	services
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

This series fixes the issues around rt_task_inquire I posted yesterday.
Additionally, it introduces an analogous services pthread_inquire_np for
the POSIX skin. That allows, among other things, to implement test cases
for the upcoming fast xnsynch/mutex patches.

Jan

--
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux


