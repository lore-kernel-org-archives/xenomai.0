Message-ID: <442C24D1.2080607@domain.hid>
Date: Thu, 30 Mar 2006 20:34:57 +0200
From: Wolfgang Grandegger <wg@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] cyclictest.c
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

Hello,

The new testsuite program cyclictest.c breaks compilation of Xenomai on 
Linux 2.4 because SIGEV_THREAD_ID does not exist. Is it only suitable 
for Linux 2.6 (with NTPL threads)?

Wolfgang.

