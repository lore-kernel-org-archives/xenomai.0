From: Philippe Gerum <rpm@xenomai.org>
In-Reply-To: <1316809390.2050.11.camel@domain.hid>
References: <CAMJ=MEeOYUsNXMOUwLyxTo5kDcTTER90bXUpPiwao0YGZMpTeQ@mail.gmail.com>
	<1316782850.2050.8.camel@domain.hid>
	<CAMJ=MEfe-EKe9V7N3c=udfq=YGz23HhFec9UqvfZ6LtT2R3bjw@domain.hid>
	<1316809390.2050.11.camel@domain.hid>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Sep 2011 12:46:45 +0200
Message-ID: <1317034005.2174.6.camel@domain.hid>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Ronny Meeus <ronny.meeus@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Fri, 2011-09-23 at 22:23 +0200, Philippe Gerum wrote:
> On Fri, 2011-09-23 at 22:21 +0200, Ronny Meeus wrote:
> > On Fri, Sep 23, 2011 at 3:00 PM, Philippe Gerum <rpm@xenomai.org> wrote:
> > > On Thu, 2011-09-22 at 22:15 +0200, Ronny Meeus wrote:
> > >> Hello
> > >>
> > >> I have created some time ago a test application for the PSOS interface
> > >> of Xenomai.
> > >> This is a extensive test that stresses most of the PSOS services we
> > >> use in our application. You can find it as an attachment.
> > >> It is running fine on Xenomai 2-5-6.
> > >> Note that in the test application there is also a benchmarking part.
> > >> This is currently disabled, I will fix that later.
> > >>
> > >> Now I'm investigating a switch to xenomai-forge so I tried to run the
> > >> same test on this platform.
> > >
> > > This is a double cleanup call, due to the incorrect propagation of an
> > > internal error detected in the task trampoline within the psos emulator.
> > > In fact, this reveals a more general shortcoming with handling this
> > > situation for tasks, and this may also reveal an issue with t_delete()
> > > over the Mercury core.
> > >
> > > I can't reproduce the issue here with your test program, but I'm sure
> > > something is wrong in the emulator anyway, I'm just lucky with the
> > > timings. Since you are running over the vanilla kernel and maybe x86,
> > > you could run valgrind to check whether some memory corruption is
> > > detected.
> > >
> > > I'm working on this bug which will bite any emulator based on the
> > > copperplate interface the same way. I don't see any show stopper to fix
> > > it, but this needs some thoughts to do this properly.
> > >
> > > Btw,
> > >
> > > - what is your architecture?
> > > - what is your glibc version?
> > 
> > Running on a PC (virtual BOX).
> > 
> > This is the information about the lib I use:
> > meeusr@domain.hid$ ./libc.so.6
> > GNU C Library (Ubuntu EGLIBC 2.11.1-0ubuntu7.6) stable release version
> > 2.11.1, by Roland McGrath et al.
> > Copyright (C) 2009 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.
> > There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
> > PARTICULAR PURPOSE.
> > Compiled by GNU CC version 4.4.3.
> > Compiled on a Linux >>2.6.24-27-server<< system on 2010-11-17.
> > Available extensions:
> > 	crypt add-on version 2.1 by Michael Glad and others
> > 	GNU Libidn by Simon Josefsson
> > 	Native POSIX Threads Library by Ulrich Drepper et al
> > 	BIND-8.2.3-T5B
> > For bug reporting instructions, please see:
> > <http://www.debian.org/Bugs/>.
> > 
> > 
> > The valgrind stuff I will do later.
> 
> I can reproduce now. This is highly timing dependent.
> 

git://git.xenomai.org/xenomai-forge.git has a general fix for this
issue. Your test code will need the following patch to work. The basic
fix is that you can't create multiple objects with the same name with
Xenomai, because we need unique names for the registry to be meaningful.

I reduced the number of test loops as well, since 100 or 1000 loops do
not make any difference. Actually, two consecutive iterations of
t_create/t_delete were enough to trigger the issue.

--- rtprint.c.orig	2011-09-26 12:38:47.711339003 +0200
+++ rtprint.c	2011-09-26 12:37:49.871339005 +0200
@@ -115,7 +115,7 @@
 
 	my_printf("%s\n",__FUNCTION__);
  
