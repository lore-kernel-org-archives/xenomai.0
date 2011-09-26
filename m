MIME-Version: 1.0
In-Reply-To: <1317034005.2174.6.camel@domain.hid>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<1316782850.2050.8.camel@domain.hid>
	<CAMJ=MEfe-EKe9V7N3c=udfq=YGz23HhFec9UqvfZ6LtT2R3bjw@domain.hid>
	<1316809390.2050.11.camel@domain.hid> <1317034005.2174.6.camel@domain.hid>
Date: Mon, 26 Sep 2011 22:01:04 +0200
Message-ID: <CAMJ=MEf+bdds8Cv7vENTJLeVpYpR+ZGq1yP6TEFnFvTLy6iB3Q@mail.gmail.com>
From: Ronny Meeus <ronny.meeus@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai-help] Xenomai-forge: SEGFAULT is pSOS skin
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, Sep 26, 2011 at 12:46 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> On Fri, 2011-09-23 at 22:23 +0200, Philippe Gerum wrote:
>> On Fri, 2011-09-23 at 22:21 +0200, Ronny Meeus wrote:
>> > On Fri, Sep 23, 2011 at 3:00 PM, Philippe Gerum <rpm@xenomai.org> wrot=
e:
>> > > On Thu, 2011-09-22 at 22:15 +0200, Ronny Meeus wrote:
>> > >> Hello
>> > >>
>> > >> I have created some time ago a test application for the PSOS interf=
ace
>> > >> of Xenomai.
>> > >> This is a extensive test that stresses most of the PSOS services we
>> > >> use in our application. You can find it as an attachment.
>> > >> It is running fine on Xenomai 2-5-6.
>> > >> Note that in the test application there is also a benchmarking part=
.
>> > >> This is currently disabled, I will fix that later.
>> > >>
>> > >> Now I'm investigating a switch to xenomai-forge so I tried to run t=
he
>> > >> same test on this platform.
>> > >
>> > > This is a double cleanup call, due to the incorrect propagation of a=
n
>> > > internal error detected in the task trampoline within the psos emula=
tor.
>> > > In fact, this reveals a more general shortcoming with handling this
>> > > situation for tasks, and this may also reveal an issue with t_delete=
()
>> > > over the Mercury core.
>> > >
>> > > I can't reproduce the issue here with your test program, but I'm sur=
e
>> > > something is wrong in the emulator anyway, I'm just lucky with the
>> > > timings. Since you are running over the vanilla kernel and maybe x86=
,
>> > > you could run valgrind to check whether some memory corruption is
>> > > detected.
>> > >
>> > > I'm working on this bug which will bite any emulator based on the
>> > > copperplate interface the same way. I don't see any show stopper to =
fix
>> > > it, but this needs some thoughts to do this properly.
>> > >
>> > > Btw,
>> > >
>> > > - what is your architecture?
>> > > - what is your glibc version?
>> >
>> > Running on a PC (virtual BOX).
>> >
>> > This is the information about the lib I use:
>> > meeusr@domain.hid$ ./libc.so.6
>> > GNU C Library (Ubuntu EGLIBC 2.11.1-0ubuntu7.6) stable release version
>> > 2.11.1, by Roland McGrath et al.
>> > Copyright (C) 2009 Free Software Foundation, Inc.
>> > This is free software; see the source for copying conditions.
>> > There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
>> > PARTICULAR PURPOSE.
>> > Compiled by GNU CC version 4.4.3.
>> > Compiled on a Linux >>2.6.24-27-server<< system on 2010-11-17.
>> > Available extensions:
>> > =A0 =A0 crypt add-on version 2.1 by Michael Glad and others
>> > =A0 =A0 GNU Libidn by Simon Josefsson
>> > =A0 =A0 Native POSIX Threads Library by Ulrich Drepper et al
>> > =A0 =A0 BIND-8.2.3-T5B
>> > For bug reporting instructions, please see:
>> > <http://www.debian.org/Bugs/>.
>> >
>> >
>> > The valgrind stuff I will do later.
>>
>> I can reproduce now. This is highly timing dependent.
>>
>
> git://git.xenomai.org/xenomai-forge.git has a general fix for this
> issue. Your test code will need the following patch to work. The basic
> fix is that you can't create multiple objects with the same name with
> Xenomai, because we need unique names for the registry to be meaningful.

