MIME-Version: 1.0
In-Reply-To: <4E09D243.4050706@domain.hid>
References: <BANLkTi=2WnfLFC9DVQY81obGPO6_CG_PCA@mail.gmail.com>
	<4E086122.7060405@domain.hid>
	<BANLkTimCab2u0EOrJ6JtLTVLNAzktbvFQg@domain.hid>
	<4E09D243.4050706@domain.hid>
Date: Tue, 28 Jun 2011 16:02:55 +0200
Message-ID: <BANLkTimTquz4n7qMzRd05gWAi6rkMmc2gw@domain.hid>
From: Adrien LEMAITRE <adrien.lemaitre@domain.hid>
Content-Type: multipart/alternative; boundary=90e6ba6e8cfae0f1af04a6c61fef
Subject: Re: [Xenomai-help] Program hangs using "rt_task_sleep" in a
 particular way
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

--90e6ba6e8cfae0f1af04a6c61fef
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Thanks for your answer.

2011/6/28 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> The problem is that the "rt_task_spawn" service causes its caller to
> switch to secondary mode. This means, that the task is no longer real-time.
>

I wasn't aware of this fact. It could be annoying if we have to create
several RT Tasks...
It's only true for rt_task_spawn or for all Xenomai services ?

A better practice will to first make several rt_task_create and after
activate them by rt_task_start services?



> Normally, root thread priority coupling should allow to avoid that.
> Unfortunately, there is a small hole in this functionality which make it
> not work in some conditions (and fixing this hole would introduce a
> possibility of priority inversion).
>
My advisor (jerome Delatour from ESEO) want to better understand this point,
where could I find explanations on this point ?


> As for the influence of the length of the call to rt_task_sleep, a short
> rt_task_sleep will cause the "go" task to switch to primary mode and
> preempt the task "WorkingTask1" before it is completely started.
>

OK, I will also make some test around this.


> Nevertheless(2), xenomai needs linux to run in order to work correctly,
> so, the real-time tasks should always suspend to let linux run. I bet if
> you put an rt_task_sleep in WorkingTask1 and WorkingTask2 loop, the test
> will no longer hang.
>
Yes, even a rt_task-sleep(0) or rt_task_sleep(1) works, but I thought
because in that case we force a call to the Xenomai scheduler


>
> Please no private mails.
>
I apologize, my gmail didn't work as expected.


Adrien, Engineering student at ESEO

--90e6ba6e8cfae0f1af04a6c61fef
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Thanks for your answer.<br><br><div class=3D"gmail_quote">2011/6=
/28 Gilles Chanteperdrix <span dir=3D"ltr">&lt;<a href=3D"mailto:gilles.cha=
nteperdrix@domain.hid">gilles.chanteperdrix@xenomai.org</a>&gt;</span><br>=
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
The problem is that the &quot;rt_task_spawn&quot; service causes its caller=
 to<br>
switch to secondary mode. This means, that the task is no longer real-time.=
<br></blockquote><div><br>I wasn&#39;t aware of this fact. It could be anno=
ying if we have to create several RT Tasks...<br>It&#39;s only true for rt_=
task_spawn or for all Xenomai services ?<br>
<br>A better practice will to first make several rt_task_create and after a=
ctivate them by rt_task_start services?<br><br>=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid=
 rgb(204, 204, 204); padding-left: 1ex;">


Normally, root thread priority coupling should allow to avoid that.<br>
Unfortunately, there is a small hole in this functionality which make it<br=
>
not work in some conditions (and fixing this hole would introduce a<br>
possibility of priority inversion).<br></blockquote><div>My advisor (jerome=
 Delatour from ESEO) want to better understand this point, where could I fi=
nd explanations on this point ?<br>=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204,=
 204); padding-left: 1ex;">


As for the influence of the length of the call to rt_task_sleep, a short<br=
>
rt_task_sleep will cause the &quot;go&quot; task to switch to primary mode =
and<br>
preempt the task &quot;WorkingTask1&quot; before it is completely started.<=
br></blockquote><div><br>OK, I will also make some test around this.<br>=A0=
</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex;=
 border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


Nevertheless(2), xenomai needs linux to run in order to work correctly,<br>
so, the real-time tasks should always suspend to let linux run. I bet if<br=
>
you put an rt_task_sleep in WorkingTask1 and WorkingTask2 loop, the test<br=
>
will no longer hang.<br></blockquote><div>Yes, even a rt_task-sleep(0) or r=
t_task_sleep(1) works, but I thought because in that case we force a call t=
o the Xenomai scheduler<br>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); p=
adding-left: 1ex;">

<br>
Please no private mails.<br></blockquote><div>I apologize, my gmail didn&#3=
9;t work as expected.<br><br><br>Adrien, Engineering student at ESEO<br></d=
iv></div><br>

--90e6ba6e8cfae0f1af04a6c61fef--

