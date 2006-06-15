From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
Date: Thu, 15 Jun 2006 13:40:54 +0200
References: <200606122058.18019.niklaus.giger@domain.hid>
	<17552.3527.468486.973862@domain.hid>
In-Reply-To: <17552.3527.468486.973862@domain.hid>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_HdUkE2n1GQOGIeZ"
Message-Id: <200606151340.55710.niklaus.giger@domain.hid>
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
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_HdUkE2n1GQOGIeZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

Here the reworked patch.

vxWorks supports empty messages. Only one at a time can be received.

Test log of running t010726-2 under vxWorks and the simulator are below:
(vxWorks target)
0x1e268a8 (root): t010726-2.c:180: TEST failed: qid =3D=3D 0 && errno =3D=3D
S_msgQLib_INVALID_QUEUE_TYPE
0x1e268a8 (): task deadt010726-2.c:337 Correct sequence: SEQ("root",1)
0x1e268a8 (): task deadt010726-2.c:338 Correct sequence: SEQ("Peer",2)
0x1e268a8 (): task deadt010726-2.c:339 Correct sequence:
SEQ("root",10)
0x1e268a8 (): task deadt010726-2.c:340 Correct sequence: SEQ("Peer",2)
0x1e268a8 (): task deadt010726-2.c:341 Correct sequence: SEQ("root",8)
0x1e268a8 (): task deadt010726-2.c:342 Correct sequence:
SEQ("Peer",14)
0x1e268a8 (): task deadt010726-2.c:343 Correct sequence: SEQ("root",6)
0x1e268a8 (): task deadt010726-2.c:348, test finished: 1 failures/ 111
tests =A0 =A0 =A0

(Xenomai sim)
starting VxWorks services.
t010726-2.c:196: TEST failed: qid !=3D 0
t010726-2.c:199: TEST failed: rc =3D=3D 0
t010726-2.c:201: TEST failed: rc =3D=3D OK
t010726-2.c:203: TEST failed: rc =3D=3D 1
t010726-2.c:205: TEST failed: rc =3D=3D OK
t010726-2.c:207: TEST failed: rc =3D=3D 2
t010726-2.c:209: TEST failed: rc=3D=3D OK
Error code 3997697: S_objLib_OBJ_ID_ERROR
t010726-2.c:211: TEST failed: rc =3D=3D 1
t010726-2.c:213: TEST failed: rc=3D=3D OK
Error code 3997697: S_objLib_OBJ_ID_ERROR
t010726-2.c:215: TEST failed: rc =3D=3D 0
t010726-2.c:220: TEST failed: rc =3D=3D 2
t010726-2.c:222: TEST failed: rc=3D=3D OK
Error code 3997697: S_objLib_OBJ_ID_ERROR
t010726-2.c:224: TEST failed: rc =3D=3D 1
t010726-2.c:227: TEST failed: rc =3D=3D OK
t010726-2.c:278: TEST failed: rc=3D=3D OK
Error code 4259841: S_msgQLib_INVALID_MSG_LENGTH
t010726-2.c:284: TEST failed: rc =3D=3D ERROR && errno =3D=3D S_objLib_OBJ_=
UNAVAILABLE
Xenoscope: lt-t010726-2: fatal in MvmIrq (time=3D30000658.732701):=20

Best regards
=2D-=20
Niklaus Giger

--Boundary-00=_HdUkE2n1GQOGIeZ
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vx_patch.msgq3"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vx_patch.msgq3"

Index: sim/skins/vxworks/testsuite/t010823-1.c
===================================================================
--- sim/skins/vxworks/testsuite/t010823-1.c	(Revision 1206)
+++ sim/skins/vxworks/testsuite/t010823-1.c	(Arbeitskopie)
@@ -70,7 +70,7 @@
     TEST_ASSERT(pTcb != NULL);
 
 #ifdef VXWORKS
