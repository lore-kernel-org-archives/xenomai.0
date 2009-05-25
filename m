MIME-Version: 1.0
In-Reply-To: <878wkkzxba.fsf@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
Date: Tue, 26 May 2009 00:35:49 +0300
Message-ID: <9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5a57bcc7d6d046ac36419
Subject: Re: [Xenomai-help] Driver testing procedure ?!
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Alexis Berlemont <berlemont.hauw@domain.hid>, xenomai@xenomai.org

--001636c5a57bcc7d6d046ac36419
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I finally figured out this aspect but I still have one problem, residing in
the fact that I have no comedi devices in my dev list
and so I cannot ./comedi_config /dev/comedi0 nipcimio !

As I see it there are no comedi devices

/usr/xenomai/sbin # cat /proc/devices
Character devices:
  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
 10 misc
 13 input
 21 sg
128 ptm
136 pts
150 rtpipe
180 usb
189 usb_device
254 usb_endpoint

Block devices:
  1 ramdisk
  7 loop
  8 sd
 31 mtdblock
 65 sd
 66 sd
 67 sd
 68 sd
 69 sd
 70 sd
 71 sd
128 sd
129 sd
130 sd
131 sd
132 sd
133 sd
134 sd
135 sd

and the list

/usr/xenomai/sbin # cat /proc/comedi/devices
--  Comedi devices --

| idx | status | driver
|  00 | Unused | No driver
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver
/usr/xenomai/sbin # cat /proc/comedi/drivers
comedi_config   rtcanconfig     rtps
/usr/xenomai/sbin # cat /proc/comedi/drivers
--  Comedi drivers --

| idx | driver name
|  00 | pcimio
|  01 | comedi_8255
|  02 | comedi_loop
|  03 | comedi_fake

Shouldn't the specific comedi devices be generated when installing Xenomai ?

Best !

On Tue, May 26, 2009 at 12:28 AM, Alexis Berlemont
<berlemont.hauw@domain.hid>wrote:

> Hi,
>
> Cristian Axenie <cristian.axenie@domain.hid> writes:
>
> > Hello!
> > I've took a snapshot of the git tree from Alexis's when he added the
> PCIMIO drivers. I've built my kernel and created an own usbflash filesystem.
> Now what should I do to
> > begin testing the drivers ?
> > The drivers are now kernel built-in and there is no comedi_config
> anymore.
> That is not correct; even if the comedi driver is statically linked into
> the kernel does not mean the comedi layer automatically linked it to a
> specific device. Have a look at the proc file /proc/comedi/devices, you
> will see the devices are initialized unattached in any case.
>
> Nonetheless, you should have had a message, somewhere, telling you such
> thing. I will fix that as soon as possible.
>
> Regards.
>
> Alexis.
>

--001636c5a57bcc7d6d046ac36419
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>I finally figured out this aspect but I still have one problem, =
residing in the fact that I have no comedi devices in my dev list<br>and so=
 I cannot ./comedi_config /dev/comedi0 nipcimio !<br><br>As I see it there =
are no comedi devices <br>
<br>/usr/xenomai/sbin # cat /proc/devices <br>Character devices:<br>=A0 1 m=
em<br>=A0 2 pty<br>=A0 3 ttyp<br>=A0 4 ttyS<br>=A0 5 /dev/tty<br>=A0 5 /dev=
/console<br>=A0 5 /dev/ptmx<br>=A010 misc<br>=A013 input<br>=A021 sg<br>128=
 ptm<br>136 pts<br>
150 rtpipe<br>180 usb<br>189 usb_device<br>254 usb_endpoint<br><br>Block de=
vices:<br>=A0 1 ramdisk<br>=A0 7 loop<br>=A0 8 sd<br>=A031 mtdblock<br>=A06=
5 sd<br>=A066 sd<br>=A067 sd<br>=A068 sd<br>=A069 sd<br>=A070 sd<br>=A071 s=
d<br>128 sd<br>129 sd<br>
130 sd<br>131 sd<br>132 sd<br>133 sd<br>134 sd<br>135 sd<br><br>and the lis=
t <br><br>/usr/xenomai/sbin # cat /proc/comedi/devices <br>--=A0 Comedi dev=
ices --<br><br>| idx | status | driver<br>|=A0 00 | Unused | No driver<br>|=
=A0 01 | Unused | No driver<br>
|=A0 02 | Unused | No driver<br>|=A0 03 | Unused | No driver<br>|=A0 04 | U=
nused | No driver<br>|=A0 05 | Unused | No driver<br>|=A0 06 | Unused | No =
driver<br>|=A0 07 | Unused | No driver<br>|=A0 08 | Unused | No driver<br>|=
=A0 09 | Unused | No driver<br>
/usr/xenomai/sbin # cat /proc/comedi/drivers <br>comedi_config=A0=A0 rtcanc=
onfig=A0=A0=A0=A0 rtps <br>/usr/xenomai/sbin # cat /proc/comedi/drivers <br=
>--=A0 Comedi drivers --<br><br>| idx | driver name<br>|=A0 00 | pcimio<br>=
|=A0 01 | comedi_8255<br>
|=A0 02 | comedi_loop<br>|=A0 03 | comedi_fake<br><br>Shouldn&#39;t the spe=
cific comedi devices be generated when installing Xenomai ?<br><br>Best !<b=
r><br><div class=3D"gmail_quote">On Tue, May 26, 2009 at 12:28 AM, Alexis B=
erlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid">be=
rlemont.hauw@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi,<br>
<div class=3D"im"><br>
Cristian Axenie &lt;<a href=3D"mailto:cristian.axenie@domain.hid">cristian.a=
xenie@domain.hid</a>&gt; writes:<br>
<br>
&gt; Hello!<br>
&gt; I&#39;ve took a snapshot of the git tree from Alexis&#39;s when he add=
ed the PCIMIO drivers. I&#39;ve built my kernel and created an own usbflash=
 filesystem. Now what should I do to<br>
&gt; begin testing the drivers ?<br>
&gt; The drivers are now kernel built-in and there is no comedi_config anym=
ore.<br>
</div>That is not correct; even if the comedi driver is statically linked i=
nto<br>
the kernel does not mean the comedi layer automatically linked it to a<br>
specific device. Have a look at the proc file /proc/comedi/devices, you<br>
will see the devices are initialized unattached in any case.<br>
<br>
Nonetheless, you should have had a message, somewhere, telling you such<br>
thing. I will fix that as soon as possible.<br>
<br>
Regards.<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>

--001636c5a57bcc7d6d046ac36419--

