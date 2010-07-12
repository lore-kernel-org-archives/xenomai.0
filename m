Message-ID: <4C3ADF54.1080507@domain.hid>
Date: Mon, 12 Jul 2010 11:24:36 +0200
From: Oliver Clugnet <oliver.clugnet@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Segmentation fault
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

I am trying to get the xenomai user-space programs to work on an x86 
embedded system with a uClibc Buildroot root filesystem.
I have patched a kernel, activated the Xenomai sub-system, and 
cross-compiled it with the Buildroot uClibc toolchain as well as the 
userspace programs. The system boots alright with the Xenomai nucleus 
and everything ("dmesg | grep Xenomai" shows that Xenomai is initialised).
But everytime I try to launch a program (cyclictest, clocktest, ...), I 
get a segmentation fault with a kernel error message such as: 
"clocktest[149] general protection ip:804cc22 sp:bfa29594 error:0 in 
clocktest[8048000+7000]".
A possibility I've been looking at is that maybe the programs try to 
access the High Memory, even though /proc/meminfo shows that there is 
none on this system ("HighTotal 0k"), thus the segmentation fault. I 
might add that the system has a 500Mb memory.
Could the High Memory be the problem? Is there a way of getting around it?
Or could the problem be elsewhere?

Regards,

Oliver Clugnet

