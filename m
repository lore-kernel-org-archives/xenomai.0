Message-ID: <20061005135710.35700.qmail@domain.hid>
Date: Thu, 5 Oct 2006 06:57:10 -0700 (PDT)
From: mani bhatti <imranbashirbhatti@domain.hid>
In-Reply-To: <451A9C64.7040802@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1512227822-1160056630=:35465"
Content-Transfer-Encoding: 8bit
Subject: [Xenomai-help] Problem with Aperiodic xenomai tasks
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

--0-1512227822-1160056630=:35465
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI=20
I want to have two tasks in xenomai the pariodic task and the non pariodic =
tasks which is signalled by the pariodic task.The problem is that  if i mak=
e one thread pariodic and the other one non pariodic then the pariodic thre=
ad never runs after specific time period and only non pariodic thread appea=
rs .The code for tasks  is given below.I would be very thankful if please s=
ome one  figure out what wrong i am doing.Thanks

void zaehler1_task(void *cookie){
        int ret;
    ret =3D rt_task_set_periodic(NULL, TM_NOW,                     rt_timer=
_ns2ticks(task_period_ns1));
        if (ret) {
                printf("error while set periodic, code %d\n",ret);
                 return;
        }
        while(!end){
                ret =3D rt_task_set_mode(0, T_RRB, NULL);
                if (ret) {
                        printf("error while rt_task_set_mode, code %d\n",re=
t);
                        return;
                }
                ret =3D  rt_task_wait_period();
                printf("T1:Start\n");

                if (ret) {
                 printf("error while rt_task_wait_period, code %d\n",ret);
                  return;
                }
           rt_mutex_lock(&threadmutex,TM_INFINITE);
           count1++;
           printf("T1:Ende:%d\n", count1);
    =20
           if(count1=3D=3D15)    =20
          {  rt_cond_signal(&cond); } =20
            rt_mutex_unlock(&threadmutex);
          }
}
void zaehler2_task(void *cookie){
    int ret;   =20
    long ii;
    long jj;
    double a;
    while(!end){
             rt_mutex_lock(&threadmutex,TM_INFINITE);
             rt_cond_wait(&cond,&threadmutex,TM_INFINITE);
             printf("\t\tT2:Start\n");
              count2++;
             printf("\t\tT2:Ende:%d\n", count2++);
            rt_mutex_unlock(&threadmutex);
         }
}
int main(int argc, char *argv[]) {
    int err, ret;
    printf("start\n");
    // install signal handler
    signal(SIGTERM, clean_exit);   =20
    signal(SIGINT, clean_exit);   =20
    // start timer
    ret =3D rt_timer_start(TM_ONESHOT);
    switch (ret) {
        case 0:       printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");
                      break;
        case -EBUSY:  printf("timer is running\n");
                      break;
        case -ENOSYS: printf("can't start timer\n");
                      return ret;
    }

    rt_cond_create(&cond,NULL);
        /* create zaehler1_task */
    err =3D rt_task_create(&zaehler1_task_ptr,"Zaehler_1",STACK_SIZE,STD_PR=
IO1,0);
    /* create zaehler2_task */
    err =3D rt_task_create(&zaehler2_task_ptr,"Zaehler_2",STACK_SIZE,STD_PR=
IO2,0);

    /* start zaehler1_task */
    err =3D rt_task_start(&zaehler1_task_ptr,&zaehler1_task,NULL);

    /* start zaehler2_task */
    err =3D rt_task_start(&zaehler2_task_ptr,&zaehler2_task,NULL);

    // wait for signal & return of signal handler
    pause();
    fflush(NULL);
    return 0;
}




Jan Kiszka <jan.kiszka@domain.hid> wrote: mani bhatti wrote:
> Thanks Jan for your reply
> Actually the semaphore and mutexes stuff you have referred to i have
> already grounds for them.The only problem i have is please some body
> tell me that i dont want to make a thread periodic i,e i dont want to
> call a thread after periodic time interval i wanted it to  make it
> aperiodic like threads in C++ are scheduled by scheduler byitself