-    pstackBase = (char *) malloc(stackSize) + stacksize;
+    pstackBase = (char *) malloc(stackSize) + stackSize;
 #endif
   
     TEST_ASSERT(taskInit(&peerTcb,
@@ -100,7 +100,10 @@
 
     TEST_MARK();
 
-    TEST_ASSERT(taskIdVerify(0) == ERROR && errno == S_objLib_OBJ_ID_ERROR);
+    errno = 0;
+    TEST_ASSERT(taskIdVerify(0) == ERROR && errno == 0);
+    errno = 0;
+    TEST_ASSERT(taskIdVerify(malloc(20)) == ERROR && errno == S_objLib_OBJ_ID_ERROR);
 
     TEST_ASSERT_OK(taskIdVerify((TASK_ID)&peerTcb));
 
Index: sim/skins/vxworks/testsuite/t010726-2.c
===================================================================
--- sim/skins/vxworks/testsuite/t010726-2.c	(Revision 1206)
+++ sim/skins/vxworks/testsuite/t010726-2.c	(Arbeitskopie)
@@ -17,7 +17,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  *
- * Description: Testing VxWorks services:
+ * Description: Testing VxWorks services (task to task and int to task):
  * - msgQCreate
  * - msgQDelete
  * - msgQNumMsgs
@@ -47,6 +47,67 @@
 
 #define NMESSAGES (sizeof(message_list) / sizeof(message_list[0]))
 
+static WDOG_ID wid;
+
+static int int2taskQid ;
+
+void msgDuringInt (long arg)
+
+{
+    int qid = 0, rc = 0, msg = 0;
+    TEST_ASSERT(intContext());
+    TEST_MARK();
+
+    qid = msgQCreate(NMESSAGES,sizeof(int),MSG_Q_FIFO);
+    TEST_ASSERT(qid == 0 && errno == S_intLib_NOT_ISR_CALLABLE);
+
+    errno = 0;
+    rc = msgQNumMsgs(int2taskQid);
+    TEST_ASSERT(rc == 0);
+
+    errno = 0;
+    rc = msgQReceive(int2taskQid,(char *)&msg,sizeof(msg), 0);
+    TEST_ASSERT(rc == ERROR && errno == S_intLib_NOT_ISR_CALLABLE);
+    msg = 0x5555affe;
+
+    errno = 0;
+    rc = msgQSend(int2taskQid,(char *)&msg,sizeof(int),0, MSG_PRI_NORMAL);
+    TEST_ASSERT_OK(rc);
+
+    errno = 0;
+    rc = msgQSend(int2taskQid,(char *)&msg,sizeof(int),WAIT_FOREVER, MSG_PRI_NORMAL);
+    TEST_ASSERT(rc == ERROR && errno == S_msgQLib_NON_ZERO_TIMEOUT_AT_INT_LEVEL);
+    TEST_MARK();
+}
+
+void testMsqInterrupt()
+{
+   int nmsg = 0, qid, rc, msg = 0;
+   int2taskQid = msgQCreate(NMESSAGES,sizeof(int),MSG_Q_FIFO);
+   TEST_ASSERT(int2taskQid != 0);
+
+   wid = wdCreate();
+
+   TEST_ASSERT(wid != 0);
+
+   TEST_ASSERT_OK(wdStart(wid,1,msgDuringInt,0x25262728));
+
+   TEST_MARK();
+
+   TEST_ASSERT_OK(taskDelay(2));
+   TEST_ASSERT_OK(wdCancel(wid));
+   TEST_ASSERT_OK(wdDelete(wid));
+
+   TEST_MARK();
+
+   errno = 0;
+   rc = msgQReceive(int2taskQid,(char *)&msg,sizeof(msg), 0);
+   TEST_ASSERT(rc == sizeof(msg) && msg == 0x5555affe);
+
+   TEST_MARK();
+
+}
+
 void peerTask (long a0, long a1, long a2, long a3, long a4,
                long a5, long a6, long a7, long a8, long a9)
 {
@@ -105,6 +166,7 @@
 {
     int nmsg = 0, qid, rc, msg = 0;
     WIND_TCB *pTcb;
+    char *buffer;
 
     TEST_START(0);
 
@@ -113,15 +175,57 @@
 
     TEST_MARK();
 
+    errno = 0;
     qid = msgQCreate(NMESSAGES,sizeof(int),0xffff);
     TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_QUEUE_TYPE);
 
+#ifndef VXWORKS
+    /* This is undesirable behaviour in vxWorks (at least tested under version 5.5.1. 
+       Some might even call it a bug.
+       Passing a negative argument to maxMsgs for msgQCreate returns a  non null MSG_Q_ID.
+       Freeing it leads to a  a memPartFree: invalid block.
+       For maxMsgs bigger than the available memory, vxWorks returns 0, 
+       but does not set errno to a consistent value.
+    */
     qid = msgQCreate(-1,sizeof(int),MSG_Q_FIFO);
     TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_QUEUE_TYPE);
+#endif
 
+    /* Test mailbox with 0 length messages */
     qid = msgQCreate(NMESSAGES,0,MSG_Q_FIFO);
-    TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_MSG_LENGTH);
+    TEST_ASSERT(qid != 0);
+    errno = 0;
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 0);
+    rc = msgQSend(qid,(char *)&message_list[0],0, NO_WAIT, MSG_PRI_NORMAL);
+    TEST_ASSERT(rc == OK);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 1);
+    rc = msgQSend(qid,(char *)&message_list[0],0, NO_WAIT, MSG_PRI_NORMAL);
+    TEST_ASSERT(rc == OK);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 2);
+    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
+    TEST_ASSERT_OK(rc);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 1);
+    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
+    TEST_ASSERT_OK(rc);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 0);
 
