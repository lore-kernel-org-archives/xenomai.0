Message-ID: <e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
Date: Thu, 15 Feb 2007 12:49:25 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <45D2CE22.5010105@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_121998_17870309.1171523965209"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D029B8.1030805@domain.hid>
	<e45fe62b0702120448i7b23bd24o4fa88a05237a69a@domain.hid>
	<45D0666C.8070409@domain.hid>
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
	<45D192EB.9030608@domain.hid>
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
	<45D2CE22.5010105@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jan.kiszka@domain.hid
Cc: Xenomai-help@domain.hid

------=_Part_121998_17870309.1171523965209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Do u mean to say that if i have created my tasks using native xenomai API's
like rt_task_create , then inside those tasks i will have to use posix skin
calls like pthread_setschedpolicy, etc...?

Is that so.

Cant i just have context switch between the tasks themselves say low
priority and a high priority task created by rt_task_create.

Reason being i have created two tasks using the rt_task_create API and my
high priority task is runnning and my low priority task has slept, so as
soon as my low priority task has expired its sleep time and gets ready to
run,

The low priority task preempts my high priority task and even its priority
gets raised to that of the high priority task and starts executing. The
higgh priority task gets suspended altogether amidst its running. Simply
baffled by the behavior?

On 2/14/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Preetam Joshi wrote:
> > Hi ,
> >
> > Its working now .
> >
> > But how do i set a scheduling policy say FIFO for a real time task . ?
>
> Depends on the skin you use. Please have a look at the available API
> documentation regarding how to set priorities or scheduling policies.
>
> Jan
>
>
>

------=_Part_121998_17870309.1171523965209
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>Do u mean to say that if i have created my tasks using native xenomai API&#39;s like rt_task_create , then inside those tasks i will have to use posix skin calls like pthread_setschedpolicy, etc...?<br><br>Is that so. 
<br><br>Cant i just have context switch between the tasks themselves say low priority and a high priority task created by rt_task_create. <br><br>Reason being i have created two tasks using the rt_task_create API and my high priority task is runnning and my low priority task has slept, so as soon as my low priority task has expired its sleep time and gets ready to run,
<br><br><span style="font-weight: bold;">The low priority task preempts my high priority task and even its priority gets raised to that of the high priority task and starts executing. The higgh priority task gets suspended altogether amidst its running. 
<span style="font-weight: bold;">Simply baffled by the behavior?</span><br></span><br><div><span class="gmail_quote">On 2/14/07, <b class="gmail_sendername">Jan Kiszka</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Preetam Joshi wrote:<br>&gt; Hi ,<br>&gt;<br>&gt; Its working now .<br>
&gt;<br>&gt; But how do i set a scheduling policy say FIFO for a real time task . ?<br><br>Depends on the skin you use. Please have a look at the available API<br>documentation regarding how to set priorities or scheduling policies.
<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_121998_17870309.1171523965209--