-	check("t_create",t_create("TEST",250,16000,16000,0,&tid),0);
+	check("t_create",t_create(NULL,96,16000,16000,0,&tid),0);
 	check("t_setreg",t_setreg(tid,0UL,100UL),0);
 	check("t_getreg",t_getreg(tid,0UL,&reg_value),0);
 	check("reg_value",reg_value,100);
@@ -150,7 +150,7 @@
 
 	suspendmyself = 0;
 
-	check("t_create",t_create("TEST",250,16000,16000,0,&tid),0);
+	check("t_create",t_create(NULL,96,16000,16000,0,&tid),0);
 	check("t_start",t_start(tid,0,test_tasksuspend_body,args),0);
     
 	counter = 0;
@@ -201,7 +201,7 @@
 static void create_and_start_task(unsigned long *tid)
 {
 	unsigned long local_args[4] = {0,200,300,400};
-	check("t_create low prio",t_create ("TEST",2,4000,0,T_LOCAL,tid),0);	
+	check("t_create low prio",t_create (NULL,2,4000,0,T_LOCAL,tid),0);	
 	check("t_start low prio",t_start(*tid,T_PREEMPT|T_TSLICE,test_taskcreation_body,local_args),0);
 }
     
@@ -219,7 +219,7 @@
 
 	for (i=1;i<2;i++)
 	{
-		check("t_create",t_create("TEST",(unsigned long)i,16000,16000,0,&tid),0);
+		check("t_create",t_create(NULL,(unsigned long)i,16000,16000,0,&tid),0);
 		check("t_start",t_start(tid,T_PREEMPT| T_TSLICE | T_NOASR,test_taskcreation_body2,args),0);
 	}  
 
@@ -260,7 +260,7 @@
 	args[0] = 0;
 	for (i=0;i<500;i++)
 	{ 
-		check("t_create loop3",t_create ("TEST",(i%250)+1,100000,0,0,&tid),0);    
+		check("t_create loop3",t_create ("TEST",(i%96)+1,100000,0,0,&tid),0);    
 		check("t_start loop3",t_start(tid,T_PREEMPT,test_taskcreation_body,args),0);
 		check("t_delete loop3",t_delete(tid),0);			       
 		my_printf("t_create + t_start + t_delete %d\r",i);
@@ -334,7 +334,7 @@
 	test_basicevents();
 	
 	t_ident(0,0,&args[0]);
-	check("t_create",t_create("TEST",2,16000,16000,0,&tid),0);
+	check("t_create",t_create(NULL,2,16000,16000,0,&tid),0);
 	check("t_start",t_start(tid,0,test_events_body,args),0);
 	
 	ev_receive(1,EV_ALL|EV_WAIT,0,&ev_rcvd);
@@ -361,7 +361,7 @@
 	}
 	
 	for (i=0;i<50;i++)
-		check("q_create",q_create("TTTU",0,Q_NOLIMIT|Q_PRIOR,&qids[i]),0);
+		check("q_create",q_create(NULL,0,Q_NOLIMIT|Q_PRIOR,&qids[i]),0);
 	for (i=0;i<50;i++) 
 		check("q_delete",q_delete(qids[i]),0);
 }                          
@@ -439,20 +439,20 @@
 	
 	my_printf("%s\n",__FUNCTION__);   
 
-	check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid1),0);
-	check("q_create",q_create("TEST",0,Q_NOLIMIT|Q_PRIOR,&qid2),0);
+	check("q_create",q_create(NULL,0,Q_NOLIMIT|Q_PRIOR,&qid1),0);
+	check("q_create",q_create(NULL,0,Q_NOLIMIT|Q_PRIOR,&qid2),0);
  
 	args[0] = qid1;
 	args[1] = qid2;
  	args[2] = 1000;
 	t_ident(0,0,&args[3]); 
-	check("t_create",t_create("TEST",50,16000,16000,0,&tid),0);
+	check("t_create",t_create(NULL,50,16000,16000,0,&tid),0);
 	check("t_start",t_start(tid,0,test_msgqueue_ctxtswitch_body,args),0);
 
 	args[0] = qid2;
 	args[1] = qid1;
 	args[3] = 0;    /* Make sure only 1 sends the event. */
