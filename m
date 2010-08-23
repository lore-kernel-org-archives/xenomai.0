MIME-Version: 1.0
In-Reply-To: <4C723CD4.60604@domain.hid>
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
	<4C7232E6.8070709@domain.hid>
	<AANLkTi=sOUgazTM-OxCsC6Za0y=ZkRoM1PC61ADx54+c@domain.hid>
	<4C723CD4.60604@domain.hid>
Date: Mon, 23 Aug 2010 15:28:43 +0530
Message-ID: <AANLkTinLVrdOomSMqKX8NcmDPLuNMnofnZu_VupNXJz+@mail.gmail.com>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c598729e0147048e7ab199
Subject: Re: [Xenomai-help] Xenomai patch for AT91ARM9200
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

--001636c598729e0147048e7ab199
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 23, 2010 at 2:48 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Prakash A S wrote:
> > On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix <
> > gilles.chanteperdrix@xenomai.org> wrote:
> >
> >> Prakash A S wrote:
> >>> Dear All,
> >>>          Now I am working on AT91RM9200 based processor ARM board with
> >> Linux
> >>> 2.6.20 kernel and also planing to port Xenomai on this board. I
> preferred
> >>> xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20 kernel.
> >> However I
> >>> found that there is an separate ipipe patch available for AT91
> processor
> >> in
> >>> xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0 or
> >>> adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
> >>>
> >>> I beleive the steps will be like,
> >>> linux-2.6.20+2.6.20-at91.patch.gz+adeos-ipipe-2.6.20-arm-1.802.patch
> >> You did it again: as documented in ksrc/arch/arm/patches/README,
> >> what Xenomai version you pick is largely irrelevant to what I-pipe patch
> >> you want to use, so, you can probably use the I-pipe patch for 2.6.20
> >> with Xenomai 2.5.4.
> >>
> >>
> > Agreed. The intention is to clarify few doubts. Otherwise I will missed
> to
> > get such an specific info mentioned below.
> > Thanks for the info.
> >
> >
> >> All releases of a Xenomai branch are backward compatible, so, if you
> >> want to pick something in the any branch, pick the latest (2.4.10 for
> >> 2.4 branch, 2.5.4 for 2.5 branch). Also note that all I-pipe patches up
> >> to, but not including, 2.6.28-1.12-05, are buggy, so, if you want to use
> >> 2.6.20, you will have to apply the patch attached to this mail:
> >>
> >> https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
> >>
> >> As for the initial question, I do not remember that far in the past.
> >> But, at some point in the past, the I-pipe patch started being able to
> >> be applied with and without the AT91 patch, I do not remember if
> >> 2.6.20-1.8-02 was in this case.
> >>
> >>
> > At this moment my board only supports linux-2.6.20. So I just like to
> port
> > xenomai and test the board with the same kernel version. Later I will
> > upgrade the linux kernel and move to the latest xenomai.
> >
> > I would like to know in which format you getting my mails now?.
>
> You can check the mail contents:
>
> Content-Type: multipart/alternative; boundary=001636c5a98061861f048e7a11ca
>
> --001636c5a98061861f048e7a11ca
> Content-Type: text/plain; charset=ISO-8859-1
>
> On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix <
> gilles.chanteperdrix@xenomai.org> wrote:
>
> (...)
>
> --001636c5a98061861f048e7a11ca
> Content-Type: text/html; charset=ISO-8859-1
> Content-Transfer-Encoding: quoted-printable
>
> <br><br><div class=3D"gmail_quote">On Mon, Aug 23, 2010 at 2:05 PM, Gilles
> =
> Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:
> gilles.chanteperdrix@=
> xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span>
> wrote:<br><blo=
> ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,
> 204,=
>  204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
>
>
>
Ya, Really ugly. I disabled "plain text option" in my mailinglist settings
and sending this reply. Any changes now?.

-Prakash

--001636c598729e0147048e7ab199
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 23, 2010 at 2:48 PM, Gilles =
Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@=
xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><blo=
ckquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204,=
 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">Prakash A S wrote:<br>
&gt; On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix &lt;<br>
&gt; <a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdr=
ix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; Prakash A S wrote:<br>
&gt;&gt;&gt; Dear All,<br>
&gt;&gt;&gt; =A0 =A0 =A0 =A0 =A0Now I am working on AT91RM9200 based proces=
sor ARM board with<br>
&gt;&gt; Linux<br>
&gt;&gt;&gt; 2.6.20 kernel and also planing to port Xenomai on this board. =
I preferred<br>
&gt;&gt;&gt; xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20 ker=
nel.<br>
&gt;&gt; However I<br>
&gt;&gt;&gt; found that there is an separate ipipe patch available for AT91=
 processor<br>
