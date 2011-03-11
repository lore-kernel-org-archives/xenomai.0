Message-ID: <4D79DD32.4050307@domain.hid>
Date: Fri, 11 Mar 2011 09:28:34 +0100
From: Johann Obermayr <johann.obermayr@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="------------090306070204090704010909"
Subject: [Xenomai-help] rt_task_delete trouble
Reply-To: johann.obermayr@domain.hid
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

This is a multi-part message in MIME format.
--------------090306070204090704010909
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hello,

i'm a newbie with xenomai.
My problem is, if a rt task will delete with rt_task_delete, than
the progam hangs.

here is my sample
----------------------------------
#include <stdio.h>
#include <signal.h>
#include <unistd.h>
#include <sys/mman.h>

#include <native/mutex.h>
#include <native/task.h>
#include <native/types.h>

#include <rtdk.h>

RT_TASK task_waiter, task_worker;

volatile int task_waiter_flag =3D 0;

#define DELAYS(x)        (x * 1000 * 1000 * 1000)
#define DELAYMS(x)        (x * 1000 * 1000)

void delaysec(unsigned int sec)
{
     RTIME delay =3D DELAYS(sec);
     rt_task_sleep( delay );
}

void task_waiter_do(void *data)
{
     rt_printf("task_waiter_do started\n");
     while(task_waiter_flag =3D=3D 0)
         ; // rt_task_sleep( DELAYMS(1) );
     rt_printf("task_waiter_do finished\n");
}

void task_worker_do(void *data)
{
     int rval;
     rt_printf("task_worker_do started\n");
     delaysec(1);
     rt_printf("task_worker_do suspend waiter\n");
     rval =3D rt_task_suspend(&task_waiter);
     rt_printf("task_worker_do suspend:%d\n", rval);
     delaysec(1);
     rt_printf("task_worker_do delete waiter\n");
     rval =3D rt_task_delete(&task_waiter);
     rt_printf("task_worker_do delete:%d\n", rval);
     delaysec(1);
     while(task_waiter_flag =3D=3D 0)
         rt_task_sleep( DELAYMS(10) );
     rt_printf("task_worker_do finished\n");
}

int main(int argc, char **argv)
{
     int rval;

     mlockall(MCL_CURRENT|MCL_FUTURE);

     printf("Starting\n");
     rt_print_auto_init(1);

     rval =3D rt_task_create(&task_worker, "worker", 0, 80, 0);
     if (rval =3D=3D 0) {
         rval =3D rt_task_create(&task_waiter, "waiter", 0, 30, 0);

         rval =3D rt_task_start(&task_worker, &task_worker_do, NULL);
         if (rval =3D=3D 0) {
             rval =3D rt_task_start(&task_waiter, &task_waiter_do, NULL);
             if (rval =3D=3D 0) {

                 printf("Working\n");
             }
             else
                 rt_printf("rt_task_suspend failed(%d)", rval);
         }
         else
             rt_printf("rt_task_start failed(%d)", rval);
     }
     else
         rt_printf("rt_task_create failed(%d)", rval);


     printf("Finsihed <press any key>\n");
     getchar();
     task_waiter_flag =3D 1;
     usleep(100000);
     return 0;
}
----------------------------------
the task task_worker_do will hang after rt_task_delete. Why ?
if i add a sleep into task_waiter_do, the sample work correct.
What can i do, to solve this.

   Thanks
     greetings
       Johann

--=20
Mit freundlichen Gr=FC=DFen, best regards
     Johann Obermayr

Software Entwicklung
________________________________________________
SIGMATEK GmbH&  Co KG
Sigmatekstra=DFe 1
5112 Lamprechtshausen
=D6sterreich / Austria

Tel.  :  +43 / 6274/ 43 21-0   (Durchwahl leider nicht m=F6glich)
Fax   :  +43 / 6274/ 43 21-18  (bzw 300 im Werk 2 )
E-Mail:johann.obermayr@domain.hid
http://www.sigmatek-automation.com
****************************Please note:********************************
  This email and all attachments are confidential and intended solely for
  the person or entity to whom it is addressed. If you are not the named
  addressee you must not make this email and all attachments accessible
  to any other person. If you have received this email in error please
  delete it together with all attachments.
************************************************************************


