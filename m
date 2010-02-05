MIME-Version: 1.0
In-Reply-To: <4B6AF2D5.1000908@domain.hid>
References: <1aa9845a1002040751o549d86efh19c7c0c033dae2c1@domain.hid>
	<4B6AF2D5.1000908@domain.hid>
Date: Fri, 5 Feb 2010 21:53:36 +0530
Message-ID: <1aa9845a1002050823s2b1efe26hb17987f09f93c94@domain.hid>
From: Saravanan S <sarans1987@domain.hid>
Content-Type: multipart/alternative; boundary=0016e64dddcca77293047edcdff8
Subject: Re: [Xenomai-help] User interrupt handling in Xenomai running into
	probs
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stefan Kisdaroczi <kisda@domain.hid>
Cc: xenomai@xenomai.org

--0016e64dddcca77293047edcdff8
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Feb 4, 2010 at 9:46 PM, Stefan Kisdaroczi <kisda@domain.hid> wrote:

> Hi,
>
> Am 04.02.2010 16:51, schrieb Saravanan S:
> > Hi,
> >
> >     I tried to implement the hardware interrupt handling feature of
> > xenomai in user space.I read the native-api document and ran the
> > user_irq.c program with one change ,i tried to intercept the eth0
> > interrupt on my system(using interrupt number from cat
> > /proc/interrupts).When i ran the program the system froze!!!!!
>
> The rt_intr_* interface is disabled by default in the kernel configuration,
> please check.
> That would mean that rt_intr_wait returns immediately, now look at this
> loop from user_irq.c:
>    for (;;) {
>
>       /* Wait for the next interrupt on channel #7. */
>       err = rt_intr_wait(&intr_desc,TM_INFINITE);
>
>       if (!err) {
>           /* Process interrupt. */
>        }
>
>
Can you please indicate which variable in the kernel config controls that
setting???


> > What am i doing wrong??
> >
> > What  is the purpose of this feature of allowing user space handling of
> > interrupts.Can a user space driver be written using this???
>
> You should use the rtdm interface for drivers.
>

I know very little in kernel programming so thought it would be easier to
process interrrupts in user space.....


>
> Regards Stefan
>
>
Regards

S Saravanan

--0016e64dddcca77293047edcdff8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Thu, Feb 4, 2010 at 9:46 PM, Stefan K=
isdaroczi <span dir=3D"ltr">&lt;<a href=3D"mailto:kisda@domain.hid" target=
=3D"_blank">kisda@domain.hid</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">

Hi,<br>
<br>
Am 04.02.2010 16:51, schrieb Saravanan S:<br>
<div>&gt; Hi,<br>
&gt;<br>
&gt; =A0 =A0 I tried to implement the hardware interrupt handling feature o=
f<br>
&gt; xenomai in user space.I read the native-api document and ran the<br>
&gt; user_irq.c program with one change ,i tried to intercept the eth0<br>
&gt; interrupt on my system(using interrupt number from cat<br>
&gt; /proc/interrupts).When i ran the program the system froze!!!!!<br>
<br>
</div>The rt_intr_* interface is disabled by default in the kernel configur=
ation, please check.<br>
That would mean that rt_intr_wait returns immediately, now look at this loo=
p from user_irq.c:<br>
 =A0 =A0for (;;) {<br>
<br>
 =A0 =A0 =A0 /* Wait for the next interrupt on channel #7. */<br>
 =A0 =A0 =A0 err =3D rt_intr_wait(&amp;intr_desc,TM_INFINITE);<br>
<br>
 =A0 =A0 =A0 if (!err) {<br>
 =A0 =A0 =A0 =A0 =A0 /* Process interrupt. */<br>
<div> =A0 =A0 =A0 }<br>
<br></div></blockquote><div><br>Can you please indicate which variable in t=
he kernel config controls that setting???<br>=A0</div><blockquote class=3D"=
gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0p=
t 0pt 0pt 0.8ex; padding-left: 1ex;">
<div>
&gt; What am i doing wrong??<br>
&gt;<br>
&gt; What =A0is the purpose of this feature of allowing user space handling=
 of<br>
&gt; interrupts.Can a user space driver be written using this???<br>
<br>
</div>You should use the rtdm interface for drivers.<br></blockquote><div><=
br>I know very little in kernel programming so thought it would be easier t=
o process interrrupts in user space.....<br>=A0<br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<br>
Regards Stefan<br>
<br>
</blockquote></div><br>Regards <br><br>S Saravanan<br>

--0016e64dddcca77293047edcdff8--

