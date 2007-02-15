Message-ID: <e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
Date: Thu, 15 Feb 2007 15:46:51 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <45D431CF.5090201@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_123947_10263597.1171534611060"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<45D171F9.7000705@domain.hid>
	<e45fe62b0702130021i5ec6c345m699a9abcc2e665c0@domain.hid>
	<45D192EB.9030608@domain.hid>
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
	<45D2CE22.5010105@domain.hid>
	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
	<45D421EA.5070507@domain.hid>
	<e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
	<45D431CF.5090201@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_123947_10263597.1171534611060
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi using it inside the task loop wwud give me RT_TASK_info as undeclared its
a global structure even as mentioned in the API documentation and the
behavior wud neways still remain the same as i mentioned in the code?

Please execute the code and comment.

Thanks.

On 2/15/07, Anders Blomdell <anders.blomdell@domain.hid> wrote:
>
> Preetam Joshi wrote:
> > ok,
> >
> > here is the code.
> > The code essentially cerates two tasks low and high priority task.
> > The low priority task has priority as 3 and high as 98
> >
> > When i execute this initally everything goes smoothly as low priority
> task
> > starts running with priority thread 3 , it sleeps so then the high
> priority
> > thread runs with priority 98. But before the high priority thread
> finishes
> > the for loop for 7 times the low priority thread prempts it and starts
> > running with priority = 98.
> Nope, you just don't read the state (using a global is also a bad idea).
>
> >
> > This is what has baffled me?
> >
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <sys/mman.h>
> > #include <native/task.h>
> > #include <native/timer.h>
> >
> > RT_TASK task1;
> > RT_TASK task2;
> > RT_TASK_INFO info;
> >
> > void low_task(void *arg)
> > {
>           RT_TASK_INFO info;
> >        rt_task_inquire(&task1, &info);
> >        printf("Priority of low task %d\n", info.cprio);
> >
> >        rt_task_sleep(3000000000);
> >
> >       while(1)
> >        {
>                   rt_task_inquire(&task1, &info);
> >                printf("Priority of Low task %d\n",info.cprio);
> >        }
> >
> > }
> >
> > void high_task(void *arg)
> > {
> >        unsigned int i;
> >        rt_task_inquire(&task2, &info);
> >        printf("Priority of high task before sleep %d\n", info.cprio);
> >        for(i=0;i<7;i++)
> >        {
> >
> >                printf("Priority of High Priotity task1 %d\n",info.cprio
> );
> >                rt_task_sleep(1000000000);
> >        }
> >
> >        printf("High priority thread goin to sleep %d\n",info.cprio);
> >        rt_task_sleep(3000000000);
> >
> >        for(i=0;i<100;i++)
> >        {
> >                printf("Priority of High task2 %d\n",info.cprio);
> >        }
> >
> >       int main(int argc, char* argv[])
> > {
> >        mlockall(MCL_CURRENT|MCL_FUTURE);
> >
> >        rt_task_create(&task1, "Low Priority Task", 0, 3, 0);
> >        rt_task_create(&task2, "High Priority Task", 0, 98, 0);
> >
> >        rt_task_start(&task1, &low_task, NULL);
> >        rt_task_start(&task2, &high_task, NULL);
> >
> >        pause();
> >
> >        rt_task_join(&task1);
> >        rt_task_join(&task2);
> >
> > }
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > On 2/15/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> >>
> >> Preetam Joshi wrote:
> >> > Hi,
> >> >
> >> > Do u mean to say that if i have created my tasks using native xenomai
> >> API's
> >> > like rt_task_create , then inside those tasks i will have to use
> posix
> >> skin
> >> > calls like pthread_setschedpolicy, etc...?
> >> >
> >> > Is that so.
> >>
> >> Nope. If you picked the native skin API, all scheduler setup for a RT
> >> task should be done through that interface.
> >>
> >> >
> >> > Cant i just have context switch between the tasks themselves say low
> >> > priority and a high priority task created by rt_task_create.
> >> >
> >> > Reason being i have created two tasks using the rt_task_create API
> and
> >> my
> >> > high priority task is runnning and my low priority task has slept,
> >> so as
> >> > soon as my low priority task has expired its sleep time and gets
> ready
> >> to
> >> > run,
> >> >
> >> > The low priority task preempts my high priority task and even its
> >> priority
> >> > gets raised to that of the high priority task and starts executing.
> The
> >> > higgh priority task gets suspended altogether amidst its running.
> >> Simply
> >> > baffled by the behavior?
> >>
> >> If you have found a weird behaviour of Xenomai, please post some
> >> as-small-as-possible demo code that exposes the issue. We will have a
> >> look at it.
> >>
> Regards
>
> Anders
>

------=_Part_123947_10263597.1171534611060
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi using it inside the task loop wwud give me RT_TASK_info as undeclared its a global structure even as mentioned in the API documentation and the behavior wud neways still remain the same as i mentioned in the code?<br><br>
Please execute the code and comment.<br><br>Thanks.<br><br><div><span class="gmail_quote">On 2/15/07, <b class="gmail_sendername">Anders Blomdell</b> &lt;<a href="mailto:anders.blomdell@domain.hid">anders.blomdell@domain.hid
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Preetam Joshi wrote:<br>&gt; ok,<br>&gt;<br>&gt; here is the code.<br>
&gt; The code essentially cerates two tasks low and high priority task.<br>&gt; The low priority task has priority as 3 and high as 98<br>&gt;<br>&gt; When i execute this initally everything goes smoothly as low priority task
<br>&gt; starts running with priority thread 3 , it sleeps so then the high priority<br>&gt; thread runs with priority 98. But before the high priority thread finishes<br>&gt; the for loop for 7 times the low priority thread prempts it and starts
<br>&gt; running with priority = 98.<br>Nope, you just don&#39;t read the state (using a global is also a bad idea).<br><br>&gt;<br>&gt; This is what has baffled me?<br>&gt;<br>&gt; #include &lt;stdio.h&gt;<br>&gt; #include &lt;
unistd.h&gt;<br>&gt; #include &lt;sys/mman.h&gt;<br>&gt; #include &lt;native/task.h&gt;<br>&gt; #include &lt;native/timer.h&gt;<br>&gt;<br>&gt; RT_TASK task1;<br>&gt; RT_TASK task2;<br>&gt; RT_TASK_INFO info;<br>&gt;<br>&gt; void low_task(void *arg)
<br>&gt; {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;RT_TASK_INFO info;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_inquire(&amp;task1, &amp;info);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of low task %d\n&quot;, info.cprio);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(3000000000);
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_inquire(&amp;task1, &amp;info);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of Low task %d\n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&gt;<br>&gt; }
<br>&gt;<br>&gt; void high_task(void *arg)<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned int i;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_inquire(&amp;task2, &amp;info);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of high task before sleep %d\n&quot;, info.cprio
);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for(i=0;i&lt;7;i++)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of High Priotity task1 %d\n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(1000000000);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;High priority thread goin to sleep %d\n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(3000000000);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for(i=0;i&lt;100;i++)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of High task2 %d\n&quot;,
info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int main(int argc, char* argv[])<br>&gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mlockall(MCL_CURRENT|MCL_FUTURE);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_create(&amp;task1, &quot;Low Priority Task&quot;, 0, 3, 0);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_create(&amp;task2, &quot;High Priority Task&quot;, 0, 98, 0);<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_start(&amp;task1, &amp;low_task, NULL);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_start(&amp;task2, &amp;high_task, NULL);<br>
&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pause();<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_join(&amp;task1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_join(&amp;task2);<br>&gt;<br>&gt; }<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;
<br>&gt;<br>&gt;<br>&gt; On 2/15/07, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid">jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; Preetam Joshi wrote:<br>&gt;&gt; &gt; Hi,<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Do u mean to say that if i have created my tasks using native xenomai
<br>&gt;&gt; API&#39;s<br>&gt;&gt; &gt; like rt_task_create , then inside those tasks i will have to use posix<br>&gt;&gt; skin<br>&gt;&gt; &gt; calls like pthread_setschedpolicy, etc...?<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Is that so.
<br>&gt;&gt;<br>&gt;&gt; Nope. If you picked the native skin API, all scheduler setup for a RT<br>&gt;&gt; task should be done through that interface.<br>&gt;&gt;<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Cant i just have context switch between the tasks themselves say low
<br>&gt;&gt; &gt; priority and a high priority task created by rt_task_create.<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Reason being i have created two tasks using the rt_task_create API and<br>&gt;&gt; my<br>&gt;&gt; &gt; high priority task is runnning and my low priority task has slept,
<br>&gt;&gt; so as<br>&gt;&gt; &gt; soon as my low priority task has expired its sleep time and gets ready<br>&gt;&gt; to<br>&gt;&gt; &gt; run,<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; The low priority task preempts my high priority task and even its
<br>&gt;&gt; priority<br>&gt;&gt; &gt; gets raised to that of the high priority task and starts executing. The<br>&gt;&gt; &gt; higgh priority task gets suspended altogether amidst its running.<br>&gt;&gt; Simply<br>&gt;&gt; &gt; baffled by the behavior?
<br>&gt;&gt;<br>&gt;&gt; If you have found a weird behaviour of Xenomai, please post some<br>&gt;&gt; as-small-as-possible demo code that exposes the issue. We will have a<br>&gt;&gt; look at it.<br>&gt;&gt;<br>Regards<br>
<br>Anders<br></blockquote></div><br>

------=_Part_123947_10263597.1171534611060--

