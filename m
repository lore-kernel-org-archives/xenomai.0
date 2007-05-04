Message-ID: <7289437c0705040108s7ecc6092u5332cb40796a8dd6@domain.hid>
Date: Fri, 4 May 2007 10:08:29 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20448_15398719.1178266109612"
Subject: [Xenomai-help] Problem with API Posix
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

------=_Part_20448_15398719.1178266109612
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm writing some simple examples of real time code with API Posix of Xenomai
and I think I'm doing something wrong.
I would like to have two threads with different priority and see the two
threads switching.
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



pthread_t task1, task2;

pthread_mutex_t mutex;

void routine1 (void * cookie);

void routine2 (void * cookie);



int tab[200];



void affich(int i)

{

            static int cpt = 0;

            pthread_mutex_lock(&mutex);

            tab[cpt] = i;

            cpt ++;

            if(cpt == 150){

                        cpt = 0;

            }

            pthread_mutex_unlock(&mutex);

}

void routine1 (void * cookie){

            for(;;){

                        affich(1);

                        sleep(1);

            }

}

void routine2 (void * cookie)

{

            for(;;){

                        affich(2);

                        sleep(2);

            }

}

void cleanup_upon_sig(int sig __attribute__((unused)))

{

            pthread_mutex_destroy(&mutex);

            pthread_exit(&task1);

            pthread_exit(&task2);

            exit(0);

}

int main(int argc, char **argv)

{

            sigset_t mask;

            pthread_attr_t attr1, attr2;

            struct sched_param param1, param2;

            int i = 0;

            mlockall(MCL_CURRENT | MCL_FUTURE);



            pthread_mutex_init(&mutex,NULL);



            sigemptyset(&mask);

            sigaddset(&mask, SIGINT);

            signal(SIGINT, cleanup_upon_sig);

            sigaddset(&mask, SIGTERM);

            signal(SIGTERM, cleanup_upon_sig);

            sigaddset(&mask, SIGHUP);

            signal(SIGHUP, cleanup_upon_sig);



            pthread_attr_init(&attr1);

            pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_JOINABLE);

            pthread_attr_setinheritsched(&attr1, PTHREAD_EXPLICIT_SCHED);

            pthread_attr_setschedpolicy(&attr1, SCHED_FIFO);

            pthread_attr_setschedparam(&attr1, &param1);

            param1.sched_priority =20;

            pthread_attr_setstacksize(&attr1, PTHREAD_STACK_MIN);



            pthread_attr_init(&attr2);

            pthread_attr_setdetachstate(&attr2, PTHREAD_CREATE_JOINABLE);

            pthread_attr_setinheritsched(&attr2, PTHREAD_EXPLICIT_SCHED);

            pthread_attr_setschedpolicy(&attr2, SCHED_FIFO);

            pthread_attr_setschedparam(&attr2, &param2);

            param2.sched_priority = 99;

            pthread_attr_setstacksize(&attr2, PTHREAD_STACK_MIN);



            pthread_create (&task1,&attr1,(void *)routine1,NULL);

            pthread_create (&task2,&attr2,(void *)routine2,NULL);

            sleep(10);



            for(i = 0; i < 150 ; i++){

                        printf("Task %d\n",tab[i]);

            }

return 0;

}



And here is the result :



Task 2

Task 2

Task 2

Task 2

Task 2



Task 1 don't run when Task 2 is sleeping.

I know that sleep() is not real time but it is the reason of this problem?



Thank you

------=_Part_20448_15398719.1178266109612
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hello, </div>
<div>&nbsp;</div>
<div>I&#39;m writing some simple examples of real time code with API Posix of Xenomai and I think I&#39;m doing something wrong.</div>
<div>I would like to have two threads&nbsp;with different priority&nbsp;and see the two threads switching.</div>
<div>Here is my code : </div>
<div>&nbsp;</div>
<div>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;pthread.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;string.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;stdio.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;signal.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;time.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;errno.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;fcntl.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;getopt.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;unistd.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;stdlib.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;sys/mman.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;sys/time.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">#include &lt;limits.h&gt;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">pthread_t task1, task2;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">pthread_mutex_t mutex;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void routine1 (void * cookie);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void routine2 (void * cookie);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">int tab[200];</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void affich(int i)</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">{</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>static int cpt = 0;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_lock(&amp;mutex);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>tab[cpt] = i;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cpt ++;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if(cpt == 150){</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cpt = 0;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_unlock(&amp;mutex);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void routine1 (void * cookie){</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(;;){<span style="mso-tab-count: 1"> </span></font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>affich(1);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sleep(1);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void routine2 (void * cookie)</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">{</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(;;){</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>affich(2);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sleep(2);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">void cleanup_upon_sig(int sig __attribute__((unused)))</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">{</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_destroy(&amp;mutex);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_exit(&amp;task1);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_exit(&amp;task2);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(0);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">int main(int argc, char **argv)</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">{</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigset_t mask;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_t attr1, attr2;<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct sched_param param1, param2;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int i = 0; </font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mlockall(MCL_CURRENT | MCL_FUTURE);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_init(&amp;mutex,NULL);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigemptyset(&amp;mask);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGINT);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGINT, cleanup_upon_sig);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGTERM);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGTERM, cleanup_upon_sig);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGHUP);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGHUP, cleanup_upon_sig);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-tab-count: 1"><font face="Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_init(&amp;attr1);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setdetachstate(&amp;attr1, PTHREAD_CREATE_JOINABLE);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setinheritsched(&amp;attr1, PTHREAD_EXPLICIT_SCHED);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedpolicy(&amp;attr1, SCHED_FIFO);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedparam(&amp;attr1, &amp;param1);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>param1.sched_priority =20;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setstacksize(&amp;attr1, PTHREAD_STACK_MIN);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-tab-count: 1"><font face="Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_init(&amp;attr2);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setdetachstate(&amp;attr2, PTHREAD_CREATE_JOINABLE);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setinheritsched(&amp;attr2, PTHREAD_EXPLICIT_SCHED);<span style="mso-spacerun: yes">
&nbsp; </span></font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedpolicy(&amp;attr2, SCHED_FIFO);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedparam(&amp;attr2, &amp;param2);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>param2.sched_priority = 99;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setstacksize(&amp;attr2, PTHREAD_STACK_MIN);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">&nbsp;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_create (&amp;task1,&amp;attr1,(void *)routine1,NULL);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_create (&amp;task2,&amp;attr2,(void *)routine2,NULL);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sleep(10);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><span style="mso-tab-count: 1"><font face="Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(i = 0; i &lt; 150 ; i++){</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;Task %d\n&quot;,tab[i]);</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"><span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}<span style="mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">return 0;</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">}</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">And here is the result : </font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 2</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 2</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 2</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 2</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 2</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Task 1 don&#39;t run when Task 2 is sleeping.</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">I know that sleep() is not real time but it is the reason of this problem?</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman">Thank you</font></p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p>
<p class="MsoNormal" style="MARGIN: 0cm 0cm 0pt"><font face="Times New Roman"></font>&nbsp;</p></div>

------=_Part_20448_15398719.1178266109612--

