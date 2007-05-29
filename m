Message-ID: <7289437c0705290347y20eeff5bq3e86cd0cd4984ddb@domain.hid>
Date: Tue, 29 May 2007 12:47:49 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
In-Reply-To: <465BE777.7010204@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_131098_29827892.1180435669580"
References: <0B45E93C5FF65740AEAE690BF3848B7A4AB0F3@domain.hid>
	<465ADB44.2070705@domain.hid> <1180360288.4727.50.camel@domain.hid>
	<7289437c0705290130k627df2f9j2940c509311c75c5@domain.hid>
	<465BE777.7010204@domain.hid>
Subject: Re: [Xenomai-help] =?iso-8859-1?q?Xenomai_with_=B5Clibc?=
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

------=_Part_131098_29827892.1180435669580
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It seems that cyclictest and switchtest compile fine.
I had no error when I installed Xenomai.

Here is an example of code that fails :

/*Fichier essai_mutex.c*/
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
int DESTRUCT=0;

void affich(int toto){
 static int cpt = 0;
 pthread_mutex_lock(&mutex);
 tab[cpt] = toto;
 cpt ++;
 if(cpt == 150)
 {
  cpt = 0;
 }
 pthread_mutex_unlock(&mutex);
}

void routine1 (void * cookie){
 struct sched_param param = {.sched_priority = 10 };
 pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 for(;;){
  affich(1);
  sleep(1);
  if(DESTRUCT==1){
   pthread_exit(NULL);
  };
 }
}

void routine2 (void * cookie){
 struct sched_param param = {.sched_priority = 10 };
 pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);
 for(;;){
  affich(2);
  sleep(2);
  if(DESTRUCT==1){
   pthread_exit(NULL);
  };
 }
}

void cleanup_upon_sig(int sig __attribute__((unused)))
{
 DESTRUCT=1;
}

int main(int argc, char **argv)
{
 int i = 0;
 int err;
 sigset_t mask, oldmask;
 pthread_attr_t attr1, attr2;
 struct sched_param param1 = {.sched_priority = 10 };
 struct sched_param param2 = {.sched_priority = 10 };

 mlockall(MCL_CURRENT | MCL_FUTURE);

 /*creation du mutex*/
 pthread_mutex_init(&mutex,NULL);

 sigemptyset(&mask);
 sigaddset(&mask, SIGINT);
 signal(SIGINT, cleanup_upon_sig);
 sigaddset(&mask, SIGTERM);
 signal(SIGTERM, cleanup_upon_sig);
 sigaddset(&mask, SIGHUP);
 signal(SIGHUP, cleanup_upon_sig);

 pthread_sigmask(SIG_BLOCK, &mask, &oldmask);

 printf("Ctrl C pour stopper l'application et afficher le resultat\n");

 /*Initialisation des attributs des taches*/
 pthread_attr_init(&attr1);
 pthread_attr_setdetachstate(&attr1, PTHREAD_CREATE_JOINABLE);
 pthread_attr_setinheritsched(&attr1, PTHREAD_EXPLICIT_SCHED);
 pthread_attr_setschedpolicy(&attr1, SCHED_FIFO);
 pthread_attr_setschedparam(&attr1, &param1);
 pthread_attr_setstacksize(&attr1, PTHREAD_STACK_MIN);

 pthread_attr_init(&attr2);
 pthread_attr_setdetachstate(&attr2, PTHREAD_CREATE_JOINABLE);
 pthread_attr_setinheritsched(&attr2, PTHREAD_EXPLICIT_SCHED);
 pthread_attr_setschedpolicy(&attr2, SCHED_FIFO);
 pthread_attr_setschedparam(&attr2, &param2);
 pthread_attr_setstacksize(&attr2, PTHREAD_STACK_MIN);

 if (err = pthread_create (&task1,&attr1,(void *)routine1,NULL))
  fprintf(stderr, "failed to create threads: %s\n", strerror(err));

 if (err = pthread_create (&task2,&attr2,(void *)routine2,NULL))
  fprintf(stderr, "failed to create threads: %s\n", strerror(err));

 pthread_sigmask(SIG_UNBLOCK, &mask, &oldmask);

 pthread_join(task1, NULL);
 pthread_join(task2, NULL);

 if (err = pthread_mutex_destroy(&mutex))
  fprintf(stderr, "failed to cancel mutex");

 for(i = 0; i < 20 ; i++)
  {
   printf("Task %d\n",tab[i]);
  }
return 0;
}

