Date: Fri, 31 Mar 2006 10:58:26 +0200
From: ew@domain.hid
Message-ID: <71356528500.20060331105826@domain.hid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] gdb and latency
Reply-To: ew@domain.hid
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

Dear Xenomai team,

We're using Xenomai 2.1.0 on an PPC based Freescale controller. Kernel
Version is 2.4.25. Testsuite's latency works fine, except when using GDB.
While debugging the program, the semaphore in line 220 is not caught and
line 225 prints  "failed to pend on semaphore, code -512".
Breakpoints set in this vicinity are ignored. We've tried GDB 5.1 and 6.4.
Do you have an explanation for this bevaviour?

Thanks in advance

O. Flick

---------------------------------------------

ADC GmbH
Systems for industry and automation

Kringelsburg
21379 Scharnebeck
Germany

Tel. +49 4136/90 00-0
Fax  +49 4136/90 00-21

eMail ew@domain.hid
web   http://www.adcgmbh.de



