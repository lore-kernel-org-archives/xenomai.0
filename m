Message-ID: <d3f72a390801280610k7298eae0tfd626e574b8cccff@domain.hid>
Date: Mon, 28 Jan 2008 15:10:00 +0100
From: "axel axel" <softaxel@domain.hid>
In-Reply-To: <18333.52494.176360.871342@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_12419_21839552.1201529400442"
References: <d3f72a390801280134l6073203fr3cee621b34321301@domain.hid>
	<18333.52494.176360.871342@domain.hid>
Subject: Re: [Xenomai-core] RESCHEDULE TASK
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_12419_21839552.1201529400442
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

thanks for the response but all that i want to know is a general answer:

what does the periodic timer do respect oneshot timer ? ( i understand that
xenomai scheduler can't stop realtime task in execution ).

I think that periodic timer has the chance to run other task with the same
priority even if the task is working ( for example a sum like this a = a + 1
+ sin( a );)

Thanks a lot

Roberto

2008/1/28, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>:
>
> axel axel wrote:
> > Hi,
> >
> >
> > after the previouses answers about not sleeping tasks ( mailing list
> thread
> > "task scheduling e priority"* *) i ask you how to reschedule a not
> sleeping
> > task.
>
> When you want to reply to a previous mail, just hit the "reply" button,
> that is what it is made for, and it makes discussions much easier to
> follow for anyone reading the list.
>
> >
> > I explain better:
> >
> > if my xenomai primary task work for example for 7 seconds without sleep
> the
> > other task and linux don't work.
> >
> > How can i run the task for a estabilished time ( for example 10 ms ) and
> > start schedule for other task without insert in the task sleep or other
> > instruction ?
>
> We do not know exactly what is doing the task which runs all the time,
> so it is hard to give you a precise answer. Thus I will give you a very
> general answer: redesign your application so that it is event-driven.
>
> --
>
>
>                                             Gilles Chanteperdrix.
>

------=_Part_12419_21839552.1201529400442
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>thanks for the response but all that i want to know is a general answer:<br><br>what does the periodic timer do respect oneshot timer ? ( i understand that xenomai scheduler can&#39;t stop realtime task in execution ).<br>
<br>I think that periodic timer has the chance to run other task with the same priority even if the task is working ( for example a sum like this a = a + 1 + sin( a );)<br><br>Thanks a lot<br><br>Roberto<br><br><div><span class="gmail_quote">2008/1/28, Gilles Chanteperdrix &lt;<a href="mailto:gilles.chanteperdrix@xenomai.org">gilles.chanteperdrix@xenomai.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
axel axel wrote:<br> &gt; Hi,<br> &gt;<br> &gt;<br> &gt; after the previouses answers about not sleeping tasks ( mailing list thread<br> &gt; &quot;task scheduling e priority&quot;* *) i ask you how to reschedule a not sleeping<br>
 &gt; task.<br><br>When you want to reply to a previous mail, just hit the &quot;reply&quot; button,<br>that is what it is made for, and it makes discussions much easier to<br>follow for anyone reading the list.<br><br> &gt;<br>
 &gt; I explain better:<br> &gt;<br> &gt; if my xenomai primary task work for example for 7 seconds without sleep the<br> &gt; other task and linux don&#39;t work.<br> &gt;<br> &gt; How can i run the task for a estabilished time ( for example 10 ms ) and<br>
 &gt; start schedule for other task without insert in the task sleep or other<br> &gt; instruction ?<br><br>We do not know exactly what is doing the task which runs all the time,<br>so it is hard to give you a precise answer. Thus I will give you a very<br>
general answer: redesign your application so that it is event-driven.<br><br>--<br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gilles Chanteperdrix.<br></blockquote></div><br>

------=_Part_12419_21839552.1201529400442--

