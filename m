Message-ID: <46FED989.6000402@domain.hid>
Date: Sat, 29 Sep 2007 19:02:33 -0400
From: Brian Zenowich <bz@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Functional difference between tty and xterm?
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

I am using kernel 2.6.20.14 with Xenomai 2.3.1 and the Peak CAN driver 
6.4. This is the only combination I can get to coexist peacefully. I 
have tried 20.18/2.3.3 and 22.9/2.4rc3 but the former fails xeno-test, 
and the latter hangs on boot when loading the Peak driver.

I have a Core2 Duo. Kernel SMP is enabled. SMI/ACPI/APM is all 
configured to make Xenomai happy. User-space Xenomai was NOT configured 
with --enable-smp.

My ncurses-based program runs well from the tty (as root), but if I 
'startx' and try to run my program from an xterm window (still as root), 
it hangs the machine at the moment it calls CAN_Init(). CAN_Init() is 
essentially a call to rt_dev_open("/dev/pcan0", 0_RDWR). I am using a 
PCI CAN card.

I am able to launch my program from the tty, then switch to a new tty 
and startx from there. If I switch back to my program's tty, it is still 
humming along.

Do you have any thoughts as to what is the difference (from a Xenomai 
user-space program's point of view) between running in a tty and running 
in an xterm?

Why would the rt_dev_open() call work from a tty, but not in an xterm?

Thanks for any insight you might have,

-Brian Z.

