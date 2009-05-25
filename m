MIME-Version: 1.0
In-Reply-To: <9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
References: <9c789a000905250446t78fd6b38x1a6f28e35b70d7d6@domain.hid>
	<878wkkzxba.fsf@domain.hid>
	<9c789a000905251435p6f851d21v617c7e26a971f143@domain.hid>
	<871vqczveh.fsf@domain.hid>
	<9c789a000905251516j5272ae7bpc60aea8fdc17d50c@domain.hid>
Date: Tue, 26 May 2009 01:32:42 +0300
Message-ID: <9c789a000905251532i4775d796x8f095503a203e5bb@domain.hid>
From: Cristian Axenie <cristian.axenie@domain.hid>
Content-Type: multipart/alternative; boundary=001636c599a6410a47046ac43011
Subject: [Xenomai-help]  Driver testing procedure ?!
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

--001636c599a6410a47046ac43011
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

---------- Forwarded message ----------
From: Cristian Axenie <cristian.axenie@domain.hid>
Date: Tue, May 26, 2009 at 1:16 AM
Subject: Re: [Xenomai-help] Driver testing procedure ?!
To: Alexis Berlemont <berlemont.hauw@domain.hid>




On Tue, May 26, 2009 at 1:10 AM, Alexis Berlemont <berlemont.hauw@domain.hid>wrote:

> Cristian Axenie <cristian.axenie@domain.hid> writes:
>
> > Hi,
> >
> > I finally figured out this aspect but I still have one problem, residing
> in the fact that I have no comedi devices in my dev list
> > and so I cannot ./comedi_config /dev/comedi0 nipcimio !
> >
> > As I see it there are no comedi devices
> >
> > /usr/xenomai/sbin # cat /proc/devices
>
> You should not look at there. This proc file lists everything but RTDM
> devices.
>
> >
> > and the list
> >
> > /usr/xenomai/sbin # cat /proc/comedi/devices
> > --  Comedi devices --
> >
> > | idx | status | driver
> > |  00 | Unused | No driver
> > |  01 | Unused | No driver
> > |  02 | Unused | No driver
> > |  03 | Unused | No driver
> > |  04 | Unused | No driver
> > |  05 | Unused | No driver
> > |  06 | Unused | No driver
> > |  07 | Unused | No driver
> > |  08 | Unused | No driver
> > |  09 | Unused | No driver
> > /usr/xenomai/sbin # cat /proc/comedi/drivers
> > comedi_config   rtcanconfig     rtps
> > /usr/xenomai/sbin # cat /proc/comedi/drivers
> > --  Comedi drivers --
> >
> > | idx | driver name
> > |  00 | pcimio
> > |  01 | comedi_8255
> > |  02 | comedi_loop
> > |  03 | comedi_fake
> >
> > Shouldn't the specific comedi devices be generated when installing
> Xenomai ?
>
> That is common comedi behaviour. So far, the comedi drivers are listed,
> they are available in the kernel. However, you have to attach them so as
> to make them reachable (thanks to comedi_config).
>
> Once the attach will be done, you will see your driver appear in
> /proc/comedi/devices.
>
> If the comedi_config did not work, the problem is here. In such case,
> could you send the traces?


The problem is that the comedi devs are not present in /dev and so when I
run comedi config

/usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio
comedi_config: comedi_open failed ret=-19

Shouldn't the comedi0, comedi1... devices be created when installing Xenomai
?


>
>
> Alexis.
>