&gt;&gt; in<br>
&gt;&gt;&gt; xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0 o=
r<br>
&gt;&gt;&gt; adeos-ipipe-2.6.20-arm-1.802.patch is enough?.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I beleive the steps will be like,<br>
&gt;&gt;&gt; linux-2.6.20+2.6.20-at91.patch.gz+adeos-ipipe-2.6.20-arm-1.802=
.patch<br>
&gt;&gt; You did it again: as documented in ksrc/arch/arm/patches/README,<b=
r>
&gt;&gt; what Xenomai version you pick is largely irrelevant to what I-pipe=
 patch<br>
&gt;&gt; you want to use, so, you can probably use the I-pipe patch for 2.6=
.20<br>
&gt;&gt; with Xenomai 2.5.4.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; Agreed. The intention is to clarify few doubts. Otherwise I will misse=
d to<br>
&gt; get such an specific info mentioned below.<br>
&gt; Thanks for the info.<br>
&gt;<br>
&gt;<br>
&gt;&gt; All releases of a Xenomai branch are backward compatible, so, if y=
ou<br>
&gt;&gt; want to pick something in the any branch, pick the latest (2.4.10 =
for<br>
&gt;&gt; 2.4 branch, 2.5.4 for 2.5 branch). Also note that all I-pipe patch=
es up<br>
&gt;&gt; to, but not including, 2.6.28-1.12-05, are buggy, so, if you want =
to use<br>
&gt;&gt; 2.6.20, you will have to apply the patch attached to this mail:<br=
>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://mail.gna.org/public/xenomai-core/2009-08/msg000=
21.html" target=3D"_blank">https://mail.gna.org/public/xenomai-core/2009-08=
/msg00021.html</a><br>
&gt;&gt;<br>
&gt;&gt; As for the initial question, I do not remember that far in the pas=
t.<br>
&gt;&gt; But, at some point in the past, the I-pipe patch started being abl=
e to<br>
&gt;&gt; be applied with and without the AT91 patch, I do not remember if<b=
r>
&gt;&gt; 2.6.20-1.8-02 was in this case.<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt; At this moment my board only supports linux-2.6.20. So I just like to =
port<br>
&gt; xenomai and test the board with the same kernel version. Later I will<=
br>
&gt; upgrade the linux kernel and move to the latest xenomai.<br>
&gt;<br>
&gt; I would like to know in which format you getting my mails now?.<br>
<br>
</div></div>You can check the mail contents:<br>
<br>
Content-Type: multipart/alternative; boundary=3D001636c5a98061861f048e7a11c=
a<br>
<br>
--001636c5a98061861f048e7a11ca<br>
Content-Type: text/plain; charset=3DISO-8859-1<br>
<div class=3D"im"><br>
On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix &lt;<br>
<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
nomai.org</a>&gt; wrote:<br>
<br>
</div>(...)<br>
<br>
--001636c5a98061861f048e7a11ca<br>
Content-Type: text/html; charset=3DISO-8859-1<br>
Content-Transfer-Encoding: quoted-printable<br>
<br>
&lt;br&gt;&lt;br&gt;&lt;div class=3D3D&quot;gmail_quote&quot;&gt;On Mon, Au=
g 23, 2010 at 2:05 PM, Gilles =3D<br>
Chanteperdrix &lt;span dir=3D3D&quot;ltr&quot;&gt;&amp;lt;&lt;a href=3D3D&q=
uot;mailto:<a href=3D"mailto:gilles.chanteperdrix@">gilles.chanteperdrix@</=
a>=3D<br>
<a href=3D"http://xenomai.org" target=3D"_blank">xenomai.org</a>&quot;&gt;<=
a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org=
omai.org</a>&lt;/a&gt;&amp;gt;&lt;/span&gt; wrote:&lt;br&gt;&lt;blo=3D<br>
ckquote class=3D3D&quot;gmail_quote&quot; style=3D3D&quot;border-left: 1px =
solid rgb(204, 204,=3D<br>
=A0204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;&quot;&gt;<br>
<br>
<br></blockquote><div><br>Ya, Really ugly. I disabled &quot;plain text opti=
on&quot; in my mailinglist settings and sending this reply. Any changes now=
?. <br><br>-Prakash<br></div></div>

--001636c598729e0147048e7ab199--