Thanks for looking into this issue.
The problem that we have is that we have a huge application and we
cannot guarantee that all tasknames are unique.
That is why I have implemented a mechanism to make a taskname unique
(I already had this in the Xenomai-2.5.6). In the force version this
could be something like:

        if (name =3D=3D NULL || *name =3D=3D '\0')
                sprintf(task->name, "t%lu", ++anon_tids);
        else {
                struct clusterobj *cobj =3D
cluster_findobj(&psos_task_table, name);
                if (cobj !=3D NULL) {
                        snprintf(task->name,sizeof(task->name),
"%s@domain.hid", name, ++anon_tids);
                }
                else
                        strncpy(task->name, name, sizeof(task->name));
                task->name[sizeof(task->name) - 1] =3D '\0';
        }

This is an example for tasks. The same could be done for
regions,semaphores and message queues. I tried it on my repo and the
task application (rtprint) runs unmodified.
The only issue I see with this approach is that when 2 tasks with an
identical name, for example TEST, are created, the second one will be
mapped to TEST@1. If a t_ident call is executed, the TID of the first
instance will be returned, which is fine. If now the first task is
deleted, the t_ident call will fail.


Next to this I also adapted the task priority automatically using
following algorithm:
static int check_task_priority(u_long *psos_prio)
{
        if (*psos_prio < 1 || *psos_prio > 255) /* In theory. */
                return ERR_PRIOR;
        /* Do not change priorities <=3D10 and >=3D 240.
         * Priorities in between are divided by 4 */
        if (*psos_prio > 240)
                *psos_prio =3D 70 + *psos_prio - 240;
        else if (*psos_prio > 10)
                *psos_prio =3D 11 + ((*psos_prio-10)/4);

        if ((int)(*psos_prio) >=3D threadobj_max_prio - 1) /* In practice. =
*/
                panic("current implementation restricts pSOS "
                      "priority levels to range [1..%d]",
                      threadobj_max_prio - 2);

        return SUCCESS;
}

It also works well for our application.
Please share your thoughts.

