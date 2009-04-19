MIME-Version: 1.0
In-Reply-To: <49E89BC7.6000704@domain.hid>
References: <2b490f270904170749m3ec39cc8vddab1b5aa50f4b4c@domain.hid>
	<49E89BC7.6000704@domain.hid>
Date: Sun, 19 Apr 2009 10:51:53 +0200
Message-ID: <2b490f270904190151n70cfc610u9a742da5c62e4076@domain.hid>
From: Dehann Fourie <dehann.fourie@domain.hid>
Content-Type: multipart/alternative; boundary=0016364d1fef85e0110467e48684
Subject: Re: [Xenomai-help] RT Serial, rt_dev_read blocking problem
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

--0016364d1fef85e0110467e48684
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Gilles,

Thanks a lot. Will give it a try. I have tried  .rx_timeout =
RTSER_TIMEOUT_NONE before, but then I was not able to read any data. I am
assuming the data expired before I had read it. This was on a different
config however, so I will try it again.

Please excuse my lack of knowledge but I am not following you on:
-  ... and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31
-     from head.

Thanks again and kind regards,
Dehann

On Fri, Apr 17, 2009 at 5:09 PM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> Dehann Fourie wrote:
> > Hi,
> >
> > I am having trouble with reading data from the serial port. I initially
> > followed the RT Serial example from captain. I changed the read task to a
> > periodic 20ms task, from which I read from the serial port (rtser0). This
> is
> > all that the rt_task is doing. The serial port config is:
> >
> > static const struct rtser_config
> > <
> http://www.xenomai.org/documentation/trunk/html/api/structrtser__config.html
> >
> > read_config = {
> >         .config_mask       = 0xFFFF,
> >         .baud_rate         = 57600,
> >         .parity            = RTSER_NO_PARITY,
> >         .data_bits         = RTSER_8_BITS,
> >         .stop_bits         = RTSER_1_STOPB,
> >         .handshake         = RTSER_NO_HAND,
> >         .fifo_depth        = RTSER_DEF_FIFO_DEPTH,
> >         .rx_timeout        = RTSER_DEF_TIMEOUT,
>
> Did you try to set .rx_timeout = RTSER_TIMEOUT_NONE here ? I may be
> completely wrong because I never used the serial driver, but it looks
> like what you are looking for.
>
> > I am on a Geode 500MHz single board computer with kernel 2.6.23 and xeno
> > 2.4.3.
>
> Some issues with FPU on Geode were fixed recently, so, you should use
> Xenomai 2.4.7, using the latest I-pipe patch which ship with this
> version, and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31
> from head.
>
> --
>                                             Gilles.
>



-- 
Dehann Fourie

--0016364d1fef85e0110467e48684
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Gilles,<br><br>Thanks a lot. Will give it a try. I have tried=A0 .rx_tim=
eout =3D=A0 RTSER_TIMEOUT_NONE before, but then I was not able to read any =
data. I am assuming the data expired before I had read it. This was on a di=
fferent config however, so I will try it again.<br>
<br>Please excuse my lack of knowledge but I am not following you on:<br>-=
=A0 ... and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31<br><d=
iv id=3D":9d" class=3D"ii gt">
-=A0=A0=A0=A0 from head.</div><br>Thanks again and kind regards,<br>Dehann<=
br><br><div class=3D"gmail_quote">On Fri, Apr 17, 2009 at 5:09 PM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>Dehann Fourie wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am having trouble with reading data from the serial port. I initiall=
y<br>
&gt; followed the RT Serial example from captain. I changed the read task t=
o a<br>
&gt; periodic 20ms task, from which I read from the serial port (rtser0). T=
his is<br>
&gt; all that the rt_task is doing. The serial port config is:<br>
&gt;<br>
&gt; static const struct rtser_config<br>
</div>&gt; &lt;<a href=3D"http://www.xenomai.org/documentation/trunk/html/a=
pi/structrtser__config.html" target=3D"_blank">http://www.xenomai.org/docum=
entation/trunk/html/api/structrtser__config.html</a>&gt;<br>
<div class=3D"im">&gt; read_config =3D {<br>
&gt; =A0 =A0 =A0 =A0 .config_mask =A0 =A0 =A0 =3D 0xFFFF,<br>
&gt; =A0 =A0 =A0 =A0 .baud_rate =A0 =A0 =A0 =A0 =3D 57600,<br>
&gt; =A0 =A0 =A0 =A0 .parity =A0 =A0 =A0 =A0 =A0 =A0=3D RTSER_NO_PARITY,<br=
>
&gt; =A0 =A0 =A0 =A0 .data_bits =A0 =A0 =A0 =A0 =3D RTSER_8_BITS,<br>
&gt; =A0 =A0 =A0 =A0 .stop_bits =A0 =A0 =A0 =A0 =3D RTSER_1_STOPB,<br>
&gt; =A0 =A0 =A0 =A0 .handshake =A0 =A0 =A0 =A0 =3D RTSER_NO_HAND,<br>
&gt; =A0 =A0 =A0 =A0 .fifo_depth =A0 =A0 =A0 =A0=3D RTSER_DEF_FIFO_DEPTH,<b=
r>
&gt; =A0 =A0 =A0 =A0 .rx_timeout =A0 =A0 =A0 =A0=3D RTSER_DEF_TIMEOUT,<br>
<br>
</div>Did you try to set .rx_timeout =3D RTSER_TIMEOUT_NONE here ? I may be=
<br>
completely wrong because I never used the serial driver, but it looks<br>
like what you are looking for.<br>
<div class=3D"im"><br>
&gt; I am on a Geode 500MHz single board computer with kernel 2.6.23 and xe=
no<br>
&gt; 2.4.3.<br>
<br>
</div>Some issues with FPU on Geode were fixed recently, so, you should use=
<br>
Xenomai 2.4.7, using the latest I-pipe patch which ship with this<br>
version, and apply the commit 3a23967f3cc8d6881d8e3280130bbc431195aa31<br>
from head.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Gilles.<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>Dehann Fourie<br=
>

--0016364d1fef85e0110467e48684--

