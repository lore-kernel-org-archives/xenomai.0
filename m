Message-ID: <7289437c0705140221tb124a04mcbf9910e47d3ac2e@domain.hid>
Date: Mon, 14 May 2007 11:21:40 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_89033_10762262.1179134500418"
Subject: [Xenomai-help] Problem with Message queue
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

------=_Part_89033_10762262.1179134500418
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I'm writing an application using Message queue and mq_send returns the errn=
o
value EBADF.
I don't understand what I'm doing wrong, I need some help.

Here's my code :


pthread_t task1, task2;

pthread_mutex_t mutex;



void routine1 (void * cookie);

void routine2 (void * cookie);



int tab[200];

int DESTRUCT=3D0;



mqd_t mq1, mq2;

#define MAX_MSGS        5

#define MSG_SIZE        50

char buf1[MSG_SIZE];

char buf2[MSG_SIZE];



void affich(int toto)

{

            static int cpt =3D 0;

            pthread_mutex_lock(&mutex);

            tab[cpt] =3D toto;

            cpt ++;

            if(cpt =3D=3D 150){

                        cpt =3D 0;

            }

            pthread_mutex_unlock(&mutex);

}



void routine1 (void * cookie){

            int ret;

            struct sched_param param =3D {.sched_priority =3D 10 };

            pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);



            for(;;){

                        affich(1);

                        ret =3D mq_receive(mq2, buf2,MSG_SIZE, NULL);

                        printf("receive mq2 returned %d, errno %d\n", ret,
errno);

                        ret =3D mq_send(mq1, buf1, MSG_SIZE, 0);

                        printf("send mq1 returned %d, errno %d\n", ret,
errno );

                        if(DESTRUCT=3D=3D1){

                                   pthread_exit(NULL);

                        };

            }

}



void routine2 (void * cookie){

            int ret;

            struct sched_param param =3D {.sched_priority =3D 10 };

            pthread_setschedparam(pthread_self(), SCHED_FIFO, &param);

            for(;;){

                        affich(2);

                        ret =3D mq_send(mq2, buf2, MSG_SIZE, 0);

                        printf("send mq2 returned %d, errno %s\n", ret,
errno );

                        ret =3D mq_receive(mq1, buf1, MSG_SIZE, NULL );

                        printf("receive mq1 returned %d, errno %s\n", ret,
errno);

                        if(DESTRUCT=3D=3D1){

                                    pthread_exit(NULL);

                        };

            }

}



void cleanup_upon_sig(int sig __attribute__((unused)))

{

            DESTRUCT=3D1;

}



int main(int argc, char **argv)

{

            int i =3D 0;

            int err;

            sigset_t mask, oldmask;

            pthread_attr_t attr1, attr2;

            struct sched_param param1 =3D {.sched_priority =3D 10 };

            struct sched_param param2 =3D {.sched_priority =3D 10 };

            struct mq_attr qattr1, qattr2;



            mlockall(MCL_CURRENT | MCL_FUTURE);



            /*cr=E9ation du mutex*/

            pthread_mutex_init(&mutex,NULL);



            /*cr=E9ation des Message_queue*/

            qattr1.mq_maxmsg =3D MAX_MSGS;

            qattr1.mq_msgsize =3D MSG_SIZE;

            qattr2.mq_maxmsg =3D MAX_MSGS;

            qattr2.mq_msgsize =3D MSG_SIZE;



            if (mq1=3Dmq_open("/mq1", O_CREAT|O_RDWR, 0, &qattr1) =3D=3D
(mqd_t)(-1)) {

                perror( "mq1_open failed" );

                exit(1);

        }

            if (mq2=3Dmq_open("/mq2", O_CREAT|O_RDWR, 0, &qattr2) =3D=3D
(mqd_t)(-1)) {

                perror( "mq2_open failed" );

                exit(1);

        }



            sigemptyset(&mask);

            sigaddset(&mask, SIGINT);

            signal(SIGINT, cleanup_upon_sig);

            sigaddset(&mask, SIGTERM);

            signal(SIGTERM, cleanup_upon_sig);

            sigaddset(&mask, SIGHUP);

            signal(SIGHUP, cleanup_upon_sig);



            pthread_sigmask(SIG_BLOCK, &mask, &oldmask);



            /*Initialisation des attributs des t=E2ches*/

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



            if (err =3D pthread_create (&task1,&attr1,(void *)routine1,NULL=
))

                        fprintf(stderr, "failed to create threads: %s\n",
strerror(err));



            if (err =3D pthread_create (&task2,&attr2,(void *)routine2,NULL=
))

                        fprintf(stderr, "failed to create threads: %s\n",
strerror(err));



            pthread_sigmask(SIG_UNBLOCK, &mask, &oldmask);



            pthread_join(task1, NULL);

            pthread_join(task2, NULL);



            /*destruction mutex*/

            if (err =3D pthread_mutex_destroy(&mutex))

                        fprintf(stderr, "failed to cancel mutex");



            /*destruction message_queue*/

            if( mq_close(mq1) =3D=3D -1 ) {

                perror( "mq1_close failed" );

                exit(1);

        }

            if( mq_close(mq2) =3D=3D -1 ) {

                perror( "mq2_close failed" );

                exit(1);

        }



            for(i =3D 0; i < 20 ; i++)

                        {

                                   printf("Task %d\n",tab[i]);

                        }

return 0;

}