And the makefile :

arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/usr/xenomai_arm-
2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -g
essai_mutex.c -c -o essai_mutex_rt.o

arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthread_setschedparam
-Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield
-Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy
-Wl,--wrap,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait
-Wl,--wrap,sem_trywait -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open
-Wl,--wrap,sem_close -Wl,--wrap,sem_unlink -Wl,--wrap,clock_getres
-Wl,--wrap,clock_gettime -Wl,--wrap,clock_settime -Wl,--wrap,clock_nanosleep
-Wl,--wrap,nanosleep -Wl,--wrap,pthread_mutexattr_init
-Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthread_mutexattr_gettype
-Wl,--wrap,pthread_mutexattr_settype
-Wl,--wrap,pthread_mutexattr_getprotocol
-Wl,--wrap,pthread_mutexattr_setprotocol
-Wl,--wrap,pthread_mutexattr_getpshared
-Wl,--wrap,pthread_mutexattr_setpshared -Wl,--wrap,pthread_mutex_init
-Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread_mutex_lock
-Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timedlock
-Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init
-Wl,--wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock
-Wl,--wrap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_getpshared
-Wl,--wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init
-Wl,--wrap,pthread_cond_destroy -Wl,--wrap,pthread_cond_wait
-Wl,--wrap,pthread_cond_timedwait -Wl,--wrap,pthread_cond_signal
-Wl,--wrap,pthread_cond_broadcast -Wl,--wrap,mq_open -Wl,--wrap,mq_close
-Wl,--wrap,mq_unlink -Wl,--wrap,mq_getattr -Wl,--wrap,mq_setattr
-Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--wrap,mq_receive
-Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,open
-Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl \,--wrap,sendto
-Wl,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt -Wl,--wrap,setsockopt
-Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,listen -Wl,--wrap,accept
-Wl,--wrap,getsockname -Wl,--wrap,getpeername -Wl,--wrap,shutdown
-Wl,--wrap,timer_create -Wl,--wrap,timer_delete -Wl,--wrap,timer_settime
-Wl,--wrap,timer_getoverrun -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate
-Wl,--wrap,close -Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap
-Wl,--wrap,munmap -L/usr/xenomai_arm-2.3.1uClibc/lib essai_mutex_rt.o
-lpthread_rt -lpthread -lrt -o essai_mutex_rt

Thanks


