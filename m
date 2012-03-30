MIME-Version: 1.0
In-Reply-To: <4F75B5BF.8030401@domain.hid>
References: <CAGq8jPhOy=v8Lccb+hddH9W_u8p-Ayi+XfEcFC+rHVzsSp-ghg@domain.hid>
	<4F7555F7.6010102@domain.hid>
	<CAGq8jPioLnu+ehj+LA5dL6OWUpxQnUH+Nh01kB088FtsLsSrGA@mail.gmail.com>
	<CAGq8jPi4S4TTBy9dLYYnWuWQdX_awhXxu0C93okgFO5vWv_20A@mail.gmail.com>
	<4F75B5BF.8030401@domain.hid>
Date: Fri, 30 Mar 2012 16:34:55 +0200
Message-ID: <CAGq8jPgY6fTw0ufdj=pvc+Q1jrrQkYptSHTzFOQK=qSiJJU32Q@mail.gmail.com>
From: Minh GIANG <giang.hminh@domain.hid>
Content-Type: multipart/alternative; boundary=20cf303f6794857a1804bc76be8a
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

--20cf303f6794857a1804bc76be8a
Content-Type: text/plain; charset=ISO-8859-1

hi,

with option RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl(), this function returns
un number -110 (Connection timed out)
with option RTSER_RTIOC_GET_STATUS in rt_dev_ioctl(), this function returns
un number 0 (not message)

Anyway, currently it works without  rt_dev_ioctl(), i can see rt_dev_read()
wait data event (with debug mode) while giving the period of write
task,  for exemple  = two seconds.

so can i remove the funtion rt_dev_ioctl?


On Fri, Mar 30, 2012 at 3:31 PM, Wolfgang Grandegger <wg@domain.hid>wrote:

> On 03/30/2012 01:15 PM, Minh GIANG wrote:
> > hello,
> >
> > after testing a lot of time, i have one port which doesn't work well in
> > writing (material problem i think). Now it works in writing and reading
> > with one condtion that i have to remove the function
> > "err=rt_dev_ioctl(...)" because it returns error.
>
> Hm, what does rt_dev_ioctl() return?
>
> > could you tell me the interet of this function? i think that rt_dev_read
> is
> > enough to read the message.
>
> Well, the ioctl waits for certain events and informs the task when they
> occur. "cross_link.c" actually waits for the RTSER_EVENT_RXPEND meaning
> that RX data are available. So, the sub-sequent read will/must work. You
> do not need to call that ioctl but the read directly. But I doubt that
> the read return successfully.
>
> Maybe the interrupt service routine does detect errors due to hardware
> problems:
>
>
> http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/serial/16550A.c#213
>
> and that's why the interrupt counter increases.
>
> You could check that by setting RTSER_EVENT_ERRPEND or reading the
> status using the ioctl request RTSER_RTIOC_GET_STATUS.
>
> Wolfgang.
>
> > On Fri, Mar 30, 2012 at 10:45 AM, Minh GIANG <giang.hminh@domain.hid>
> wrote:
> >
> >> hello,
> >> thanks for your response. i compile cross-link program in ECLIPSE C++ so
> >> my command in setting configuration is
> >> command :   g++
> >> All options:   -l/usr/xenomai/include -O3 -wall -c -fmessage-length=0
> >>
> >> i connected 2 serial port of my computer by one cable in order to make
> the
> >> test. The write task works well but the other task is blocked by
> rt_dev_ioctl(...).as
> >> i already mentionned and when i removed rt_dev_ioctl, the "rt_dev_read"
> >> function return 0
> >> I did what you said, but it doesn't work yet
> >>
> >> On Fri, Mar 30, 2012 at 8:43 AM, Wolfgang Grandegger <wg@domain.hid
> >wrote:
> >>
> >>> On 03/29/2012 05:26 PM, Minh GIANG wrote:
> >>>> i want to revive the topic over the problem RTSER_RTIOC_WAIT_EVENT
> >>>> while compiling cross-link.c program. I cann't resolve my problem
> >>>> after doing some solution given by the others
> >>>>
> >>>> Loading module:
> >>>>
> >>>> insmod ./xeno_16550A.ko io=0x3f8,0x2f8 irq=4,3 tx_fifo=10,20
> >>>
> >>> Hm, is a FIFO size of 20 supported by the hardware? For a first try I
> >>> would drop "tx_fifo=10,20" (using the default of 16 for both uarts).
> >>>
> >>>> start_index=0 (i have two serial ports on my pc)
> >>>>
> >>>> running crosslink test:
> >>>>
> >>>> main : write-file opened
> >>>> main : write-config written
> >>>> main : read-file opened
> >>>> main : read-config written
> >>>> main : write-task created
> >>>> main : read-task created
> >>>> main : starting write-task
> >>>> main : starting read-task
> >>>>  Nr |   write->irq    |    irq->read    |   write->read   |
> >>>> -----------------------------------------------------------
> >>>> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
> >>>> read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection timed out
> >>>>
> >>>> ...
> >>>>
> >>>>
> >>>>
> >>>> running test:
> >>>>
> >>>> cat /proc/xenomai/irq
> >>>>
> >>>> IRQ         CPU0
> >>>>   3:        1089         rtser1
> >>>>   4:        5155         rtser0
> >>>
> >>> You get interrupts, at least, but not the same amount, strange. What
> >>> cross-link command options do you use?
> >>>
> >>> Wolfgang.
> >>>
> >>
> >>
> >
>
>

