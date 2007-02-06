Message-ID: <cbe23c50702061337yc411319l881b9402e4677d6d@domain.hid>
Date: Tue, 6 Feb 2007 22:37:26 +0100
From: "Eric Noulard" <eric.noulard@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] Multiple NIC trouble
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Xenomai help <xenomai@xenomai.org>

I am about to begin to use Xenomai
on a dual-core x86_64 box.

I installed FC6 i386 (32bits) since the adeos patch for x86_64
was not there when I did the install, I may go back
to run xenomai on x86_64 since I install both systems (x86_64 and i386)

Nevertheless I have three 32bits kernels

2.6.19-vanilla     (pure kernel.org kernel)
2.6.20-rc1-rtXX (precompiled from Ingo Molnar)
2.6.19-xenomai (vanilla + adeos-ipipe-2.6.19-i386-1.6-03.patch)

The box has 3 ethernet interface (2 on-board + 1 on an additionnal NIC)

eth0 is the additionnal NIC
eth1,eth2 the on-board I/F

eth1 used for corporate LAN
eth0 "should" be used for private network (only 2 machines for now)

With this config the machine boots properly with the non-xenomai
kernels with eth1 and eth0 up and running.

If I boot the xenomai kernel the machine hangs
(even sysrq does not help) as soon as  the system tries to ifup eth0.

If I disable eth0 the xenomai kernel boots until the end.
If I try to ifup eth0 "manually" afterward I got the same "hang".

I have no log and sysrq does not work !!

How would you suggest me to investigate that problem?

-- 
Erk