+    rc = msgQSend(qid,(char *)&message_list[0],0, NO_WAIT, MSG_PRI_NORMAL);
+    rc = msgQSend(qid,(char *)&message_list[0],0, NO_WAIT, MSG_PRI_NORMAL);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 2);
+    rc = msgQReceive(qid,(char *)&msg,2,NO_WAIT);
+    TEST_ASSERT_OK(rc);
+    rc = msgQNumMsgs(qid);
+    TEST_ASSERT(rc == 1);
+
+    rc = msgQDelete(qid);
+    TEST_ASSERT(rc == OK);
+
     qid = msgQCreate(NMESSAGES,sizeof(int),MSG_Q_FIFO);
     TEST_ASSERT(qid != 0);
 
@@ -148,23 +252,38 @@
 
     TEST_MARK();
 
-    rc = msgQSend(qid,(char *)&message_list[0],0,WAIT_FOREVER,MSG_PRI_NORMAL);
+    errno = 0;
+    rc = msgQSend(qid,(char *)&message_list[0],2*message_list[0], WAIT_FOREVER,MSG_PRI_NORMAL);
     TEST_ASSERT(rc == ERROR && errno == S_msgQLib_INVALID_MSG_LENGTH);
 
     rc = msgQSend(qid,(char *)&message_list[0],sizeof(int),WAIT_FOREVER,MSG_PRI_NORMAL);
     TEST_ASSERT_OK(rc);
 
+    rc = msgQSend(qid,(char *)&message_list[0], 2*sizeof(int),WAIT_FOREVER,MSG_PRI_NORMAL);
+    TEST_ASSERT(rc == ERROR && errno == S_msgQLib_INVALID_MSG_LENGTH);
+
     TEST_MARK();
 
+    errno = 0;
     rc = msgQReceive(0,(char *)&msg,sizeof(msg),NO_WAIT);
     TEST_ASSERT(rc == ERROR && errno == S_objLib_OBJ_ID_ERROR);
 
-    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
-    TEST_ASSERT(rc == ERROR && errno == S_msgQLib_INVALID_MSG_LENGTH);
-
+    errno = 0;
     rc = msgQReceive(qid,(char *)&msg,sizeof(msg),NO_WAIT);
     TEST_ASSERT(rc == sizeof(msg));
 
+    rc = msgQSend(qid,(char *)&message_list[0],sizeof(int),WAIT_FOREVER,MSG_PRI_NORMAL);
+    TEST_ASSERT_OK(rc);
+    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
+    TEST_ASSERT_OK(rc);
+
+    errno = 0;
+    buffer = malloc(2*sizeof(message_list));
+    bzero(buffer,   2*sizeof(message_list));
+    rc = msgQReceive(qid,buffer,2*sizeof(message_list),NO_WAIT);
+    TEST_ASSERT(rc == ERROR && errno == S_objLib_OBJ_UNAVAILABLE);
+    free(buffer);
+
     TEST_MARK();
 
     for (nmsg = 0; nmsg < NMESSAGES; nmsg++)