-	check("t_create",t_create("TEST",50,16000,16000,0,&tid),0);
+	check("t_create",t_create(NULL,50,16000,16000,0,&tid),0);
 	check("t_start",t_start(tid,0,test_msgqueue_ctxtswitch_body,args),0);
  
 	/*send initial message */
@@ -490,8 +490,8 @@
 
 	my_printf("%s\n",__FUNCTION__);   
 
-	check("t_create",t_create("TEST",50,16000,16000,0,&tid1),0);
-	check("t_create",t_create("TEST",50,16000,16000,0,&tid2),0);
+	check("t_create",t_create(NULL,50,16000,16000,0,&tid1),0);
+	check("t_create",t_create(NULL,50,16000,16000,0,&tid2),0);
 
 	args[0] = tid2;
 	args[1] = 1000;
@@ -533,7 +533,7 @@
 	}
 
 	for (i=0;i<50;i++)
-		check("sm_create",sm_create("TTTT",0,SM_PRIOR,&smids[i]),0);
+		check("sm_create",sm_create(NULL,0,SM_PRIOR,&smids[i]),0);
 	for (i=0;i<50;i++)
 		check("sm_delete",sm_delete(smids[i]),0);
         
@@ -690,7 +690,7 @@
 
         copperplate_init(argc, argv);
 
-        check("t_create",t_create("TEST",50,16000,16000,0,&tid),0);
+        check("t_create",t_create("ROOT",50,16000,16000,0,&tid),0);
         check("t_start",t_start(tid,0,test_main_body,args),0);
 
 	while (1) tm_wkafter(1000);
@@ -703,7 +703,7 @@
 { 
 	int i = 0;
 	char testCaseName[32];
-	int count = 1000;
+	int count = 100;
 
 	for (i=0;i<count;i++)
 	{
@@ -711,12 +711,12 @@
 		unsigned long args[4] = {0,200,300,400};
 
 		sprintf(testCaseName,"t_create %d",i);         
-		check(testCaseName,t_create ("TEST",(i%250)+1,100000,0,0,&tid),0);    
+		check(testCaseName,t_create ("TEST",(i%96)+1,100000,0,0,&tid),0);    
 		sprintf(testCaseName,"t_start %d",i);
 		check(testCaseName,t_start(tid,T_PREEMPT,test_taskcreation_body,args),0);
 		sprintf(testCaseName,"t_delete %d",i);
 		check(testCaseName,t_delete(tid),0);                                         
-		if ((i%1000) == 0) my_printf("create + start + delete %d\n",i);
+		if ((i%100) == 0) my_printf("create + start + delete %d\n",i);
 	}
 
 	for (i=0;i<count;i++)
@@ -725,10 +725,10 @@
 		unsigned long args[4] = {100,200,300,400};
 
 		sprintf(testCaseName,"t_create %d",i);
-		check(testCaseName,t_create ("TEST",(i%250)+1,100000,0,0,&tid),0);    
+		check(testCaseName,t_create (NULL,(i%96)+1,100000,0,0,&tid),0);    
 		sprintf(testCaseName,"t_start %d",i);
 		check(testCaseName,t_start(tid,T_PREEMPT,test_taskcreation_body2,args),0);
-		if ((i%1000) == 0) my_printf("create + start + self delete %d\n",i);
+		if ((i%100) == 0) my_printf("create + start + self delete %d\n",i);
 	}
 
 	for (i=0;i<count;i++)
@@ -739,7 +739,7 @@
 		check(testCaseName,sm_create("TTTT",0,SM_PRIOR,&smid),0);
 		sprintf(testCaseName,"sm_delete %d",i);
 		check(testCaseName,sm_delete(smid),0);
-		if ((i%1000) == 0) my_printf("sm_create + sm_delete %d\n",i);
+		if ((i%100) == 0) my_printf("sm_create + sm_delete %d\n",i);
 	}
 
 	for (i=0;i<count;i++)
@@ -750,7 +750,7 @@
 		check(testCaseName,q_create("TTTT",0,Q_NOLIMIT|Q_PRIOR,&qid),0);
 		sprintf(testCaseName,"q_delete %d",i);
 		check(testCaseName,q_delete(qid),0);
-		if ((i%1000) == 0) my_printf("q_create + q_delete %d\n",i);              
+		if ((i%100) == 0) my_printf("q_create + q_delete %d\n",i);              
 	}

-- 
Philippe.



