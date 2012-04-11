MIME-Version: 1.0
In-Reply-To: <4F85D505.6080002@domain.hid>
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
	<4F7555F7.6010102@domain.hid>
	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
	<4F75B5BF.8030401@domain.hid>
	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
	<4F75C7D1.4020808@domain.hid>
	<CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
	<4F79D5EA.3010501@domain.hid>
	<CAGq8jPjq79CdBbNys1=ccV-CKSyNfG9nX-1L31Ar6WShuNE=HQ@mail.gmail.com>
	<4F7D7A43.4060502@domain.hid>
	<CAGq8jPhqRN0WTKHC1uJXbHyecX_tKOB6zFnDJ4=DbKtzU3mmcA@mail.gmail.com>
	<CAGq8jPgON96yy7_wOCSs83QwxVrfSsTn-fe1P+EBZ8-KLMfj0A@mail.gmail.com>
	<4F8592F3.6070907@domain.hid> <4F85B7BE.9080706@domain.hid>
	<4F85B869.2060102@domain.hid> <4F85D505.6080002@domain.hid>
Date: Wed, 11 Apr 2012 22:51:56 +0200
Message-ID: <CAGq8jPj4dNaukTMZXo6+C=UA-TfpP5h9FOU07FUTnX0TTDsqCA@mail.gmail.com>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf30564321ef537504bd6d68fc
Subject: Re: [Xenomai-help] Cross-link.c ---RTSER_RTIOC_WAIT_EVENT
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Grandegger <wg@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

--20cf30564321ef537504bd6d68fc
Content-Type: text/plain; charset=ISO-8859-1

ok for CC, i was afraid of spam everyone by my mail. I answer your
questions.

- non, i didn't modify cross-link program  (even if i used to modify this
program to make it run, but it worked the same way)

- Xenomai 2.6

- Linux 2.6.38 and patch Adeos 2.6.38 of course

- i build the program in Eclipse C++ so my command in setting configuration
is

command :   g++
All options:   -l/usr/xenomai/include -O3 -wall -c -fmessage-length=0

Well, i will soon rebuild my kernel with this patch

Goodbye

On Wed, Apr 11, 2012 at 9:01 PM, Wolfgang Grandegger <wg@domain.hid>wrote:

> On 04/11/2012 06:59 PM, Gilles Chanteperdrix wrote:
> > On 04/11/2012 06:56 PM, Gilles Chanteperdrix wrote:
> >> On 04/11/2012 04:19 PM, Wolfgang Grandegger wrote:
> >>> Hi,
> >>>
> >>> On 04/05/2012 02:46 PM, Minh GIANG wrote:
> >>>> i'm sorry sir, what i displayed just in the last mail, isn't good,
> because
> >>>> i removed rt_dev_ioctl(...) in cross-link program
> >>>> And then, with  rt_dev_ioctl( RTSER_RTIOC_WAIT_EVENT ).
> >>>>
> >>>> [93076.465077] base=0x2f8 iir=0x4
> >>>> [93076.465082] base=0x2f8 status=0x0
> >>>> [93076.465084] base=0x2f8 iir=0x1
> >>>
> >>> TX on rtser0:
> >>>
> >>>> [93076.556794] base=0x3f8 iir=0x2
> >>>> [93076.556799] base=0x3f8 status=0x0
> >>>> [93076.556801] base=0x3f8 iir=0x1
> >>>
> >>> RX of 8 chars on rtser1:
> >>>
> >>>> [93076.557819] base=0x2f8 iir=0x4
> >>>> [93076.557823] base=0x2f8 status=0x0
> >>>> [93076.557825] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.558860] base=0x2f8 iir=0x4
> >>>> [93076.558865] base=0x2f8 status=0x0
> >>>> [93076.558867] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.559898] base=0x2f8 iir=0x4
> >>>> [93076.559901] base=0x2f8 status=0x0
> >>>> [93076.559903] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.560943] base=0x2f8 iir=0x4
> >>>> [93076.560946] base=0x2f8 status=0x0
> >>>> [93076.560948] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.561969] base=0x2f8 iir=0x4
> >>>> [93076.561971] base=0x2f8 status=0x0
> >>>> [93076.561973] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.563006] base=0x2f8 iir=0x4
> >>>> [93076.563009] base=0x2f8 status=0x0
> >>>> [93076.563011] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.564012] base=0x2f8 iir=0x4
> >>>> [93076.564012] base=0x2f8 status=0x0
> >>>> [93076.564012] base=0x2f8 iir=0x1
> >>>
> >>>> [93076.564012] base=0x2f8 iir=0x4
> >>>> [93076.564012] base=0x2f8 status=0x0
> >>>> [93076.564012] base=0x2f8 iir=0x1
> >>>
> >>> TX on rtser0:
> >>>
> >>>> [93076.656766] base=0x3f8 iir=0x2
> >>>> [93076.656770] base=0x3f8 status=0x0
> >>>> [93076.656772] base=0x3f8 iir=0x1
> >>>
> >>> RX on rtser1:
> >>>
> >>>> [93076.657793] base=0x2f8 iir=0x4
> >>>> [93076.657795] base=0x2f8 status=0x0
> >>>> [93076.657797] base=0x2f8 iir=0x1
> >>>
> >>> ... and so on.
> >>>
> >>> This looks completely normal and I'm really puzzled why the
> >>> rt_dev_ioctl(RTSER_RTIOC_WAIT_EVENT) does not work as expected. Ah, I
> >>> just realized that the following patch was not yet applied:
> >>>
> >>> https://mail.gna.org/public/xenomai-core/2011-11/msg00009.html
> >>>
> >>> I think it will fix your problem.
> >>
> >> Sorry, it looks like I completely forgot this patch. Could you rebase it
> >> on the current contents of xenomai-2.6 so that I can merge it?
> >>
> > Actually, the patches are merged in xenomai-2.6 repository. The problem
> > we have is simply that xenomai 2.6.0 is too old.
>
> Argh, you are right. Sorry for the noise.
>
> Wolfgang.
>
>
>
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
>

