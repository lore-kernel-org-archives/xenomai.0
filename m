Date: Thu, 16 Feb 2006 08:21:31 -0800
From: Steven Seeger <steve@domain.hid>
Message-ID: <C019E68B.23F6%steve@domain.hid>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Content-transfer-encoding: 7bit
Subject: [Xenomai-help] no-brainer realtime issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

I have a xenomai userspace application that does the following:

A thread of priority 90 toggles a bit (outb) to move a stepper motor.

A thread of priority 10 updates the display once a second.

The motor thread is periodic and uses rt_task_wait_period(). The display
thread just uses sleep(1).

My question is this: the priority 90 thread is higher priority, and doesn't
do anything relating to linux system calls. Whenever the display thread
updates the display, the motor thread stalls momentarily.

Any idea why this is?

Steven


