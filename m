Message-ID: <49CC95A4.9010702@domain.hid>
Date: Fri, 27 Mar 2009 10:00:20 +0100
From: Axel Beierlein <belatronix@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Meaning of cache locking in /proc/xenomai/faults
Reply-To: belatronix@domain.hid
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

Hello,

on my MPC5200 i have the following output of /proc/xenomai/faults

TRAP         CPU0
   0:            0    (Data or instruction access)
   1:            0    (Alignment)
   2:            0    (Altivec unavailable)
   3:            0    (Program check exception)
   4:            0    (Machine check exception)
   5:            0    (Unknown)
   6:            0    (Instruction breakpoint)
   7:            0    (Run mode exception)
   8:            0    (Single-step exception)
   9:            0    (Non-recoverable exception)
  10:            0    (Software emulation)
  11:            0    (Debug)
  12:            0    (SPE)
  13:            0    (Altivec assist)
  14:  -1072753084    (Cache-locking exception)
  15:            0    (Kernel FP unavailable)

Now i am trying to find out what the negative Value of Cache-locking and 
what this Trap general mean and when it was triggered.

Can you give me some advice?

TIA