--20cf30564321ef537504bd6d68fc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

ok for CC, i was afraid of spam everyone by my mail. I answer your question=
s.<div><br></div><div><span style>- non, i didn&#39;t modify cross-link pro=
gram =A0(even if i used to modify this program to make it run, but it worke=
d the same way)</span><br style>
<br style><span style>- Xenomai 2.6</span><br style><br style><span style>-=
 Linux 2.6.38 and patch Adeos 2.6.38 of course</span><br style><br style><s=
pan style>- i build the program in Eclipse C++=A0</span><span style>so my c=
ommand in setting configuration is</span></div>
<div><span style><br></span></div><div style>command : =A0 g++=A0</div><div=
 style>All options: =A0 -l/usr/xenomai/include -O3 -wall -c -fmessage-lengt=
h=3D0</div><div><font color=3D"#222222" face=3D"arial, sans-serif"><br></fo=
nt></div>
<div><font color=3D"#222222" face=3D"arial, sans-serif">Well, i will soon r=
ebuild my kernel with this patch</font></div><div><font color=3D"#222222" f=
ace=3D"arial, sans-serif"><br></font></div><div><font color=3D"#222222" fac=
e=3D"arial, sans-serif">Goodbye<br>
</font><br><div class=3D"gmail_quote">On Wed, Apr 11, 2012 at 9:01 PM, Wolf=
gang Grandegger <span dir=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid">=
wg@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 04/11/2012 06:59 PM, Gilles Chan=
teperdrix wrote:<br>
&gt; On 04/11/2012 06:56 PM, Gilles Chanteperdrix wrote:<br>
&gt;&gt; On 04/11/2012 04:19 PM, Wolfgang Grandegger wrote:<br>
&gt;&gt;&gt; Hi,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On 04/05/2012 02:46 PM, Minh GIANG wrote:<br>
&gt;&gt;&gt;&gt; i&#39;m sorry sir, what i displayed just in the last mail,=
 isn&#39;t good, because<br>
&gt;&gt;&gt;&gt; i removed rt_dev_ioctl(...) in cross-link program<br>
&gt;&gt;&gt;&gt; And then, with =A0rt_dev_ioctl( RTSER_RTIOC_WAIT_EVENT ).<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.465077] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.465082] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.465084] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; TX on rtser0:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.556794] base=3D0x3f8 iir=3D0x2<br>
&gt;&gt;&gt;&gt; [93076.556799] base=3D0x3f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.556801] base=3D0x3f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; RX of 8 chars on rtser1:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.557819] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.557823] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.557825] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.558860] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.558865] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.558867] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.559898] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.559901] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.559903] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.560943] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.560946] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.560948] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.561969] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.561971] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.561973] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.563006] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.563009] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.563011] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.564012] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; TX on rtser0:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.656766] base=3D0x3f8 iir=3D0x2<br>
&gt;&gt;&gt;&gt; [93076.656770] base=3D0x3f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.656772] base=3D0x3f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; RX on rtser1:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; [93076.657793] base=3D0x2f8 iir=3D0x4<br>
&gt;&gt;&gt;&gt; [93076.657795] base=3D0x2f8 status=3D0x0<br>
&gt;&gt;&gt;&gt; [93076.657797] base=3D0x2f8 iir=3D0x1<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; ... and so on.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This looks completely normal and I&#39;m really puzzled why th=
e<br>
&gt;&gt;&gt; rt_dev_ioctl(RTSER_RTIOC_WAIT_EVENT) does not work as expected=
. Ah, I<br>
&gt;&gt;&gt; just realized that the following patch was not yet applied:<br=
>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://mail.gna.org/public/xenomai-core/2011-11/ms=
g00009.html" target=3D"_blank">https://mail.gna.org/public/xenomai-core/201=
1-11/msg00009.html</a><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I think it will fix your problem.<br>
&gt;&gt;<br>
&gt;&gt; Sorry, it looks like I completely forgot this patch. Could you reb=
ase it<br>
&gt;&gt; on the current contents of xenomai-2.6 so that I can merge it?<br>
&gt;&gt;<br>
&gt; Actually, the patches are merged in xenomai-2.6 repository. The proble=
m<br>
&gt; we have is simply that xenomai 2.6.0 is too old.<br>
<br>
</div></div>Argh, you are right. Sorry for the noise.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
<br>
_______________________________________________<br>
Xenomai-help mailing list<br>
<a href=3D"mailto:Xenomai-help@domain.hid">Xenomai-help@domain.hid</a><br>
<a href=3D"https://mail.gna.org/listinfo/xenomai-help" target=3D"_blank">ht=
tps://mail.gna.org/listinfo/xenomai-help</a><br>
</div></div></blockquote></div><br></div>

--20cf30564321ef537504bd6d68fc--

