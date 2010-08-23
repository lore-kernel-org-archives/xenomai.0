MIME-Version: 1.0
In-Reply-To: <1282555835.1961.55.camel@domain.hid>
References: <AANLkTinWHLk2fc0qMygBOmgYpAAh88FbUAUFDq2DPRKL@mail.gmail.com>
	<4C7232E6.8070709@domain.hid>
	<AANLkTi=sOUgazTM-OxCsC6Za0y=ZkRoM1PC61ADx54+c@domain.hid>
	<1282555835.1961.55.camel@domain.hid>
Date: Mon, 23 Aug 2010 15:58:36 +0530
Message-ID: <AANLkTimE5K2Hy=UH+TVN6MEfvtVn=n=bh_AMkPakTf+K@mail.gmail.com>
From: Prakash A S <asprakash83@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5c13472d9b6048e7b1c19
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org

--001636c5c13472d9b6048e7b1c19
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 23, 2010 at 3:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:

> On Mon, 2010-08-23 at 14:43 +0530, Prakash A S wrote:
> >
> >
> > On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix
> > <gilles.chanteperdrix@xenomai.org> wrote:
> >
> >         Prakash A S wrote:
> >         > Dear All,
> >         >          Now I am working on AT91RM9200 based processor ARM
> >         board with Linux
> >         > 2.6.20 kernel and also planing to port Xenomai on this
> >         board. I preferred
> >         > xenomai-2.4.0. Because it has adeos-ipipe patch for 2.6.20
> >         kernel. However I
> >         > found that there is an separate ipipe patch available for
> >         AT91 processor in
> >         > xenomai-2.3.2. Do I need any similar patch for xenomai-2.4.0
> >         or
> >         > adeos-ipipe-2.6.20-arm-1.802.patch is enough?.
> >         >
> >         > I beleive the steps will be like,
> >         > linux-2.6.20+2.6.20-at91.patch.gz
> >         +adeos-ipipe-2.6.20-arm-1.802.patch
> >
> >
> >         You did it again: as documented in
> >         ksrc/arch/arm/patches/README,
> >         what Xenomai version you pick is largely irrelevant to what
> >         I-pipe patch
> >         you want to use, so, you can probably use the I-pipe patch for
> >         2.6.20
> >         with Xenomai 2.5.4.
> >
> >
> > Agreed. The intention is to clarify few doubts. Otherwise I will
> > missed to get such an specific info mentioned below.
> > Thanks for the info.
> >
> >         All releases of a Xenomai branch are backward compatible, so,
> >         if you
> >         want to pick something in the any branch, pick the latest
> >         (2.4.10 for
> >         2.4 branch, 2.5.4 for 2.5 branch). Also note that all I-pipe
> >         patches up
> >         to, but not including, 2.6.28-1.12-05, are buggy, so, if you
> >         want to use
> >         2.6.20, you will have to apply the patch attached to this
> >         mail:
> >
> >         https://mail.gna.org/public/xenomai-core/2009-08/msg00021.html
> >
> >         As for the initial question, I do not remember that far in the
> >         past.
> >         But, at some point in the past, the I-pipe patch started being
> >         able to
> >         be applied with and without the AT91 patch, I do not remember
> >         if
> >         2.6.20-1.8-02 was in this case.
> >
> >
> > At this moment my board only supports linux-2.6.20. So I just like to
> > port xenomai and test the board with the same kernel version. Later I
> > will upgrade the linux kernel and move to the latest xenomai.
>
> What Gilles told you, is that Xenomai is backward-compatible with older
> Adeos releases. Therefore, unless you really want to hit Xenomai bugs
> which have been solved since 2007, you should consider using the
> _latest_ Xenomai release, which does support 2.6.20 kernels, with your
> legacy kernel. Could you somehow trust us when we recommend what we
> think is the best way for your project to succeed?
>
> The other incentive for you to do that, is to get answers to your
> questions if any issue happens during this process. Because likely
> nobody will ever bother or have any clue for problems regarding Xenomai
> 2.4.0 on this list.
>

Dear Philippe,
        Thanks for pointing out the right way towards my target. I got his
point and I trust the community work and open source rather than the closed
one. Moreover, that is the only reason I am using xenomai now. So there is
no doubt about the xenomai; But it is about the BSP.

Obviously no one will bother about the old version if something new is
already exist with the best. But my current worry is, BSP. I believe,
adopting with latest xenomai is easy compare with BSP preparation for new
kernel.  So my idea is to test the board with 2.6.20 xenoami (not care about
the bug/performance)and then move to the latest version. At the same time
not interested to mess the community with older version of xenomai.

-Prakash

--001636c5c13472d9b6048e7b1c19
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 23, 2010 at 3:00 PM, Philipp=
e Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
i.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">
<div><div></div><div class=3D"h5">On Mon, 2010-08-23 at 14:43 +0530, Prakas=
h A S wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Aug 23, 2010 at 2:05 PM, Gilles Chanteperdrix<br>
&gt; &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Prakash A S wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt; Dear All,<br>
&gt; =A0 =A0 =A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0Now I am working on AT91RM9200=
 based processor ARM<br>
&gt; =A0 =A0 =A0 =A0 board with Linux<br>
&gt; =A0 =A0 =A0 =A0 &gt; 2.6.20 kernel and also planing to port Xenomai on=
 this<br>
