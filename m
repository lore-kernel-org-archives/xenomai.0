MIME-Version: 1.0
In-Reply-To: <4F75C7D1.4020808@domain.hid>
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
	<4F7555F7.6010102@domain.hid>
	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
	<4F75B5BF.8030401@domain.hid>
	<CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
	<4F75C7D1.4020808@domain.hid>
Date: Mon, 2 Apr 2012 10:25:24 +0200
Message-ID: <CAGq8jPhqv16jgPQh631x8S2MmDhm1F4HtnrQA0xsGPe4bTo6eA@mail.gmail.com>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=001636c5bf8f8c18ad04bcadeec8
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

--001636c5bf8f8c18ad04bcadeec8
Content-Type: text/plain; charset=ISO-8859-1

hello,

i don't know how call the function rt_dev_ioctl() after the timeout
happened, this function is called in the begining of "while" loop
(cross-link program).
I get the value of struct  rtser_status,
line status = 96
modem status = 176
to be honest, i don't know why cross-line program works without the
function  rt_dev_ioctl() with  RTSER_RTIOC_WAIT_EVENT in  option.

main : write-file opened
main : write-config written
main : read-file opened
main : read-config written
main : write-task created
main : read-task created
main : starting write-task
main : starting read-task
 Nr |   write->irq    |    irq->read    |   write->read   |
-----------------------------------------------------------
  0 |17113389816533987823 |1333354257183912191 |         8348398
  1 |17113389815533997483 |1333354258183885264 |         8331131
  2 |17113389814533998100 |1333354259183882033 |         8328517
  3 |17113389813534000420 |1333354260183884535 |         8333339
  4 |17113389812533998430 |1333354261183888665 |         8335479
......

i tried to send a character table, and it also worked.



On Fri, Mar 30, 2012 at 4:48 PM, Wolfgang Grandegger <wg@domain.hid>wrote:

> On 03/30/2012 04:34 PM, Minh GIANG wrote:
> > hi,
> >
> > with option RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl(), this function
> returns
> > un number -110 (Connection timed out)
> > with option RTSER_RTIOC_GET_STATUS in rt_dev_ioctl(), this function
> returns
> > un number 0 (not message)
>
> You should call this function *after* the timeout happened. What does
> the "struct rtser_status"  contain? Especially the "line_status" is of
> interest.
>
> >
> > Anyway, currently it works without  rt_dev_ioctl(), i can see
> rt_dev_read()
> > wait data event (with debug mode) while giving the period of write
> > task,  for exemple  = two seconds.
> >
> > so can i remove the funtion rt_dev_ioctl?
>
> The rt_dev_ioctl should work. You can remove it, but the problem will
> remain. To debug the problem you could also add some printk's here:
>
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A.c#223
>
> Especially the value of "iir" might be interesting.
>
> Wolfgang.
>

--001636c5bf8f8c18ad04bcadeec8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hello,=A0<div><br></div><div>i don&#39;t know how call the function rt_dev_=
ioctl() after the timeout happened, this function is called in the begining=
 of &quot;while&quot; loop (cross-link program).</div><div>I get the value =
of struct=A0
rtser_status,=A0</div><div>line status =3D 96</div><div>modem status =3D 17=
6</div><div>to be honest, i don&#39;t know why cross-line program works wit=
hout the function=A0
rt_dev_ioctl() with =A0RTSER_RTIOC_WAIT_EVENT=A0in =A0option.</div><div><br=
></div><div><div>main : write-file opened</div><div>main : write-config wri=
tten</div><div>main : read-file opened</div><div>main : read-config written=
</div>
<div>main : write-task created</div><div>main : read-task created</div><div=
>main : starting write-task</div><div>main : starting read-task</div><div>=
=A0Nr | =A0 write-&gt;irq =A0 =A0| =A0 =A0irq-&gt;read =A0 =A0| =A0 write-&=
gt;read =A0 |</div>
<div>-----------------------------------------------------------</div><div>=
=A0 0 |17113389816533987823 |1333354257183912191 | =A0 =A0 =A0 =A0 8348398<=
/div><div>=A0 1 |17113389815533997483 |1333354258183885264 | =A0 =A0 =A0 =
=A0 8331131</div><div>
=A0 2 |17113389814533998100 |1333354259183882033 | =A0 =A0 =A0 =A0 8328517<=
/div><div>=A0 3 |17113389813534000420 |1333354260183884535 | =A0 =A0 =A0 =
=A0 8333339</div><div>=A0 4 |17113389812533998430 |1333354261183888665 | =
=A0 =A0 =A0 =A0 8335479</div><div>
......</div><div><br></div><div>i tried to send a character table, and it=
=A0also=A0worked.</div><div><br></div><div><br></div><br><div class=3D"gmai=
l_quote">On Fri, Mar 30, 2012 at 4:48 PM, Wolfgang Grandegger <span dir=3D"=
ltr">&lt;<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;</sp=
an> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 03/30/2012 04:34 PM, Mi=
nh GIANG wrote:<br>
&gt; hi,<br>
&gt;<br>
&gt; with option RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl(), this function re=
turns<br>
&gt; un number -110 (Connection timed out)<br>
&gt; with option RTSER_RTIOC_GET_STATUS in rt_dev_ioctl(), this function re=
turns<br>
&gt; un number 0 (not message)<br>
<br>
</div>You should call this function *after* the timeout happened. What does=
<br>
the &quot;struct rtser_status&quot; =A0contain? Especially the &quot;line_s=
tatus&quot; is of<br>
interest.<br>
<div class=3D"im"><br>
&gt;<br>
&gt; Anyway, currently it works without =A0rt_dev_ioctl(), i can see rt_dev=
_read()<br>
&gt; wait data event (with debug mode) while giving the period of write<br>
&gt; task, =A0for exemple =A0=3D two seconds.<br>
&gt;<br>
&gt; so can i remove the funtion rt_dev_ioctl?<br>
<br>
</div>The rt_dev_ioctl should work. You can remove it, but the problem will=
<br>
remain. To debug the problem you could also add some printk&#39;s here:<br>
<br>
<a href=3D"http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/s=
erial/16550A.c#223" target=3D"_blank">http://www.rts.uni-hannover.de/xenoma=
i/lxr/source/ksrc/drivers/serial/16550A.c#223</a><br>
<br>
Especially the value of &quot;iir&quot; might be interesting.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span></blockquote></div><br></div>

--001636c5bf8f8c18ad04bcadeec8--

