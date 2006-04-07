Message-ID: <4436C5DF.6060005@domain.hid>
Date: Fri, 07 Apr 2006 16:04:47 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] bad/slow TSC hw  detected by  2.6.17-rc1-mm1
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

FYI,

Ive just built 17-rc1-mm1, and noted that the new time-keeping-system
http://lwn.net/Articles/176837/

can now detect the buggy TSC on my GEODE-sc1100 cpu,
and also that its apparently fixable by adding 'idle=poll' to 
kernel-boot-line.

Apr  7 11:42:01 truck kernel: [   19.160016] Kernel command line: 
console=ttyS0,115200n81 root=/dev/nfs 
nfsroot=192.168.42.1:/nfshost/truck 
nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5 initrd=initrd-2.6.17-rc1-mm1-sk.img  
BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
Apr  7 11:42:01 truck kernel: [   24.314851] Time: tsc clocksource has 
been installed.
Apr  7 11:42:01 truck kernel: [   29.977802] TSC appears to be running 
slowly. Marking it as unstable
Apr  7 11:42:01 truck kernel: [   20.460000] Time: pit clocksource has 
been installed.

Apr  7 12:35:56 truck kernel: [   21.562573] Kernel command line: 
console=ttyS0,115200n81 root=/dev/nfs 
nfsroot=192.168.42.1:/nfshost/truck 
nfsaddrs=192.168.42.100:192.168.42.1:192.168.42.1:255.255.255.0:soekris:eth0 
panic=5 initrd=initrd-2.6.17-rc1-mm1-sk.img idle=poll 
BOOT_IMAGE=vmlinuz-2.6.17-rc1-mm1-sk
Apr  7 12:35:56 truck kernel: [   21.563049] using polling idle threads.
Apr  7 12:35:56 truck kernel: [   28.393469] Time: tsc clocksource has 
been installed.


hope this is useful,
jimc

