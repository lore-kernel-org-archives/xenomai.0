MIME-Version: 1.0
In-Reply-To: <4D4D6F32.4070302@domain.hid>
References: <AANLkTi=pm4BfNAwCzw-6HLOiKfJQmgMQdPmVXTcCBSBs@domain.hid>
	<4D49CF24.9080700@domain.hid>
	<AANLkTinaTVSJW1jQzn7+jbsQgNE+HAEOXLEK3LC0MoWR@mail.gmail.com>
	<4D49D608.5020006@domain.hid>
	<AANLkTinU4b-SY6Vy7=Ss+Nxrp-+qEZ6qsTudBsmrjbh_@domain.hid>
	<4D4A80F6.5020600@domain.hid> <4D4A8354.7010209@domain.hid>
	<AANLkTim3M6fPN5u6AjNn5xdwbOM9AmzB+yG2w37o1A3J@mail.gmail.com>
	<4D4C7F10.3020703@domain.hid>
	<AANLkTi=QiGXpMwdY3tEz=Qo0tO8Q5fe1xnPpo+dX3eEP@mail.gmail.com>
	<4D4D6F32.4070302@domain.hid>
Date: Sat, 5 Feb 2011 11:26:00 -0600
Message-ID: <AANLkTinu8tB1iiNS5gjMTYOqJ6=dO2ddrvZp=HCOgJ1e@domain.hid>
From: at91_enthus <nwromania@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba615418e14cda049b8c4a7c
Subject: Re: [Xenomai-help] I-pipe clock source change and MMC issues (AT91)
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

--90e6ba615418e14cda049b8c4a7c
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Feb 5, 2011 at 9:39 AM, Gilles Chanteperdrix <
gilles.chanteperdrix@xenomai.org> wrote:

> at91_enthus wrote:
> >>> Rookie mistake. Indeed, I can have everything in userspace using
> Xenomai.
> >> I
>
> Or in kernel-space... with Xenomai RTDM skin.
>
> >>> wrote a simple program that did a periodic job every 100 us and the
> >> jitter
> >>> was very small (around 20 us without load and around 35 us with SSH-ing
> >> and
> >>> Xenomai compilation running on board).
>
> Well, as we often say, benchmarking requires making more than that to
> load the board, and for a long time.
>
> >>>
> >>> Somewhat unrelated to this thread, I found that when I invoked
> >>> rt_task_set_periodic(), I got very precise timings (as expected).
> >> However,
> >>> when I tried to insert small delays using rt_timer_spin(), the errors
> >>> (t_meas - t_spin_func_argument) were not large, but noticeable. For
> >> example,
> >>> I can precisely measure a 50 us periodic task on the scope. With the
> same
> >>> interval in rt_timer_spin(), I get 55-60 us. As far as I understood,
> all
> >>> timing-related functions use the same time base, so what's the reason
> for
> >>> this behavior?
> >>
>
> Well, rt_task_set_periodic gets the hardware timer to tick exactly every
> 50us. So, whatever time it takes between the return of the call to
> rt_task_wait_period() to the entry of the next is irrelevant. And
> particularily, the jitter will not matter as long as it is smaller than
> 50u.
>
> On the other hand, doing:
>
> for(;;) {
>        /* Do something */
>        rt_timer_spin(50000);
> }
>
> The period of the loop will be 50us + rt_timer_spin jitter + time to "do
> something". And so, will not even be constant.
> You are not creating a periodic task. Besides, the system will not
> execute anything else in user-space than your real-time task, and in
> particular, the Linux will never run. Except of course if "do something"
> contains a call to some secondary domain function, in which case, your
> real-time task no longer is real-time.
>
> So, that is not the correct way to get a periodic task.
>
> --
>                                                                 Gilles.
>

Actually, the rt_timer_spin was included in this function that is run as a
real time task:

void spin(){

    rt_task_set_periodic(&spin_task,TM_NOW, 100000);

    while(1){

    *((unsigned int *) (piob_base + (PIO_SODR))) = 1<<0;

     rt_task_wait_period(NULL);

     *((unsigned int *) (piob_base + (PIO_CODR))) = 1<<0;

     rt_timer_spin(50000);

  }

I decided to go for simple GPIOs manipulation, so I can have a better
picture of what's happening on the scope.

R.

--90e6ba615418e14cda049b8c4a7c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Sat, Feb 5, 2011 at 9:39 AM, Gilles C=
hanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
enomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-lef=
t: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<div class=3D"im">at91_enthus wrote:<br>
&gt;&gt;&gt; Rookie mistake. Indeed, I can have everything in userspace usi=
ng Xenomai.<br>
&gt;&gt; I<br>
<br>
</div>Or in kernel-space... with Xenomai RTDM skin.<br>
<div class=3D"im"><br>
&gt;&gt;&gt; wrote a simple program that did a periodic job every 100 us an=
d the<br>
&gt;&gt; jitter<br>
&gt;&gt;&gt; was very small (around 20 us without load and around 35 us wit=
h SSH-ing<br>
&gt;&gt; and<br>
&gt;&gt;&gt; Xenomai compilation running on board).<br>
<br>
</div>Well, as we often say, benchmarking requires making more than that to=
<br>
load the board, and for a long time.<br>
<div class=3D"im"><br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Somewhat unrelated to this thread, I found that when I invoked=
<br>
&gt;&gt;&gt; rt_task_set_periodic(), I got very precise timings (as expecte=
d).<br>
&gt;&gt; However,<br>
&gt;&gt;&gt; when I tried to insert small delays using rt_timer_spin(), the=
 errors<br>
&gt;&gt;&gt; (t_meas - t_spin_func_argument) were not large, but noticeable=
. For<br>
&gt;&gt; example,<br>
&gt;&gt;&gt; I can precisely measure a 50 us periodic task on the scope. Wi=
th the same<br>
&gt;&gt;&gt; interval in rt_timer_spin(), I get 55-60 us. As far as I under=
stood, all<br>
&gt;&gt;&gt; timing-related functions use the same time base, so what&#39;s=
 the reason for<br>
&gt;&gt;&gt; this behavior?<br>
&gt;&gt;<br>
<br>
</div>Well, rt_task_set_periodic gets the hardware timer to tick exactly ev=
ery<br>
50us. So, whatever time it takes between the return of the call to<br>
rt_task_wait_period() to the entry of the next is irrelevant. And<br>
particularily, the jitter will not matter as long as it is smaller than 50u=
.<br>
<br>
On the other hand, doing:<br>
<br>
for(;;) {<br>
 =A0 =A0 =A0 =A0/* Do something */<br>
 =A0 =A0 =A0 =A0rt_timer_spin(50000);<br>
}<br>
<br>
The period of the loop will be 50us + rt_timer_spin jitter + time to &quot;=
do<br>
something&quot;. And so, will not even be constant.<br>
You are not creating a periodic task. Besides, the system will not<br>
execute anything else in user-space than your real-time task, and in<br>
particular, the Linux will never run. Except of course if &quot;do somethin=
g&quot;<br>
contains a call to some secondary domain function, in which case, your<br>
real-time task no longer is real-time.<br>
<br>
So, that is not the correct way to get a periodic task.<br>
<br>
--<br>
<font color=3D"#888888"> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0Gilles.<br>
</font></blockquote></div><br>Actually, the rt_timer_spin was included in t=
his function that is run as a real time task:<br><br>void spin(){<br><br>=
=A0=A0=A0 rt_task_set_periodic(&amp;spin_task,TM_NOW, 100000);<br>=A0=A0 <b=
r>=A0=A0=A0 while(1){<br>
=A0<br>=A0=A0=A0 *((unsigned int *) (piob_base + (PIO_SODR))) =3D 1&lt;&lt;=
0;<br>=A0<br>=A0 =A0=A0 rt_task_wait_period(NULL);=A0 <br>=A0=A0=A0 <br>=A0=
=A0=A0=A0 *((unsigned int *) (piob_base + (PIO_CODR))) =3D 1&lt;&lt;0;<br><=
br>=A0 =A0=A0 rt_timer_spin(50000);<br>
<br>=A0 }<br><br>I decided to go for simple GPIOs manipulation, so I can ha=
ve a better picture of what&#39;s happening on the scope.<br><br>R.<br>

--90e6ba615418e14cda049b8c4a7c--

