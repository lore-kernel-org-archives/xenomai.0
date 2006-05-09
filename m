Message-ID: <44609FE0.9060206@domain.hid>
Date: Tue, 09 May 2006 15:57:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Xenomai v2.1.1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org, xenomai@xenomai.org


This is the first maintenance release of the v2.1.x branch [1]. The
short log follows:

[blackfin] Major kernel update to uClinux 2.6.16. Port over the BF537
board [2] sponsored by Analog Devices.

[i386] Fix FPU context restore after a domain migration.

[nucleus] Optimize feature selection for message pipe and
registry supports. Optimize fast path for thread
suspension/resumption. Fix GDB access error on mmapped heaps. Fix
error path during module loadup. Check for CAP_SYS_NICE
capability for running Xenomai syscalls.

[posix] Various fixes. shm and registry updates.

[native] Fix deletion of non-current task. Make queue
services more robust when passed garbled buffer addresses.

[scripts] Various fixes and updates.

[16550A] Fix lock leakage. Fix IRQ source detection.

[sim] Fix issues with GCC 4.x.

The Adeos support has been upgraded for all the supported
architectures. Please see the ChangeLog for details.

[1] http://download.gna.org/xenomai/stable/xenomai-2.1.1.tar.bz2
[2] http://www.analog.com/en/prod/0,,ADSP%252DBF537,00.html

-- 

Philippe.


