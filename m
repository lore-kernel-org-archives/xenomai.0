From: Wolfgang Mauerer <wolfgang.mauerer@domain.hid>
Date: Wed, 23 Dec 2009 10:25:50 +0100
Message-Id: <1261560352-9120-1-git-send-email-wolfgang.mauerer@domain.hid>
Subject: [Xenomai-core] [PATCH 0/2] xnvdso mechanism and unit test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

the following two mails integrate Gilles' comments into
the xnvdso patch and add a unit test. Notice that this submission
does not consider efficient access of shared data from
kernel space. Since this problem is independent from the
xnvdso mechanism, it will be addressed when I submit the NTP
time correction sharing code.

Thanks, Wolfgang

