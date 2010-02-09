MIME-Version: 1.0
In-Reply-To: <4bed572e1001080314n4d723074ld77459d1dffc8c3e@domain.hid>
References: <4bed572e0911221135s64fc4726x1cd7235f116e11a4@domain.hid> 
	<4bed572e0912160458i32834958q9512476f1603979d@domain.hid> 
	<4B2BF4D9.6000503@domain.hid>
	<4bed572e1001051015l21e71e8eyaec207701c2e21ad@domain.hid> 
	<4B43BE72.6040101@domain.hid>
	<4bed572e1001060557x12ffd808k193573c565830a1b@domain.hid> 
	<4B450B7E.80106@domain.hid>
	<4bed572e1001071124x55a964f8u22558c05c2a4485c@domain.hid> 
	<4B46590F.2060308@domain.hid>
	<4bed572e1001080314n4d723074ld77459d1dffc8c3e@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Date: Tue, 9 Feb 2010 15:21:30 -0200
Message-ID: <8b216e9e1002090921n61b662ag7a7e7fd6d3d337f4@domain.hid>
Content-Type: multipart/alternative; boundary=001636e0b67d38b686047f2e27d1
Subject: Re: [Xenomai-help] Help on analogy_ni_pcimio (Alexis Berlemont?)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Ettore Pedretti <epedrett@domain.hid>
Cc: xenomai@xenomai.org

--001636e0b67d38b686047f2e27d1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,

I just installed Xenomai 2.5.1, however, I am having the exact same problem
- the computer completely crashes when running analogy_config analogy0
analogy_ni_pcimio. However, I could not get any significant debug info
before the system crashes.

This is the exact behavior I had with Xenomai 2.5.0.

I am running Ubuntu 9.04 on a with a AMD Sempron 2800+ with a National
Instruments 6221-37 DAQ card. Xenomai seems to be running pretty well.

So, is this a known issue? Can I help with the debug messages/logs in any
way?

Thanks for the help,
     -Felipe Brand=E3o Cavalcanti

(Sorry to reply to such an old thread.. but my problem seemed a lot like
this one.)

On Fri, Jan 8, 2010 at 9:14 AM, Ettore Pedretti <epedrett@domain.hid> wrote:

> Hi,
>
> I started from scratch by rebooting the system.
>
> analogy_config analogy0 analogy_ni_pcimio
>
> insn_write (no output)
>
> Relevant error trace:
> Analogy: a4l_rt_open: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_ioctl_devcfg: minor=3D0
> Analogy: a4l_presetup_transfer: minor=3D0
> Analogy: a4l_device_attach: minor=3D0
> Analogy: a4l_fill_lnkdesc: minor=3D0
> Analogy: a4l_lct_drv: name=3Danalogy_ni_pcimio
> Analogy: a4l_assign_driver: minor=3D0
> Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6711 board
> mite 0000:04:01.0: PCI->APIC IRQ transform: INT A -> IRQ 48
> mite 0000:04:01.0: setting latency timer to 64
> Analogy: MITE: 0xd0801000 mapped to f8e26000
> Analogy: DAQ: 0xd0800000 mapped to f8e2a000
> Analogy: MITE: version =3D 1, type =3D 1, mite mode =3D 1, interface mode=
 =3D 3
