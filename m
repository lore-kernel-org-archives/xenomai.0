Message-ID: <e45fe62b0702210018k7f4dfbfan6abd45b8d83fc00b@domain.hid>
Date: Wed, 21 Feb 2007 13:48:21 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
Subject: Re: [Xenomai-help] Make error
In-Reply-To: <e45fe62b0702210012m67b03597qa17c14625573f411@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_3109_19052432.1172045901337"
References: <e45fe62b0702112124r71b9e03fv8413028178857a57@domain.hid>
	<e45fe62b0702132157p2e52a36ficb37516e98269ee@domain.hid>
	<45D2CE22.5010105@domain.hid>
	<e45fe62b0702142319s5ccce2cbkadbcd1b921a4b653@domain.hid>
	<45D421EA.5070507@domain.hid>
	<e45fe62b0702150158m62bf6095m528395578551fc26@domain.hid>
	<45D431CF.5090201@domain.hid>
	<e45fe62b0702150216y6f6f98cdydfb4bab685f2478d@domain.hid>
	<1171540811.11100.27.camel@domain.hid>
	<e45fe62b0702210012m67b03597qa17c14625573f411@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: Xenomai-help@domain.hid, Jan Kiszka <jan.kiszka@domain.hid>

------=_Part_3109_19052432.1172045901337
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I got the solution to it


