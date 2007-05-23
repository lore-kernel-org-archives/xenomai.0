Message-ID: <7289437c0705230649u5a09e726q86204106bb22a7b8@domain.hid>
Date: Wed, 23 May 2007 15:49:57 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_81791_21379205.1179928197358"
Subject: [Xenomai-help] Problem API Posix : ressource temporarily unavailable
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

------=_Part_81791_21379205.1179928197358
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I work on an ARM9 with the API Posix and I found a problem during my tests.
I have written a simple example who show this problem.
Here is my code :

#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <signal.h>
#include <time.h>
#include <errno.h>
#include <fcntl.h>
#include <getopt.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <limits.h>
#include <mqueue.h>
void routine (void * cookie);
void routine (void * cookie)
{
struct timespec timeout;
struct sched_param param = {.sched_priority = 10 };
pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
timeout.tv_sec=0;
timeout.tv_nsec=200000000;

nanosleep ( &timeout, NULL);
printf("destruction tache\n");
pthread_exit(NULL);
}

int main(int argc, char **argv)
{
int i = 0;
int err;
pthread_attr_t attr;
pthread_t task;
struct timespec timeout, timeout2;
struct sched_param param = {.sched_priority = 10 };

mlockall(MCL_CURRENT | MCL_FUTURE);

timeout.tv_sec=50;
timeout.tv_nsec=0;
timeout2.tv_sec=0;
timeout2.tv_nsec=500000000;

pthread_attr_init(&attr);
pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
pthread_attr_setschedparam(&attr, &param);
pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);

for(i=0;i<10000;i++){
 printf("Tour %d\n", i);
 if (err = pthread_create (&task,&attr,(void *)routine,NULL))
 fprintf(stderr, "failed to create threads: %s\n", strerror(err));
 if (err = pthread_create (&task,&attr,(void *)routine,NULL))
 fprintf(stderr, "failed to create threads: %s\n", strerror(err));
 if (err = pthread_create (&task,&attr,(void *)routine,NULL))
 fprintf(stderr, "failed to create threads: %s\n", strerror(err));

 nanosleep ( &timeout2, NULL);
}

nanosleep ( &timeout, NULL);
return 0;
}

At the turn 509, it doesn't work any more. Ressources are unavailable to
create another task.


Thanks

------=_Part_81791_21379205.1179928197358
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello, </div>
<div>&nbsp;</div>
<div>I work on an ARM9 with the API Posix and I found a problem during my tests.</div>
<div>I have written a simple example who show this problem.</div>
<div>Here is my code : </div>
<div>&nbsp;</div>
<div><font face="verdana" size="1">#include &lt;pthread.h&gt;<br>#include &lt;string.h&gt;<br>#include &lt;stdio.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;time.h&gt;<br>#include &lt;errno.h&gt;<br>#include &lt;fcntl.h
&gt;<br>#include &lt;getopt.h&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include &lt;sys/mman.h&gt;<br>#include &lt;sys/time.h&gt;<br>#include &lt;limits.h&gt;<br>#include &lt;mqueue.h&gt;<br>void routine (void * cookie);
<br></font></div>
<div><font face="verdana" size="1">void routine (void * cookie)<br>{<br>struct timespec timeout;<br>struct sched_param param = {.sched_priority = 10 };<br>pthread_setschedparam(pthread_self(), SCHED_FIFO, &amp;param);<br>
timeout.tv_sec=0;<br>timeout.tv_nsec=200000000;</font></div>
<div>
<p><font face="verdana" size="1">nanosleep ( &amp;timeout, NULL);<br>printf(&quot;destruction tache\n&quot;);<br>pthread_exit(NULL);<br>}</font></p>
<p><font face="verdana" size="1">int main(int argc, char **argv)<br>{<br>int i = 0; <br>int err;<br>pthread_attr_t attr;<br>pthread_t task; <br>struct timespec timeout, timeout2; <br>struct sched_param param = {.sched_priority = 10 };
</font></p>
<p><font face="verdana" size="1">mlockall(MCL_CURRENT | MCL_FUTURE);</font></p>
<p><font face="verdana" size="1">timeout.tv_sec=50;<br>timeout.tv_nsec=0;<br>timeout2.tv_sec=0;<br>timeout2.tv_nsec=500000000;</font></p>
<p><font face="verdana" size="1">pthread_attr_init(&amp;attr);<br>pthread_attr_setdetachstate(&amp;attr, PTHREAD_CREATE_JOINABLE);<br>pthread_attr_setinheritsched(&amp;attr, PTHREAD_EXPLICIT_SCHED);<br>pthread_attr_setschedpolicy(&amp;attr, SCHED_FIFO);
<br>pthread_attr_setschedparam(&amp;attr, &amp;param);<br>pthread_attr_setstacksize(&amp;attr, PTHREAD_STACK_MIN);</font></p>
<p><font face="verdana" size="1">for(i=0;i&lt;10000;i++){<br>&nbsp;printf(&quot;Tour %d\n&quot;, i);<br>&nbsp;if (err = pthread_create (&amp;task,&amp;attr,(void *)routine,NULL))<br>&nbsp;fprintf(stderr, &quot;failed to create threads: %s\n&quot;, strerror(err));
<br>&nbsp;if (err = pthread_create (&amp;task,&amp;attr,(void *)routine,NULL))&nbsp;<br>&nbsp;fprintf(stderr, &quot;failed to create threads: %s\n&quot;, strerror(err));<br>&nbsp;if (err = pthread_create (&amp;task,&amp;attr,(void *)routine,NULL))
<br>&nbsp;fprintf(stderr, &quot;failed to create threads: %s\n&quot;, strerror(err));</font></p>
<p><font face="verdana" size="1">&nbsp;nanosleep ( &amp;timeout2, NULL);<br>}<br>&nbsp;<br>nanosleep ( &amp;timeout, NULL);<br>return 0;<br>}</font></p></div>
<div>&nbsp;</div>
<div>At the turn 509, it doesn&#39;t work any more. Ressources are unavailable to create another task.</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Thanks</div>
<div>&nbsp;</div>

------=_Part_81791_21379205.1179928197358--

