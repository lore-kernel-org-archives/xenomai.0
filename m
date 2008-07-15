Message-ID: <6132061f0807151602j50626e9bse74d5b578418fd56@domain.hid>
Date: Tue, 15 Jul 2008 20:02:48 -0300
From: "Breno Carneiro Pinheiro" <brenodee@domain.hid>
In-Reply-To: <200807150803.52326.Sebastian.Smolorz@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_14602_6654939.1216162968609"
References: <6132061f0807141723u5125f946m324749aa81fbdcc6@domain.hid>
	<200807150803.52326.Sebastian.Smolorz@domain.hid>
Subject: Re: [Xenomai-help] rtsocketcan in kernel space
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Sebastian Smolorz <Sebastian.Smolorz@domain.hid>
Cc: xenomai@xenomai.org

------=_Part_14602_6654939.1216162968609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks Sebastian. Btw, I'd like to know whether  it's possible to change the
task's period or task's priority on-line. I mean, is there a way to change
the period or priority using rt_task_set_priority or rt_task_set_periodic
calls?

Thanks a lot,

Breno

2008/7/15 Sebastian Smolorz <Sebastian.Smolorz@domain.hid>:

> Breno Carneiro Pinheiro wrote:
> > Is it possible to write an application using rtsocketcan to run on kernel
> > space? I mean, buid a kernel module using functions from rtsocketcan API.
>
> RTDM provides an inter-driver API, see:
>
> http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__interdrv.html
>
> This is for calling RTDM driver functions from kernel space. But ask
> yourself
> whether it is really necessary for you to write an application in kernel
> space. User space applications are highly recommended.
>
> --
> Sebastian
>

------=_Part_14602_6654939.1216162968609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Thanks Sebastian. Btw, I&#39;d like to know whether&nbsp; it&#39;s possible to change the task&#39;s period or task&#39;s priority on-line. I mean, is there a way to change the period or priority using rt_task_set_priority or rt_task_set_periodic calls?<br>
<br>Thanks a lot,<br><br>Breno<br><br><div class="gmail_quote">2008/7/15 Sebastian Smolorz &lt;<a href="mailto:Sebastian.Smolorz@domain.hid">Sebastian.Smolorz@domain.hid</a>&gt;:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class="Ih2E3d">Breno Carneiro Pinheiro wrote:<br>
&gt; Is it possible to write an application using rtsocketcan to run on kernel<br>
&gt; space? I mean, buid a kernel module using functions from rtsocketcan API.<br>
<br>
</div>RTDM provides an inter-driver API, see:<br>
<a href="http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__interdrv.html" target="_blank">http://www.xenomai.org/documentation/branches/v2.4.x/html/api/group__interdrv.html</a><br>
<br>
This is for calling RTDM driver functions from kernel space. But ask yourself<br>
whether it is really necessary for you to write an application in kernel<br>
space. User space applications are highly recommended.<br>
<br>
--<br>
<font color="#888888">Sebastian<br>
</font></blockquote></div><br></div>

------=_Part_14602_6654939.1216162968609--

