From: "Fritschek Rick" <rfrit@domain.hid>
Date: Thu, 16 Oct 2008 16:15:31 +0200
Message-Id: <20081016140048.M69240@domain.hid>
In-Reply-To: <48F73EC6.6010000@domain.hid>
References: <20081015121228.M34584@domain.hid>
	<48F601EA.4090500@domain.hid>
	<20081016113943.M4807@domain.hid>
	<48F73EC6.6010000@domain.hid>
MIME-Version: 1.0
Content-Type: text/html;
	charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Pc-freeze with kernel 2.6.26.5 under Ubuntu
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
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

<HTML>
<HEAD>
<META content=3D"text/html; charset=3Diso-8859-1" http-equiv=3DContent-Type>
<META content=3D"OPENWEBMAIL" name=3DGENERATOR>
</HEAD>
<BODY bgColor=3D#ffffff>

<font size=3D"2"><b>On Thu, 16 Oct 2008 15:16:54 +0200, Jan Kiszka wrote</b>
<br />&gt; Fritschek=20
Rick wrote:=20
<br />&gt;=20

&gt; *Hello Jan=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20

&gt; On Wed, 15 Oct 2008 16:44:58 +0200, Jan Kiszka wrote*=20
<br />&gt;=20

&gt; =A0&gt; Fritschek Rick wrote:=20
<br />&gt;=20

&gt; =A0&gt; &gt; Hello=20
<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; Like the topic, i am using Kernel 2.6.26.5(vanilla kernel=
)=20
with the patch:=20
<br />&gt;=20

&gt; =A0&gt; &gt; adeos-ipipe-2.6.26-x86-2.0-13 and xenomai version 2.4.5.=
=20

<br />&gt;=20

&gt; =A0&gt; &gt; I followed the HowTo :=20=20
<br />&gt;=20

&gt; <a target=3D"_blank" href=3D"http://www.xenomai.org/index.php/Xenomai_=
quick_build_quide">http://www.xenomai.org/index.php/Xenomai_quick_build_qui=
de</a> .=20

<br />&gt;=20

&gt; =A0&gt; &gt; Os is Ubuntu 8.04.=20
<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; i've disabled this in .config=20
<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 * CONFIG_CPU_FREQ: This allows the CPU=20
frequency to be modulated with=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 workload, but many CPUs change the TSC=20
counting frequency also, which=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 makes it useless for accurate timing=20
when the CPU clock can change. Also=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 some CPUs can take several=20
milliseconds to ramp up to full speed.=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 * CONFIG_APM: The APM model assigns power=20
management control to the BIOS,=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 and BIOS code is never written with=20
RT-latency in mind. If=20=20
<br />&gt;=20

&gt; configured, APM=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 routines are invoked with SMI=20
priority, which breaks the rule that=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 adeos-ipipe must be in charge of such=20
things.=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 CONFIG_XENO_HW_SMI_WORKAROUND_*=20
doesn't help here.=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 * CONFIG_ACPI_PROCESSOR: For systems with=20
ACPI support in the BIOS, this=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 ACPI sub-option installs an 'idle'=20
handler that uses ACPI C2 and C3=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 processor states to save power. The=20
CPU must 'warm-up' from these sleep=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 states, increasing latency in ways=20
dependent upon both the BIOS's ACPI=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 tables and code. You may be able to=20
suppress the sleeping with=20=20
<br />&gt;=20

&gt; 'idle=3Dpoll'=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 boot-arg, test to find out. With=20
recents versions of Linux (probably=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 starting around Linux 2.6.21), the=20
acpi processor module disables the=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 local APIC when loaded. This will=20
cause Xenomai timer initialization to=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 fail. This makes a second reason for=20
disabling this option.=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 * CONFIG_INPUT_PCSPKR (/only/ if i386=20
&amp;&amp; kernel 2.6 &amp;&amp; no TSC available):=20
<br />&gt;=20

&gt; =A0&gt; &gt; =A0 =A0 =A0 Collides with Xenomai's TSC emulation=20
on oldish x86 systems.=20
<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; I've tried it with and without mtrr. (because i found=20
something about=20=20
<br />&gt;=20

&gt; freezes in=20
<br />&gt;=20

&gt; =A0&gt; &gt; xenomai with mtrr and xserver)=20
<br />&gt;=20

&gt; =A0&gt; &gt; but there are no changes.=20
<br />&gt;=20

&gt; =A0&gt; &gt; My PC boot correct, but freezes randomly when the x-serve=
r=20
ist started .=20
<br />&gt;=20

&gt; =A0&gt; &gt; Sometimes in GDM when i want to login, sometimes in brows=
er=20
or when i just=20
<br />&gt;=20

&gt; =A0&gt; &gt; compile a new kernel.=20
<br />&gt;=20

&gt; =A0&gt; &gt; It seems that there is no specific action , that causes t=
he=20
freeze.=20
<br />&gt;=20

&gt; =A0&gt; &gt; And i dont know, how i can find out.=20
<br />&gt;=20

