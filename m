From: os_1a <utsav.patel@domain.hid>
Date: Sat, 18 Feb 2012 12:14:30 +0000 (UTC)
Message-ID: <loom.20120218T125532-226@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

I'm getting this type of error while running the tests.
how can I enable them and how to reconfigure the kernel?


ceems@domain.hid$ sudo ./latency 
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
ceems@domain.hid$ sudo ./clocktest 
Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_posix?)
ceems@domain.hid$ sudo ./sigtest 
Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_posix?)
ceems@domain.hid$ sudo ./rtdm 
Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_native?)
ceems@domain.hid$ 



