Message-ID: <475E7CBA.7060300@domain.hid>
Date: Tue, 11 Dec 2007 13:04:10 +0100
From: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
MIME-Version: 1.0
References: <475E76A0.4010007@domain.hid>
In-Reply-To: <475E76A0.4010007@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: Quoted-Printable
Subject: Re: [Xenomai-help] Application broken 2.3.4 ---> 2.4.0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Ignacio Garc=EDa P=E9rez escribi=F3:

Ok, replying myself with further findings:

It turns out that the following code miserably fails to set the thread=20
periodic:

rt_task_set_periodic(&_blink_thread, rt_timer_read(), mili2count(250));

Where this actually works:

rt_task_set_periodic(&_blink_thread, TM_NOW, mili2count(250));

Which makes me think that rt_task_set_periodic() fails when the passed=20
idate is in the past.

And you may say: why the hell do you use rt_timer_read() when you can=20
use TM_NOW ???

Well, I think that rt_task_set_periodic should word (AND DID) both ways,=20
but actually I have a very good reason to (sometimes) use an idate in=20
the past: I want the blinking synchronized to the "event" as closely as=20
possible. If there is a delay D from my recorded time for the event to=20
the actual call to rt_task_set_periodic, I can:

a) Use rt_task_set_periodic(TM_NOD)

b) Use rt_task_set_periodic(recorded_time)

In the first case there will be a delay of D from every period to the=20
"event", while in the second case that delay will be only in the FIRST=20
execution of the periodic task.

Anyway, something is truly screwed up when=20
rt_task_set_periodic(&_blink_thread, rt_timer_read(), mili2count(250))=20
fails to make the task periodic...

> Hi,
>
> I've compiled a previously 100% working application under the new 2.4.0=
=20
> release and found the following issues:
>
>
> 1- rt_task_set_periodic does not work sometimes?
>
> In this application I have a periodic task (250ms period) which is used=
=20
> to blink some lights. The blinking is occasionally resynchronized to=20
> some external event, and this is what I do:
>
> In the periodic task:
>
> blink_count =3D 0;
> rt_task_set_periodic();
> for (;;) {
>     whatever();
>     blink_count =3D (blink_count + 1) & 3;
>     rt_task_wait_period();
> }
>
> Some somewhere else, when I want to synchronize the blinking:
>
>     blink_count =3D 0;
>     rt_task_set_periodic();
>
> This has worked perfectly until version 2.4.0. It seems that further=20
> calls to rt_task_set_periodic (from a different task) break the=20
> periodicity (the periodic task enters rt_task_wait_period() and never=20
> leaves again).
>
> Any clues?
>  =20


