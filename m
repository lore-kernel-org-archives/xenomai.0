MIME-Version: 1.0
In-Reply-To: <4EA1D1F4.3010507@domain.hid>
References: <CAMwkeZxmX1dU-5d2zDiYqv_SRcFqyDF+gmp+i8t=q1G6NXrmbg@domain.hid>
	<4EA19A9D.1080502@domain.hid>
	<CAMwkeZwpNG9i0fGFRXQBOtpaaLZU6L2HvD=bBjM21em3dVCfZg@domain.hid>
	<4EA1B033.6060707@domain.hid>
	<CAMwkeZyTBkswrYe5TKaVZcY6Hm9FpefTSzLLABaN4HkgXFCa8g@domain.hid>
	<4EA1BE4C.5030301@domain.hid>
	<CAMwkeZzPDN5TFKiU05tuZdW4=yHT1XoWe2=xwceiimRw-rF4_w@domain.hid>
	<4EA1C2FB.1050009@domain.hid>
	<CAMwkeZwXzXZrGoXxPxyisOCkekf3jzjWh5pp-Ddv5oj9kL4ZdQ@mail.gmail.com>
	<4EA1D1F4.3010507@domain.hid>
Date: Fri, 21 Oct 2011 18:27:21 -0200
Message-ID: <CAMwkeZxTOHGPLc+nc1hSK25sKmd3MvyWXD-aAq0HCGaJ7D-kBA@mail.gmail.com>
From: =?UTF-8?Q?Fernando_Herrero_Carr=C3=B3n?= <elferdo@domain.hid>
Content-Type: multipart/alternative; boundary=bcaec5215d7b77dbd804afd4e662
Subject: Re: [Xenomai-help] rt_task_wait_period returns an undocumented value
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Daniele Nicolodi <daniele@domain.hid>
Cc: xenomai@xenomai.org

--bcaec5215d7b77dbd804afd4e662
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2011/10/21 Daniele Nicolodi <daniele@domain.hid>

> On 21/10/11 21:15, Fernando Herrero Carr=C3=B3n wrote:
> > Ok, thanks for the advice. The computations I will be doing will not be
> > very expensive in principle, but I believe the analogy infrastructure i=
s
> > the actual bottleneck. I have not been able to perform the acquisitions
> > I want beyond 10kHz. At higher frequencies it looks like analogy does
> > not have enough time to acknowledge all DMA interruptions. But this is =
a
> > different issue.
>
> I think you are doing something wrong then (and the fact that you need a
> periodic task to perform such acquisitions smells like there is
> something wrong in your code). I have acquisitions running at over 200
> kHz for weeks without a glitch.
>
> Cheers,
>
>
Dear Daniele,

I'm glad to hear from you, because I found some posts on the list that
pointed to my same problems.

Actually no, I don't need a periodic task. I was just comparing interrupt
based vs. polling based acquisitions. But my first attempt has always been
using the TRIG_WAKE_EOS flag to setup a command and then use read() in
comedi and then async_read() in analogy to read those values.

I've got one question for you. Do you process each scan separately or are
you working with blocks? 15kHz in comedi and 10kHz with analogy has been th=
e
highest rate I have achieved for end-of-scan processing (reading 8 channels
and writing 8 channels in each iteration of the loop).

I am very interested in your approach, any help is greatly appreciated.

Fernando

--bcaec5215d7b77dbd804afd4e662
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2011/10/21 Daniele Nicolodi <span dir=3D"ltr">&l=
t;<a href=3D"mailto:daniele@domain.hid">daniele@domain.hid</a>&gt;</span><b=
r><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; bor=
der-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">On 21/10/11 21:15, Fernando Herrero Carr=C3=B3n wrote:<br=
>
&gt; Ok, thanks for the advice. The computations I will be doing will not b=
e<br>
&gt; very expensive in principle, but I believe the analogy infrastructure =
is<br>
&gt; the actual bottleneck. I have not been able to perform the acquisition=
s<br>
&gt; I want beyond 10kHz. At higher frequencies it looks like analogy does<=
br>
&gt; not have enough time to acknowledge all DMA interruptions. But this is=
 a<br>
&gt; different issue.<br>
<br>
</div>I think you are doing something wrong then (and the fact that you nee=
d a<br>
periodic task to perform such acquisitions smells like there is<br>
something wrong in your code). I have acquisitions running at over 200<br>
kHz for weeks without a glitch.<br>
<br>
Cheers,<br><br></blockquote></div><br>Dear Daniele,<br><br>I&#39;m glad to =
hear from you, because I found some posts on the list that pointed to my sa=
me problems.<br><br>Actually no, I don&#39;t need a periodic task. I was ju=
st comparing interrupt based vs. polling based acquisitions. But my first a=
ttempt has always been using the TRIG_WAKE_EOS flag to setup a command and =
then use read() in comedi and then async_read() in analogy to read those va=
lues.<br>
<br>I&#39;ve got one question for you. Do you process each scan separately =
or are you working with blocks? 15kHz in comedi and 10kHz with analogy has =
been the highest rate I have achieved for end-of-scan processing (reading 8=
 channels and writing 8 channels in each iteration of the loop).<br>
<br>I am very interested in your approach, any help is greatly appreciated.=
<br><br>Fernando<br>

--bcaec5215d7b77dbd804afd4e662--

