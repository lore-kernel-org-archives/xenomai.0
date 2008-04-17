Message-ID: <d6c8ef150804170346t4537b9dehf448cd6c9d0debb5@domain.hid>
Date: Thu, 17 Apr 2008 12:46:15 +0200
From: "Bosko Radivojevic" <bosko.radivojevic@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] RTDM question
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

What could be the reason of rt_dev_open() returning 0 (zero)?

I can see that device is properly registered. When I start user-space
program, I can see in /proc/xenomai/rtdm/filedes that one file is
open:
Index   Locked  Device          Owner [PID]
0       0       macbdev0        user [306]

But I never reach write function. rt_dev_write() & rt_dev_read() are
returning -1. In API documentation, for rt_dev_open return values
says:
Positive file descriptor value on success, otherwise a negative error code.

Thanks

