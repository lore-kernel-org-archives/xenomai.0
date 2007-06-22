Message-ID: <2a9546e00706212247y667294d9u7d1d0a596f6b3a4a@domain.hid>
Date: Fri, 22 Jun 2007 11:17:32 +0530
From: "sanjeev sharma" <sanjeevsharmaengg@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_5855_30625454.1182491252535"
Subject: [Xenomai-help] why use xenomai over linux
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

------=_Part_5855_30625454.1182491252535
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi ,

we have Xenomai realtime process with priority 99, and alarm is  fired every
2ms, in this Xenomai process we write to the pipe once alarm is fired.
on the Linux domian we have a process which opens the same Xenomai pipe and
reads the pipe, there are counters variables in Xenomai and Linux domain, we
are passing the count value which gets incremented after each alarm, and we
are checking difference of the counts in the Linux process once we read the
data from pipe,
if the difference is greater than 1, we say Linux has lost the data, it
failed to read the pipe.

this we ran for overnightand did not fail. its good.
even chekced with both process being Xenomai realtime and its gives the same
result for overnight.


please clerify this doubt, as Linux process can handle only for 10ms how is
it able to read data even for 2ms .

when we run for 500us time, write operation fails as it runs out of internal
buffer of the pipe, is it because the pipe is not read from linux process.
in case if we increase the buffer length it will generate theerror on
writing after more delayed time, what could be the reason for this, we are
balnk here, any pointers please.

one more question,

are we comparing apple to apple here as Xenomai is a realtime process it
will able to write even at 500us time. I think to compare I should make two
linux process one on everytimer interrupt should write to pipe and another
linux process should read and then I should compare this with above one
making it apple to apple.

may be this will prove why use Xenomai over Linux, we are in the process of
giving this data to the client to use Xenomai, please clarify.

we are using Montavista Linux .
please comment on my undertsanding.

below is the code for xenomai and Linux process.


* Xenomai process firing alarm and writing to pipe.*

/************************************************************

* This program illustrate How to trigger an Alarm in Xenomai*

* user space program afetr a interval of 100 ms and pass data

* to linux domain through pipe. *

************************************************************/

/* Include Files */

#include <stdio.h>

#include <native/task.h>

#include <sys/mman.h>

#include <native/pipe.h>

#include <unistd.h>

#include <native/alarm.h>

#include <native/timer.h>

/* Global variables */

RT_TASK task; /* Task Descriptor */

RT_PIPE rt_pipe; /* Pipe Descriptor */

RT_ALARM alarm_desc;

#define ALARM_VALUE 4 /*Alarm value given in ticks */

/*200 tick=100 ms if period = 500000*/



#define ALARM_INTERVAL 4 /* Period in ticks */

/*200 tick=100 ms if period = 500000*/

/* Real Time task's Function body */

void task_body (void *cookie)

{

int err,i;

unsigned long int xenomai_counter =0;

printf("Creating the RT Pipe\n");

err = rt_pipe_create(&rt_pipe, "Xenomai_pipe",4,0); /* Creating a pipe with
name as pipe, minor number as 4*/

if (err !=0)

printf("Error in creating pipe\n");

else

printf("pipe created \n");

while(1)

{

/* Wait for the next alarm to trigger. */

err = rt_alarm_wait (&alarm_desc);

if (err != 0)

{

printf ("Rt_alarm_wait return with error and return value is=%d\n",

err);

}

/*Writing data on the pipe*/

xenomai_counter++;

err = rt_pipe_write(&rt_pipe, &xenomai_counter, sizeof(xenomai_counter),
P_NORMAL);

if (err < 0)

{

printf("Error in writing = %d\n",err);

exit(0);

}

}

rt_task_sleep(250);

err = rt_pipe_delete(&rt_pipe); /* Delete the pipe descriptor */

if (err != 0 )

printf("Error in deleting the pipe\n");

else

printf("Successful in deleting the pipe\n");

exit(0);

}

int main (int argc, char **argv)

{

int err;

mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for the
realtime task from swapping */

/* Create an Alarm... */

err = rt_alarm_create (&alarm_desc, "Xenomai_Alarm");

if (err != 0)

{

printf ("Error encounter while created Alarm and retrun value is =%d\n",

err);

}

/*start an Alarm */

err = rt_alarm_start (&alarm_desc, ALARM_VALUE, ALARM_INTERVAL);

if (err != 0)

{

printf

("Problem encounter while Starting an Alarm and retrun value is =%d\n",

err);

}



/* Creating Task with name mytask, stack size will be allocated by Kernel as
by passing 0, priority as 1*/

err = rt_task_create(&task,"Xenomai_task",0,99,T_FPU);

if (err)

{

fprintf(stderr,"failed to create task, code %d\n",err);

return 0;

}

/* Starting the task execution */

err = rt_task_start(&task,&task_body,NULL);

if (err)

{

fprintf(stderr,"failed to start task, code %d\n",err);

return 0;

}

pause(); /* This function should be ther to make the parent to be in
existence this can be achived by

making task as joinable and waiting for that to complete */

// return 0;

}