@@ -209,6 +328,8 @@
     rc = msgQDelete(qid);
     TEST_ASSERT_OK(rc);
 
+    testMsqInterrupt();
+
     /*
     TEST_ASSERT(!ckObjectExists(qid));
     */
@@ -219,10 +340,10 @@
                         SEQ("Peer",2),
                         SEQ("root",8),
                         SEQ("Peer",14),
-                        SEQ("root",1),
+                        SEQ("root",6),
                         END_SEQ);
 
-    TEST_ASSERT_OK(taskDelete(peerTid));
+   if (peerTid) TEST_ASSERT_OK(taskDelete(peerTid));
     
     TEST_FINISH();
 }
Index: sim/skins/vxworks/testsuite/t010820-2.c
===================================================================
--- sim/skins/vxworks/testsuite/t010820-2.c	(Revision 1206)
+++ sim/skins/vxworks/testsuite/t010820-2.c	(Arbeitskopie)
@@ -33,6 +33,7 @@
 
 {
     TEST_ASSERT(arg == 0x25262728);
+    TEST_ASSERT(intContext());
     TEST_MARK();
 }
 
Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt	(Revision 1206)
+++ doc/txt/vxworks-skin.txt	(Arbeitskopie)
@@ -73,31 +73,37 @@
   genuine OS.
 
 - The exit() service is called taskExit() for kernel-space based
-applications. User-space applications may invoke exit() normally.
+  applications. User-space applications may invoke exit() normally.
 
 - Functions taking function pointers as arguments do not use FUNCPTR, which mean
   that the function pointer types are verified at compile time.
 
+- Passing a negative argument to maxMsgs for msgQCreate returns 0 and sets
+  errno to S_msgQLib_INVALID_QUEUE_TYPE
+
+- Passing a argument with non defined bits to options for msgQCreate returns 0.
+  VxWorks returns a valid msqId.
+
 - msgQSend() might return S_memLib_NOT_ENOUGH_MEMORY in case of
-dynamic memory shortage when called from user-space, for messages
-longer than 128 bytes. This service might also return
-S_msgQLib_INVALID_MSG_LENGTH whenever the message buffer address is
-NULL.
+  dynamic memory shortage when called from user-space, for messages
+  longer than 128 bytes. This service might also return
+  S_msgQLib_INVALID_MSG_LENGTH whenever the message buffer address is
+  NULL.
 
 - msgQReceive() might return S_objLib_OBJ_UNAVAILABLE if the timeout
-parameter is different from NO_WAIT, but the caller cannot be put to
-sleep. This is for instance the case whenever the caller is not a
-VxWorks task, or the scheduler is locked.
+  parameter is different from NO_WAIT, but the caller cannot be put to
+  sleep. This is for instance the case whenever the caller is not a
+  VxWorks task, or the scheduler is locked.
 
 - In case the documented VxWorks API does not explicitely handle the
-case, calling blocking services outside of any VxWorks task context or
-under scheduler lock, might return the POSIX error value "EPERM".
+  case, calling blocking services outside of any VxWorks task context or
+  under scheduler lock, might return the POSIX error value "EPERM".
 
 - When called from user-space, all blocking services might return
-prematurely with the POSIX error value "EINTR", whenever a Linux
-signal is received by the sleeping task. This also includes
-taskDelete() which might need to wait for the deleted task to exit a
-safe section (taskSafe/taskUnsafe) before proceeding.
+  prematurely with the POSIX error value "EINTR", whenever a Linux
+  signal is received by the sleeping task. This also includes
+  taskDelete() which might need to wait for the deleted task to exit a
+  safe section (taskSafe/taskUnsafe) before proceeding.
 
 Module parameters
 =================

--Boundary-00=_HdUkE2n1GQOGIeZ--

