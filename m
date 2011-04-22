MIME-Version: 1.0
In-Reply-To: <4DB18EB3.7000107@domain.hid>
References: <BANLkTimmraMpqpZ2areb0z9aC2U19SE5_w@domain.hid>
	<4DB143E8.3000900@domain.hid>
	<BANLkTikNWeDdRMXFN=gHK=sQshMgP-=y5w@domain.hid>
	<4DB17F63.2050504@domain.hid>
	<BANLkTikBZ_YorUhRrEQ8hukMUY=d9m92BQ@mail.gmail.com>
	<4DB18EB3.7000107@domain.hid>
Date: Fri, 22 Apr 2011 17:11:45 +0200
Message-ID: <BANLkTi=sxO=wxxNysMvVR-HM-F5=vpuYJg@domain.hid>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba539faeac52c804a1834622
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

--90e6ba539faeac52c804a1834622
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/4/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> Aurele Traynard wrote:
> > 2011/4/22 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
> >
> >> Aurele Traynard wrote:
> >>> ok i'm sorry i wasn't clear at all...
> >>> my problem is : when i call readl in a rt_task, the task is stopped..=
.
> >>> (maybe because the rt_task is launched in a module?)
> >>> "Xenomai: suspending kernel thread bf0041c8 ('test_rt') at 0xbf003824
> >> after
> >>> exception #0"
> >>> if i remove the readl there is no problem
> >>>
> >>> With a normal Linux, in a module there isn't any problem
> >> On what platform? I can think of two things:
> >> - the platform you use maps the ioremaped memory on-demand (x86 and AR=
M
> >> at least do not allow this, but I do not know about other platforms)
> >> - you are making an unaligned access, it works with Linux because it h=
as
> >> a handler for handling unaligned accesses, whereas Xenomai default
> >> handler is to simply suspend a task doing this kind of things.
> >>
> >> Please do not forget to CC the mailing list.
> >>
> >> --
> >>                                             Gilles.
> >>
> > I'm working with PXA270 (ARMv5te), FPGA's registers physicaly are mappe=
d
> as
> > CPU's registers... so it is alligned (i read 0x040001C0 and i use a
> 32bits
> > integer....)
> > so if i understand it should work...
>
> Are you sure 0x040001C0 is a virtual address?
>
> --
>                                             Gilles.
>
I'm sure it is not a virtual address. It is the physical address.
I use "ioremap" and after i use the value given by "ioremap" in "readl"

I apologize I realized my mistake thanks to you... it wasn't in any case
from Xenomai (I just launch the task too early...)

Thanks a lot for your time.
Aur=E8le

--90e6ba539faeac52c804a1834622
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2011/4/22 Gilles Chanteperdrix <span dir=
=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.cha=
nteperdrix@domain.hid</a>&gt;</span><br><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div><div></div><div class=3D"h5">Aurele Traynard wrote:<br>
&gt; 2011/4/22 Gilles Chanteperdrix &lt;<a href=3D"mailto:gilles.chanteperd=
rix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;<br>
&gt;<br>
&gt;&gt; Aurele Traynard wrote:<br>
&gt;&gt;&gt; ok i&#39;m sorry i wasn&#39;t clear at all...<br>
&gt;&gt;&gt; my problem is : when i call readl in a rt_task, the task is st=
opped...<br>
&gt;&gt;&gt; (maybe because the rt_task is launched in a module?)<br>
&gt;&gt;&gt; &quot;Xenomai: suspending kernel thread bf0041c8 (&#39;test_rt=
&#39;) at 0xbf003824<br>
&gt;&gt; after<br>
&gt;&gt;&gt; exception #0&quot;<br>
&gt;&gt;&gt; if i remove the readl there is no problem<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; With a normal Linux, in a module there isn&#39;t any problem<b=
r>
&gt;&gt; On what platform? I can think of two things:<br>
&gt;&gt; - the platform you use maps the ioremaped memory on-demand (x86 an=
d ARM<br>
&gt;&gt; at least do not allow this, but I do not know about other platform=
s)<br>
&gt;&gt; - you are making an unaligned access, it works with Linux because =
it has<br>
&gt;&gt; a handler for handling unaligned accesses, whereas Xenomai default=
<br>
&gt;&gt; handler is to simply suspend a task doing this kind of things.<br>
&gt;&gt;<br>
&gt;&gt; Please do not forget to CC the mailing list.<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 Gilles.<br>
&gt;&gt;<br>
&gt; I&#39;m working with PXA270 (ARMv5te), FPGA&#39;s registers physicaly =
are mapped as<br>
&gt; CPU&#39;s registers... so it is alligned (i read 0x040001C0 and i use =
a 32bits<br>
&gt; integer....)<br>
&gt; so if i understand it should work...<br>
<br>
</div></div>Are you sure 0x040001C0 is a virtual address?<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div>I&#39;m sure it is not a virtual address. It is t=
he physical address.<br>I use &quot;ioremap&quot; and after i use the value=
 given by &quot;ioremap&quot; in &quot;readl&quot;<br><br>I apologize <span=
 id=3D"result_box" class=3D"short_text" lang=3D"en"><span title=3D"Cliquer =
ici pour voir d&#39;autres traductions" class=3D"hps">I</span> <span title=
=3D"Cliquer ici pour voir d&#39;autres traductions" class=3D"hps">realized<=
/span> <span title=3D"Cliquer ici pour voir d&#39;autres traductions" class=
=3D"hps">my</span> <span title=3D"Cliquer ici pour voir d&#39;autres traduc=
tions" class=3D"hps">mistake</span> <span title=3D"Cliquer ici pour voir d&=
#39;autres traductions" class=3D"hps">thanks to</span> <span title=3D"Cliqu=
er ici pour voir d&#39;autres traductions" class=3D"hps">you... it wasn&#39=
;t in any case from Xenomai (I just launch the task too early...)<br>
<br>Thanks a lot for your time.<br>Aur=E8le<br><br></span></span>

--90e6ba539faeac52c804a1834622--