Thanks

------=_Part_89033_10762262.1179134500418
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello, </div>
<div>&nbsp;</div>
<div>I&#39;m writing an application using Message queue and mq_send returns=
 the errno value EBADF.</div>
<div>I don&#39;t understand what I&#39;m doing wrong, I need some help.</di=
v>
<div>&nbsp;</div>
<div>Here&#39;s my code : </div>
<div>&nbsp;</div>
<div>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">pthread_t task1, task2;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">pthread_mutex_t mutex;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void routine1 (void * cookie);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void routine2 (void * cookie);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">int tab[200];</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">int DESTRUCT=3D0;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">mqd_t mq1, mq2;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">#define MAX_MSGS<span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; </span>5 </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">#define MSG_SIZE<span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; </span>50 </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">char buf1[MSG_SIZE];</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">char buf2[MSG_SIZE];</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void affich(int toto)</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">{</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>static int cpt =3D 0;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_lock(&amp;mutex);</f=
ont></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>tab[cpt] =3D toto;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cpt ++;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if(cpt =3D=3D 150){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>cpt =3D 0;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_unlock(&amp;mutex);<=
/font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void routine1 (void * cookie){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int ret; </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct sched_param param =3D {.sch=
ed_priority =3D 10 };</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_setschedparam(pthread_self=
(), SCHED_FIFO, &amp;param);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-tab=
-count: 1"><font face=3D"Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(;;){<span style=3D"mso-tab-cou=
nt: 1"> </span></font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>affich(1);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>ret =3D mq_receive(mq2, buf2,MSG_SIZE=
, NULL);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;receive mq2 returned %d,=
 errno %d\n&quot;, ret, errno); </font></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>ret =3D mq_send(mq1, buf1, MSG_SIZE, =
0);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;send mq1 returned %d, er=
rno %d\n&quot;, ret, errno ); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if(DESTRUCT=3D=3D1){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span>pthread_exit(NULL);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>};</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void routine2 (void * cookie){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int ret; </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct sched_param param =3D {.sch=
ed_priority =3D 10 };</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_setschedparam(pthread_self=
(), SCHED_FIFO, &amp;param);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(;;){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>affich(2);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>ret =3D mq_send(mq2, buf2, MSG_SIZE, =
0);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;send mq2 returned %d, er=
rno %s\n&quot;, ret, errno );</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>ret =3D mq_receive(mq1, buf1, MSG_SIZ=
E, NULL );</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;receive mq1 returned %d,=
 errno %s\n&quot;, ret, errno); </font></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if(DESTRUCT=3D=3D1){</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span><span style=3D"mso-tab-count: 2">&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthre=
ad_exit(NULL);</font></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>};</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">void cleanup_upon_sig(int sig __attribute__((unused)))</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">{<span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; </span></font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>DESTRUCT=3D1;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">int main(int argc, char **argv)</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">{</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int i =3D 0; </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>int err;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigset_t mask, oldmask;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_t attr1, attr2;<span =
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </spa=
n></font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct sched_param param1 =3D {.sc=
hed_priority =3D 10 };</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct sched_param param2 =3D {.sc=
hed_priority =3D 10 };</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>struct mq_attr qattr1, qattr2;</fo=
nt></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>mlockall(MCL_CURRENT | MCL_FUTURE)=
;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/*cr=E9ation du mutex*/</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_mutex_init(&amp;mutex,NULL=
);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/*cr=E9ation des Message_queue*/</=
font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>qattr1.mq_maxmsg =3D MAX_MSGS; </f=
ont></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span><span =
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </spa=
n>qattr1.mq_msgsize =3D MSG_SIZE;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>qattr2.mq_maxmsg =3D MAX_MSGS; </f=
ont></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp; </span><span =
style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </spa=
n>qattr2.mq_msgsize =3D MSG_SIZE;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (mq1=3Dmq_open(&quot;/mq1&quot;=
, O_CREAT|O_RDWR, 0, &amp;qattr1) =3D=3D (mqd_t)(-1)) { </font></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror( &=
quot;mq1_open failed&quot; ); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1); =
</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp; </span><span style=3D"mso=
-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>} </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (mq2=3Dmq_open(&quot;/mq2&quot;=
, O_CREAT|O_RDWR, 0, &amp;qattr2) =3D=3D (mqd_t)(-1)) { </font></p>

<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror( &=
quot;mq2_open failed&quot; ); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1); =
</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; </span>} </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigemptyset(&amp;mask);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGINT);</fon=
t></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGINT, cleanup_upon_sig);<=
/font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGTERM);</fo=
nt></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGTERM, cleanup_upon_sig);=
</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>sigaddset(&amp;mask, SIGHUP);</fon=
t></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>signal(SIGHUP, cleanup_upon_sig);<=
/font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_sigmask(SIG_BLOCK, &amp;ma=
sk, &amp;oldmask);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-tab=
-count: 1"><font face=3D"Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/*Initialisation des attributs des=
 t=E2ches*/</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_init(&amp;attr1);</fo=