> Analogy: MITE: num channels =3D 3, write post fifo depth =3D 1, wins =3D =
0,
> iowins =3D 2
> Analogy: analogy_ni_pcimio: pcimio_attach: found irq 48
> Analogy: analogy_ni_pcimio: mio_common: starting attach procedure...
> Analogy: analogy_ni_pcimio: mio_common: registering AI subdevice...
> Analogy: analogy_ni_pcimio: mio_common: AI subdevice not present
> Analogy: analogy_ni_pcimio: mio_common: AI subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering AO subdevice...
> Analogy: analogy_ni_pcimio: mio_common: AO: 4 channels
> Analogy: analogy_ni_pcimio: mio_common: AO subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering DIO subdevice...
> Analogy: analogy_ni_pcimio: mio_common: DIO: 8 channels
> Analogy: analogy_ni_pcimio: mio_common: DIO subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering 8255 subdevice...
> Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice not present
> Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering calib subdevice...
> Analogy: analogy_ni_pcimio: mio_common: calib: common calibration
> Analogy: analogy_ni_pcimio: mio_common: calib subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering EEPROM subdevice...
> Analogy: analogy_ni_pcimio: mio_common: EEPROM: size =3D 512
> Analogy: analogy_ni_pcimio: mio_common: EEPROM subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering PFI(DIO) subdevice...
> Analogy: analogy_ni_pcimio: mio_common: PFI: 10 bits...
> Analogy: analogy_ni_pcimio: mio_common: PFI subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering serial subdevice...
> Analogy: analogy_ni_pcimio: mio_common: serial subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering GPCT[0] subdevice...
> Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: 24 bits
> Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: command feature availabl=
e
> Analogy: analogy_ni_pcimio: mio_common: GCPT[0] subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering GPCT[1] subdevice...
> Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: 24 bits
> Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: command feature availabl=
e
> Analogy: analogy_ni_pcimio: mio_common: GCPT[1] subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: registering counter subdevice...
> Analogy: analogy_ni_pcimio: mio_common: counter subdevice registered
> Analogy: analogy_ni_pcimio: mio_common: initializing AI...
> Analogy: analogy_ni_pcimio: mio_common: AI initialization OK
> Analogy: analogy_ni_pcimio: mio_common: initializing A0...
> Analogy: analogy_ni_pcimio: mio_common: A0 initialization OK
> Analogy: analogy_ni_pcimio: mio_common: DMA setup
> Analogy: analogy_ni_pcimio: mio_common: attach procedure complete
> Analogy: a4l_free_lnkdesc: minor=3D0
> Analogy: a4l_setup_transfer: minor=3D0
> Analogy: a4l_rt_close: minor=3D0
> Analogy: a4l_rt_open: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_ioctl_devinfo: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> ---------------> snip <-----------------
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_reserve_transfer: minor=3D0 idx=3D1
> Analogy: a4l_rt_close: minor=3D0
>
> Then typed:
> cmd_write
> cmd_write: triggering failed (ret=3D-16)
>
> error trace:
>
> Analogy: a4l_rt_open: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> ---------------> snip <-----------------
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_ioctl_cancel: subdevice currently idle
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: a4l_ioctl_cmd: minor=3D0
> Analogy: a4l_fill_cmddesc: desc dump
> Analogy:        ->idx_subd=3D1
> Analogy:        ->flags=3D0
> Analogy:        ->nb_chan=3D2
> Analogy:        ->chan_descs=3D0x0
> Analogy:        ->data_len=3D0
> Analogy:        ->pdata=3D0x(null)
> Analogy: a4l_check_cmddesc: minor=3D0
> Analogy: a4l_ioctl_cmd: 1st cmd checks passed
> Analogy: a4l_ioctl_cmd: driver's cmd checks passed
> Analogy: a4l_reserve_transfer: minor=3D0 idx=3D1
> Analogy: a4l_init_transfer: minor=3D0 idx=3D1
> Analogy: a4l_rt_write: minor=3D0
> Analogy: a4l_rt_ioctl: minor=3D0
> Analogy: analogy_ni_pcimio: ni_request_ao_mite_channel: failed to
> reserve mite dma channel for analog outut.
> Analogy: a4l_rt_close: minor=3D0
>
> Hope this helps
> Ettore
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>



--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

--001636e0b67d38b686047f2e27d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hello,</div><div><br></div><div>I just installed Xenomai 2.5.1, howeve=
r, I am having the exact same problem - the computer completely crashes whe=
n running=A0analogy_config analogy0 analogy_ni_pcimio. However, I could not=
 get any significant debug info before the system crashes.</div>

<div><br></div><div>This is the exact behavior I had with Xenomai 2.5.0.</d=
iv><div><br></div><div>I am running Ubuntu 9.04 on a with a AMD Sempron 280=
0+ with a National Instruments=A0<span class=3D"Apple-style-span" style=3D"=
font-family: Helvetica; font-size: 12px; ">6221-37 DAQ card. Xenomai seems =
to be running pretty well.</span></div>

