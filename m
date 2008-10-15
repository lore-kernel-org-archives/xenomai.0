From: "Fritschek Rick" <rfrit@domain.hid>
Date: Wed, 15 Oct 2008 14:33:08 +0200
Message-Id: <20081015121228.M34584@domain.hid>
MIME-Version: 1.0
Content-Type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai-help] Pc-freeze with kernel 2.6.26.5 under Ubuntu
Reply-To: Rick.Fritschek@domain.hid
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

<HTML>
<HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" http-equiv=3DContent-Type>
<META content=3D"OPENWEBMAIL" name=3DGENERATOR>
</HEAD>
<BODY bgColor=3D#ffffff>
Hello
<br />
<br />Like the topic, i am using Kernel 2.6.26.5(vanilla kernel) with the p=
atch: adeos-ipipe-2.6.26-x86-2.0-13 and xenomai version 2.4.5.
<br />I followed the HowTo : http://www.xenomai.org/index.php/Xenomai_quick=
_build_quide .
<br />Os is Ubuntu 8.04.
<br />
<br />i've disabled this in .config
<br />
<ul>
<li> CONFIG_CPU_FREQ: This allows the CPU frequency to be modulated
with workload, but many CPUs change the TSC counting frequency also,
which makes it useless for accurate timing when the CPU clock can
change. Also some CPUs can take several milliseconds to ramp up to full
speed.
</li>
<li> CONFIG_APM: The APM model assigns power management control
to the BIOS, and BIOS code is never written with RT-latency in mind. If
configured, APM routines are invoked with SMI priority, which breaks
the rule that adeos-ipipe must be in charge of such things.
CONFIG_XENO_HW_SMI_WORKAROUND_* doesn't help here.
</li>
<li> CONFIG_ACPI_PROCESSOR: For systems with ACPI support in the
BIOS, this ACPI sub-option installs an 'idle' handler that uses ACPI C2
and C3 processor states to save power. The CPU must 'warm-up' from
these sleep states, increasing latency in ways dependent upon both the
BIOS's ACPI tables and code. You may be able to suppress the sleeping
with 'idle=3Dpoll' boot-arg, test to find out. With recents versions of
Linux (probably starting around Linux 2.6.21), the acpi processor
module disables the local APIC when loaded. This will cause Xenomai
timer initialization to fail. This makes a second reason for disabling
this option.
</li>
<li> CONFIG_INPUT_PCSPKR (<i>only</i> if i386 &amp;&amp; kernel 2.6 &amp;&a=
mp; no TSC available): Collides with Xenomai's TSC emulation on oldish x86 =
systems.
</li>
</ul>
I've tried it with and without mtrr. (because i found something about freez=
es in xenomai with mtrr and xserver)
<br />but there are no changes.
<br />My PC boot correct, but freezes randomly when the x-server ist starte=
d .
<br />Sometimes in GDM when i want to login, sometimes in browser or when i=
 just compile a new kernel.
<br />It seems that there is no specific action , that causes the freeze.
<br />And i dont know, how i can find out.
<br />kern.log messages gave me no hint about the problem.
<br />
<br />My question ist now, if there is any known problem, that causes such =
freezes with my configuration(kernel-xenomai-adeos versions).
<br />And if anybody maybe had something similar and knows already a soluti=
on for the problem.
<br />Maybe ubuntu makes problems associated with vanilla kernel and xenoma=
i.
<br />
<br />I can post dmesg or .config=A0 if you want.
<br />
<br />regards=20
<br />
<br />Rick
<br />


</BODY>
</HTML>


