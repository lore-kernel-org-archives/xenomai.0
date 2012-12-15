MIME-Version: 1.0
Date: Sat, 15 Dec 2012 14:21:39 +0530
Message-ID: <CAMgy_J2Evr-oAZqDiUES2JCa5n8yRqYZzfDpid=T+1nEW6PNqg@mail.gmail.com>
From: Shamju Joseph <shamju.joseph@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Issues with Xenomai on multi core computer
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi

I=92m facing some problem with Xenomai. I have to run kernel patched with
xenomai on a multi core system. (Panasonic laptop with core duo and dell
laptop with core i5 processor) The kernel configuration says =93Warning you
enabled APM, CPU frequency scaling or ACPI processor. These options are
known to cause trouble with xenomai=94. But if I disable ACPI and build
kernel patched with xenomai, I get only one core after booting. (Even if
SMP is selected & max no of CPUs is set ). So I enabled ACPI and built
kernel with xenomai patch. I could boot the kernel and got multiple core
listed in /proc/cpuinfo. But the issue is that when I call xenomai API task
spawn on the second core, program hangs for long time. Also observed lot of
timing variations in the latency test.

I tried with Fedora 14 and RHEL 6 distributions. I used kernel 2.6.37 and
xenomai 2.5.6 versions. The following are the output I got from system.

[gddr@M4500 ~]$ dmesg | grep Xenomai

[    1.665262] I-pipe: Domain Xenomai registered.

[    1.665266] Xenomai: hal/i386 started.

[    1.665285] Xenomai: scheduling class idle registered.

[    1.665287] Xenomai: scheduling class rt registered.

[    1.665719] Xenomai: real-time nucleus v2.5.6 (Wormhole Wizards) loaded.

[    1.665798] Xenomai: SMI-enabled chipset found

[    1.665808] Xenomai: SMI workaround enabled

[    1.665816] Xenomai: starting native API services.

[    1.665817] Xenomai: starting POSIX services.

[    1.665835] Xenomai: starting RTDM services.

[gddr@M4500 ~]$

[gddr@M4500 ~]$ dmesg | grep I-pipe

[    0.000000] I-pipe 2.9-00: pipeline enabled.

[    1.665262] I-pipe: Domain Xenomai registered.

[gddr@M4500 ~]$

I=92ve the following doubts.

1)      How to get xenomai working with multi core processor system?

2)      There are many services like cpuspeed, irqbalance, crond, sendmail,
acpid, pcscd, iscsi etc running in the background by default. Are these
causing some problem with xenomai? What are the essential services required
and what are to be disabled?

3)      Is there any standard or HOWTO document available which explains
the detailed installation steps (kernel configurations to set/clear & Linux
services to enable/disable) for xenomai?

Please help me.
 -Shamju Joseph
