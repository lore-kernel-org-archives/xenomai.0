From: Sebastian Smolorz <ssm@domain.hid>
Date: Thu, 16 Nov 2006 10:57:46 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <E1Gke0B-0003BT-CA@mailer.emlix.com>
Subject: [Xenomai-help] Interrupt shield
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello,

can anybody confirm this behaviour? If I configure the I-shield into the 
kernel and start the latency test the RT tasks have not activated T_SHIELD 
although the documentation states it (and btw in rt_task_create this bit is 
set). If I try to set T_SHIELD inside the display task, the system hangs, a 
soft lockup appears and sometimes a few correct lines of the display task are 
printed, followed by the next lockup.

Explainable?

I'm testing on ARM with my S3C24xx I-pipe patch.

--
Sebastian

