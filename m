MIME-Version: 1.0
In-Reply-To: <1240050469.26554.128.camel@domain.hid>
References: <b131c9f0903230100x1b2aa2fet9e2b0efe68a7a77f@domain.hid>
	<49E45473.4050409@domain.hid>
	<1239708396.5780.34.camel@domain.hid>
	<49E4750B.6060602@domain.hid>
	<1239709765.5780.40.camel@domain.hid>
	<49E4793D.2010105@domain.hid>
	<1239717322.5780.62.camel@domain.hid>
	<49E49A0B.1040307@domain.hid>
	<b131c9f0904170844w2f81b3acrc1b9386734a3ac28@domain.hid>
	<1240050469.26554.128.camel@domain.hid>
Date: Sun, 19 Apr 2009 20:23:02 +0200
Message-ID: <b131c9f0904191123s7783d9f6t8a353e29be592f8b@domain.hid>
From: vikesh rambaran <vikesh.rambaran@domain.hid>
Content-Type: multipart/alternative; boundary=00221532cf6c0fe3d90467ec81d7
Subject: Re: [Xenomai-help] Xenomai LTTng support
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
Cc: Jan Kiszka <jan.kiszka@domain.hid>, Vikesh Rambaran <vikesh.rambaran@domain.hid>, xenomai-help <xenomai@xenomai.org>

--00221532cf6c0fe3d90467ec81d7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi

On Sat, Apr 18, 2009 at 12:27 PM, Philippe Gerum <rpm@xenomai.org> wrote:

>
> >
> > Here's serial console output of two scenarios that produced a kernel
> > panic using kernel 2.6.28.7
> > with xenomai-head-6759ba0580f10f7465c8a205a68ce49e552ea77f
> >
>
> Does this patch show any improvement?
>
> http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe-2.6.28.9-x86-2.2-07.patch
>
> You may want to try this one if you plan to run 2.6.29 as well.
>
> http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.29.1-x86-2.3-01.patch
>

Thanx a lot for the quick updates! Appreciated.

Tried both the 2.6.28.9 and 2.6.29.1 kernels for a few hours each on an AMD
platform.
(Used the Xenomai 2.5 RC 1 source, since the patches are the same for that
release)

Good news : everything looks stable thus far with normal use and with
Xenomai apps running

Will do the same tests on the Intel platforms and give feedback

Keep well
Vicki

--00221532cf6c0fe3d90467ec81d7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi<br><br><div class=3D"gmail_quote">On Sat, Apr 18, 2009 at 12:27 PM, Phil=
ippe Gerum <span dir=3D"ltr">&lt;<a href=3D"mailto:rpm@xenomai.org">rpm@xenomai.org=
omai.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; p=
adding-left: 1ex;">
<div><div></div><div class=3D"h5"><br>
&gt;<br>
&gt; Here&#39;s serial console output of two scenarios that produced a kern=
el<br>
&gt; panic using kernel 2.6.28.7<br>
&gt; with xenomai-head-6759ba0580f10f7465c8a205a68ce49e552ea77f<br>
&gt;<br>
<br>
</div></div>Does this patch show any improvement?<br>
<a href=3D"http://download.gna.org/adeos/patches/v2.6/x86/older/adeos-ipipe=
-2.6.28.9-x86-2.2-07.patch" target=3D"_blank">http://download.gna.org/adeos=
/patches/v2.6/x86/older/adeos-ipipe-2.6.28.9-x86-2.2-07.patch</a><br>
<br>
You may want to try this one if you plan to run 2.6.29 as well.<br>
<a href=3D"http://download.gna.org/adeos/patches/v2.6/x86/adeos-ipipe-2.6.2=
9.1-x86-2.3-01.patch" target=3D"_blank">http://download.gna.org/adeos/patch=
es/v2.6/x86/adeos-ipipe-2.6.29.1-x86-2.3-01.patch</a><br>
</blockquote><div><br>Thanx a lot for the quick updates! Appreciated.<br><b=
r>Tried both the 2.6.28.9 and 2.6.29.1 kernels for a few hours each on an A=
MD platform. <br>(Used the Xenomai 2.5 RC 1 source, since the patches are t=
he same for that release)<br>
<br>Good news : everything looks stable thus far with normal use and with X=
enomai apps running<br><br>Will do the same tests on the Intel platforms an=
d give feedback<br><br>Keep well<br>Vicki<br></div></div><br>

--00221532cf6c0fe3d90467ec81d7--