<div><font class=3D"Apple-style-span" face=3D"Helvetica" size=3D"3"><span c=
lass=3D"Apple-style-span" style=3D"font-size: 12px;"><br></span></font></di=
v><div><font class=3D"Apple-style-span" face=3D"Helvetica" size=3D"3"><span=
 class=3D"Apple-style-span" style=3D"font-size: 12px;">So, is this a known =
issue? Can I help with the debug messages/logs in any way?</span></font></d=
iv>

<div><font class=3D"Apple-style-span" face=3D"Helvetica" size=3D"3"><span c=
lass=3D"Apple-style-span" style=3D"font-size: 12px;"><br></span></font></di=
v><div><font class=3D"Apple-style-span" face=3D"Helvetica" size=3D"3"><span=
 class=3D"Apple-style-span" style=3D"font-size: 12px;">Thanks for the help,=
</span></font></div>

<div><font class=3D"Apple-style-span" face=3D"Helvetica" size=3D"3"><span c=
lass=3D"Apple-style-span" style=3D"font-size: 12px;">=A0=A0 =A0 -Felipe Bra=
nd=E3o Cavalcanti</span></font></div><div><br></div><div>(Sorry to reply to=
 such an old thread.. but my problem seemed a lot like this one.)</div>

<br><div class=3D"gmail_quote">On Fri, Jan 8, 2010 at 9:14 AM, Ettore Pedre=
tti <span dir=3D"ltr">&lt;<a href=3D"mailto:epedrett@domain.hid">epedrett@domain.hid=
ail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

Hi,<br>
<br>
I started from scratch by rebooting the system.<br>
<div class=3D"im"><br>
analogy_config analogy0 analogy_ni_pcimio<br>
<br>
</div>insn_write (no output)<br>
<br>
Relevant error trace:<br>
Analogy: a4l_rt_open: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_ioctl_devcfg: minor=3D0<br>
Analogy: a4l_presetup_transfer: minor=3D0<br>
Analogy: a4l_device_attach: minor=3D0<br>
Analogy: a4l_fill_lnkdesc: minor=3D0<br>
Analogy: a4l_lct_drv: name=3Danalogy_ni_pcimio<br>
Analogy: a4l_assign_driver: minor=3D0<br>
Analogy: analogy_ni_pcimio: pcimio_attach: found pci-6711 board<br>
<div class=3D"im">mite 0000:04:01.0: PCI-&gt;APIC IRQ transform: INT A -&gt=
; IRQ 48<br>
mite 0000:04:01.0: setting latency timer to 64<br>
</div>Analogy: MITE: 0xd0801000 mapped to f8e26000<br>
Analogy: DAQ: 0xd0800000 mapped to f8e2a000<br>
Analogy: MITE: version =3D 1, type =3D 1, mite mode =3D 1, interface mode =
=3D 3<br>
Analogy: MITE: num channels =3D 3, write post fifo depth =3D 1, wins =3D 0,=
 iowins =3D 2<br>