This has nothing to do with C++, rather with the class library you are
used to.

> and sleep on waiting condition with out any specific time interval
> and wake  only when  signalled from  pariodic thread. I hope you
> understand my point.Thanks a lot .

Let's try it differently:

thread_a()
{
 rt_task_set_periodic(...);
 while (1) {
  rt_task_wait_period(NULL);
  /* do some work */
  if (I_should_trigger_thread_b)
   rt_sem_v(&sem);
 }
}

thread_b()
{
 while (1) {
  rt_sem_p(&sem, TM_INFINITE);
  /* so some other work */
 }
}

Again, read up what the services are exactly doing or you will be lost
once you have to modify things only slightly.

Jan



 	=09
---------------------------------
How low will we go? Check out Yahoo! Messenger=92s low  PC-to-Phone call ra=
tes.
--0-1512227822-1160056630=:35465
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI <br>I want to have two tasks in xenomai the pariodic task and the non pa=
riodic tasks which is signalled by the pariodic task.The problem is that&nb=
sp; if i make one thread pariodic and the other one non pariodic then the p=
ariodic thread never runs after specific time period and only non pariodic =
thread appears .The code for tasks&nbsp; is given below.I would be very tha=
nkful if please some one&nbsp; figure out what wrong i am doing.Thanks<br><=
br>void zaehler1_task(void *cookie){<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; int ret;<br>&nbsp;&nbsp;&nbsp; ret =3D rt_task_set_periodic(NULL, T=
M_NOW,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_timer_ns2ticks(task_=
period_ns1));<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; printf("error while set periodic, code
 %d\n",ret);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while(!end){<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; ret =3D rt_task_set_mode(0, T_RRB, NULL);<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; if (ret) {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; printf("error while rt_task_set_mode, code %d\n",ret);<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;
 }<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D  rt_task_wait_period();<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr=
intf("T1:Start\n");<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; printf("error while rt_task_wait_period, code %d\n",ret);<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; return;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_mutex_lock(&amp;threadmutex,TM_INFIN=
ITE);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; count=
1++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 printf("T1:Ende:%d\n", count1);<br>&nbsp;&nbsp;&nbsp;  <br>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  if(count1=3D=3D15)&nbsp;&nbsp;&nbs=
p;&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {&nbsp;=
 rt_cond_signal(&amp;cond); }&nbsp; <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_mutex_unlock(&amp;threadmutex);<br>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>}<br>void zaehler2_t=
