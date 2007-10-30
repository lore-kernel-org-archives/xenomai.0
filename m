Message-ID: <47279853.9050704@domain.hid>
Date: Tue, 30 Oct 2007 13:47:15 -0700
From: Dennis Nguyen <dennisnguy@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Xenomai loading module error when running xero-test
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

Hello,
I'm using linux kernel i386 2.6.20.10, xenomai 2.4-rc5, 
adeos-ipipe-2.6.20-i386-1.10.10.patch.
I got errors when running xenoo-test:
FATAL: Error inserting xeno_nucleus 
(/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko): 
No such device
WARNING: Error inserting xeno_nucleus 
(/lib/modules/2.6.20.10/kernel/kernel/xenomai/nucleus/xeno_nucleus.ko): 
No such device
FATAL: Error inserting xeno_posix 
(/lib/modules/2.6.20.10/kernel/kernel/xenomai/skins/posix/xeno_posix.ko): 
Unknown symbol in module, or unknown parameter (see dmesg)
Xenomai: POSIX skin or CONFIG_XENO_OPT_PERVASIVE disabled.
(modprobe xeno_posix?)
ERROR: Module xeno_posix does not exist in /proc/modules
ERROR: Module xeno_nucleus does not exist in /proc/modules
I checked the xeno_nucleus.ko and  xeno_posix.ko files in the 
directories and they were there.
Any suggestion please?
I had other PC which run exactly configuration (I copied the .config) 
and the test done successful.
Thanks,
Dennis