On 2/21/07, Preetam Joshi <j.preetam@domain.hid> wrote:
>
>  cd ../../.. && /bin/sh ./config.status src/testsuite/mytask/Makefile
> depfiles
> config.status: error: invalid argument: src/testsuite/mytask/Makefile
> make: *** [Makefile] Error 1
> What dows this error mean n how do i solve it?
>
> On 2/15/07, Philippe Gerum <rpm@xenomai.org> wrote:
> >
> > On Thu, 2007-02-15 at 15:46 +0530, Preetam Joshi wrote:
> > > Hi using it inside the task loop wwud give me RT_TASK_info as
> > > undeclared its a global structure even as mentioned in the API
> > > documentation
> >
> > This is stated nowhere in the doc. Please read again.
> >
> > >  and the behavior wud neways still remain the same as i mentioned in
> > > the code?
> > >
> >
> > Of course not, that's why Anders showed you the way.
> >
> > > Please execute the code and comment.
> >
> > Your code does not compile properly. There's a missing brace to close
> > the high priority task's body to start with. Additionally, 3000000000
> > only starts to be an implicitely unsigned value with the ISO C90
> > standard, so adding the 'ULL' qualifier would be a nice hint given to
> > the compiler that you really now what your are doing here.
> >
> > Now, aside of those basic issues, the trivial one that bugs you is that:
> >
> >
> > 1) the low priority task starts first, sets "info", then sleeps
> > 2) the high priority task starts next while the low one is aslept,
> > overwrites "info", then sleeps,
> > 3) which in turn causes the low priority task to print out the
> > overwritten value indefinitely after wakeup, which relates to the high
> > priority one, because it does this without ever reloading this variable
> > with its own priority information.
> >
> > Please read your code again, make the "info" variable a local one for
> > both threads, then post anew if anything remains unclear.
> >
> > >
> > > Thanks.
> > >
> > > On 2/15/07, Anders Blomdell <anders.blomdell@domain.hid> wrote:
> > >         Preetam Joshi wrote:
> > >         > ok,
> > >         >
> > >         > here is the code.
> > >         > The code essentially cerates two tasks low and high priority
> > >         task.
> > >         > The low priority task has priority as 3 and high as 98
> > >         >
> > >         > When i execute this initally everything goes smoothly as low
> > >         priority task
> > >         > starts running with priority thread 3 , it sleeps so then
> > >         the high priority
> > >         > thread runs with priority 98. But before the high priority
> > >         thread finishes
> > >         > the for loop for 7 times the low priority thread prempts it
> > >         and starts
> > >         > running with priority = 98.
> > >         Nope, you just don't read the state (using a global is also a
> > >         bad idea).
> > >
> > >         >
> > >         > This is what has baffled me?
> > >         >
> > >         > #include <stdio.h>
> > >         > #include < unistd.h>
> > >         > #include <sys/mman.h>
> > >         > #include <native/task.h>
> > >         > #include <native/timer.h>
> > >         >
> > >         > RT_TASK task1;
> > >         > RT_TASK task2;
> > >         > RT_TASK_INFO info;
> > >         >
> > >         > void low_task(void *arg)
> > >         > {
> > >                   RT_TASK_INFO info;
> > >         >        rt_task_inquire(&task1, &info);
> > >         >        printf("Priority of low task %d\n", info.cprio);
> > >         >
> > >         >        rt_task_sleep(3000000000);
> > >         >
> > >         >       while(1)
> > >         >        {
> > >                           rt_task_inquire(&task1, &info);
> > >         >                printf("Priority of Low task %d
> > >         \n",info.cprio);
> > >         >        }
> > >         >
> > >         > }
> > >         >
> > >         > void high_task(void *arg)
> > >         > {
> > >         >        unsigned int i;
> > >         >        rt_task_inquire(&task2, &info);
> > >         >        printf("Priority of high task before sleep %d\n",
> > >         info.cprio );
> > >         >        for(i=0;i<7;i++)
> > >         >        {
> > >         >
> > >         >                printf("Priority of High Priotity task1 %d
> > >         \n",info.cprio);
> > >         >                rt_task_sleep(1000000000);
> > >         >        }
> > >         >
> > >         >        printf("High priority thread goin to sleep %d
> > >         \n",info.cprio);
> > >         >        rt_task_sleep(3000000000);
> > >         >
> > >         >        for(i=0;i<100;i++)
> > >         >        {
> > >         >                printf("Priority of High task2 %d\n",
> > >         info.cprio);
> > >         >        }
> > >         >
> > >         >       int main(int argc, char* argv[])
> > >         > {
> > >         >        mlockall(MCL_CURRENT|MCL_FUTURE);
> > >         >
> > >         >        rt_task_create(&task1, "Low Priority Task", 0, 3,
> > >         0);
> > >         >        rt_task_create(&task2, "High Priority Task", 0, 98,
> > >         0);
> > >         >
> > >         >        rt_task_start(&task1, &low_task, NULL);
> > >         >        rt_task_start(&task2, &high_task, NULL);
> > >         >
> > >         >        pause();
> > >         >
> > >         >        rt_task_join(&task1);
> > >         >        rt_task_join(&task2);
> > >         >
> > >         > }
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         >
> > >         > On 2/15/07, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> > >         >>
> > >         >> Preetam Joshi wrote:
> > >         >> > Hi,
> > >         >> >
> > >         >> > Do u mean to say that if i have created my tasks using
> > >         native xenomai
> > >         >> API's
> > >         >> > like rt_task_create , then inside those tasks i will have
> > >         to use posix
> > >         >> skin
> > >         >> > calls like pthread_setschedpolicy, etc...?
> > >         >> >
> > >         >> > Is that so.
> > >         >>
> > >         >> Nope. If you picked the native skin API, all scheduler
> > >         setup for a RT
> > >         >> task should be done through that interface.
> > >         >>
> > >         >> >
> > >         >> > Cant i just have context switch between the tasks
> > >         themselves say low
> > >         >> > priority and a high priority task created by
> > >         rt_task_create.
> > >         >> >
> > >         >> > Reason being i have created two tasks using the
> > >         rt_task_create API and
> > >         >> my
> > >         >> > high priority task is runnning and my low priority task
> > >         has slept,
> > >         >> so as
> > >         >> > soon as my low priority task has expired its sleep time
> > >         and gets ready
> > >         >> to
> > >         >> > run,
> > >         >> >
> > >         >> > The low priority task preempts my high priority task and
> > >         even its
> > >         >> priority
> > >         >> > gets raised to that of the high priority task and starts
> > >         executing. The
> > >         >> > higgh priority task gets suspended altogether amidst its
> > >         running.
> > >         >> Simply
> > >         >> > baffled by the behavior?
> > >         >>
> > >         >> If you have found a weird behaviour of Xenomai, please post
> > >         some
> > >         >> as-small-as-possible demo code that exposes the issue. We
> > >         will have a
> > >         >> look at it.
> > >         >>
> > >         Regards
> > >
> > >         Anders
> > >
> > > _______________________________________________
> > > Xenomai-help mailing list
> > > Xenomai-help@domain.hid
> > > https://mail.gna.org/listinfo/xenomai-help
> > --
> > Philippe.
> >
> >
> >
>

------=_Part_3109_19052432.1172045901337
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I got the solution to it<br><br><br><div><span class="gmail_quote">On 2/21/07, <b class="gmail_sendername">Preetam Joshi</b> &lt;<a href="mailto:j.preetam@domain.hid">j.preetam@domain.hid</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&nbsp;cd ../../.. &amp;&amp; /bin/sh ./config.status src/testsuite/mytask/Makefile depfiles<br>config.status: error: invalid argument: src/testsuite/mytask/Makefile<br>make: *** [Makefile] Error 1<br>What dows this error mean n how do i solve it?
<div><span class="q" id="q_110e35c2234813d6_1"><br><br><div><span class="gmail_quote">On 2/15/07, <b class="gmail_sendername">Philippe Gerum</b> &lt;<a href="mailto:rpm@xenomai.org" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
rpm@xenomai.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
On Thu, 2007-02-15 at 15:46 +0530, Preetam Joshi wrote:<br>&gt; Hi using it inside the task loop wwud give me RT_TASK_info as<br>&gt; undeclared its a global structure even as mentioned in the API<br>&gt; documentation<br>

<br>This is stated nowhere in the doc. Please read again.<br><br>&gt;&nbsp;&nbsp;and the behavior wud neways still remain the same as i mentioned in<br>&gt; the code?<br>&gt;<br><br>Of course not, that&#39;s why Anders showed you the way.
<br><br>&gt; Please execute the code and comment.<br><br>Your code does not compile properly. There&#39;s a missing brace to close<br>the high priority task&#39;s body to start with. Additionally, 3000000000<br>only starts to be an implicitely unsigned value with the ISO C90
<br>standard, so adding the &#39;ULL&#39; qualifier would be a nice hint given to<br>the compiler that you really now what your are doing here.<br><br>Now, aside of those basic issues, the trivial one that bugs you is that:
<br><br>1) the low priority task starts first, sets &quot;info&quot;, then sleeps<br>2) the high priority task starts next while the low one is aslept,<br>overwrites &quot;info&quot;, then sleeps,<br>3) which in turn causes the low priority task to print out the
<br>overwritten value indefinitely after wakeup, which relates to the high<br>priority one, because it does this without ever reloading this variable<br>with its own priority information.<br><br>Please read your code again, make the &quot;info&quot; variable a local one for
<br>both threads, then post anew if anything remains unclear.<br><br>&gt;<br>&gt; Thanks.<br>&gt;<br>&gt; On 2/15/07, Anders Blomdell &lt;<a href="mailto:anders.blomdell@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
anders.blomdell@domain.hid</a>&gt; wrote:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Preetam Joshi wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ok,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; here is the code.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; The code essentially cerates two tasks low and high priority<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; task.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; The low priority task has priority as 3 and high as 98<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; When i execute this initally everything goes smoothly as low<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority task<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; starts running with priority thread 3 , it sleeps so then
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the high priority<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; thread runs with priority 98. But before the high priority<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; thread finishes<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; the for loop for 7 times the low priority thread prempts it
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and starts<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; running with priority = 98.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Nope, you just don&#39;t read the state (using a global is also a<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bad idea).<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; This is what has baffled me?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; #include &lt;stdio.h&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; #include &lt; unistd.h&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; #include &lt;sys/mman.h&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; #include &lt;native/task.h&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; #include &lt;native/timer.h&gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; RT_TASK task1;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; RT_TASK task2;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; RT_TASK_INFO info;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; void low_task(void *arg)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; {
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_TASK_INFO info;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_inquire(&amp;task1, &amp;info);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of low task %d\n&quot;, info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(3000000000);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(1)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_inquire(&amp;task1, &amp;info);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of Low task %d
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; void high_task(void *arg)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned int i;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_inquire(&amp;task2, &amp;info);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of high task before sleep %d\n&quot;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.cprio );<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for(i=0;i&lt;7;i++)
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of High Priotity task1 %d<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(1000000000);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;High priority thread goin to sleep %d<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n&quot;,info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_sleep(3000000000);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;for(i=0;i&lt;100;i++)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printf(&quot;Priority of High task2 %d\n&quot;,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; info.cprio);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int main(int argc, char* argv[])<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;mlockall(MCL_CURRENT|MCL_FUTURE);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_create(&amp;task1, &quot;Low Priority Task&quot;, 0, 3,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_create(&amp;task2, &quot;High Priority Task&quot;, 0, 98,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_start(&amp;task1, &amp;low_task, NULL);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_start(&amp;task2, &amp;high_task, NULL);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pause();<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_join(&amp;task1);<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;rt_task_join(&amp;task2);
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; }<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; On 2/15/07, Jan Kiszka &lt;<a href="mailto:jan.kiszka@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
jan.kiszka@domain.hid</a>&gt; wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; Preetam Joshi wrote:<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; Hi,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; Do u mean to say that if i have created my tasks using<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; native xenomai
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; API&#39;s<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; like rt_task_create , then inside those tasks i will have<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to use posix<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; skin<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; calls like pthread_setschedpolicy, etc...?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; Is that so.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; Nope. If you picked the native skin API, all scheduler<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; setup for a RT<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; task should be done through that interface.
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; Cant i just have context switch between the tasks<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; themselves say low<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; priority and a high priority task created by
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; Reason being i have created two tasks using the<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create API and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; my<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; high priority task is runnning and my low priority task
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; has slept,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; so as<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; soon as my low priority task has expired its sleep time<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; and gets ready<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; to<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; run,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; The low priority task preempts my high priority task and<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; even its<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; priority<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; gets raised to that of the high priority task and starts
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; executing. The<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; higgh priority task gets suspended altogether amidst its<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; running.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; Simply<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; &gt; baffled by the behavior?
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; If you have found a weird behaviour of Xenomai, please post<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; some<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; as-small-as-possible demo code that exposes the issue. We<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; will have a
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt; look at it.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt;&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regards<br>&gt;<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Anders<br>&gt;<br>&gt; _______________________________________________<br>&gt; Xenomai-help mailing list<br>&gt; 
<a href="mailto:Xenomai-help@domain.hid" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">Xenomai-help@domain.hid</a><br>&gt; <a href="https://mail.gna.org/listinfo/xenomai-help" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
https://mail.gna.org/listinfo/xenomai-help</a><br>--<br>Philippe.<br><br><br></blockquote></div><br>
</span></div></blockquote></div><br>

------=_Part_3109_19052432.1172045901337--