&gt; =A0 =A0 =A0 =A0 board. I preferred<br>
&gt; =A0 =A0 =A0 =A0 &gt; xenomai-2.4.0. Because it has adeos-ipipe patch f=
or 2.6.20<br>
&gt; =A0 =A0 =A0 =A0 kernel. However I<br>
&gt; =A0 =A0 =A0 =A0 &gt; found that there is an separate ipipe patch avail=
able for<br>
&gt; =A0 =A0 =A0 =A0 AT91 processor in<br>
&gt; =A0 =A0 =A0 =A0 &gt; xenomai-2.3.2. Do I need any similar patch for xe=
nomai-2.4.0<br>
&gt; =A0 =A0 =A0 =A0 or<br>
&gt; =A0 =A0 =A0 =A0 &gt; adeos-ipipe-2.6.20-arm-1.802.patch is enough?.<br=
>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; I beleive the steps will be like,<br>
&gt; =A0 =A0 =A0 =A0 &gt; linux-2.6.20+2.6.20-at91.patch.gz<br>
&gt; =A0 =A0 =A0 =A0 +adeos-ipipe-2.6.20-arm-1.802.patch<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 You did it again: as documented in<br>
&gt; =A0 =A0 =A0 =A0 ksrc/arch/arm/patches/README,<br>
&gt; =A0 =A0 =A0 =A0 what Xenomai version you pick is largely irrelevant to=
 what<br>
&gt; =A0 =A0 =A0 =A0 I-pipe patch<br>
&gt; =A0 =A0 =A0 =A0 you want to use, so, you can probably use the I-pipe p=
atch for<br>
&gt; =A0 =A0 =A0 =A0 2.6.20<br>
&gt; =A0 =A0 =A0 =A0 with Xenomai 2.5.4.<br>
&gt;<br>
&gt;<br>
&gt; Agreed. The intention is to clarify few doubts. Otherwise I will<br>
&gt; missed to get such an specific info mentioned below.<br>
&gt; Thanks for the info.<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 All releases of a Xenomai branch are backward compatib=
le, so,<br>
&gt; =A0 =A0 =A0 =A0 if you<br>
&gt; =A0 =A0 =A0 =A0 want to pick something in the any branch, pick the lat=
est<br>
&gt; =A0 =A0 =A0 =A0 (2.4.10 for<br>
&gt; =A0 =A0 =A0 =A0 2.4 branch, 2.5.4 for 2.5 branch). Also note that all =
I-pipe<br>
&gt; =A0 =A0 =A0 =A0 patches up<br>
&gt; =A0 =A0 =A0 =A0 to, but not including, 2.6.28-1.12-05, are buggy, so, =
if you<br>
&gt; =A0 =A0 =A0 =A0 want to use<br>
&gt; =A0 =A0 =A0 =A0 2.6.20, you will have to apply the patch attached to t=
his<br>
&gt; =A0 =A0 =A0 =A0 mail:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 <a href=3D"https://mail.gna.org/public/xenomai-core/20=
09-08/msg00021.html" target=3D"_blank">https://mail.gna.org/public/xenomai-=
core/2009-08/msg00021.html</a><br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 As for the initial question, I do not remember that fa=
r in the<br>
&gt; =A0 =A0 =A0 =A0 past.<br>
&gt; =A0 =A0 =A0 =A0 But, at some point in the past, the I-pipe patch start=
ed being<br>
&gt; =A0 =A0 =A0 =A0 able to<br>
&gt; =A0 =A0 =A0 =A0 be applied with and without the AT91 patch, I do not r=
emember<br>
&gt; =A0 =A0 =A0 =A0 if<br>
&gt; =A0 =A0 =A0 =A0 2.6.20-1.8-02 was in this case.<br>
&gt;<br>
&gt;<br>
&gt; At this moment my board only supports linux-2.6.20. So I just like to<=
br>
&gt; port xenomai and test the board with the same kernel version. Later I<=
br>
&gt; will upgrade the linux kernel and move to the latest xenomai.<br>
<br>
</div></div>What Gilles told you, is that Xenomai is backward-compatible wi=
th older<br>
Adeos releases. Therefore, unless you really want to hit Xenomai bugs<br>
which have been solved since 2007, you should consider using the<br>
_latest_ Xenomai release, which does support 2.6.20 kernels, with your<br>
legacy kernel. Could you somehow trust us when we recommend what we<br>
think is the best way for your project to succeed?<br>
<br>
The other incentive for you to do that, is to get answers to your<br>
questions if any issue happens during this process. Because likely<br>
nobody will ever bother or have any clue for problems regarding Xenomai<br>
2.4.0 on this list.<br></blockquote><div><br></div></div>Dear Philippe,<br>
=A0=A0=A0=A0=A0=A0=A0 Thanks for pointing out the right way towards my targ=
et. I got
his point and I trust the community work and open source rather than
the closed one. Moreover, that is the only reason I am using xenomai now. S=
o there is no doubt about the xenomai; But it is about the BSP.<br>
<br>
Obviously no one will bother about the old version if something new is
already exist with the best. But my current worry is, BSP. I believe,
adopting with latest xenomai is easy compare with BSP preparation for
new kernel.=A0 So my idea is to test the board with 2.6.20 xenoami (not car=
e about the bug/performance)and then move to the latest version. At the sam=
e time not interested to mess the community with older version of xenomai.<=
br>
<br>-Prakash<br><br>

--001636c5c13472d9b6048e7b1c19--

