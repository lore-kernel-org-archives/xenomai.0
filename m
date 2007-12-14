MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-ID: <18274.54045.838102.705505@domain.hid>
Date: Fri, 14 Dec 2007 20:01:49 +0100
In-Reply-To: <4762B80F.3020804@domain.hid>
References: <475E76A0.4010007@domain.hid> <475E7CBA.7060300@domain.hid>
	<475E7F84.1040600@domain.hid> <475E8DAE.9070405@domain.hid>
	<2ff1a98a0712110541x12633fa3yb311214d9d0245a1@domain.hid>
	<475EA9F4.3020306@domain.hid>
	<2ff1a98a0712110841y7d16bb2esfca8fdfd7419ea5e@domain.hid>
	<47624674.5070107@domain.hid>
	<2ff1a98a0712140146o2a3c5761i8a97d67921fedecd@domain.hid>
	<4762B80F.3020804@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
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
To: =?ISO-8859-1?Q?Ignacio_Garc=EDa_P=E9rez?= <iggarpe@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Ignacio Garc=EDa P=E9rez wrote:
 > <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
 > <html>
 > <head>
 >   <meta content=3D"text/html;charset=3DISO-8859-1" http-equiv=3D"Content=
-Type">
 > </head>
 > <body bgcolor=3D"#ffffff" text=3D"#000000">
 > <br>
 > <blockquote
 >  cite=3D"mid:2ff1a98a0712140146o2a3c5761i8a97d67921fedecd@domain.hid"
 >  type=3D"cite">
 >   <blockquote type=3D"cite">
 >     <pre wrap=3D"">immediate execution while in 2.4.0 it is not.
 >     </pre>
 >   </blockquote>
 >   <pre wrap=3D""><!---->
 > I do not see this in 2.3.4 code, but let's admit it is true: then
 > v2.3.4 code is broken, and so is your application. Really, no RTOS
 > allows starting timers with dates in the past, you can check the
 > various Xenomai skins implementation or the posix spec. So, our advice
 > is to fix your application.
 >=20
 >   </pre>
 > </blockquote>
 > <br>
 > I agree it makes no sense to start a timer in the past, but we are not
 > talking about a timer, but about a <b>task</b>.<br>
 > <br>

Yeah, but guess what ? the rt_task_set_periodic starts a timer, so what
you are basically asking is the ability to start a timer with a date in
the past.

 > The discussion is: I want to make a task periodic starting a "little
 > while" ago, what should the rt_task_set_periodic do:<br>
 > <br>
 > a) Fail and do nothing about the task (actually it will <b>stop</b> it
 > if it was already periodic !!!).<br>
 > <br>
 > b) Fail, but schedule the task for immediate execution and set it
 > periodic starting at the specified date plus a period multiple such
 > that the result is in the future.<br>
 > <br>

This is a bad idea, a service which fails should have as little effect
as possible, precisely because it... failed.

 > Not only it seems to me that (b) makes more sense and does something
 > actually useful, but also <b>I think there is no way I can do the
 > equivalent in an atomic way in the application code</b> (I mean without
 > resorting to non-native API functions).<br>
 > <br>
 > I might be wrong, and if so, I'll really appreciate an example of how
 > do to that. Atomically. Meanwhile this is the only thing I could come
 > up with:<br>
 > <br>
 > while ((r =3D rt_task_set_periodic(&amp;mytask, start, period)) =3D=3D
 > -ETIMEDOUT) {<br>
 > &nbsp;&nbsp;&nbsp; count++; start +=3D period;<br>
 > }<br>
 > if (count &gt; 0) rt_task_resume(&amp;mytask);<br>
 > <br>

The rt_task_resume call will only cause a spurious wakeup. Remove it,
and you have a working solution.

 > That code, would however have a non-desirable effect under certain
 > circumstances: let's assume that I want a task A executed, rather than
 > every T milliseconds, N times per second. If the "master" if both tasks
 > are prevented from executing by some other task with higher priority
 > for a large amount of time larger than several periods, several
 > executions would be skipped, which may not be the best solution (maybe
 > I'd rather have the task A execute its processing loop severan times
 > nonstop until it "cathes up" with the total expected number of
 > executions).<br>
 > <br>
 > And now that I think about it, &iquest;what happens to a periodic task w=
hen it
 > is prevented from executing by some other higher priority task for an
 > interval equivalent to several periods?<br>

This is called an overrun, and this is what is returned by the calls to
rt_task_wait_period, if you do not pass a null pointer.

 > <br>
 > Regards.<br>
 > <br>
 > Nacho.<br>
 > <br>
 > <br>
 > <br>
 > <br>
 > </body>
 > </html>


--=20


					    Gilles Chanteperdrix.

