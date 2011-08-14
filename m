MIME-Version: 1.0
Date: Sun, 14 Aug 2011 19:35:36 +0200
Message-ID: <CAKvQZ_1pNxqhW_6jXyzEgaq9foymv2UhLKj-1eOu_FvJdDi9rg@domain.hid>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=0015176f0d7008757304aa7a9305
Subject: [Xenomai-help] Difficulties with xeno_can_isa module
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

--0015176f0d7008757304aa7a9305
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I was using sja1000_isa module on a PC 104 CPU+CAN stack under a normal
linux. For some reasons I would like to use xenomai instead of linux, so I
tried to switch from sja1000_isa to xeno_can_isa to have the equivalent rtdm
driver.

The command line I used before was :
modprobe sja1000_isa irq=10,10 mem=0xD0000,0xD0200 ocr=0x5e,0x5e cdr=0,0
So I was accessing it via iomem.

I had a quick look at xeno_can_isa, but it only support ioport access. I
think my board doesn't support this (
http://www.ixxat.com/pc_i_04_104_en.html for details), but I must admit this
mem vs port access are not very clear to me.

Does this mean that I have no chance to find a rt driver for my isa board ?
If so, Is it conceivable to extend the current driver ? (knowing that I am
really not at ease with this low level developement)
Do I a trick to use port instead of mem for my hardware ?

--0015176f0d7008757304aa7a9305
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,<br><br>I was using sja1000_isa module on a PC 104 CPU+CAN stack und=
er a normal linux. For some reasons I would like to use xenomai instead of =
linux, so I tried to switch from sja1000_isa to xeno_can_isa to have the eq=
uivalent rtdm driver.<br>
<br>The command line I used before was :<br>modprobe sja1000_isa irq=3D10,1=
0 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e cdr=3D0,0<br>So I was accessing it =
via iomem.<br><br>I had a quick look at xeno_can_isa, but it only support i=
oport access. I think my board doesn&#39;t support this (<a href=3D"http://=
www.ixxat.com/pc_i_04_104_en.html">http://www.ixxat.com/pc_i_04_104_en.html=
</a> for details), but I must admit this mem vs port access are not very cl=
ear to me. <br>
<br>Does this mean that I have no chance to find a rt driver for my isa boa=
rd ?<br>If so, Is it conceivable to extend the current driver ? (knowing th=
at I am really not at ease with this low level developement)<br>Do I a tric=
k to use port instead of mem for my hardware ?<br>
<br><br><div style=3D"visibility: hidden; left: -5000px; position: absolute=
; z-index: 9999; padding: 0px; margin-left: 0px; margin-top: 0px; overflow:=
 hidden; word-wrap: break-word; color: black; font-size: 10px; text-align: =
left; line-height: 130%;" id=3D"avg_ls_inline_popup">
</div>

--0015176f0d7008757304aa7a9305--

