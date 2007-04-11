From: Jeff Weber <jweber@domain.hid>
Date: Wed, 11 Apr 2007 16:56:18 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704111656.18894.jweber@domain.hid>
Subject: [Xenomai-help] Linux system calls from RT kernel task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

Are there any restrictions against calling the Linux kernel, namely 
do_gettimeofday(), from a Xenomai kernel task?

Does the kernel space task switch from primary to secondary mode, just as a 
user space task would?

	thanks,
	Jeff
-- 
Jeff Weber
American Superconductor Corp.

