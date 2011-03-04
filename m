MIME-Version: 1.0
Date: Fri, 4 Mar 2011 08:39:44 -0500
Message-ID: <AANLkTinnqCe1aJzfsJMGApD2De7NAk1hhOYAWqKdJfAL@mail.gmail.com>
From: Jeff Hyams <jeff.hyams@domain.hid>
Content-Type: multipart/alternative; boundary=0016364edcba66f039049da84751
Subject: [Xenomai-help] xenomai patched kernel "laggy"
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--0016364edcba66f039049da84751
Content-Type: text/plain; charset=ISO-8859-1

I am running a patched 2.6.32.20 kernel with the correct xenomai patches
(2.5.5.2 and the adeos patch for 2.6.32.20) and my RT application seems to
work fine, I can use the PEAK CAN drivers fine, and I managed to make a
config where all my interrupts work.  However, when using the machine
without any real time apps running, I start to see a lot of latency in
normal use.  Ie, a regular compile operation that normally takes a few
seconds all the sudden takes a minute, and my i/o also seems incredibly
slow.  The display also seems lag frequently.

I have been trying to track down the problem for a while now, but I am not
seeing any specific error messages in any of the syslogs or anywhere, and
the machine does not completely hang or anything.  I was wondering if anyone
had any advice on where to look next?

I'm running on a dual quad core 64 bit Xeon machine with an nvidia Quadro fx
4800, a dual channel PEAK CAN card, 2 dual channel network adapters, and a
dual channel firewire card.

For reference,  I did an install of the Ubuntu 10.04 iso, then basically
followed the instructions referenced here:
http://www.xenomai.org/index.php/Building_Debian_packages.    With the
additional caveat of doing an apt-get purge on nvidia-current and the an
apt-get install on nvidia-current to get the proprietary nvidia driver to
work with the new kernel.

Any help would be greatly appreciated.

Thanks,

Jeff Hyams

--0016364edcba66f039049da84751
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am running a patched 2.6.32.20 kernel with the correct xenomai patches (2=
.5.5.2 and the adeos patch for 2.6.32.20) and my RT application seems to wo=
rk fine, I can use the PEAK CAN drivers fine, and I managed to make a confi=
g where all my interrupts work.=A0 However, when using the machine without =
any real time apps running, I start to see a lot of latency in normal use.=
=A0 Ie, a regular compile operation that normally takes a few seconds all t=
he sudden takes a minute, and my i/o also seems incredibly slow.=A0 The dis=
play also seems lag frequently.<br>
<br>I have been trying to track down the problem for a while now, but I am =
not seeing any specific error messages in any of the syslogs or anywhere, a=
nd the machine does not completely hang or anything.=A0 I was wondering if =
anyone had any advice on where to look next?<br>
<br>I&#39;m running on a dual quad core 64 bit Xeon machine with an nvidia =
Quadro fx 4800, a dual channel PEAK CAN card, 2 dual channel network adapte=
rs, and a dual channel firewire card.=A0 <br><br>For reference,=A0 I did an=
 install of the Ubuntu 10.04 iso, then basically followed the instructions =
referenced here:=A0 <a href=3D"http://www.xenomai.org/index.php/Building_De=
bian_packages">http://www.xenomai.org/index.php/Building_Debian_packages</a=
>.=A0=A0=A0 With the additional caveat of doing an apt-get purge on nvidia-=
current and the an apt-get install on nvidia-current to get the proprietary=
 nvidia driver to work with the new kernel.<br>
<br>Any help would be greatly appreciated.<br><br>Thanks,<br><br>Jeff Hyams=
<br>

--0016364edcba66f039049da84751--

