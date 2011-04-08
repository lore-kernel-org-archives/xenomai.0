Message-ID: <4D9F0679.7080109@domain.hid>
Date: Fri, 8 Apr 2011 14:58:33 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi

I'm trying to implement some gateway functionality in the kernel on a
emerson CPCI6200 board, but have run into some strange errors. The
kernel module is made up of two threads that run every 1 ms. I have also
made use of the rtpc dispatcher in rtnet to dispatch control messages
from a netlink socket to the RT part of my kernel module.

The problem is that when loaded the threads get suspended due to exceptions:

Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0xb929cbc0
after exception #1792

or

Xenomai: suspending kernel thread b929cbc0 ('tt_upgw_0') at 0x0 after
exception #1025

or

Xenomai: suspending kernel thread b911f518 ('rtnet-rtpc') at 0xb911f940
after exception #1792


I have ported the "gianfar" driver from linux to rtnet.

The versions and hardware are listed below. The errors are most likely
due to faulty software on my part, but i would like to ask if there are
any known issues with the versions or hardware i'm using. I would also
like to ask if there are any ways of further debugging the errors as i
am not getting very far with the above messages.



System info:

Linux kernel: 2.6.29.6
i-pipe version: 2.7-04
processor: powerpc mpc8572
xenomai version: 2.5.3
rtnet version: 0.9.12

-- 
/Jesper