&gt; =A0&gt; &gt; kern.log messages gave me no hint about the problem.=20

<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; My question ist now, if there is any known problem, that=
=20
causes such freezes=20
<br />&gt;=20

&gt; =A0&gt; &gt; with my configuration(kernel-xenomai-adeos versions).=20

<br />&gt;=20

&gt; =A0&gt; &gt; And if anybody maybe had something similar and knows=20
already a solution for=20=20
<br />&gt;=20

&gt; the=20
<br />&gt;=20

&gt; =A0&gt; &gt; problem.=20
<br />&gt;=20

&gt; =A0&gt; &gt; Maybe ubuntu makes problems associated with vanilla kerne=
l=20
and xenomai.=20
<br />&gt;=20

&gt; =A0&gt; &gt;=20
<br />&gt;=20

&gt; =A0&gt; &gt; I can post dmesg or .config =A0if you want.=20
<br />&gt;=20

&gt; =A0&gt;=20
<br />&gt;=20

&gt; =A0&gt; Both would help, ideally also a kernel log captured via serial=
=20
console=20
<br />&gt;=20

&gt; =A0&gt; (in case there is some oops around the lock-up). Also, can you=
=20
confirm=20
<br />&gt;=20

&gt; =A0&gt; that your system is not tained, only GPL drivers are involved?=
=20
I'm=20
<br />&gt;=20

&gt; =A0&gt; specifically thinking of graphic drivers...=20
<br />&gt;=20

&gt; =A0&gt;=20
<br />&gt;=20

&gt; =A0&gt; Jan=20
<br />&gt;=20

&gt; =A0&gt;=20
<br />&gt;=20

&gt; =A0&gt; --=20
<br />&gt;=20

&gt; =A0&gt; Siemens AG, Corporate Technology, CT SE 2=20
<br />&gt;=20

&gt; =A0&gt; Corporate Competence Center Embedded Linux=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20

&gt; my .config :=20
<br />&gt;=20

&gt; <a target=3D"_blank" href=3D"http://webuser.hs-furtwangen.de/~rfrit/co=
nfig.txt">http://webuser.hs-furtwangen.de/~rfrit/config.txt</a>=20
<br />&gt;=20

&gt; my dmesg after systemstart:=20
<br />&gt;=20

&gt; <a target=3D"_blank" href=3D"http://webuser.hs-furtwangen.de/~rfrit/dm=
esg.txt">http://webuser.hs-furtwangen.de/~rfrit/dmesg.txt</a>=20
<br />&gt;=20

&gt; cat /proc/cpuinfo :=20
<br />&gt;=20

&gt; <a target=3D"_blank" href=3D"http://webuser.hs-furtwangen.de/~rfrit/cp=
uinfo.txt">http://webuser.hs-furtwangen.de/~rfrit/cpuinfo.txt</a>=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20

&gt; i hope this helps :/=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20

&gt; and xfce said, that im not using =A0proprietary drivers :/=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20

&gt; dont know if i can check this :/=20
<br />&gt;=20

&gt;=20=20
<br />&gt;=20
<br />&gt;=20

Absichtlich oder versehentlich off-list?=20
<br />sorry , war versehentlich :/
<br />&gt;=20
<br />&gt;=20

However, danke soweit, sehe noch nichts. Bliebe die Frage, ob Du eine=20
<br />&gt;=20

serielle Verbindung zur Kernel-Konsole aufbauen und ggf. die Meldungen=20
<br />&gt;=20

beim Lockup einfangen kannst =3D&gt; linux/Documentation/serial-console.txt=
.=20

<br />&gt;=20
<br />&gt;=20

Weitere Testmechanismen: CONFIG_XENOMAI=3Dn (nur IPIPE),=20
<br />&gt;=20

CONFIG_IPIPE_DEBUG_CONTEXT, XENO_HW_NMI_DEBUG_LATENCY.=20
<br />&gt;=20
<br />&gt;=20

Antwort dann bitte wieder mit CC an die Liste.=20
<br />&gt;=20
<br />&gt;=20

Gru=DF,=20
<br />&gt;=20

Jan=20
<br />&gt;=20
<br />&gt;=20

--=20=20
<br />&gt;=20

Siemens AG, Corporate Technology, CT SE 2=20
<br />&gt;=20

Corporate Competence Center Embedded Linux=20

<br />
<br />ok, i tried a few things...and now it seems, that there are no freeze=
s anymore ( 2 hours no freeze )
<br />there is one funny thing...in xfce ...the program for propritary driv=
ers(under system-&gt;hardware drivers) says, that i'm using 'scsi low-level=
 driver for ATA in ACPI mode' ...i deaktivated it(no tick in the box under =
aktive)=A0 but it still says that it is in use . However..it seems , that t=
he system is stable since i made this change.
<br />
<br />so thanks for your advice with the drivers :D
<br />
<br />regards
<br />
<br />Rick
<br />
<br />
<br />
<br />
</font>
</BODY>
</HTML>