--------------090306070204090704010909
Content-Type: text/html; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv=3D"content-type" content=3D"text/html;
      charset=3DISO-8859-15">
  </head>
  <body bgcolor=3D"#ffffff" text=3D"#000000">
    <div class=3D"moz-text-flowed" style=3D"font-family: -moz-fixed;
      font-size: 13px;" lang=3D"x-western">Hello, <br>
      <br>
      i'm a newbie with xenomai. <br>
      My problem is, if a rt task will delete with rt_task_delete, than
      <br>
      the progam hangs. <br>
      <br>
      here is my sample <br>
      ---------------------------------- <br>
      #include &lt;stdio.h&gt; <br>
      #include &lt;signal.h&gt; <br>
      #include &lt;unistd.h&gt; <br>
      #include &lt;sys/mman.h&gt; <br>
      <br>
      #include &lt;native/mutex.h&gt; <br>
      #include &lt;native/task.h&gt; <br>
      #include &lt;native/types.h&gt; <br>
      <br>
      #include &lt;rtdk.h&gt; <br>
      <br>
      RT_TASK task_waiter, task_worker; <br>
      <br>
      volatile int task_waiter_flag =3D 0; <br>
      <br>
      #define DELAYS(x)=A0=A0=A0=A0=A0=A0=A0 (x * 1000 * 1000 * 1000) <br>
      #define DELAYMS(x)=A0=A0=A0=A0=A0=A0=A0 (x * 1000 * 1000) <br>
      <br>
      void delaysec(unsigned int sec) <br>
      { <br>
      =A0=A0=A0 RTIME delay =3D DELAYS(sec); <br>
      =A0=A0=A0 rt_task_sleep( delay ); <br>
      } <br>
      <br>
      void task_waiter_do(void *data) <br>
      { <br>
      =A0=A0=A0 rt_printf("task_waiter_do started\n"); <br>
      =A0=A0=A0 while(task_waiter_flag =3D=3D 0) <br>
      =A0=A0=A0=A0=A0=A0=A0 ; // rt_task_sleep( DELAYMS(1) ); <br>
      =A0=A0=A0 rt_printf("task_waiter_do finished\n"); <br>
      } <br>
      <br>
      void task_worker_do(void *data) <br>
      { <br>
      =A0=A0=A0 int rval; <br>
      =A0=A0=A0 rt_printf("task_worker_do started\n"); <br>
      =A0=A0=A0 delaysec(1); <br>
      =A0=A0=A0 rt_printf("task_worker_do suspend waiter\n"); <br>
      =A0=A0=A0 rval =3D rt_task_suspend(&amp;task_waiter); <br>
      =A0=A0=A0 rt_printf("task_worker_do suspend:%d\n", rval); <br>
      =A0=A0=A0 delaysec(1); <br>
      =A0=A0=A0 rt_printf("task_worker_do delete waiter\n"); <br>
      =A0=A0=A0 rval =3D rt_task_delete(&amp;task_waiter); <br>
      =A0=A0=A0 rt_printf("task_worker_do delete:%d\n", rval); <br>
      =A0=A0=A0 delaysec(1); <br>
      =A0=A0=A0 while(task_waiter_flag =3D=3D 0) <br>
      =A0=A0=A0=A0=A0=A0=A0 rt_task_sleep( DELAYMS(10) ); <br>
      =A0=A0=A0 rt_printf("task_worker_do finished\n"); <br>
      } <br>
      <br>
      int main(int argc, char **argv) <br>
      { <br>
      =A0=A0=A0 int rval; <br>
      <br>
      =A0=A0=A0 mlockall(MCL_CURRENT|MCL_FUTURE); <br>
      <br>
      =A0=A0=A0 printf("Starting\n"); <br>
      =A0=A0=A0 rt_print_auto_init(1); <br>
      <br>
      =A0=A0=A0 rval =3D rt_task_create(&amp;task_worker, "worker", 0, 80, =
0); <br>
      =A0=A0=A0 if (rval =3D=3D 0) { <br>
      =A0=A0=A0=A0=A0=A0=A0 rval =3D rt_task_create(&amp;task_waiter, "wait=
er", 0, 30,
      0); <br>
      <br>
      =A0=A0=A0=A0=A0=A0=A0 rval =3D rt_task_start(&amp;task_worker,
      &amp;task_worker_do, NULL); <br>
      =A0=A0=A0=A0=A0=A0=A0 if (rval =3D=3D 0) { <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rval =3D rt_task_start(&amp;task_wa=
iter,
      &amp;task_waiter_do, NULL); <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rval =3D=3D 0) { <br>
      <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printf("Working\n"); <b=
r>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 } <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rt_printf("rt_task_susp=
end failed(%d)", rval); <br>
      =A0=A0=A0=A0=A0=A0=A0 } <br>
      =A0=A0=A0=A0=A0=A0=A0 else <br>
      =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rt_printf("rt_task_start failed(%d)=
", rval); <br>
      =A0=A0=A0 } <br>
      =A0=A0=A0 else <br>
      =A0=A0=A0=A0=A0=A0=A0 rt_printf("rt_task_create failed(%d)", rval); <=
br>
      <br>
      <br>
      =A0=A0=A0 printf("Finsihed &lt;press any key&gt;\n"); <br>
      =A0=A0=A0 getchar(); <br>
      =A0=A0=A0 task_waiter_flag =3D 1; <br>
      =A0=A0=A0 usleep(100000); <br>
      =A0=A0=A0 return 0; <br>
      } <br>
      ---------------------------------- <br>
      the task task_worker_do will hang after rt_task_delete. Why ? <br>
      if i add a sleep into task_waiter_do, the sample work correct. <br>
      What can i do, to solve this. <br>
      <br>
      =A0 Thanks <br>
      =A0=A0=A0 greetings <br>
      =A0=A0=A0=A0=A0 Johann <br>
      <br>
    </div>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Mit freundlichen Gr=FC=DFen, best regards
    Johann Obermayr

Software Entwicklung
________________________________________________
SIGMATEK GmbH &amp; Co KG
Sigmatekstra=DFe 1
5112 Lamprechtshausen
=D6sterreich / Austria

Tel.  :  +43 / 6274/ 43 21-0   (Durchwahl leider nicht m=F6glich)
Fax   :  +43 / 6274/ 43 21-18  (bzw 300 im Werk 2 )
E-Mail: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:johann.obermay=
r@domain.hid">johann.obermayr@domain.hid</a>
<a class=3D"moz-txt-link-freetext" href=3D"http://www.sigmatek-automation.c=
om">http://www.sigmatek-automation.com</a>
****************************Please note:********************************
 This email and all attachments are confidential and intended solely for
 the person or entity to whom it is addressed. If you are not the named
 addressee you must not make this email and all attachments accessible
 to any other person. If you have received this email in error please
 delete it together with all attachments.
************************************************************************
</pre>
  </body>
</html>

--------------090306070204090704010909--

