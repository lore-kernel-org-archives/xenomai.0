From: Henry Bausley <hbausley@domain.hid>
In-Reply-To: <loom.20081016T124807-588@domain.hid>
References: <loom.20081016T124807-588@domain.hid>
Content-Type: text/plain
Date: Tue, 21 Oct 2008 09:12:16 -0700
Message-Id: <1224605536.10407.15.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Reducing Kernel Mode Interrupt Latency
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


Is there any way the kernel mode interrupt handling maximum times can be
decreased.  I very much need to reduce my kernel mode interrupt
latencies.  I know my hardware is capable of better performance based
upon measurements done with RT Linux.  Below is our timing comparison,
all times are the maximums.


Xenomai 2.4.5 interrupt handler  w/ Kernel 2.6.26 powerpc, gcc 4.2
-------------------------------------------------------------------
AMCC 440EP - 24.5 usec
AMCC 460EX - 16.5 usec


FSM Labs RT-Linux 2.2 w/ Kernel 2.6.14 ppc, gcc 3.3
---------------------------------------------------
AMCC 440EP - 10.0 usec
AMCC 460EX - Not Available, would require 10's of thousands of dollars
to WindRiver