ask(void *cookie){<br>&nbsp;&nbsp;&nbsp; int ret;&nbsp;&nbsp;&nbsp; <br>&nb=
sp;&nbsp;&nbsp; long ii;<br>&nbsp;&nbsp;&nbsp; long jj;<br>&nbsp;&nbsp;&nbs=
p; double a;<br>&nbsp;&nbsp;&nbsp; while(!end){<br>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_mutex_lock(&amp;threadmutex,=
TM_INFINITE);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rt_cond_wait(&amp;cond,&amp;threadmutex,TM_INFINITE);<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 printf("\t\tT2:Start\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;  count2++;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("\t\tT2:Ende:%d\n", count2++=
);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt=
_mutex_unlock(&amp;threadmutex);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; }<br>}<br>int main(int argc, char *argv[]) {<br>&nbsp;&nbsp;&nbsp=
; int err, ret;<br>&nbsp;&nbsp;&nbsp; printf("start\n");<br>&nbsp;&nbsp;&nb=
sp; // install signal handler<br>&nbsp;&nbsp;&nbsp; signal(SIGTERM, clean_e=
xit);&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; signal(SIGINT, clean_exit);&=
nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp;&nbsp; // start timer<br>&nbsp;&nbsp;&nbs=
p; ret =3D rt_timer_start(TM_ONESHOT);<br>&nbsp;&nbsp;&nbsp; switch (ret) {=
<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case 0:&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; printf("Mit dem Fahrrad nich inn ersten Wagen\n\n");<br>&nbsp;&n=
bsp;&nbsp;
 &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; cas=
e -EBUSY:&nbsp; printf("timer is running\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&=
nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; break;<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; case -ENOSY=
S: printf("can't start timer\n");<br>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return ret;<br>&nbsp;&nbsp;&nbsp; }<br><br>&nbsp;&nbsp;&nbsp; rt_cond_c=
reate(&amp;cond,NULL);<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* cre=
ate zaehler1_task */<br>&nbsp;&nbsp;&nbsp; err =3D rt_task_create(&amp;zaeh=
ler1_task_ptr,"Zaehler_1",STACK_SIZE,STD_PRIO1,0);<br>&nbsp;&nbsp;&nbsp; /*=
 create zaehler2_task */<br>&nbsp;&nbsp;&nbsp; err =3D rt_task_create(&amp;=
zaehler2_task_ptr,"Zaehler_2",STACK_SIZE,STD_PRIO2,0);<br><br>&nbsp;&nbsp;&=
nbsp; /* start
 zaehler1_task */<br>&nbsp;&nbsp;&nbsp; err =3D rt_task_start(&amp;zaehler1=
_task_ptr,&amp;zaehler1_task,NULL);<br><br>&nbsp;&nbsp;&nbsp; /* start zaeh=
ler2_task */<br>&nbsp;&nbsp;&nbsp; err =3D rt_task_start(&amp;zaehler2_task=
_ptr,&amp;zaehler2_task,NULL);<br><br>&nbsp;&nbsp;&nbsp; // wait for signal=
 &amp; return of signal handler<br>&nbsp;&nbsp;&nbsp; pause();<br>&nbsp;&nb=
sp;&nbsp; fflush(NULL);<br>&nbsp;&nbsp;&nbsp; return 0;<br>}<br><br><br><br=
><br><b><i>Jan Kiszka &lt;jan.kiszka@domain.hid&gt;</i></b> wrote:<blockquo=
te class=3D"replbq" style=3D"border-left: 2px solid rgb(16, 16, 255); margi=
n-left: 5px; padding-left: 5px;"> mani bhatti wrote:<br>&gt; Thanks Jan for=
 your reply<br>&gt; Actually the semaphore and mutexes stuff you have refer=
red to i have<br>&gt; already grounds for them.The only problem i have is p=
lease some body<br>&gt; tell me that i dont want to make a thread periodic =
i,e i dont want to<br>&gt; call a thread after periodic time interval i wan=
ted it to  make
 it<br>&gt; aperiodic like threads in C++ are scheduled by scheduler byitse=
lf<br><br>This has nothing to do with C++, rather with the class library yo=
u are<br>used to.<br><br>&gt; and sleep on waiting condition with out any s=
pecific time interval<br>&gt; and wake  only when  signalled from  pariodic=
 thread. I hope you<br>&gt; understand my point.Thanks a lot .<br><br>Let's=
 try it differently:<br><br>thread_a()<br>{<br> rt_task_set_periodic(...);<=
br> while (1) {<br>  rt_task_wait_period(NULL);<br>  /* do some work */<br>=
  if (I_should_trigger_thread_b)<br>   rt_sem_v(&amp;sem);<br> }<br>}<br><b=
r>thread_b()<br>{<br> while (1) {<br>  rt_sem_p(&amp;sem, TM_INFINITE);<br>=
  /* so some other work */<br> }<br>}<br><br>Again, read up what the servic=
es are exactly doing or you will be lost<br>once you have to modify things =
only slightly.<br><br>Jan<br><br></blockquote><br><p>&#32;
		<hr size=3D1>How low will we go? Check out Yahoo! Messenger=92s low <a hr=
ef=3D"http://us.rd.yahoo.com/mail_us/taglines/postman8/*http://us.rd.yahoo.=
com/evt=3D39663/*http://voice.yahoo.com"> PC-to-Phone call rates.
--0-1512227822-1160056630=:35465--

