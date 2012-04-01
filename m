MIME-Version: 1.0
In-Reply-To: <4F7756AF.5000602@domain.hid>
References: <CAGq8jPgJUWE2YrhUMCshCtSsRyTWPqx5zV5vPnVzpF2ctN0edg@domain.hid>
	<4F7756AF.5000602@domain.hid>
Date: Mon, 2 Apr 2012 01:30:04 +0200
Message-ID: <CAGq8jPgjgm-nHW1Y6k8ea-Cdb24rE2PAqcsa9UHk8p6eePijtA@mail.gmail.com>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf3040e37a0fdfd404bca67474
Subject: Re: [Xenomai-help] difference Analogy API et rtdm API in xenomai
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
Cc: xenomai@xenomai.org

--20cf3040e37a0fdfd404bca67474
Content-Type: text/plain; charset=ISO-8859-1

Hello,

thank for your advice, my other question is that i should use the POSIX API
instead of Native API in Xenomai for my application because it will be more
portable, but it seems easier with Native API for development,  i'm wrong?
In conclusion, it will be better that i develop my project (data acquision
for example) with Analogy and POSIX API.



On Sat, Mar 31, 2012 at 9:10 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> On 03/30/2012 03:45 PM, Minh GIANG wrote:
> > hello everybody,
> >
> > i have a small question, which is the difference between the analogy API
> > and rtdm API in xenomai. for exemple, i think that i can open a port for
> > data transmission in the two api.
>
> The RTDM API is an API allowing to implement drivers for xenomai using
> the usual POSIX open/close/ioctl/etc... API.
>
> Analogy is a driver implemented using the RTDM API. So, you can access
> it using either the usual POSIX open/close/ioctl/etc... API, or using
> the analogy library provided.
>
> So, yes, you can use the two APIs, but using the analogy library is
> probably simpler.
>
> --
>                                                                Gilles.
>

--20cf3040e37a0fdfd404bca67474
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>thank for your advice, my other question is that i should use=
 the POSIX API instead of Native API in Xenomai for my application because =
it will be more portable, but it seems easier with Native API for developme=
nt,=A0  i&#39;m wrong?=A0 <br>
In conclusion, it will be better that i develop my project (data acquision =
for example) with Analogy and POSIX API.<br><br><br><br><div class=3D"gmail=
_quote">On Sat, Mar 31, 2012 at 9:10 PM, Gilles Chanteperdrix <span dir=3D"=
ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org">gilles.chantep=
erdrix@domain.hid</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">On 0=
3/30/2012 03:45 PM, Minh GIANG wrote:<br>
&gt; hello everybody,<br>
&gt;<br>
&gt; i have a small question, which is the difference between the analogy A=
PI<br>
&gt; and rtdm API in xenomai. for exemple, i think that i can open a port f=
or<br>
&gt; data transmission in the two api.<br>
<br>
</div></div>The RTDM API is an API allowing to implement drivers for xenoma=
i using<br>
the usual POSIX open/close/ioctl/etc... API.<br>
<br>
Analogy is a driver implemented using the RTDM API. So, you can access<br>
it using either the usual POSIX open/close/ioctl/etc... API, or using<br>
the analogy library provided.<br>
<br>
So, yes, you can use the two APIs, but using the analogy library is<br>
probably simpler.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></span></blockquote></div><br>

--20cf3040e37a0fdfd404bca67474--