nt></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setdetachstate(&amp;a=
ttr1, PTHREAD_CREATE_JOINABLE);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setinheritsched(&amp;=
attr1, PTHREAD_EXPLICIT_SCHED);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedpolicy(&amp;a=
ttr1, SCHED_FIFO);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedparam(&amp;at=
tr1, &amp;param1);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setstacksize(&amp;att=
r1, PTHREAD_STACK_MIN);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-tab=
-count: 1"><font face=3D"Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_init(&amp;attr2);</fo=
nt></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setdetachstate(&amp;a=
ttr2, PTHREAD_CREATE_JOINABLE);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setinheritsched(&amp;=
attr2, PTHREAD_EXPLICIT_SCHED);<span style=3D"mso-spacerun: yes">
&nbsp; </span></font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedpolicy(&amp;a=
ttr2, SCHED_FIFO);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setschedparam(&amp;at=
tr2, &amp;param2);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_attr_setstacksize(&amp;att=
r2, PTHREAD_STACK_MIN);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (err =3D pthread_create (&amp;t=
ask1,&amp;attr1,(void *)routine1,NULL))</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>fprintf(stderr, &quot;failed to creat=
e threads: %s\n&quot;, strerror(err));</font>
</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (err =3D pthread_create (&amp;t=
ask2,&amp;attr2,(void *)routine2,NULL))</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>fprintf(stderr, &quot;failed to creat=
e threads: %s\n&quot;, strerror(err));</font>
</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_sigmask(SIG_UNBLOCK, &amp;=
mask, &amp;oldmask);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_join(task1, NULL);</font><=
/p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>pthread_join(task2, NULL);</font><=
/p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/*destruction mutex*/</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if (err =3D pthread_mutex_destroy(=
&amp;mutex))</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>fprintf(stderr, &quot;failed to cance=
l mutex&quot;);</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><span style=3D"mso-tab=
-count: 1"><font face=3D"Times New Roman">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </font></span></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>/*destruction message_queue*/</fon=
t></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if( mq_close(mq1) =3D=3D -1 ) { </=
font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror( &=
quot;mq1_close failed&quot; ); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1); =
</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; </span>} </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>if( mq_close(mq2) =3D=3D -1 ) { </=
font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>perror( &=
quot;mq2_close failed&quot; ); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;</span><span style=3D"mso-=
spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; </span>exit(1); </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-spacerun: yes">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; </span>} </font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">&nbsp;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>for(i =3D 0; i &lt; 20 ; i++)</fon=
t></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>{</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; </span>printf(&quot;Task %d\n&quot;,tab[i]);</font></=
p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"><span style=3D"mso-tab-count: 2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">return 0;</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">}</font></p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman"></font>&nbsp;</p>
<p class=3D"MsoNormal" style=3D"MARGIN: 0cm 0cm 0pt"><font face=3D"Times Ne=
w Roman">Thanks</font></p></div>

------=_Part_89033_10762262.1179134500418--

