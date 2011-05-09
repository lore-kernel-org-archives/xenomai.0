MIME-Version: 1.0
In-Reply-To: <4DC430AE.20206@domain.hid>
References: <BANLkTi=qj7YfrFvQJPPZQbLjx=QSJqWzng@domain.hid>
	<4DC430AE.20206@domain.hid>
Date: Mon, 9 May 2011 08:57:11 +0200
Message-ID: <BANLkTik9LH8WO8uTvWz+msGt=L61ZagJyg@domain.hid>
From: Aurele Traynard <aurele.traynard@domain.hid>
Content-Type: multipart/alternative; boundary=0016e645b94847b2b004a2d2596c
Subject: Re: [Xenomai-help] user-space support : Inconsistency detected by
	ld.so
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

--0016e645b94847b2b004a2d2596c
Content-Type: text/plain; charset=ISO-8859-1

Hello

it is activate... is it bad or is there a workaround
CONFIG_IWMMXT=y

thanks

2011/5/6 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 05/06/2011 05:13 PM, Aurele Traynard wrote:
> > hello all,
> >
> > I have a problem whith user-space support :
> > I compile a program with makefile of Xenomai and when i want to use it
> this
> > apear :
> >
> > Inconsistency detected by ld.so: dl-deps.c: 622: _dl_map_object_deps:
> > Assertion`nlist > 1' failed!
> >
> > compilation process :
> >
> >
> DESTDIR=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging
> > make
> >
> XENO=/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/
> > arm-none-linux-gnueabi-gcc
> >
> -I/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/include
> > -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__   -lnative
> >
> -L/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
> > -lxenomai -lpthread  -O -Xlinker -rpath -Xlinker
> >
> /home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/usr/xenomai/lib
> > playing_led_rt.c   -o playing_led_rt
> > playing_led_rt.c: In function 'main':
> > playing_led_rt.c:126:2: warning: format '%08X' expects type 'unsigned
> int',
> > but argument 3 has type 'long unsigned int'
> > playing_led_rt.c:128:2: warning: format '%08X' expects type 'unsigned
> int',
> > but argument 2 has type 'long unsigned int'
> >
> > I have made two programs one with rt_tasks but he don't work, so supress
> all
> > real-time call and it doesn't work again with the same error.
> >
> > does anyone have a way to go?
> > thanks for reply
>
> This looks like a bug in the context switch routine. How is
> CONFIG_IWMMXT in your kernel configuration?
>
>
> --
>                                                                 Gilles.
>

--0016e645b94847b2b004a2d2596c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello<br><br>it is activate... is it bad or is there a workaround <br>CONFI=
G_IWMMXT=3Dy<br><br>thanks<br><br><div class=3D"gmail_quote">2011/5/6 Gille=
s Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdri=
x@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex;"><div><div></div><div class=3D"h5">On 05/06/=
2011 05:13 PM, Aurele Traynard wrote:<br>
&gt; hello all,<br>
&gt;<br>
&gt; I have a problem whith user-space support :<br>
&gt; I compile a program with makefile of Xenomai and when i want to use it=
 this<br>
&gt; apear :<br>
&gt;<br>
&gt; Inconsistency detected by ld.so: dl-deps.c: 622: _dl_map_object_deps:<=
br>
&gt; Assertion`nlist &gt; 1&#39; failed!<br>
&gt;<br>
&gt; compilation process :<br>
&gt;<br>
&gt; DESTDIR=3D/home/aurele/workdir/test/test_noyau/buildroot-2010.08/outpu=
t/staging<br>
&gt; make<br>
&gt; XENO=3D/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/s=
taging/usr/xenomai/<br>
&gt; arm-none-linux-gnueabi-gcc<br>
&gt; -I/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/stagin=
g/usr/xenomai/include<br>
&gt; -D_GNU_SOURCE -D_REENTRANT -Wall -pipe -D__XENO__ =A0 -lnative<br>
&gt; -L/home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/stagin=
g/usr/xenomai/lib<br>
&gt; -lxenomai -lpthread =A0-O -Xlinker -rpath -Xlinker<br>
&gt; /home/aurele/workdir/test/test_noyau/buildroot-2010.08/output/staging/=
usr/xenomai/lib<br>
&gt; playing_led_rt.c =A0 -o playing_led_rt<br>
&gt; playing_led_rt.c: In function &#39;main&#39;:<br>
&gt; playing_led_rt.c:126:2: warning: format &#39;%08X&#39; expects type &#=
39;unsigned int&#39;,<br>
&gt; but argument 3 has type &#39;long unsigned int&#39;<br>
&gt; playing_led_rt.c:128:2: warning: format &#39;%08X&#39; expects type &#=
39;unsigned int&#39;,<br>
&gt; but argument 2 has type &#39;long unsigned int&#39;<br>
&gt;<br>
&gt; I have made two programs one with rt_tasks but he don&#39;t work, so s=
upress all<br>
&gt; real-time call and it doesn&#39;t work again with the same error.<br>
&gt;<br>
&gt; does anyone have a way to go?<br>
&gt; thanks for reply<br>
<br>
</div></div>This looks like a bug in the context switch routine. How is<br>
CONFIG_IWMMXT in your kernel configuration?<br>
<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>

--0016e645b94847b2b004a2d2596c--

