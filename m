MIME-Version: 1.0
In-Reply-To: <CAKvQZ_1pNxqhW_6jXyzEgaq9foymv2UhLKj-1eOu_FvJdDi9rg@domain.hid>
References: <CAKvQZ_1pNxqhW_6jXyzEgaq9foymv2UhLKj-1eOu_FvJdDi9rg@domain.hid>
Date: Sun, 14 Aug 2011 23:47:06 +0200
Message-ID: <CAKvQZ_2rhR2O+anYcVQPOVc7HDk-1HxFYOOngF7cST40EViGmQ@mail.gmail.com>
From: Willy Lambert <lambert.willy@domain.hid>
Content-Type: multipart/alternative; boundary=00163646cfc67295c804aa7e169d
Subject: Re: [Xenomai-help] Difficulties with xeno_can_isa module
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org, Wolfgang Grandegger <wg@domain.hid>

--00163646cfc67295c804aa7e169d
Content-Type: text/plain; charset=ISO-8859-1

2011/8/14 Willy Lambert <lambert.willy@domain.hid>

> Hi all,
>
> I was using sja1000_isa module on a PC 104 CPU+CAN stack under a normal
> linux. For some reasons I would like to use xenomai instead of linux, so I
> tried to switch from sja1000_isa to xeno_can_isa to have the equivalent rtdm
> driver.
>
> The command line I used before was :
> modprobe sja1000_isa irq=10,10 mem=0xD0000,0xD0200 ocr=0x5e,0x5e cdr=0,0
> So I was accessing it via iomem.
>
> I had a quick look at xeno_can_isa, but it only support ioport access. I
> think my board doesn't support this (
> http://www.ixxat.com/pc_i_04_104_en.html for details), but I must admit
> this mem vs port access are not very clear to me.
>
> Does this mean that I have no chance to find a rt driver for my isa board ?
> If so, Is it conceivable to extend the current driver ? (knowing that I am
> really not at ease with this low level developement)
> Do I a trick to use port instead of mem for my hardware ?
>
>
>
>From  "Wolfgang Grandegger" <wg@domain.hid> in private (my fault, I
contacted him in private first) :


I'm still puzzled what you intend to do. If you want to use
RT-Socket-CAN for your hardware (using mem= with Linux), then you should
use the driver xeno_can_mem with the same parameters:

 insmod xeno_can_mem.ko irq=10,10 mem=0xD0000,0xD0200 ocr=0x5e,0x5e

The xeno_can_isa.ko is only for I/O port accesses.

Yes, that's it ! I'll try this. It's just that I could not find my way in
the middle of all xeno drivers and choosed isa because it's an ISA bus.

--00163646cfc67295c804aa7e169d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/8/14 Willy Lambert <span dir=3D"ltr=
">&lt;<a href=3D"mailto:lambert.willy@domain.hid">lambert.willy@domain.hid</a=
>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex;">
Hi all,<br><br>I was using sja1000_isa module on a PC 104 CPU+CAN stack und=
er a normal linux. For some reasons I would like to use xenomai instead of =
linux, so I tried to switch from sja1000_isa to xeno_can_isa to have the eq=
uivalent rtdm driver.<br>

<br>The command line I used before was :<br>modprobe sja1000_isa irq=3D10,1=
0 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5e cdr=3D0,0<br>So I was accessing it =
via iomem.<br><br>I had a quick look at xeno_can_isa, but it only support i=
oport access. I think my board doesn&#39;t support this (<a href=3D"http://=
www.ixxat.com/pc_i_04_104_en.html" target=3D"_blank">http://www.ixxat.com/p=
c_i_04_104_en.html</a> for details), but I must admit this mem vs port acce=
ss are not very clear to me. <br>

<br>Does this mean that I have no chance to find a rt driver for my isa boa=
rd ?<br>If so, Is it conceivable to extend the current driver ? (knowing th=
at I am really not at ease with this low level developement)<br>Do I a tric=
k to use port instead of mem for my hardware ?<br>

<br><br></blockquote><div><br>From=A0 &quot;Wolfgang Grandegger&quot; &lt;<=
a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt; in private (m=
y fault, I contacted him in private first) :<br><br><br><div style=3D"margi=
n-left: 40px;">


I&#39;m still puzzled what you intend to do. If you want to use<br>

RT-Socket-CAN for your hardware (using mem=3D with Linux), then you should<=
br>

use the driver xeno_can_mem with the same parameters:<br>

<br>

 =A0insmod xeno_can_mem.ko irq=3D10,10 mem=3D0xD0000,0xD0200 ocr=3D0x5e,0x5=
e<br>

<br>

The xeno_can_isa.ko is only for I/O port accesses. <br></div></div></div><b=
r>Yes, that&#39;s it ! I&#39;ll try this. It&#39;s just that I could not fi=
nd my way in the middle of all xeno drivers and choosed isa because it&#39;=
s an ISA bus.<br>
<br><div style=3D"visibility: hidden; left: -5000px; position: absolute; z-=
index: 9999; padding: 0px; margin-left: 0px; margin-top: 0px; overflow: hid=
den; word-wrap: break-word; color: black; font-size: 10px; text-align: left=
; line-height: 130%;" id=3D"avg_ls_inline_popup">
</div>

--00163646cfc67295c804aa7e169d--

