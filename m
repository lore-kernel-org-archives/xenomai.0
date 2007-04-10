From: Sebastian Smolorz <ssm@domain.hid>
Date: Tue, 10 Apr 2007 12:53:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1HbDyF-000442-DW@mailer.emlix.com>
Subject: [Xenomai-core] Wrong example code in Native-API-Tour
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

Hello Philippe,

on page 21 of Native-API-Tour-rev-C.pdf one gets the impression that 
rt_intr_wait() returns 0 on success. However, it returns a positive value in 
this case (as the API description states it right).

-- 
Sebastian

