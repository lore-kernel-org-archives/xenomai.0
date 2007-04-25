Message-ID: <bc4264770704250422p40e58608leb3f62d23bea25cb@domain.hid>
Date: Wed, 25 Apr 2007 11:22:18 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] warnings rtcan.h rtdm.h
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

Hi Jan,

you may remember that I posted this warning from the compiler a long
while back. You fixed it (rather made it quiet) but it seems to be
back in rtdm.h packed with 2.3.1 which I have now installed.


It does not bother me but I thought you would like to know.

In file included from /mnt/appusb/xenomai-2.3.1/include/rtdm/rtcan.h:250,
                 from cancom.h:6,
                 from task1.cpp:10:
/mnt/appusb/xenomai-2.3.1/include/rtdm/rtdm.h: In function `ssize_t
rt_dev_sendto(int, const void*, size_t, int, const sockaddr*,
socklen_t)':
/mnt/appusb/xenomai-2.3.1/include/rtdm/rtdm.h:323: warning: missing
initializer for member `msghdr::msg_flags'

running gcc version 3.4.6

regards,

Roland.

