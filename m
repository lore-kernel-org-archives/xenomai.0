Message-ID: <4503EB88.2040309@domain.hid>
Date: Sun, 10 Sep 2006 12:40:08 +0200
From: Matthias Fuchs <matthias.fuchs@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] No hardware interrupts with xenomai on ppc405 
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi,

I was trying to use some external hardware interupts on a PPC405 board
as part of a hacking session with Jan to bring up the rtcan driver on
this board.

Here are some versions:

	Linux Kernel: 2.6.14
	Adeos: 1.3-07
	Xenomai: from svn (2.3pre, last friday night)

The first interrupt interrupt was always fine. When the 2nd interupt
occured, it was never handled and did not cause any action. We used the
ipipe-tracer and did not see anything related to the 2nd and any further
interrupt.

I think that the hardware interrupt is somehow masked and therefore
never result in any action. So the handling of the first interrupt might
be incorrect.

This seems to be ppc or even ppc4xx related because I assume that x86
platforms do not have this issue. Is this an Adeos issue.

I will do the same test on a 2.4 kernel next week - if nobody tells me
that this will be a waste of time.

Matthias