Analogy: analogy_ni_pcimio: pcimio_attach: found irq 48<br>
Analogy: analogy_ni_pcimio: mio_common: starting attach procedure...<br>
Analogy: analogy_ni_pcimio: mio_common: registering AI subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: AI subdevice not present<br>
Analogy: analogy_ni_pcimio: mio_common: AI subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering AO subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: AO: 4 channels<br>
Analogy: analogy_ni_pcimio: mio_common: AO subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering DIO subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: DIO: 8 channels<br>
Analogy: analogy_ni_pcimio: mio_common: DIO subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering 8255 subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice not present<br>
Analogy: analogy_ni_pcimio: mio_common: 8255 subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering calib subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: calib: common calibration<br>
Analogy: analogy_ni_pcimio: mio_common: calib subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering EEPROM subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: EEPROM: size =3D 512<br>
Analogy: analogy_ni_pcimio: mio_common: EEPROM subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering PFI(DIO) subdevice...<b=
r>
Analogy: analogy_ni_pcimio: mio_common: PFI: 10 bits...<br>
Analogy: analogy_ni_pcimio: mio_common: PFI subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering serial subdevice...<br>
Analogy: analogy_ni_pcimio: mio_common: serial subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering GPCT[0] subdevice...<br=
>
Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: 24 bits<br>
Analogy: analogy_ni_pcimio: mio_common: GPCT[0]: command feature available<=
br>
Analogy: analogy_ni_pcimio: mio_common: GCPT[0] subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering GPCT[1] subdevice...<br=
>
Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: 24 bits<br>
Analogy: analogy_ni_pcimio: mio_common: GPCT[1]: command feature available<=
br>
Analogy: analogy_ni_pcimio: mio_common: GCPT[1] subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: registering counter subdevice...<br=
>
Analogy: analogy_ni_pcimio: mio_common: counter subdevice registered<br>
Analogy: analogy_ni_pcimio: mio_common: initializing AI...<br>
Analogy: analogy_ni_pcimio: mio_common: AI initialization OK<br>
Analogy: analogy_ni_pcimio: mio_common: initializing A0...<br>
Analogy: analogy_ni_pcimio: mio_common: A0 initialization OK<br>
Analogy: analogy_ni_pcimio: mio_common: DMA setup<br>
Analogy: analogy_ni_pcimio: mio_common: attach procedure complete<br>
Analogy: a4l_free_lnkdesc: minor=3D0<br>
Analogy: a4l_setup_transfer: minor=3D0<br>
Analogy: a4l_rt_close: minor=3D0<br>
Analogy: a4l_rt_open: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_ioctl_devinfo: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
---------------&gt; snip &lt;-----------------<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_reserve_transfer: minor=3D0 idx=3D1<br>
Analogy: a4l_rt_close: minor=3D0<br>
<br>
Then typed:<br>
cmd_write<br>
<div class=3D"im">cmd_write: triggering failed (ret=3D-16)<br>
<br>
</div>error trace:<br>
<br>
Analogy: a4l_rt_open: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
---------------&gt; snip &lt;-----------------<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_ioctl_cancel: subdevice currently idle<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: a4l_ioctl_cmd: minor=3D0<br>
Analogy: a4l_fill_cmddesc: desc dump<br>
Analogy: =A0 =A0 =A0 =A0-&gt;idx_subd=3D1<br>
Analogy: =A0 =A0 =A0 =A0-&gt;flags=3D0<br>
Analogy: =A0 =A0 =A0 =A0-&gt;nb_chan=3D2<br>
Analogy: =A0 =A0 =A0 =A0-&gt;chan_descs=3D0x0<br>
Analogy: =A0 =A0 =A0 =A0-&gt;data_len=3D0<br>
Analogy: =A0 =A0 =A0 =A0-&gt;pdata=3D0x(null)<br>
Analogy: a4l_check_cmddesc: minor=3D0<br>
Analogy: a4l_ioctl_cmd: 1st cmd checks passed<br>
Analogy: a4l_ioctl_cmd: driver&#39;s cmd checks passed<br>
Analogy: a4l_reserve_transfer: minor=3D0 idx=3D1<br>
Analogy: a4l_init_transfer: minor=3D0 idx=3D1<br>
Analogy: a4l_rt_write: minor=3D0<br>
Analogy: a4l_rt_ioctl: minor=3D0<br>
Analogy: analogy_ni_pcimio: ni_request_ao_mite_channel: failed to<br>
reserve mite dma channel for analog outut.<br>
Analogy: a4l_rt_close: minor=3D0<br>
<br>
Hope this helps<br>
<font color=3D"#888888">Ettore<br>
</font><div><div></div><div class=3D"h5"><br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br> =A0 =A0 =
=A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics and Automa=
tion Laboratory<br> =A0 =A0 =A0 Department of Electrical Engineering<br> =
=A0 =A0 =A0 UnB - University of Bras=EDlia, Brazil<br>

 =A0 =A0 =A0 <a href=3D"http://www.lara.unb.br/~fbcavalcanti/">http://www.l=
ara.unb.br/~fbcavalcanti/</a><br>

--001636e0b67d38b686047f2e27d1--

