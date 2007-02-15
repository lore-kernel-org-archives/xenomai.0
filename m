Message-ID: <e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
Date: Thu, 15 Feb 2007 15:28:46 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <45D421EA.5070507@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_123675_7950176.1171533526091"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D0666C.8070409@domain.hid>
	<e45fe62b0702122319k463327b6o8cd72dde6af895a@domain.hid>
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
	<45D192EB.9030608@domain.hid>
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
	<45D2CE22.5010105@domain.hid>
	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
	<45D421EA.5070507@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai-help@domain.hid

------=_Part_123675_7950176.1171533526091
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok,

here is the code.
The code essentially cerates two tasks low and high priority task.
The low priority task has priority as 3 and high as 98

When i execute this initally everything goes smoothly as low priority task
starts running with priority thread 3 , it sleeps so then the high priority
thread runs with priority 98. But before the high priority thread finishes
the for loop for 7 times the low priority thread prempts it and starts
running with priority = 98.

This is what has baffled me?

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>

RT_TASK task1;
RT_TASK task2;
RT_TASK_INFO info;

void low_task(void *arg)
{
        rt_task_inquire(&task1, &info);
        printf("Priority of low task %d\n", info.cprio);

        rt_task_sleep(3000000000);

       while(1)
        {
                printf("Priority of Low task %d\n",info.cprio);
        }

}

void high_task(void *arg)
{
        unsigned int i;
        rt_task_inquire(&task2, &info);
        printf("Priority of high task before sleep %d\n", info.cprio);
        for(i=0;i<7;i++)
        {

                printf("Priority of High Priotity task1 %d\n",info.cprio);
                rt_task_sleep(1000000000);
        }

        printf("High priority thread goin to sleep %d\n",info.cprio);
        rt_task_sleep(3000000000);

        for(i=0;i<100;i++)
        {
                printf("Priority of High task2 %d\n",info.cprio);
        }

       int main(int argc, char* argv[])
{
        mlockall(MCL_CURRENT|MCL_FUTURE);

        rt_task_create(&task1, "Low Priority Task", 0, 3, 0);
        rt_task_create(&task2, "High Priority Task", 0, 98, 0);

        rt_task_start(&task1, &low_task, NULL);
        rt_task_start(&task2, &high_task, NULL);

        pause();

        rt_task_join(&task1);
        rt_task_join(&task2);

}













On 2/15/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
>
> Preetam Joshi wrote:
> > Hi,
> >
> > Do u mean to say that if i have created my tasks using native xenomai
> API's
> > like rt_task_create , then inside those tasks i will have to use posix
> skin
> > calls like pthread_setschedpolicy, etc...?
> >
> > Is that so.
>
> Nope. If you picked the native skin API, all scheduler setup for a RT
> task should be done through that interface.
>
> >
> > Cant i just have context switch between the tasks themselves say low
> > priority and a high priority task created by rt_task_create.
> >
> > Reason being i have created two tasks using the rt_task_create API and
> my
> > high priority task is runnning and my low priority task has slept, so as
> > soon as my low priority task has expired its sleep time and gets ready
> to
> > run,
> >
> > The low priority task preempts my high priority task and even its
> priority
> > gets raised to that of the high priority task and starts executing. The
> > higgh priority task gets suspended altogether amidst its running. Simply
> > baffled by the behavior?
>
> If you have found a weird behaviour of Xenomai, please post some
> as-small-as-possible demo code that exposes the issue. We will have a
> look at it.
>
> Jan
>
>
>

------=_Part_123675_7950176.1171533526091
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ok,<br><br>here is the code.<br>The code essentially cerates two tasks low and high priority task.<br>The low priority task has priority as 3 and high as 98<br><br>When i execute this initally everything goes smoothly as low priority task starts running with priority thread 3 , it sleeps so then the high priority thread runs with priority 98. But before the high priority thread finishes the for loop for 7 times the low priority thread prempts it and starts running with priority = 98.
<br><br>This is what has baffled me?<br><br>#include &lt;stdio.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>#include &lt;native/timer.h&gt;<br><br>RT_TASK task1;<br>
RT_TASK task2;<br>RT_TASK_INFO info;<br><br>void low_task(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_inquire(&amp;task1, &amp;info);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Priority of low task %d\n&quot;, info.cprio);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_sleep(3000000000);
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Priority of Low task %d\n&quot;,info.cprio);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>}<br><br>void high_task(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_inquire(&amp;task2, &amp;info);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Priority of high task before sleep %d\n&quot;, info.cprio);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(i=0;i&lt;7;i++)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Priority of High Priotity task1 %d\n&quot;,info.cprio);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_sleep(1000000000);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;High priority thread goin to sleep %d\n&quot;,info.cprio);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_sleep(3000000000);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for(i=0;i&lt;100;i++)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Priority of High task2 %d\n&quot;,info.cprio);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int main(int argc, char* argv[])<br>{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create(&amp;task1, &quot;Low Priority Task&quot;, 0, 3, 0);
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create(&amp;task2, &quot;High Priority Task&quot;, 0, 98, 0);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task1, &amp;low_task, NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task2, &amp;high_task, NULL);<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pause();
<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_join(&amp;task1);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_join(&amp;task2);<br><br>}<br><br><br><br><br><br><br><br><br><br><br><br><br><br><div><span class="gmail_quote">On 2/15/07, <b class="gmail_sendername">Jan Kiszka
</b> &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Preetam Joshi wrote:
<br>&gt; Hi,<br>&gt;<br>&gt; Do u mean to say that if i have created my tasks using native xenomai API&#39;s<br>&gt; like rt_task_create , then inside those tasks i will have to use posix skin<br>&gt; calls like pthread_setschedpolicy, etc...?
<br>&gt;<br>&gt; Is that so.<br><br>Nope. If you picked the native skin API, all scheduler setup for a RT<br>task should be done through that interface.<br><br>&gt;<br>&gt; Cant i just have context switch between the tasks themselves say low
<br>&gt; priority and a high priority task created by rt_task_create.<br>&gt;<br>&gt; Reason being i have created two tasks using the rt_task_create API and my<br>&gt; high priority task is runnning and my low priority task has slept, so as
<br>&gt; soon as my low priority task has expired its sleep time and gets ready to<br>&gt; run,<br>&gt;<br>&gt; The low priority task preempts my high priority task and even its priority<br>&gt; gets raised to that of the high priority task and starts executing. The
<br>&gt; higgh priority task gets suspended altogether amidst its running. Simply<br>&gt; baffled by the behavior?<br><br>If you have found a weird behaviour of Xenomai, please post some<br>as-small-as-possible demo code that exposes the issue. We will have a
<br>look at it.<br><br>Jan<br><br><br></blockquote></div><br>

------=_Part_123675_7950176.1171533526091--