>
> I reduced the number of test loops as well, since 100 or 1000 loops do
> not make any difference. Actually, two consecutive iterations of
> t_create/t_delete were enough to trigger the issue.
>
> --- rtprint.c.orig =A0 =A0 =A02011-09-26 12:38:47.711339003 +0200
> +++ rtprint.c =A0 2011-09-26 12:37:49.871339005 +0200
> @@ -115,7 +115,7 @@
>
> =A0 =A0 =A0 =A0my_printf("%s\n",__FUNCTION__);
>
> - =A0 =A0 =A0 check("t_create",t_create("TEST",250,16000,16000,0,&tid),0)=
;
> + =A0 =A0 =A0 check("t_create",t_create(NULL,96,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0check("t_setreg",t_setreg(tid,0UL,100UL),0);
> =A0 =A0 =A0 =A0check("t_getreg",t_getreg(tid,0UL,&reg_value),0);
> =A0 =A0 =A0 =A0check("reg_value",reg_value,100);
> @@ -150,7 +150,7 @@
>
> =A0 =A0 =A0 =A0suspendmyself =3D 0;
>
> - =A0 =A0 =A0 check("t_create",t_create("TEST",250,16000,16000,0,&tid),0)=
;
> + =A0 =A0 =A0 check("t_create",t_create(NULL,96,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0check("t_start",t_start(tid,0,test_tasksuspend_body,args),=
0);
>
> =A0 =A0 =A0 =A0counter =3D 0;
> @@ -201,7 +201,7 @@
> =A0static void create_and_start_task(unsigned long *tid)
> =A0{
> =A0 =A0 =A0 =A0unsigned long local_args[4] =3D {0,200,300,400};
> - =A0 =A0 =A0 check("t_create low prio",t_create ("TEST",2,4000,0,T_LOCAL=
,tid),0);
> + =A0 =A0 =A0 check("t_create low prio",t_create (NULL,2,4000,0,T_LOCAL,t=
id),0);
> =A0 =A0 =A0 =A0check("t_start low prio",t_start(*tid,T_PREEMPT|T_TSLICE,t=
est_taskcreation_body,local_args),0);
> =A0}
>
> @@ -219,7 +219,7 @@
>
> =A0 =A0 =A0 =A0for (i=3D1;i<2;i++)
> =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("t_create",t_create("TEST",(unsigned =
long)i,16000,16000,0,&tid),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("t_create",t_create(NULL,(unsigned lo=
ng)i,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check("t_start",t_start(tid,T_PREEMPT| T_T=
SLICE | T_NOASR,test_taskcreation_body2,args),0);
> =A0 =A0 =A0 =A0}
>
> @@ -260,7 +260,7 @@
> =A0 =A0 =A0 =A0args[0] =3D 0;
> =A0 =A0 =A0 =A0for (i=3D0;i<500;i++)
> =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("t_create loop3",t_create ("TEST",(i%=
250)+1,100000,0,0,&tid),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("t_create loop3",t_create ("TEST",(i%=
96)+1,100000,0,0,&tid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check("t_start loop3",t_start(tid,T_PREEMP=
T,test_taskcreation_body,args),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check("t_delete loop3",t_delete(tid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0my_printf("t_create + t_start + t_delete %=
d\r",i);
> @@ -334,7 +334,7 @@
> =A0 =A0 =A0 =A0test_basicevents();
>
> =A0 =A0 =A0 =A0t_ident(0,0,&args[0]);
> - =A0 =A0 =A0 check("t_create",t_create("TEST",2,16000,16000,0,&tid),0);
> + =A0 =A0 =A0 check("t_create",t_create(NULL,2,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0check("t_start",t_start(tid,0,test_events_body,args),0);
>
> =A0 =A0 =A0 =A0ev_receive(1,EV_ALL|EV_WAIT,0,&ev_rcvd);
> @@ -361,7 +361,7 @@
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i=3D0;i<50;i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("q_create",q_create("TTTU",0,Q_NOLIMI=
T|Q_PRIOR,&qids[i]),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("q_create",q_create(NULL,0,Q_NOLIMIT|=
Q_PRIOR,&qids[i]),0);
> =A0 =A0 =A0 =A0for (i=3D0;i<50;i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check("q_delete",q_delete(qids[i]),0);
> =A0}
> @@ -439,20 +439,20 @@
>
> =A0 =A0 =A0 =A0my_printf("%s\n",__FUNCTION__);
>
> - =A0 =A0 =A0 check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid1)=
,0);
> - =A0 =A0 =A0 check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid2)=
,0);
> + =A0 =A0 =A0 check("q_create",q_create(NULL,0,Q_NOLIMIT|Q_PRIOR,&qid1),0=
);
> + =A0 =A0 =A0 check("q_create",q_create(NULL,0,Q_NOLIMIT|Q_PRIOR,&qid2),0=
);
>
> =A0 =A0 =A0 =A0args[0] =3D qid1;
> =A0 =A0 =A0 =A0args[1] =3D qid2;
> =A0 =A0 =A0 =A0args[2] =3D 1000;
> =A0 =A0 =A0 =A0t_ident(0,0,&args[3]);
> - =A0 =A0 =A0 check("t_create",t_create("TEST",50,16000,16000,0,&tid),0);
> + =A0 =A0 =A0 check("t_create",t_create(NULL,50,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0check("t_start",t_start(tid,0,test_msgqueue_ctxtswitch_bod=
y,args),0);
>
> =A0 =A0 =A0 =A0args[0] =3D qid2;
> =A0 =A0 =A0 =A0args[1] =3D qid1;
> =A0 =A0 =A0 =A0args[3] =3D 0; =A0 =A0/* Make sure only 1 sends the event.=
 */
> - =A0 =A0 =A0 check("t_create",t_create("TEST",50,16000,16000,0,&tid),0);
> + =A0 =A0 =A0 check("t_create",t_create(NULL,50,16000,16000,0,&tid),0);
> =A0 =A0 =A0 =A0check("t_start",t_start(tid,0,test_msgqueue_ctxtswitch_bod=
y,args),0);
>
> =A0 =A0 =A0 =A0/*send initial message */
> @@ -490,8 +490,8 @@
>
> =A0 =A0 =A0 =A0my_printf("%s\n",__FUNCTION__);
>
> - =A0 =A0 =A0 check("t_create",t_create("TEST",50,16000,16000,0,&tid1),0)=
;
> - =A0 =A0 =A0 check("t_create",t_create("TEST",50,16000,16000,0,&tid2),0)=
;
> + =A0 =A0 =A0 check("t_create",t_create(NULL,50,16000,16000,0,&tid1),0);
> + =A0 =A0 =A0 check("t_create",t_create(NULL,50,16000,16000,0,&tid2),0);
>
> =A0 =A0 =A0 =A0args[0] =3D tid2;
> =A0 =A0 =A0 =A0args[1] =3D 1000;
> @@ -533,7 +533,7 @@
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i=3D0;i<50;i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("sm_create",sm_create("TTTT",0,SM_PRI=
OR,&smids[i]),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check("sm_create",sm_create(NULL,0,SM_PRIOR=
,&smids[i]),0);
> =A0 =A0 =A0 =A0for (i=3D0;i<50;i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check("sm_delete",sm_delete(smids[i]),0);
>
> @@ -690,7 +690,7 @@
>
> =A0 =A0 =A0 =A0 copperplate_init(argc, argv);
>
> - =A0 =A0 =A0 =A0check("t_create",t_create("TEST",50,16000,16000,0,&tid),=
0);
> + =A0 =A0 =A0 =A0check("t_create",t_create("ROOT",50,16000,16000,0,&tid),=
0);
> =A0 =A0 =A0 =A0 check("t_start",t_start(tid,0,test_main_body,args),0);
>
> =A0 =A0 =A0 =A0while (1) tm_wkafter(1000);
> @@ -703,7 +703,7 @@
> =A0{
> =A0 =A0 =A0 =A0int i =3D 0;
> =A0 =A0 =A0 =A0char testCaseName[32];
> - =A0 =A0 =A0 int count =3D 1000;
> + =A0 =A0 =A0 int count =3D 100;
>
> =A0 =A0 =A0 =A0for (i=3D0;i<count;i++)
> =A0 =A0 =A0 =A0{
> @@ -711,12 +711,12 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long args[4] =3D {0,200,300,400};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"t_create %d",i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check(testCaseName,t_create ("TEST",(i%250)=
+1,100000,0,0,&tid),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check(testCaseName,t_create ("TEST",(i%96)+=
1,100000,0,0,&tid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"t_start %d",i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,t_start(tid,T_PREEMPT,t=
est_taskcreation_body,args),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"t_delete %d",i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,t_delete(tid),0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%1000) =3D=3D 0) my_printf("create + =
start + delete %d\n",i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%100) =3D=3D 0) my_printf("create + s=
tart + delete %d\n",i);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i=3D0;i<count;i++)
> @@ -725,10 +725,10 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned long args[4] =3D {100,200,300,400=
};
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"t_create %d",i);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 check(testCaseName,t_create ("TEST",(i%250)=
+1,100000,0,0,&tid),0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 check(testCaseName,t_create (NULL,(i%96)+1,=
100000,0,0,&tid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"t_start %d",i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,t_start(tid,T_PREEMPT,t=
est_taskcreation_body2,args),0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%1000) =3D=3D 0) my_printf("create + =
start + self delete %d\n",i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%100) =3D=3D 0) my_printf("create + s=
tart + self delete %d\n",i);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i=3D0;i<count;i++)
> @@ -739,7 +739,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,sm_create("TTTT",0,SM_P=
RIOR,&smid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"sm_delete %d",i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,sm_delete(smid),0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%1000) =3D=3D 0) my_printf("sm_create=
 + sm_delete %d\n",i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%100) =3D=3D 0) my_printf("sm_create =
+ sm_delete %d\n",i);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i=3D0;i<count;i++)
> @@ -750,7 +750,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,q_create("TTTT",0,Q_NOL=
IMIT|Q_PRIOR,&qid),0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sprintf(testCaseName,"q_delete %d",i);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check(testCaseName,q_delete(qid),0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%1000) =3D=3D 0) my_printf("q_create =
+ q_delete %d\n",i);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((i%100) =3D=3D 0) my_printf("q_create +=
 q_delete %d\n",i);
> =A0 =A0 =A0 =A0}
>
> --
> Philippe.
>
>
>

