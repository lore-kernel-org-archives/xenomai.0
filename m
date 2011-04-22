MIME-Version: 1.0
In-Reply-To: <4DB17F63.2050504@domain.hid>
References: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>
	<4DB143E8.3000900@domain.hid>
	<BANLkTikNWeDdRMXFN=gHK=sQshMgP-=y5w@domain.hid>
	<4DB17F63.2050504@domain.hid>
Date: Fri, 22 Apr 2011 15:42:23 +0200
Message-ID: <BANLkTikBZ_YorUhRrEQ8hukMUY=d9m92BQ@mail.gmail.com>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba53b1ea16c3b404a18207ac
Subject: Re: [Xenomai-help] first module help
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai help <xenomai@xenomai.org>

--90e6ba53b1ea16c3b404a18207ac
Content-Type: text/plain; charset=ISO-8859-1

2011/4/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Aurele Traynard wrote:
> > ok i'm sorry i wasn't clear at all...
> > my problem is : when i call readl in a rt_task, the task is stopped...
> > (maybe because the rt_task is launched in a module?)
> > "Xenomai: suspending kernel thread bf0041c8 ('test_rt') at 0xbf003824
> after
> > exception #0"
> > if i remove the readl there is no problem
> >
> > With a normal Linux, in a module there isn't any problem
>
> On what platform? I can think of two things:
> - the platform you use maps the ioremaped memory on-demand (x86 and ARM
> at least do not allow this, but I do not know about other platforms)
> - you are making an unaligned access, it works with Linux because it has
> a handler for handling unaligned accesses, whereas Xenomai default
> handler is to simply suspend a task doing this kind of things.
>
> Please do not forget to CC the mailing list.
>
> --
>                                             Gilles.
>
I'm working with PXA270 (ARMv5te), FPGA's registers physicaly are mapped as
CPU's registers... so it is alligned (i read 0x040001C0 and i use a 32bits
integer....)
so if i understand it should work...

thanks

--90e6ba53b1ea16c3b404a18207ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/22 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">Aurele Traynard wrote:<br>
&gt; ok i&#39;m sorry i wasn&#39;t clear at all...<br>
&gt; my problem is : when i call readl in a rt_task, the task is stopped...=
<br>
&gt; (maybe because the rt_task is launched in a module?)<br>
&gt; &quot;Xenomai: suspending kernel thread bf0041c8 (&#39;test_rt&#39;) a=
t 0xbf003824 after<br>
&gt; exception #0&quot;<br>
&gt; if i remove the readl there is no problem<br>
&gt;<br>
&gt; With a normal Linux, in a module there isn&#39;t any problem<br>
<br>
</div>On what platform? I can think of two things:<br>
- the platform you use maps the ioremaped memory on-demand (x86 and ARM<br>
at least do not allow this, but I do not know about other platforms)<br>
- you are making an unaligned access, it works with Linux because it has<br=
>
a handler for handling unaligned accesses, whereas Xenomai default<br>
handler is to simply suspend a task doing this kind of things.<br>
<br>
Please do not forget to CC the mailing list.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div>I&#39;m working with PXA270 (ARMv5te), FPGA&#39;s=
 registers physicaly are mapped as CPU&#39;s registers... so it is alligned=
 (i read 0x040001C0 and i use a 32bits integer....)<br>so if i understand i=
t should work...<br>
<br>thanks<br>

--90e6ba53b1ea16c3b404a18207ac--