--001636c599a6410a47046ac43011
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">---------- Forwarded message ----------<=
br>From: <b class=3D"gmail_sendername">Cristian Axenie</b> <span dir=3D"ltr=
">&lt;<a href=3D"mailto:cristian.axenie@domain.hid">cristian.axenie@domain.hid=
m</a>&gt;</span><br>
Date: Tue, May 26, 2009 at 1:16 AM<br>Subject: Re: [Xenomai-help] Driver te=
sting procedure ?!<br>To: Alexis Berlemont &lt;<a href=3D"mailto:berlemont.=
hauw@domain.hid">berlemont.hauw@domain.hid</a>&gt;<br><br><br><br><br><div class=
=3D"gmail_quote">
<div><div></div><div class=3D"h5">On Tue, May 26, 2009 at 1:10 AM, Alexis B=
erlemont <span dir=3D"ltr">&lt;<a href=3D"mailto:berlemont.hauw@domain.hid" ta=
rget=3D"_blank">berlemont.hauw@domain.hid</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); =
margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>Cristian Axenie &lt;<a href=3D"mailto:cristian.axenie@domain.hid" targe=
t=3D"_blank">cristian.axenie@domain.hid</a>&gt; writes:<br>
<br>
</div><div>&gt; Hi,<br>
&gt;<br>
&gt; I finally figured out this aspect but I still have one problem, residi=
ng in the fact that I have no comedi devices in my dev list<br>
&gt; and so I cannot ./comedi_config /dev/comedi0 nipcimio !<br>
&gt;<br>
&gt; As I see it there are no comedi devices<br>
&gt;<br>
&gt; /usr/xenomai/sbin # cat /proc/devices<br>
<br>
</div>You should not look at there. This proc file lists everything but RTD=
M devices.<br>
<div><br>
&gt;<br>
&gt; and the list<br>
&gt;<br>
&gt; /usr/xenomai/sbin # cat /proc/comedi/devices<br>
&gt; --=A0 Comedi devices --<br>
&gt;<br>
&gt; | idx | status | driver<br>
&gt; |=A0 00 | Unused | No driver<br>
&gt; |=A0 01 | Unused | No driver<br>
&gt; |=A0 02 | Unused | No driver<br>
&gt; |=A0 03 | Unused | No driver<br>
&gt; |=A0 04 | Unused | No driver<br>
&gt; |=A0 05 | Unused | No driver<br>
&gt; |=A0 06 | Unused | No driver<br>
&gt; |=A0 07 | Unused | No driver<br>
&gt; |=A0 08 | Unused | No driver<br>
&gt; |=A0 09 | Unused | No driver<br>
&gt; /usr/xenomai/sbin # cat /proc/comedi/drivers<br>
&gt; comedi_config=A0=A0 rtcanconfig=A0=A0=A0=A0 rtps<br>
&gt; /usr/xenomai/sbin # cat /proc/comedi/drivers<br>
&gt; --=A0 Comedi drivers --<br>
&gt;<br>
&gt; | idx | driver name<br>
&gt; |=A0 00 | pcimio<br>
&gt; |=A0 01 | comedi_8255<br>
&gt; |=A0 02 | comedi_loop<br>
&gt; |=A0 03 | comedi_fake<br>
&gt;<br>
&gt; Shouldn&#39;t the specific comedi devices be generated when installing=
 Xenomai ?<br>
<br>
</div>That is common comedi behaviour. So far, the comedi drivers are liste=
d,<br>
they are available in the kernel. However, you have to attach them so as<br=
>
to make them reachable (thanks to comedi_config).<br>
<br>
Once the attach will be done, you will see your driver appear in<br>
/proc/comedi/devices.<br>
<br>
If the comedi_config did not work, the problem is here. In such case,<br>
could you send the traces?</blockquote></div></div><div><br>The problem is =
that the comedi devs are not present in /dev and so when I run comedi confi=
g<br>
<br>
/usr/xenomai/sbin # ./comedi_config /dev/comedi0 pcimio<br>
comedi_config: comedi_open failed ret=3D-19<br>
<br>
Shouldn&#39;t the comedi0, comedi1... devices be created when installing Xe=
nomai ?<br>=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-l=
eft: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left:=
 1ex;">

<br>
<font color=3D"#888888"><br>
Alexis.<br>
</font></blockquote></div><br>
</div><br>

--001636c599a6410a47046ac43011--

