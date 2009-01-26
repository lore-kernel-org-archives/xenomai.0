MIME-Version: 1.0
Date: Sun, 25 Jan 2009 22:58:57 -0800
Message-ID: <894886ec0901252258t12cef21dv863a921b10c042a1@domain.hid>
From: Rob Wheeler <wheeler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] ata revalidation failed?
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

We have a robot platform with 4 identical computers installed in its
base.  Three of the computers are running an ubuntu 8.04 server
distribution.  The fourth machine is running Xenomai 2.4.5 with a
2.6.24.3 kernel.  The Xenomai machine is used to send controls to the
robot's motors at a 1KHz frequency.  Sporadically, the Xenomai machine
locks up and we can no longer ping it from the outside world and the
control program appears to no longer be running.  Unfortunately, this
particular HW platform does not have a serial connection.  In the
meantime, we've connected an LCD monitor to the Xenomai machine, and
when it locked up, we noticed the following messages:

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:89:f0:6b/00:00:00:00:00/e0 tag 0 dma 4096 out
ata3.00: status: {DRDY}
ata3.00: revalidation failed (errno=-5)

This usually repeats a small number of times on the monitor, but the
computer is otherwise non-responsive (cannot even use keyboard
connected directly to the computer).  This revalidation error seems
somewhat reoccurring, however, there are occasionally other messages
that popup, such as:

Buffer I/O error on device sda1, logical block 884241

We've been able to reproduce this problem on multiple instances of
this same make of computer running Xenomai, but never on the same HW
platform running a vanilla kernel.

Anyone have any ideas or suggestions on how to track this one down?

-R

