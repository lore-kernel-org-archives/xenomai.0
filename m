From: "Jonas Witt" <Jonas@domain.hid>
Date: Tue, 15 May 2007 00:17:34 +0200
Message-ID: <002701c79675$ac700130$c67ba8c0@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0028_01C79686.6FF8D130"
Subject: [Xenomai-help] Booting fails: Kernel panic
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

This is a multi-part message in MIME format.

------=_NextPart_000_0028_01C79686.6FF8D130
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

=20

i thought that it would be better if i started a new thread for this:

=20

I have some trouble with getting xenomai to run on a PC/104 device with =
AMD
Geode GX processor (Debian 4.0 is installed). My development platform =
which
is running a Athlon64 (with Kubuntu 6.06) is already doing fine. For =
testing
purposes i tried using the same kernel-bulid (2.6.20.11 kernel with =
2.3.1
xenomai) for both by selecting a 486-processor in the menuconfig. It =
works
on my Athlon64 but on the PC/104 after copying the files i cannot boot. =
On
the first boot it said directly that xenomai failed to load (and all the
RT-interfaces after that).. all with errorcode -19. I am not able to
reproduce that output, though. After that i turned off APIC to see if it
changes something and then i got further in the boot process but now
stopping with:

=20

/bin/dash: error while loading shared libraries: libc.so.6: cannot open
shared object file: No such file or directory

=20

Now it does not seem to change anything whether the ,noapic' parameter =
is
passed to the kernel or not, though. This is all kind of strange, =
because i
already had xenomai running successfully on that platform, but i am not =
able
to get it running again.. (in other kernel building attempts the system
booted but xenomai was not loaded (in /proc was no xenomai folder) and =
yes..
i did boot the right kernel).=20

=20

The PC/104 has a 500Mhz AMD Geode GX processor and 512MB Ram. It uses a =
1GB
Flashdisk that is plugged in via the IDE port (shows up as hda). To =
build
the xenomai-kernel i modified the config from the running Debian 4.0 =
system.

=20

Could a problem stem from the fact that i copied the files to that =
machine
and did not build them on the same machine?

=20

I really hope someone can help me with this..=20

Thanks in advance!

=20

Jonas


------=_NextPart_000_0028_01C79686.6FF8D130
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">


<meta name=3DGenerator content=3D"Microsoft Word 10 (filtered)">

<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailFormatvorlage17
	{font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 70.85pt 2.0cm 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DDE link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Hello everyone,</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>i thought that it would be better if i started a new =
thread for
this:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I have some trouble with getting xenomai to run on a =
PC/104 device
with AMD Geode GX processor (Debian 4.0 is installed). My development =
platform which
is running a Athlon64 (with Kubuntu 6.06) is already doing fine. For =
testing purposes
i tried using the same kernel-bulid (2.6.20.11 kernel with 2.3.1 =
xenomai) for both
by selecting a 486-processor in the menuconfig. It works on my Athlon64 =
but on the
PC/104 after copying the files i cannot boot. On the first boot it said =
directly
that xenomai failed to load (and all the RT-interfaces after that).. all =
with errorcode
-19. I am not able to reproduce that output, though. After that i turned =
off
APIC to see if it changes something and then i got further in the boot =
process but
now stopping with:</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>/bin/dash: error while loading shared libraries: =
libc.so.6: cannot
open shared object file: No such file or directory</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Now it does not seem to change anything whether the =
&#8218;noapic&#8217;
parameter is passed to the kernel or not, though. This is all kind of =
strange, because
i already had xenomai running successfully on that platform, but i am =
not able
to get it running again.. (in other kernel building attempts the system =
booted but
xenomai was not loaded (in /proc was no xenomai folder) and yes.. i did =
boot the
right kernel). </span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>The PC/104 has a 500Mhz AMD Geode GX processor and =
512MB Ram.
It uses a 1GB Flashdisk that is plugged in via the IDE port (shows up as =
hda).
To build the xenomai-kernel i modified the config from the running =
Debian 4.0
system.</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Could a problem stem from the fact that i copied the =
files
to that machine and did not build them on the same =
machine?</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>I really hope someone can help me with this.. =
</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Thanks in advance!</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>&nbsp;</span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3DArial><span =
style=3D'font-size:12.0pt;
font-family:Arial'>Jonas</span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0028_01C79686.6FF8D130--


