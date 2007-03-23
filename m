Message-ID: <b647ffbd0703230142n46a215ddv5ab0e2c984d0d93c@domain.hid>
Date: Fri, 23 Mar 2007 09:42:18 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@domain.hid>
Subject: Re: [Xenomai-help] [RT_PIPE] - User space read() not waking up
In-Reply-To: <20070322215707.232970@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_227476_3040698.1174639338548"
References: <20070322215707.232970@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Viktor Stark <abraar@domain.hid>
Cc: Xenomai help <xenomai@xenomai.org>

------=_Part_227476_3040698.1174639338548
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,


I wrote a RT kernel module for a DAQ card. The DAQ card gets interrupts
> every 200 us (5 kHz) and I've got a RT interrupt handler which wakes up a RT
> function


I guess, you mean a RT task. Is it a kernel or user space task?


[...]
> So basically, my question is:
> If I have rt_pipe_write() writing to a pipe from a kernel module with a
> 200 us period and I have a read() in a tight loop reading from that same
> pipe is user space, what could be the origin of the fact that sometimes my
> read() doesn't get woken up?


Xenomai does provide a Linux system with hard real-time support but it
doesn't make the Linux kernel itself hard real-time, nor user-space
applications which relies merely on the standard kernel services.

Your task (here it even doesn't matter whether it's a linux or xenomai task)
relies on read() so it's under control of the linux scheduler, hence it
depends on the /scheduling latency/ provided by Linux, not Xenomai.

Roughly speaking, with Xenomai you have 2 domains: primary (all
time-critical activities must stay here) and secondary (Linux standard
drivers, applications, xenomai tasks while executing linux system calls).

So hard real-time support is provided only as long as your tasks/drivers
work in the primary domain. To this goal, (1) drivers are developed with
RTDM (preferable way); (2) applications (both kernel and user-space) are
developed using one of the Xenomai skins (native, posix, ...).

And as I mentioned above, it's not a case for your task with a read() loop.

So you should probably reconsider your application design to clearly
separate the parts that require hard real-time support from the rest.


-- 
Best regards,
Dmitry Adamushko

------=_Part_227476_3040698.1174639338548
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div><div><br>
Hello,<br>
&nbsp;</div><br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">I
wrote a RT kernel module for a DAQ card. The DAQ card gets interrupts
every 200 us (5 kHz) and I&#39;ve got a RT interrupt handler which wakes up
a RT function</blockquote><div><br>
I guess, you mean a RT task. Is it a kernel or user space task?<br>
&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">[...]<br>So basically, my question is:<br>If
I have rt_pipe_write() writing to a pipe from a kernel module with a
200 us period and I have a read() in a tight loop reading from that
same pipe is user space, what could be the origin of the fact that
sometimes my read() doesn&#39;t get woken up?</blockquote><div><br>
Xenomai does provide a Linux system with hard real-time support but it
doesn&#39;t make the Linux kernel itself hard real-time, nor user-space
applications which relies merely on the standard kernel services.<br>
<br>
Your task (here it even doesn&#39;t matter whether it&#39;s a linux or xenomai
task) relies on read() so it&#39;s under control of the linux scheduler,
hence it depends on the /scheduling latency/ provided by Linux, not
Xenomai.<br>
<br>
Roughly speaking, with Xenomai you have 2 domains: primary (all
time-critical activities must stay here) and secondary (Linux standard
drivers, applications, xenomai tasks while executing linux system
calls).<br>
<br>
So hard real-time support is provided only as long as your
tasks/drivers work in the primary domain. To this goal, (1) drivers are
developed with RTDM (preferable way); (2) applications (both kernel and
user-space) are developed using one of the Xenomai skins (native,
posix, ...).<br><br>
And as I mentioned above, it&#39;s not a case for your task with a read() loop.<br>
<br>
So you should probably reconsider your application design to clearly
separate the parts that require hard real-time support from the rest.<br>
<br>
</div></div><br>-- <br>Best regards,<br>Dmitry Adamushko

------=_Part_227476_3040698.1174639338548--

