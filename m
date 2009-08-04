MIME-Version: 1.0
Date: Tue, 4 Aug 2009 14:23:30 +0100
Message-ID: <abaf774b0908040623w1583f930xda88c125b64394b1@domain.hid>
From: Steve <sbxenomai@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai 2.5-rc2 clock_gettime bad tv_nsec value
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

Hi,

Using Xenomai 2.5-rc2 on Linux 2.6.29.4 the following code
periodically produces a bad result:

clock_gettime(CLOCK_REALTIME, timespec);

Where it assigns a timespec.tv_nsec that is greater than 1000 million.
 If it helps the maximum returned value that i have seen before tv_sec
increments and tv_nsec returns to a 'safe' value is 1048044075.

This does not happen using Xenomai 2.4.8 on the same Linux kernel.
There are some differences between the kernel config files used for my
2.4.8 setup and 2.5-rc2 setup, but I don't imagine that that is the
problem.

Any thoughts?

Steve

