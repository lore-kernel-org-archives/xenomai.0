MIME-Version: 1.0
Date: Thu, 29 Nov 2012 22:44:30 +0530
Message-ID: <CAMgy_J0idydJq8wzH3CwQoCa+BEbSyUyOJoWmvwc+oAB3jpZ6w@mail.gmail.com>
From: Shamju Joseph <shamju.joseph@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] Frustrating experience with Xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi all,

(1) I had a frustrating experience with Xenomai. I tried to install
different combinations of Xenomai and Linux kernels. Some had compiling
error, some combination compiles but doesn't boot, some boots but doesn't
show up properly on 'dmesg | grep Xenomai' and some boots perfect but PC
hung when run Xenomai test programs like latency.

(2) When we install standard Linux distributions like RHEL & Fedora, the
distribution will take care about installing the right device drivers for
the PC. But when we install vanilla kernel patched with Xenomai, how do we
ensure that the right drivers were installed? Is there any standard
procedure to do this?

(3) I get the build errors like the following with most of the kernel &
Xenomai combinations. But PC boots OK most of the time with this new
patched kernel.

#make modules_install install

ERROR: modinfo: could not find module twofish

ERROR: modinfo: could not find module twofish_common

ERROR: modinfo: could not find module dell_wmi

ERROR: modinfo: could not find module wmi

ERROR: modinfo: could not find module video

Are the problems mentioned above in (1) due to this?

(4) I have listed below different combinations I tried and the result for
the reference (On Dell laptop - Precision M4500, core i5 processor, RHEL 6).

a) linux-2.6.34.5 with xenomai-2.5.6

==> Can't boot

b) linux-2.6.35.9. with xenomai-2.5.6

On booting, the message appears
"MP-BIOS bug: 8254 timer not connected to IO-APIC",
But booted, and Laptop is hung on running latency.

c) linux-2.6.37 with xenomai-2.5.6

On booting, the message appears

"MP-BIOS bug: 8254 timer not connected to IO-APIC", But booted.

But shows only one cpu core instead of 4 cores! (on cat /proc/cpuinfo)

d) linux-2.6.35.9 with xenomai-2.6.0

On booting, the message appears

"MP-BIOS bug: 8254 timer not connected to IO-APIC", But booted.

Laptop hung on running Xenomai test programs

[giving "noapic" as kernel boot argument also did n't help]

e) linux-2.6.38.8 with xenomai-2.6.1

==> Can't boot
(5) I also tried with other PCs (Core duo / Pentium / with FC8) and had
same experience.
Can somebody please give some suggestions?

-Shamju Joseph
