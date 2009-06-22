Mime-Version: 1.0
Date: Mon, 22 Jun 2009 16:48:49 +0530
Message-ID: <1245669529.7250.3.camel@domain.hid>
From: Shashank Bhatia <shashank.bhatia@domain.hid>
content-type: text/plain
content-transfer-encoding: 7bit
Subject: [Xenomai-core] Problem running klatency test
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai Help <xenomai@xenomai.org>

Dear All,

          I could manage to compile my patched kernel on ubuntu using
the following guide : https://wiki.ubuntu.com/KernelTeam/GitKernelBuild

Now when i installed Xenomai, i could run the latency tests, but when i
tried to run the kernel space latency test, i found the following error.


root@domain.hid# ./run 
*
*
* Type ^C to stop this application.
*
*
open(/proc/xenomai/registry/native/pipes/klat_pipe): No such file or
directory
modprobe klat_mod or try the -P option?



Please help to get this running.


The dmesg | grep Xenomai gave the following output:
[    4.353912] I-pipe: Domain Xenomai registered.
[    4.353949] Xenomai: hal/i386 started.
[    4.354530] Xenomai: real-time nucleus v2.4.8 (Lords Of Karma)
loaded.
[    4.354612] Xenomai: SMI-enabled chipset found
[    4.354623] Xenomai: SMI workaround enabled
[    4.354647] Xenomai: starting native API services.
[    4.354650] Xenomai: starting POSIX services.
[    4.354693] Xenomai: starting RTDM services.



Thanks in advance


-------------------------------------
Hi-Tech Gears Limited, Gurgaon, India





