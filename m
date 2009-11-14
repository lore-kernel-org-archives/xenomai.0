MIME-Version: 1.0
In-Reply-To: <47a3101a0911111337q643dbe48m1dc5ee484f2c93a9@domain.hid>
References: <47a3101a0911111337q643dbe48m1dc5ee484f2c93a9@domain.hid>
Date: Sat, 14 Nov 2009 15:00:45 -0200
Message-ID: <8b216e9e0911140900x5f9a131p7ffee135c89a6596@domain.hid>
From: =?ISO-8859-1?Q?Felipe_Brand=E3o_Cavalcanti?= <cavalkaf@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5bc03ab7457047857b70b
Subject: Re: [Xenomai-help] RTDM Serial port Gumstix PXA270
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Linus Casassa <linus@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

--001636c5bc03ab7457047857b70b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I had the same issue - however, instead of writing a RTDM driver, I
manipulated the memory registers directly, taking advantage of the ARM
architeture way of manipulating drivers. I do have the code available, if
you are interested, and plan on publishing a few technical documents on
getting Xenomai to work with the PXA270 (the Gumstix platform), including a
section on accessing all of the peripherals in real-time.

I would like to know if there is a "cleaner" solution, other than porting
the current driver to RTDM.

Hope this helps,
--=20
      -Felipe Brand=E3o Cavalcanti
      LARA - Robotics and Automation Laboratory
      Department of Electrical Engineering
      UnB - University of Bras=EDlia, Brazil
      http://www.lara.unb.br/~fbcavalcanti/

On Wed, Nov 11, 2009 at 7:37 PM, Linus Casassa <linus@domain.hid> wrote:

> Hi.
>
> I am using open/read/write for a serial port. But the read function delay=
s
> 8 ms from the last bit received untill it returns the chars.
>
> Obviously you would say open/read/write functions are not realtime
> functions.
>
> I changed open/read/write to rt_dev_open/rt_dev_read/rt_dev_write but the
> open function returns -19.
>
> I am using /dev/ttyS2.
> Looking the proc directory I found that there is an interrupt on the seri=
al
> port I want to use: FFUART
>
> root@domain.hid:~$ cat /proc/interrupts
>            CPU0
>   3:          2          SC  ohci_hcd:usb1
>   6:          0          SC  pxa_i2c-i2c.1
>  18:          0          SC  pxa_i2c-i2c.0
>  22:         76          SC  FFUART
>  23:        204          SC  pxa2xx-mci
>  25:          0          SC  DMA
>  26:     198061          SC  ost0
> 163:       4720        GPIO  eth0
> Err:          0
> root@domain.hid:~$
>
> Thanks.
>
> --
> Linus Casassa
> Estudiante Ingenier=EDa Civil Electr=F3nica
> Fono: 56-9-97776941
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>
>

--001636c5bc03ab7457047857b70b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I had the same issue - however, instead of writing a RTDM driver, I manipul=
ated the memory registers directly, taking advantage of the ARM architeture=
 way of manipulating drivers. I do have the code available, if you are inte=
rested, and plan on publishing a few technical documents on getting Xenomai=
 to work with the PXA270 (the Gumstix platform), including a section on acc=
essing all of the peripherals in real-time.<br>
<br>I would like to know if there is a &quot;cleaner&quot; solution, other =
than porting the current driver to RTDM.<br><br>Hope this helps,<br>-- <br>=
 =A0 =A0 =A0 -Felipe Brand=E3o Cavalcanti<br> =A0 =A0 =A0 LARA - Robotics a=
nd Automation Laboratory<br>
 =A0 =A0 =A0 Department of Electrical Engineering<br> =A0 =A0 =A0 UnB - Uni=
versity of Bras=EDlia, Brazil<br> =A0 =A0 =A0 <a href=3D"http://www.lara.un=
b.br/~fbcavalcanti/">http://www.lara.unb.br/~fbcavalcanti/</a><br><br><div =
class=3D"gmail_quote">
On Wed, Nov 11, 2009 at 7:37 PM, Linus Casassa <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:linus@domain.hid">linus@domain.hid</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi.<br><br>I am using open/read/write for a serial port. But the read funct=
ion delays 8 ms from the last bit received untill it returns the chars.<br>=
<br>Obviously you would say open/read/write functions are not realtime func=
tions.<br>


<br>I changed open/read/write to rt_dev_open/rt_dev_read/rt_dev_write but t=
he open function returns -19.<br><br>I am using /dev/ttyS2.<br>Looking the =
proc directory I found that there is an interrupt on the serial port I want=
 to use: FFUART<br>


<br>root@domain.hid:~$ cat /proc/interrupts <br>=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 CPU0<br>=A0 3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 2=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 SC=A0 ohci_hcd:usb1<br>=A0 6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa_i2c-i2c.1<br>=A018:=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa_i2c-i2c.0<br>=A022:=A0=A0=A0=
=A0=A0=A0=A0=A0 76=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 FFUART<br>


=A023:=A0=A0=A0=A0=A0=A0=A0 204=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 pxa2xx-mci=
<br>=A025:=A0=A0=A0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 DM=
A<br>=A026:=A0=A0=A0=A0 198061=A0=A0=A0=A0=A0=A0=A0=A0=A0 SC=A0 ost0<br>163=
:=A0=A0=A0=A0=A0=A0 4720=A0=A0=A0=A0=A0=A0=A0 GPIO=A0 eth0<br>Err:=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 0<br>root@domain.hid:~$ <br><br clear=3D"all"=
>


Thanks.<br><font color=3D"#888888"><br>-- <br>Linus Casassa<br>Estudiante I=
ngenier=EDa Civil Electr=F3nica<br>Fono: 56-9-97776941<br>
</font><br>_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
<br></blockquote></div>

--001636c5bc03ab7457047857b70b--