--20cf303f6794857a1804bc76be8a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<div><br></div><div>with option=A0RTSER_RTIOC_WAIT_EVENT in rt_dev_ioctl=
(), this function returns un number -110 (Connection timed out)</div><div>w=
ith option=A0RTSER_RTIOC_GET_STATUS=A0in rt_dev_ioctl(), this function retu=
rns un number 0 (not message)</div>
<div><br></div><div>Anyway, currently it works without =A0rt_dev_ioctl(), i=
 can see rt_dev_read() wait data event=A0(with debug mode)=A0while giving t=
he period of write task,=A0=A0for exemple=A0=A0=3D two seconds.</div><div><=
br></div><div>
so can i remove the funtion rt_dev_ioctl?</div><div><br><br><div class=3D"g=
mail_quote">On Fri, Mar 30, 2012 at 3:31 PM, Wolfgang Grandegger <span dir=
=3D"ltr">&lt;<a href=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;=
</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On 03/30/2012 01:15 PM, Mi=
nh GIANG wrote:<br>
&gt; hello,<br>
&gt;<br>
&gt; after testing a lot of time, i have one port which doesn&#39;t work we=
ll in<br>
&gt; writing (material problem i think). Now it works in writing and readin=
g<br>
&gt; with one condtion that i have to remove the function<br>
&gt; &quot;err=3Drt_dev_ioctl(...)&quot; because it returns error.<br>
<br>
</div>Hm, what does rt_dev_ioctl() return?<br>
<div class=3D"im"><br>
&gt; could you tell me the interet of this function? i think that rt_dev_re=
ad is<br>
&gt; enough to read the message.<br>
<br>
</div>Well, the ioctl waits for certain events and informs the task when th=
ey<br>
occur. &quot;cross_link.c&quot; actually waits for the RTSER_EVENT_RXPEND m=
eaning<br>
that RX data are available. So, the sub-sequent read will/must work. You<br=
>
do not need to call that ioctl but the read directly. But I doubt that<br>
the read return successfully.<br>
<br>
Maybe the interrupt service routine does detect errors due to hardware<br>
problems:<br>
<br>
<a href=3D"http://www.rts.uni-hannover.de/xenomai/lxr/source/ksrc/drivers/s=
erial/16550A.c#213" target=3D"_blank">http://www.rts.uni-hannover.de/xenoma=
i/lxr/source/ksrc/drivers/serial/16550A.c#213</a><br>
<br>
and that&#39;s why the interrupt counter increases.<br>
<br>
You could check that by setting RTSER_EVENT_ERRPEND or reading the<br>
status using the ioctl request RTSER_RTIOC_GET_STATUS.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Wolfgang.<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; On Fri, Mar 30, 2012 at 10:45 AM, Minh GIANG &lt;<a href=3D"mailto:gia=
ng.hminh@domain.hid">giang.hminh@domain.hid</a>&gt; wrote:<br>
&gt;<br>
&gt;&gt; hello,<br>
&gt;&gt; thanks for your response. i compile cross-link program in ECLIPSE =
C++ so<br>
&gt;&gt; my command in setting configuration is<br>
&gt;&gt; command : =A0 g++<br>
&gt;&gt; All options: =A0 -l/usr/xenomai/include -O3 -wall -c -fmessage-len=
gth=3D0<br>
&gt;&gt;<br>
&gt;&gt; i connected 2 serial port of my computer by one cable in order to =
make the<br>
&gt;&gt; test. The write task works well but the other task is blocked by r=
t_dev_ioctl(...).as<br>
&gt;&gt; i already mentionned and when i removed rt_dev_ioctl, the &quot;rt=
_dev_read&quot;<br>
&gt;&gt; function return 0<br>
&gt;&gt; I did what you said, but it doesn&#39;t work yet<br>
&gt;&gt;<br>
&gt;&gt; On Fri, Mar 30, 2012 at 8:43 AM, Wolfgang Grandegger &lt;<a href=
=3D"mailto:wg@domain.hid">wg@domain.hid</a>&gt;wrote:<br>
&gt;&gt;<br>
&gt;&gt;&gt; On 03/29/2012 05:26 PM, Minh GIANG wrote:<br>
&gt;&gt;&gt;&gt; i want to revive the topic over the problem RTSER_RTIOC_WA=
IT_EVENT<br>
&gt;&gt;&gt;&gt; while compiling cross-link.c program. I cann&#39;t resolve=
 my problem<br>
