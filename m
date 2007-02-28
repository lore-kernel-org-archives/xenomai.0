Message-ID: <e45fe62b0702280117k23198918y971763b877cd9b9a@domain.hid>
Date: Wed, 28 Feb 2007 14:47:04 +0530
From: "Preetam Joshi" <j.preetam@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_22363_3351403.1172654224649"
Subject: [Xenomai-help] Semaphore Task
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_22363_3351403.1172654224649
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi i have a problem in my code the rt_sem_create calls returns a negative
value i.e. -17

THat is semaphore creation fails? Why is it so?

Here is the code that i am trying to execute. I have created semaphore in
the main routine.

#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <native/task.h>
#include <native/timer.h>
#include <native/sem.h>

RT_TASK task1;
RT_TASK task2;

RT_SEM sem1;

int i,res;

void low_task(void *arg)
{

    printf("Inside the low priority task\n");
    rt_sem_p(&sem1,300000000);
    printf("I have the semaphore released by the high task\n");
}

void high_task(void *arg)
{

    printf("Inside the high priority task \n");
    res =rt_sem_p(&sem1,TM_INFINITE);
    printf("%d\n", res);
    if(res == 0)
    {
        printf("Semaphore Acquired by High task");
    }

    rt_task_sleep(3000000000);
    rt_sem_v(&sem1);
    printf("I have released the semaphore : High\n");
}

int  main()
{
    int res;

    mlockall(MCL_CURRENT|MCL_FUTURE);

        rt_task_create(&task2, "High Priority Task2", 0, 98, 0);
    rt_task_create(&task1, "Low Priority Task1", 0, 5, 0);

    res = rt_sem_create(&sem1, "Semaphore1", 0, S_PRIO);

    printf("%d\n",res);
    rt_task_start(&task2, &high_task, NULL);
        rt_task_start(&task1, &low_task,  NULL);

    pause();

    rt_task_join(&task1);
    rt_task_join(&task2);

}

------=_Part_22363_3351403.1172654224649
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi i have a problem in my code the rt_sem_create calls returns a negative value i.e. -17<br><br>THat is semaphore creation fails? Why is it so?<br><br>Here is the code that i am trying to execute. I have created semaphore in the main routine.
<br><br>#include &lt;stdio.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;native/task.h&gt;<br>#include &lt;native/timer.h&gt;<br>#include &lt;native/sem.h&gt;<br><br>RT_TASK task1;<br>RT_TASK task2;
<br><br>RT_SEM sem1;<br><br>int i,res;<br><br>void low_task(void *arg)<br>{<br><br>&nbsp;&nbsp;&nbsp; printf(&quot;Inside the low priority task\n&quot;);<br>&nbsp;&nbsp;&nbsp; rt_sem_p(&amp;sem1,300000000);<br>&nbsp;&nbsp;&nbsp; printf(&quot;I have the semaphore released by the high task\n&quot;);
<br>}<br><br>void high_task(void *arg)<br>{<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; printf(&quot;Inside the high priority task \n&quot;);<br>&nbsp;&nbsp;&nbsp; res =rt_sem_p(&amp;sem1,TM_INFINITE);<br>&nbsp;&nbsp;&nbsp; printf(&quot;%d\n&quot;, res);<br>&nbsp;&nbsp;&nbsp; if(res == 0)<br>&nbsp;&nbsp;&nbsp; {
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; printf(&quot;Semaphore Acquired by High task&quot;);<br>&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; rt_task_sleep(3000000000);<br>&nbsp;&nbsp;&nbsp; rt_sem_v(&amp;sem1);<br>&nbsp;&nbsp;&nbsp; printf(&quot;I have released the semaphore : High\n&quot;);<br>}<br>&nbsp;&nbsp;&nbsp; 
<br>int&nbsp; main()<br>{<br>&nbsp;&nbsp;&nbsp; int res;<br><br>&nbsp;&nbsp;&nbsp; mlockall(MCL_CURRENT|MCL_FUTURE);<br>&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_create(&amp;task2, &quot;High Priority Task2&quot;, 0, 98, 0);<br>&nbsp;&nbsp;&nbsp; rt_task_create(&amp;task1, &quot;Low Priority Task1&quot;, 0, 5, 0);
<br><br>&nbsp;&nbsp;&nbsp; res = rt_sem_create(&amp;sem1, &quot;Semaphore1&quot;, 0, S_PRIO);<br><br>&nbsp;&nbsp;&nbsp; printf(&quot;%d\n&quot;,res);<br>&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task2, &amp;high_task, NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_task_start(&amp;task1, &amp;low_task,&nbsp; NULL);
<br><br>&nbsp;&nbsp;&nbsp; pause();<br><br>&nbsp;&nbsp;&nbsp; rt_task_join(&amp;task1);<br>&nbsp;&nbsp;&nbsp; rt_task_join(&amp;task2);<br><br>}<br><br>

------=_Part_22363_3351403.1172654224649--