On 5/29/07, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> Perrine Martignoni wrote:
> > I applied the patch xeno-2.3-posix-shm.diff and the installation of
> > Xenomai works fine.
> > Thanks
> >
> > But after when I want to compile an application (who works with glibc),
> > I have this error :
> >
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> > `__wrap_mmap'
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/librt.so: undefined reference
> > to`__wrap_close'
> >
> > /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
> > `__wrap_munmap'
> >
> > collect2: ld returned 1 exit status
> >
> > This error appears with any example of code.
>
> Does this happen when compiling Xenomai posix programs, such as
> cyclictest or switchtest ?
> As usual, please show us an example of code that fails (including the
> Makefile).
>
> --
>                                                 Gilles Chanteperdrix
>

------=_Part_131098_29827892.1180435669580
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>It seems that cyclictest and switchtest compile fine.</div>
<div>I had no error when I installed Xenomai.</div>
<div>&nbsp;</div>
<div>Here is an example of code that fails : </div>
<div>&nbsp;</div>
<div>/*Fichier essai_mutex.c*/</div>
<div>#include &lt;pthread.h&gt;<br>#include &lt;string.h&gt;<br>#include &l=
t;stdio.h&gt;<br>#include &lt;signal.h&gt;<br>#include &lt;time.h&gt;<br>#i=
nclude &lt;errno.h&gt;<br>#include &lt;fcntl.h&gt;<br>#include &lt;getopt.h
&gt;<br>#include &lt;unistd.h&gt;<br>#include &lt;stdlib.h&gt;<br>#include =
&lt;sys/mman.h&gt;<br>#include &lt;sys/time.h&gt;<br>#include &lt;limits.h&=
gt;</div>
<div><br>pthread_t task1, task2;<br>pthread_mutex_t mutex;</div>
<div>void routine1 (void * cookie);<br>void routine2 (void * cookie);</div>
<div>
<p>int tab[200];<br>int DESTRUCT=3D0;</p>
<p>void affich(int toto){<br>&nbsp;static int cpt =3D 0;<br>&nbsp;pthread_m=
utex_lock(&amp;mutex);<br>&nbsp;tab[cpt] =3D toto;<br>&nbsp;cpt ++;<br>&nbs=
p;if(cpt =3D=3D 150)<br>&nbsp;{<br>&nbsp;&nbsp;cpt =3D 0;<br>&nbsp;}<br>&nb=
sp;pthread_mutex_unlock(&amp;mutex);<br>}</p>
<p>void routine1 (void * cookie){<br>&nbsp;struct sched_param param =3D {.s=
ched_priority =3D 10 };<br>&nbsp;pthread_setschedparam(pthread_self(), SCHE=
D_FIFO, &amp;param);<br>&nbsp;for(;;){&nbsp;<br>&nbsp;&nbsp;affich(1);<br>&=
nbsp;&nbsp;sleep(1);<br>&nbsp;&nbsp;if(DESTRUCT=3D=3D1){
<br>&nbsp;&nbsp;&nbsp;pthread_exit(NULL);<br>&nbsp;&nbsp;};<br>&nbsp;}<br>}=
</p>
<p>void routine2 (void * cookie){<br>&nbsp;struct sched_param param =3D {.s=
ched_priority =3D 10 };<br>&nbsp;pthread_setschedparam(pthread_self(), SCHE=
D_FIFO, &amp;param);<br>&nbsp;for(;;){<br>&nbsp;&nbsp;affich(2);<br>&nbsp;&=
nbsp;sleep(2);<br>&nbsp;&nbsp;if(DESTRUCT=3D=3D1){
<br>&nbsp;&nbsp;&nbsp;pthread_exit(NULL);<br>&nbsp;&nbsp;};<br>&nbsp;}<br>}=
</p>
<p>void cleanup_upon_sig(int sig __attribute__((unused)))<br>{&nbsp;<br>&nb=
sp;DESTRUCT=3D1;<br>}</p>
<p>int main(int argc, char **argv)<br>{<br>&nbsp;int i =3D 0; <br>&nbsp;int=
 err;<br>&nbsp;sigset_t mask, oldmask;<br>&nbsp;pthread_attr_t attr1, attr2=
;&nbsp;<br>&nbsp;struct sched_param param1 =3D {.sched_priority =3D 10 };<b=
r>&nbsp;struct sched_param param2 =3D {.sched_priority =3D 10 };
</p>
<p>&nbsp;mlockall(MCL_CURRENT | MCL_FUTURE);</p>
<p>&nbsp;/*creation du mutex*/<br>&nbsp;pthread_mutex_init(&amp;mutex,NULL)=
;</p>
<p>&nbsp;sigemptyset(&amp;mask);<br>&nbsp;sigaddset(&amp;mask, SIGINT);<br>=
&nbsp;signal(SIGINT, cleanup_upon_sig);<br>&nbsp;sigaddset(&amp;mask, SIGTE=
RM);<br>&nbsp;signal(SIGTERM, cleanup_upon_sig);<br>&nbsp;sigaddset(&amp;ma=
sk, SIGHUP);<br>&nbsp;signal(SIGHUP, cleanup_upon_sig);
</p>
<p>&nbsp;pthread_sigmask(SIG_BLOCK, &amp;mask, &amp;oldmask);</p>
<p>&nbsp;printf(&quot;Ctrl C pour stopper l&#39;application et afficher le =
resultat\n&quot;);<br>&nbsp;<br>&nbsp;/*Initialisation des attributs des ta=
ches*/<br>&nbsp;pthread_attr_init(&amp;attr1);<br>&nbsp;pthread_attr_setdet=
achstate(&amp;attr1, PTHREAD_CREATE_JOINABLE);
<br>&nbsp;pthread_attr_setinheritsched(&amp;attr1, PTHREAD_EXPLICIT_SCHED);=
<br>&nbsp;pthread_attr_setschedpolicy(&amp;attr1, SCHED_FIFO);<br>&nbsp;pth=
read_attr_setschedparam(&amp;attr1, &amp;param1);<br>&nbsp;pthread_attr_set=
stacksize(&amp;attr1, PTHREAD_STACK_MIN);
<br>&nbsp;<br>&nbsp;pthread_attr_init(&amp;attr2);<br>&nbsp;pthread_attr_se=
tdetachstate(&amp;attr2, PTHREAD_CREATE_JOINABLE);<br>&nbsp;pthread_attr_se=
tinheritsched(&amp;attr2, PTHREAD_EXPLICIT_SCHED);&nbsp; <br>&nbsp;pthread_=
attr_setschedpolicy(&amp;attr2, SCHED_FIFO);
<br>&nbsp;pthread_attr_setschedparam(&amp;attr2, &amp;param2);<br>&nbsp;pth=
read_attr_setstacksize(&amp;attr2, PTHREAD_STACK_MIN);</p>
<p>&nbsp;if (err =3D pthread_create (&amp;task1,&amp;attr1,(void *)routine1=
,NULL))<br>&nbsp;&nbsp;fprintf(stderr, &quot;failed to create threads: %s\n=
&quot;, strerror(err));</p>
<p>&nbsp;if (err =3D pthread_create (&amp;task2,&amp;attr2,(void *)routine2=
,NULL))<br>&nbsp;&nbsp;fprintf(stderr, &quot;failed to create threads: %s\n=
&quot;, strerror(err));</p>
<p>&nbsp;pthread_sigmask(SIG_UNBLOCK, &amp;mask, &amp;oldmask);</p>
<p>&nbsp;pthread_join(task1, NULL);<br>&nbsp;pthread_join(task2, NULL);</p>
<p>&nbsp;if (err =3D pthread_mutex_destroy(&amp;mutex))<br>&nbsp;&nbsp;fpri=
ntf(stderr, &quot;failed to cancel mutex&quot;);</p>
<p>&nbsp;for(i =3D 0; i &lt; 20 ; i++)<br>&nbsp;&nbsp;{<br>&nbsp;&nbsp;&nbs=
p;printf(&quot;Task %d\n&quot;,tab[i]);<br>&nbsp;&nbsp;}<br>return 0;<br>}<=
/p>
<p>And the makefile : </p><font size=3D"2">
<p align=3D"left">arm-linux-gcc -I/usr/xenomai_arm-2.3.1uClibc/include -I/u=
sr/xenomai_arm-2.3.1uClibc/include/posix -D_GNU_SOURCE -D_REENTRANT -D__XEN=
O__ -g essai_mutex.c -c -o essai_mutex_rt.o</p>
<p align=3D"left"></p>
<p align=3D"left">arm-linux-gcc -Wl,--wrap,pthread_create -Wl,--wrap,pthrea=
d_setschedparam -Wl,--wrap,pthread_getschedparam -Wl,--wrap,pthread_yield -=
Wl,--wrap,sched_yield -Wl,--wrap,sem_init -Wl,--wrap,sem_destroy -Wl,--wrap=
,sem_post -Wl,--wrap,sem_timedwait -Wl,--wrap,sem_wait -Wl,--wrap,sem_trywa=
it -Wl,--wrap,sem_getvalue -Wl,--wrap,sem_open -Wl,--wrap,sem_close -Wl,--w=
rap,sem_unlink -Wl,--wrap,clock_getres -Wl,--wrap,clock_gettime -Wl,--wrap,=
clock_settime -Wl,--wrap,clock_nanosleep -Wl,--wrap,nanosleep -Wl,--wrap,pt=
hread_mutexattr_init -Wl,--wrap,pthread_mutexattr_destroy -Wl,--wrap,pthrea=
d_mutexattr_gettype -Wl,--wrap,pthread_mutexattr_settype -Wl,--wrap,pthread=
_mutexattr_getprotocol -Wl,--wrap,pthread_mutexattr_setprotocol -Wl,--wrap,=
pthread_mutexattr_getpshared -Wl,--wrap,pthread_mutexattr_setpshared -Wl,--=
wrap,pthread_mutex_init -Wl,--wrap,pthread_mutex_destroy -Wl,--wrap,pthread=
_mutex_lock -Wl,--wrap,pthread_mutex_trylock -Wl,--wrap,pthread_mutex_timed=
lock -Wl,--wrap,pthread_mutex_unlock -Wl,--wrap,pthread_condattr_init -Wl,-=
-wrap,pthread_condattr_destroy -Wl,--wrap,pthread_condattr_getclock -Wl,--w=
rap,pthread_condattr_setclock -Wl,--wrap,pthread_condattr_getpshared -Wl,--=
wrap,pthread_condattr_setpshared -Wl,--wrap,pthread_cond_init -Wl,--wrap,pt=
hread_cond_destroy -Wl,--wrap,pthread_cond_wait -Wl,--wrap,pthread_cond_tim=
edwait -Wl,--wrap,pthread_cond_signal -Wl,--wrap,pthread_cond_broadcast -Wl=
,--wrap,mq_open -Wl,--wrap,mq_close -Wl,--wrap,mq_unlink -Wl,--wrap,mq_geta=
ttr -Wl,--wrap,mq_setattr -Wl,--wrap,mq_send -Wl,--wrap,mq_timedsend -Wl,--=
wrap,mq_receive -Wl,--wrap,mq_timedreceive -Wl,--wrap,mq_notify -Wl,--wrap,=
open -Wl,--wrap,socket -Wl,--wrap,close -Wl,--wrap,ioctl \,--wrap,sendto -W=
l,--wrap,recv -Wl,--wrap,send -Wl,--wrap,getsockopt -Wl,--wrap,setsockopt -=
Wl,--wrap,bind -Wl,--wrap,connect -Wl,--wrap,listen -Wl,--wrap,accept -Wl,-=
-wrap,getsockname -Wl,--wrap,getpeername -Wl,--wrap,shutdown -Wl,--wrap,tim=
er_create -Wl,--wrap,timer_delete -Wl,--wrap,timer_settime -Wl,--wrap,timer=
_getoverrun -Wl,--wrap,timer_gettime -Wl,--wrap,ftruncate -Wl,--wrap,close =
-Wl,--wrap,shm_open -Wl,--wrap,shm_unlink -Wl,--wrap,mmap -Wl,--wrap,munmap=
 -L/usr/xenomai_arm-
2.3.1uClibc/lib essai_mutex_rt.o -lpthread_rt -lpthread -lrt -o essai_mutex=
_rt</p>
<p align=3D"left">Thanks</p></font>
<p><br><span class=3D"gmail_quote">On 5/29/07, <b class=3D"gmail_sendername=
">Gilles Chanteperdrix</b> &lt;<a href=3D"mailto:gilles.chanteperdrix@xenomai.org=
te.net">gilles.chanteperdrix@xenomai.org</a>&gt; wrote:</span></p></div>
<div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Perrine Martignoni wrote:<br>&gt=
; I applied the patch xeno-2.3-posix-shm.diff and the installation of<br>&g=
t; Xenomai works fine.
<br>&gt; Thanks<br>&gt;<br>&gt; But after when I want to compile an applica=
tion (who works with glibc),<br>&gt; I have this error :<br>&gt;<br>&gt;<br=
>&gt; /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference t=
o
<br>&gt; `__wrap_mmap&#39;<br>&gt;<br>&gt; /usr/src/ELDK_arm/usr/../arm/lib=
/librt.so: undefined reference<br>&gt; to`__wrap_close&#39;<br>&gt;<br>&gt;=
 /usr/src/ELDK_arm/usr/../arm/lib/libpthread.so: undefined reference to
<br>&gt; `__wrap_munmap&#39;<br>&gt;<br>&gt; collect2: ld returned 1 exit s=
tatus<br>&gt;<br>&gt; This error appears with any example of code.<br><br>D=
oes this happen when compiling Xenomai posix programs, such as<br>cyclictes=
t or switchtest ?
<br>As usual, please show us an example of code that fails (including the<b=
r>Makefile).<br><br>--<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;Gilles Chanteperdrix<br></blockquote></div><br>

------=_Part_131098_29827892.1180435669580--

