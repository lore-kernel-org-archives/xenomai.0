From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 25 Sep 2006 23:10:03 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_rWEGF6Na8zbNmb0"
Message-Id: <200609252310.03954.niklaus.giger@domain.hid>
Subject: [Xenomai-core] vxworks returns -1 for semGive
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_rWEGF6Na8zbNmb0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

I modified satch.c (see attached patch) to get a testcase for a wrong=20
behaviour of the vxWorks skin. A semGive returns -1 if it is not preceded b=
y=20
a errnoSet(0).

Output is:
=2D- /usr/xenomai/bin $ /bin/satch
NO TASK WAITING
Xenomai: Switching RootTask to secondary mode after exception #1025 from=20
user-space at 0xfe5cff8 (pid 3715)

__xeno_user_init: semMCreate 45 taskId 44
__xeno_user_init: semTake 45 status 0 0 taskId 44
__xeno_user_init: semGive 45 status -1 errno 1441896 taskId 44
Error code 1441896: S_semLib_INVALID_OPERATION
__xeno_user_init: semTake 45 status 0 1441896 taskId 44
__xeno_user_init: semGive 45 status 0 errno 0 taskId 44
Error code 0: Unknown error

This is clearly a difference between the Xenomai simulator's and the user m=
ode=20
vxworks skins behaviour.

This leads me to the question how difficult it would be to modify the Xenom=
ai=20
simulator's test cases to be run under the Xenomai vxworks skin. I think=20
using similar techniques as running the test cases under a real vxworks thi=
s=20
should be feasible and I would volunteer to tackle this issue, but would li=
ke=20
to get some hints from Gilles.

I do not feel at ease with the whole autoconf/automake magic in the simulat=
or=20
source directories. I seems however an easy job to add a alternative Makefi=
le=20
(=E0 la ksrc/skin/vxworks/demo), eg. name Makefile.user. Is this a good ide=
a?

Once running I would try to integrate them into the buildbot. I am not sure=
=20
whether as part of xeno-test, an option passed to xeno-test or a different=
=20
tool.

Needless to say, that similar work should be done for the posix testsuite.

As it is the case when running the testcase under the skins some tests woul=
d=20
be expected to fail and/or return different values than those based on the=
=20
simulator's view of time.

Would such patches be accepted in the Xenomai source?

Thanks in advance

=2D--
Niklaus Giger

--Boundary-00=_rWEGF6Na8zbNmb0
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="satch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="satch.diff"

Index: satch.c
===================================================================
--- satch.c	(Revision 1672)
+++ satch.c	(Arbeitskopie)
@@ -35,6 +35,7 @@
 int root_thread_init(void);
 void root_thread_exit(void);
 
+#define add_sema_test
 #if !defined(__KERNEL__) && !defined(__XENO_SIM__)
 
 #include <sys/mman.h>
@@ -113,7 +114,6 @@
 {
     int next_msg = 0;
     const char *s;
-
     for (;;)
 	{
 	taskDelay(PRODUCER_TRIG);
@@ -122,13 +122,32 @@
 	next_msg %= (sizeof(satch_s_tunes) / sizeof(satch_s_tunes[0]));
 
 	msgQSend(message_qid,(char *)&s,sizeof(s),WAIT_FOREVER,MSG_PRI_NORMAL);
+	break;
 	}
 }
 
 int root_thread_init (void)
 
 {
-    message_qid = msgQCreate(16,sizeof(char *),MSG_Q_FIFO);
+#ifdef add_sema_test
+   int sema_1, myErr, status;
+   sema_1 = semMCreate(SEM_Q_PRIORITY | SEM_INVERSION_SAFE );
+   printf("\n%s: semMCreate %d taskId %d\n", __FUNCTION__, sema_1, taskIdSelf());
+   status = semTake(sema_1, WAIT_FOREVER);
+   printf("%s: semTake %d status %d %d taskId %d\n", __FUNCTION__, sema_1, status, errnoGet(), taskIdSelf());
+   status = semGive(sema_1);
+   myErr = errnoGet();
+   printf("%s: semGive %d status %d errno %d taskId %d\n", __FUNCTION__, sema_1, status, myErr, taskIdSelf());
+   printErrno(myErr);
+   status = semTake(sema_1, WAIT_FOREVER);
+   printf("%s: semTake %d status %d %d taskId %d\n", __FUNCTION__, sema_1, status, errnoGet(), taskIdSelf());
+   errnoSet(0);
+   status = semGive(sema_1);
+   myErr = errnoGet();
+   printf("%s: semGive %d status %d errno %d taskId %d\n", __FUNCTION__, sema_1, status, myErr, taskIdSelf());
+   printErrno(myErr);
+   exit(0);
+#endif
 
     consumer_tid = taskSpawn("ConsumerTask",
 			     CONSUMER_TASK_PRI,

--Boundary-00=_rWEGF6Na8zbNmb0--