&gt;&gt;&gt;&gt; after doing some solution given by the others<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Loading module:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; insmod ./xeno_16550A.ko io=3D0x3f8,0x2f8 irq=3D4,3 tx_fifo=
=3D10,20<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hm, is a FIFO size of 20 supported by the hardware? For a firs=
t try I<br>
&gt;&gt;&gt; would drop &quot;tx_fifo=3D10,20&quot; (using the default of 1=
6 for both uarts).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; start_index=3D0 (i have two serial ports on my pc)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; running crosslink test:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; main : write-file opened<br>
&gt;&gt;&gt;&gt; main : write-config written<br>
&gt;&gt;&gt;&gt; main : read-file opened<br>
&gt;&gt;&gt;&gt; main : read-config written<br>
&gt;&gt;&gt;&gt; main : write-task created<br>
&gt;&gt;&gt;&gt; main : read-task created<br>
&gt;&gt;&gt;&gt; main : starting write-task<br>
&gt;&gt;&gt;&gt; main : starting read-task<br>
&gt;&gt;&gt;&gt; =A0Nr | =A0 write-&gt;irq =A0 =A0| =A0 =A0irq-&gt;read =A0=
 =A0| =A0 write-&gt;read =A0 |<br>
&gt;&gt;&gt;&gt; ----------------------------------------------------------=
-<br>
&gt;&gt;&gt;&gt; read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection tim=
ed out<br>
&gt;&gt;&gt;&gt; read_task: error on RTSER_RTIOC_WAIT_EVENT, Connection tim=
ed out<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; ...<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; running test:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; cat /proc/xenomai/irq<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; IRQ =A0 =A0 =A0 =A0 CPU0<br>
&gt;&gt;&gt;&gt; =A0 3: =A0 =A0 =A0 =A01089 =A0 =A0 =A0 =A0 rtser1<br>
&gt;&gt;&gt;&gt; =A0 4: =A0 =A0 =A0 =A05155 =A0 =A0 =A0 =A0 rtser0<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; You get interrupts, at least, but not the same amount, strange=
. What<br>
&gt;&gt;&gt; cross-link command options do you use?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Wolfgang.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div>

--20cf303f6794857a1804bc76be8a--