*Linux process reading from pipe.*




/************************************************************

* This program illustrate the linux process communication **

* with Xenomai through reading on pipe **

************************************************************/

#include <stdio.h>

#include <unistd.h>

#include <sys/types.h>

#include <sys/stat.h>

#include <fcntl.h>



int main()

{

int ret;

int fd,i;

unsigned long int Xenomai_counter;

unsigned long int Linux_counter=0;

unsigned long int Xenomai_linux_diff;

printf("Opening the pipe\n");

fd = open("/dev/rtp4",O_RDWR); /* openning the pipe device file rtp4 as
xenomai task creates pipe

with minor 4 */

if (fd < 0)

{

printf("Error in opening file descriptor = %d\n",fd);

exit(0);

}

while(1)

{

/*read from pipe*/

ret = read(fd, &Xenomai_counter, (sizeof(Xenomai_counter)+1));

if (ret > 0)

printf("The data bytes read from pipe are =%d\n and the data is =
%ld\n",ret,Xenomai_counter);

Xenomai_linux_diff=Xenomai_counter-Linux_counter;



if(Xenomai_linux_diff>1)

{

printf("Interrupt is missed------->>> TEST FAILED\n");

break;

}

else

{

printf("TEST PASSED->>>\n");

}



Linux_counter++;

}

printf("FAILED FAILED FAILED FAILED\n");

close(fd);

exit(0);





}



*Reading pipe from Xenomai context:*



* This program illustrate the linux process communication **

* with Xenomai through reading on pipe **

************************************************************/

#include <stdio.h>

#include <sys/types.h>

#include <native/task.h>

#include <sys/mman.h>

#include <native/pipe.h>

#include <unistd.h>

#include <native/alarm.h>

#include <native/timer.h>

#include <sys/stat.h>

#include <fcntl.h>

/* Global variables */

RT_TASK task; /* Task Descriptor */

/* Real Time task's Function body */

void task_body (void *cookie)

{

int ret;

int fd,i;

unsigned long int Xenomai_counter;

unsigned long int Linux_counter=0;

unsigned long int Xenomai_linux_diff;

printf("inside rt task\n");

printf("Opening the pipe\n");

fd = open("/dev/rtp4",O_RDWR); /* openning the pipe device file rtp4 as
xenomai task creates pipe

with minor 4 */

if (fd < 0)

{

printf("Error in opening file descriptor = %d\n",fd);

exit(0);

}

while(1)

{

/*read from pipe*/

ret = read(fd, &Xenomai_counter, (sizeof(Xenomai_counter)+1));

if((Xenomai_counter%10000) ==0)

printf("\n Xenomai_counter value =%ld\n",Xenomai_counter);

Xenomai_linux_diff= Xenomai_counter-Linux_counter;



if(Xenomai_linux_diff>1)

{

printf("\nInterrupt is missed------->>> TEST FAILED\n");

printf("\n Exiting\n");

break;

}

Linux_counter++;

}

printf("FAILED FAILED FAILED FAILED\n");

close(fd);



}

int main (int argc, char **argv)

{

int err;

mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for the
realtime task from swapping */

/* Creating Task with name mytask, stack size will be allocated by Kernel as
by passing 0, priority as 1*/

err = rt_task_create(&task,"Xenomai_Linux_task",0,99,T_FPU);

if (err)

{

fprintf(stderr,"failed to create task, code %d\n",err);

return 0;

}

printf("rt task created\n");

/* Starting the task execution */

err = rt_task_start(&task,&task_body,NULL);

if (err)

{

fprintf(stderr,"failed to start task, code %d\n",err);

return 0;

}

pause(); /* This function should be ther to make the parent to be in
existence this can be achived by

making task as joinable and waiting for that to complete */

// return 0;

}



Thanks and Regards

san

------=_Part_5855_30625454.1182491252535
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>hi ,</div>
<div>&nbsp;</div>
<div>we have Xenomai realtime process with priority 99, and alarm is &nbsp;fired every 2ms, in this Xenomai process we write to the pipe once alarm is fired.</div>
<div>on the Linux domian we have a process which opens the same Xenomai pipe and reads the pipe, there are counters variables in Xenomai and Linux domain, we are passing the count value which gets incremented after each alarm, and we are checking difference of the counts in the Linux process once we read the data from pipe, 
</div>
<div>if the difference is greater than 1, we say Linux has lost the data, it failed to read the pipe. </div>
<div>&nbsp;</div>
<div>this we ran for overnightand did not fail. its good.</div>
<div>even chekced with both process being Xenomai realtime and its gives the same result for overnight.&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>please clerify this doubt, as Linux process can handle only for 10ms how is it able to read data even for 2ms .</div>
<div>&nbsp;</div>
<div>when we run for 500us time, write operation fails as it runs out of internal buffer of the pipe, is it because the pipe is not read from linux process. in case if we increase the buffer length it will generate theerror on writing after more delayed time, what could be the reason for this, we are balnk here, any pointers please.
</div>
<div>&nbsp;</div>
<div>one more question, </div>
<div>&nbsp;</div>
<div>are we comparing apple to apple here as Xenomai is a realtime process it will able to write even at 500us time. I think to compare I should make two linux process one on everytimer interrupt should write to pipe and another linux process should read and then I should compare this with above one making it apple to apple.
</div>
<div>&nbsp;</div>
<div>may be this will prove why use Xenomai over Linux, we are in the process of giving this data to the client to use Xenomai, please clarify.</div>
<div>&nbsp;</div>
<div>we are using Montavista Linux .</div>
<div>please comment on my undertsanding.</div>
<div>&nbsp;</div>
<div>below is the code for xenomai and Linux process.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><strong>&nbsp;Xenomai process firing alarm and writing to pipe.</strong><font size="2">
<p>/************************************************************</p>
<p>* This program illustrate How to trigger an Alarm in Xenomai*</p>
<p>* user space program afetr a interval of 100 ms and pass data </p>
<p>* to linux domain through pipe. *</p>
<p>************************************************************/</p>
<p>/* Include Files */</p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;native/task.h&gt;</p>
<p>#include &lt;sys/mman.h&gt;</p>
<p>#include &lt;native/pipe.h&gt;</p>
<p>#include &lt;unistd.h&gt;</p>
<p>#include &lt;native/alarm.h&gt;</p>
<p>#include &lt;native/timer.h&gt;</p>
<p>/* Global variables */</p>
<p>RT_TASK task; /* Task Descriptor */</p>
<p>RT_PIPE rt_pipe; /* Pipe Descriptor */</p>
<p>RT_ALARM alarm_desc;</p>
<p>#define ALARM_VALUE 4 /*Alarm value given in ticks */</p>
<p>/*200 tick=100 ms if period = 500000*/</p>
<p>&nbsp;</p>
<p>#define ALARM_INTERVAL 4 /* Period in ticks */</p>
<p>/*200 tick=100 ms if period = 500000*/</p>
<p></p>
<p>/* Real Time task&#39;s Function body */</p>
<p>void task_body (void *cookie)</p>
<p>{</p>
<p>int err,i;</p>
<p>unsigned long int xenomai_counter =0;</p>
<p>printf(&quot;Creating the RT Pipe\n&quot;);</p>
<p>err = rt_pipe_create(&amp;rt_pipe, &quot;Xenomai_pipe&quot;,4,0); /* Creating a pipe with name as pipe, minor number as 4*/</p>
<p>if (err !=0)</p>
<p>printf(&quot;Error in creating pipe\n&quot;);</p>
<p>else</p>
<p>printf(&quot;pipe created \n&quot;);</p>
<p>while(1)</p>
<p>{</p>
<p>/* Wait for the next alarm to trigger. */</p>
<p>err = rt_alarm_wait (&amp;alarm_desc);</p>
<p>if (err != 0)</p>
<p>{</p>
<p>printf (&quot;Rt_alarm_wait return with error and return value is=%d\n&quot;,</p>
<p>err);</p>
<p>}</p>
<p>/*Writing data on the pipe*/</p>
<p></p>
<p>xenomai_counter++;</p>
<p></p>
<p>err = rt_pipe_write(&amp;rt_pipe, &amp;xenomai_counter, sizeof(xenomai_counter), P_NORMAL);</p>
<p>if (err &lt; 0)</p>
<p>{</p>
<p>printf(&quot;Error in writing = %d\n&quot;,err);</p>
<p>exit(0);</p>
<p>}</p>
<p>}</p>
<p>rt_task_sleep(250); </p>
<p>err = rt_pipe_delete(&amp;rt_pipe); /* Delete the pipe descriptor */</p>
<p>if (err != 0 )</p>
<p>printf(&quot;Error in deleting the pipe\n&quot;);</p>
<p>else</p>
<p>printf(&quot;Successful in deleting the pipe\n&quot;);</p>
<p>exit(0);</p>
<p>}</p>
<p>int main (int argc, char **argv)</p>
<p>{</p>
<p>int err;</p>
<p>mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for the realtime task from swapping */</p>
<p>/* Create an Alarm... */</p>
<p>err = rt_alarm_create (&amp;alarm_desc, &quot;Xenomai_Alarm&quot;);</p>
<p>if (err != 0)</p>
<p>{</p>
<p>printf (&quot;Error encounter while created Alarm and retrun value is =%d\n&quot;,</p>
<p>err);</p>
<p>}</p>
<p>/*start an Alarm */</p>
<p>err = rt_alarm_start (&amp;alarm_desc, ALARM_VALUE, ALARM_INTERVAL);</p>
<p>if (err != 0)</p>
<p>{</p>
<p>printf</p>
<p>(&quot;Problem encounter while Starting an Alarm and retrun value is =%d\n&quot;,</p>
<p>err);</p>
<p>}</p>
<p>&nbsp;</p>
<p>/* Creating Task with name mytask, stack size will be allocated by Kernel as by passing 0, priority as 1*/</p>
<p>err = rt_task_create(&amp;task,&quot;Xenomai_task&quot;,0,99,T_FPU); </p>
<p>if (err)</p>
<p>{</p>
<p>fprintf(stderr,&quot;failed to create task, code %d\n&quot;,err);</p>
<p>return 0;</p>
<p>}</p>
<p>/* Starting the task execution */</p>
<p>err = rt_task_start(&amp;task,&amp;task_body,NULL);</p>
<p>if (err)</p>
<p>{</p>
<p>fprintf(stderr,&quot;failed to start task, code %d\n&quot;,err);</p>
<p>return 0;</p>
<p>}</p>
<p>pause(); /* This function should be ther to make the parent to be in existence this can be achived by </p>
<p>making task as joinable and waiting for that to complete */</p>
<p>// return 0;</p>
<p>}</p></font></div>
<div>&nbsp;</div>
<div><strong>Linux process reading from pipe.</strong></div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div><font size="2">
<p>/************************************************************</p>
<p>* This program illustrate the linux process communication **</p>
<p>* with Xenomai through reading on pipe **</p>
<p>************************************************************/</p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;unistd.h&gt;</p>
<p>#include &lt;sys/types.h&gt;</p>
<p>#include &lt;sys/stat.h&gt;</p>
<p>#include &lt;fcntl.h&gt;</p>
<p>&nbsp;</p>
<p>int main()</p>
<p>{</p>
<p>int ret;</p>
<p>int fd,i;</p>
<p>unsigned long int Xenomai_counter;</p>
<p>unsigned long int Linux_counter=0;</p>
<p>unsigned long int Xenomai_linux_diff; </p>
<p>printf(&quot;Opening the pipe\n&quot;); </p>
<p>fd = open(&quot;/dev/rtp4&quot;,O_RDWR); /* openning the pipe device file rtp4 as xenomai task creates pipe </p>
<p>with minor 4 */</p>
<p>if (fd &lt; 0)</p>
<p>{</p>
<p>printf(&quot;Error in opening file descriptor = %d\n&quot;,fd);</p>
<p>exit(0);</p>
<p>}</p>
<p>while(1)</p>
<p>{ </p>
<p>/*read from pipe*/</p>
<p>ret = read(fd, &amp;Xenomai_counter, (sizeof(Xenomai_counter)+1));</p>
<p>if (ret &gt; 0)</p>
<p>printf(&quot;The data bytes read from pipe are =%d\n and the data is = %ld\n&quot;,ret,Xenomai_counter);</p>
<p>Xenomai_linux_diff=Xenomai_counter-Linux_counter;</p>
<p>&nbsp;</p>
<p>if(Xenomai_linux_diff&gt;1)</p>
<p>{</p>
<p>printf(&quot;Interrupt is missed-------&gt;&gt;&gt; TEST FAILED\n&quot;);</p>
<p>break;</p>
<p>}</p>
<p>else</p>
<p>{</p>
<p>printf(&quot;TEST PASSED-&gt;&gt;&gt;\n&quot;);</p>
<p>}</p>
<p>&nbsp;</p>
<p>Linux_counter++; </p>
<p>}</p>
<p>printf(&quot;FAILED FAILED FAILED FAILED\n&quot;);</p>
<p>close(fd);</p>
<p>exit(0);</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>} </p>
<p></p>
<p>&nbsp;</p>
<p><strong>Reading pipe from Xenomai context:</strong></p>
<p>&nbsp;</p><font size="2">
<p>* This program illustrate the linux process communication **</p>
<p>* with Xenomai through reading on pipe **</p>
<p>************************************************************/</p>
<p>#include &lt;stdio.h&gt;</p>
<p>#include &lt;sys/types.h&gt;</p>
<p>#include &lt;native/task.h&gt;</p>
<p>#include &lt;sys/mman.h&gt;</p>
<p>#include &lt;native/pipe.h&gt;</p>
<p>#include &lt;unistd.h&gt;</p>
<p>#include &lt;native/alarm.h&gt;</p>
<p>#include &lt;native/timer.h&gt;</p>
<p>#include &lt;sys/stat.h&gt;</p>
<p>#include &lt;fcntl.h&gt;</p>
<p></p>
<p>/* Global variables */</p>
<p>RT_TASK task; /* Task Descriptor */</p>
<p>/* Real Time task&#39;s Function body */</p>
<p>void task_body (void *cookie)</p>
<p>{</p>
<p>int ret;</p>
<p>int fd,i;</p>
<p>unsigned long int Xenomai_counter;</p>
<p>unsigned long int Linux_counter=0;</p>
<p>unsigned long int Xenomai_linux_diff; </p>
<p>printf(&quot;inside rt task\n&quot;);</p>
<p>printf(&quot;Opening the pipe\n&quot;); </p>
<p>fd = open(&quot;/dev/rtp4&quot;,O_RDWR); /* openning the pipe device file rtp4 as xenomai task creates pipe </p>
<p>with minor 4 */</p>
<p>if (fd &lt; 0)</p>
<p>{</p>
<p>printf(&quot;Error in opening file descriptor = %d\n&quot;,fd);</p>
<p>exit(0);</p>
<p>}</p>
<p>while(1)</p>
<p>{ </p>
<p>/*read from pipe*/</p>
<p>ret = read(fd, &amp;Xenomai_counter, (sizeof(Xenomai_counter)+1));</p>
<p>if((Xenomai_counter%10000) ==0)</p>
<p>printf(&quot;\n Xenomai_counter value =%ld\n&quot;,Xenomai_counter); </p>
<p>Xenomai_linux_diff= Xenomai_counter-Linux_counter;</p>
<p>&nbsp;</p>
<p>if(Xenomai_linux_diff&gt;1)</p>
<p>{</p>
<p>printf(&quot;\nInterrupt is missed-------&gt;&gt;&gt; TEST FAILED\n&quot;);</p>
<p>printf(&quot;\n Exiting\n&quot;); </p>
<p>break;</p>
<p>}</p>
<p>Linux_counter++; </p>
<p>}</p>
<p>printf(&quot;FAILED FAILED FAILED FAILED\n&quot;);</p>
<p>close(fd);</p>
<p>&nbsp;</p>
<p>}</p>
<p>int main (int argc, char **argv)</p>
<p>{</p>
<p>int err;</p>
<p>mlockall(MCL_CURRENT | MCL_FUTURE); /* Locking the current pages for the realtime task from swapping */</p>
<p>/* Creating Task with name mytask, stack size will be allocated by Kernel as by passing 0, priority as 1*/</p>
<p>err = rt_task_create(&amp;task,&quot;Xenomai_Linux_task&quot;,0,99,T_FPU); </p>
<p>if (err)</p>
<p>{</p>
<p>fprintf(stderr,&quot;failed to create task, code %d\n&quot;,err);</p>
<p>return 0;</p>
<p>}</p>
<p>printf(&quot;rt task created\n&quot;);</p>
<p>/* Starting the task execution */</p>
<p>err = rt_task_start(&amp;task,&amp;task_body,NULL);</p>
<p>if (err)</p>
<p>{</p>
<p>fprintf(stderr,&quot;failed to start task, code %d\n&quot;,err);</p>
<p>return 0;</p>
<p>}</p>
<p>pause(); /* This function should be ther to make the parent to be in existence this can be achived by </p>
<p>making task as joinable and waiting for that to complete */</p>
<p>// return 0;</p>
<p>}</p></font>
<p>&nbsp;</p>
<p>Thanks and Regards</p>
<p>san</p>
<p>&nbsp;</p></font></div>
<div>&nbsp;</div>
<div>&nbsp;</div>

------=_Part_5855_30625454.1182491252535--

