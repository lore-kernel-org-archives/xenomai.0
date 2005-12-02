Date: Fri, 2 Dec 2005 13:15:54 +0100 (CET)
From: Klaas Gadeyne <klaas.gadeyne@domain.hid>
Message-ID: <Pine.LNX.4.63.0512021139500.2791@domain.hid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [Xenomai-help] i386 2.4 backport performing (too?) well
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

With the arrival of the 2.4 i386 adeos ipipe patch for xenomai [1], I
decided to try to compile xenomai-trunk for a 2.4 kernel. This worked
flawlessly, and moreover, I got excellent latency results:

I used the "same" kernel config as for our 2.4.31 rtai3.0r5 kernel,
which is based on Takis Issaris' liveCD config.

This resulted in a maximal latency of 30 usec after a run of over 100
minutes under heavy load (tar and dd loops, compiling, keyboard
interrupts and ping flood) [2].

For comparison, on the same hardware platform: 
- the RTAI lxrt-latency on rtai 3.0r5 (adeos oldgen r18c1
   patch for 2.4.31 also) test reports 38 usec
- the latency test of xenomai 2.01 running on a 2.6.14-ipipe-1.0-10
   kernel resulted in a latency of 80 usec.

This seems too good to be true?  Can one simply compare the results of
the former RTAI lxrt-latency test with the xenomai latency test?

Klaas

[1] <https://mail.gna.org/public/adeos-main/2005-11/msg00010.html>
[2] HW: a via mini-itx board,
     HW config at <http://issaris.org/rtai/show_entry.php?ts=2004-12-01+18%3A02%3A08%2B01>

