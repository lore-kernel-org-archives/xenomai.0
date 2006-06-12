From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 12 Jun 2006 20:58:17 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KlbjEKECG7qIvB/"
Message-Id: <200606122058.18019.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Some new test cases for the vxWorks skin
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
To: xenomai-core <xenomai@xenomai.org>

--Boundary-00=_KlbjEKECG7qIvB/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi

First I would like to thanks Gilles a lot! He patiently corrected my mistakes 
until we could finally agree on changes in the vxworks testsuite which 
allowed me to run (with a few additional files on my windows box running the 
vxworks development environment).

The attached patch vx_patch.msgq adds some more tests (and doc updates). They 
came up when I examined a little bit closer some differences between the 
vxworks skin and the actual vxworks behaviour (at least with my vxworks 
version 5.5.1). "mcu25.log" shows the output while running the tests under 
vxworks.

I added some more test as the msgQLib is our most used communication path 
between interrupt code and application code. Therefore I explicitely checked 
a few operation using a watchdog routine which runs in the interrupt context.

A found the following corner cases, where I vxworks skin is more robust than 
vxworks, e.g. it refuses to create a message queue when the maximal message 
length is zero. Or after specifying a negative number of messages vxWorks 
return a valid msgQId, but deleting this msgQId leads to an error message 
like "memPartFree: invalid block".

Applying it against revision 1194 leads to the following failures:
t010726-2.c:185: TEST failed: qid != 0 && errno == 0
t010726-2.c:256: TEST failed: rc == 0 && errno == 0
t010726-2.c:261: TEST failed: rc == ERROR && errno == S_objLib_OBJ_UNAVAILABLE
Xenoscope: lt-t010726-2: fatal in MvmIrq (time=30000658.732701): 
test interrupted by watchdog.
<..>
t010823-1.c:104: TEST failed: taskIdVerify(0) == ERROR && errno == 0

I am not sure whether all these errors can/should be fixed or added to the 
known differences between vxworks and the vxworks skin.

Is it okay to submit such a patch, which mixes a  different test cases or 
shall I submit the patches in smaller pieces? Should the test that I put into 
the procedure msgDuringInt better be inlined? Or should I add a new file for 
these tests?

Any comments are welcomed.

Best regards

-- 
Niklaus Giger

--Boundary-00=_KlbjEKECG7qIvB/
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vx_patch.msgq"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="vx_patch.msgq"

Index: sim/skins/vxworks/testsuite/t010823-1.c
===================================================================
--- sim/skins/vxworks/testsuite/t010823-1.c	(Revision 1194)
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
--- sim/skins/vxworks/testsuite/t010726-2.c	(Revision 1194)
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
@@ -47,6 +47,72 @@
 
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
+    TEST_ASSERT(rc == 0 && errno == 0);
+
+    errno = 0;
+    rc = msgQReceive(int2taskQid,(char *)&msg,sizeof(msg), 0);
+    TEST_ASSERT(rc == ERROR);
+    TEST_ASSERT(errno == S_intLib_NOT_ISR_CALLABLE);
+    msg = 0x5555affe;
+
+    errno = 0;
+    rc = msgQSend(int2taskQid,(char *)&msg,sizeof(int),0, MSG_PRI_NORMAL);
+    TEST_ASSERT_OK(rc);
+    TEST_ASSERT(errno == 0);
+
+    errno = 0;
+    rc = msgQSend(int2taskQid,(char *)&msg,sizeof(int),WAIT_FOREVER, MSG_PRI_NORMAL);
+    TEST_ASSERT(rc == ERROR);
+    TEST_ASSERT(errno == S_msgQLib_NON_ZERO_TIMEOUT_AT_INT_LEVEL);
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
+   TEST_ASSERT(rc == sizeof(msg));
+   TEST_ASSERT(msg == 0x5555affe);
+   TEST_ASSERT(errno == 0);
+
+   TEST_MARK();
+
+}
+
 void peerTask (long a0, long a1, long a2, long a3, long a4,
                long a5, long a6, long a7, long a8, long a9)
 {
@@ -105,6 +171,7 @@
 {
     int nmsg = 0, qid, rc, msg = 0;
     WIND_TCB *pTcb;
+    char *buffer;
 
     TEST_START(0);
 
@@ -113,14 +180,26 @@
 
     TEST_MARK();
 
+    errno = 0;
     qid = msgQCreate(NMESSAGES,sizeof(int),0xffff);
-    TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_QUEUE_TYPE);
+    TEST_ASSERT(qid != 0 && errno == 0);
+    if (qid) msgQDelete(qid);
 
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
 
     qid = msgQCreate(NMESSAGES,0,MSG_Q_FIFO);
     TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_MSG_LENGTH);
+    if (qid) msgQDelete(qid);
 
     qid = msgQCreate(NMESSAGES,sizeof(int),MSG_Q_FIFO);
     TEST_ASSERT(qid != 0);
@@ -148,23 +227,39 @@
 
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
+    rc = msgQNumMsgs(qid);
 
+    errno = 0;
     rc = msgQReceive(qid,(char *)&msg,sizeof(msg),NO_WAIT);
     TEST_ASSERT(rc == sizeof(msg));
 
+    rc = msgQSend(qid,(char *)&message_list[0],sizeof(int),WAIT_FOREVER,MSG_PRI_NORMAL);
+    TEST_ASSERT_OK(rc);
+    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
+    msg = errno;
+    TEST_ASSERT(rc == 0 && errno == 0);
+
+    errno = 0;
+    buffer = malloc(2*sizeof(message_list));
+    rc = msgQReceive(qid,buffer,2*sizeof(message_list),NO_WAIT);
+    TEST_ASSERT(rc == ERROR && errno == S_objLib_OBJ_UNAVAILABLE);
+
     TEST_MARK();
 
     for (nmsg = 0; nmsg < NMESSAGES; nmsg++)
@@ -209,6 +304,8 @@
     rc = msgQDelete(qid);
     TEST_ASSERT_OK(rc);
 
+    testMsqInterrupt();
+
     /*
     TEST_ASSERT(!ckObjectExists(qid));
     */
@@ -219,10 +316,10 @@
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
--- sim/skins/vxworks/testsuite/t010820-2.c	(Revision 1194)
+++ sim/skins/vxworks/testsuite/t010820-2.c	(Arbeitskopie)
@@ -33,6 +33,7 @@
 
 {
     TEST_ASSERT(arg == 0x25262728);
+    TEST_ASSERT(intContext());
     TEST_MARK();
 }
 
Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt	(Revision 1194)
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
+- Passing 0 as maxMsgLenght to msgQCreate returns 0 and sets errno to 
+  S_msgQLib_INVALID_MSG_LENGTH
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

--Boundary-00=_KlbjEKECG7qIvB/
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="mcu25.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mcu25.log"

[0m
bootSerialInit










                            VxWorks System Boot


Copyright 1984-2002  Wind River Systems, Inc.





CPU: IBM PowerPC 405GPr Rev. 1.1
Electronic CPU-ID: 0xe47f1109:0x28321d51
HCU4: 0x00000000
Version: VxWorks5.5.1
BSP version: 2.2.4
Creation date: Sep 22 2005, 19:20:28


sys_install_test 0


sysFlags 0x1000 BOOT 0x1000 1 at 0x4200

  Params-CRC at 0xfff80000 (from 0xfff80008 length 0x0000fff8) is okay  (0x5d53e1cb == 0x5d53e1cb)
 Program-CRC at 0xfff90000 (from 0xfff90008 length 0x0006fff8) is okay  (0x19c14076 == 0x19c14076)
i2c_init:
initialize_i2c_copy: tBoot HW okay. i2c_copy 128 bytes einlesen 

i2c_ip_show: size 2048 at 0x1fff7c8 signature 0xaffe i2c-version 0x0001
    PAC:   IP 172.25.1.1 
    i2c_checksum 0xf85d
FlashInfo at 0x1fff528: Vendor 0x89, Device 0x18 Version 1.1
maxTime: BytePgm 1024 BufferPgm 1024 BlockErase 16384 ChipErase 524288
Total capacity 16777216 bytes at 0x70000000 
Sector size 131072 bytes, total 128 sectors 
Write Queue Size 32 bytes
(c) Copyright 1995,1996 RST Software Industries Ltd. Israel
flags 0x1000 include 0x1000 for HCU-Boot from Flash and !sw_inst 0

Calculating CRC on F:/flash.rom (2019056 bytes) CRC=0xfa9d3771 is okay

ffsLoad from RST-FFS: F:/flash.rom...1752524
Starting at 0x10000...

[0m
usrSerialInit
i2c_init:
initialize_i2c_copy: tRootTask HW okay. i2c_copy 128 bytes einlesen 

i2c_ip_show: size 2048 at 0x1f743c0 signature 0xaffe i2c-version 0x0001
    PAC:   IP 172.25.1.1 
    i2c_checksum 0xf85d

sys_install_test 1Attached TCP/IP interface to emac unit 0
Attaching interface lo0...done

Adding 5137 symbols for standalone.
FlashInfo at 0x1e82220: Vendor 0x89, Device 0x18 Version 1.1
maxTime: BytePgm 1024 BufferPgm 1024 BlockErase 16384 ChipErase 524288
Total capacity 16777216 bytes at 0x70000000 
Sector size 131072 bytes, total 128 sectors 
Write Queue Size 32 bytes
(c) Copyright 1995,1996 RST Software Industries Ltd. Israel
0x1fffe00 (tRootTask): 
trace_init: buffer at 0x1b0200 allocated 240000 bytes (10000 entries)0x1fffe00 (tRootTask): 
trace_start: called from 0x41c88 

 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
      ]]]]]]]]]]]  ]]]]     ]]]]]]]]]]       ]]              ]]]]         (R)
 ]     ]]]]]]]]]  ]]]]]]     ]]]]]]]]       ]]               ]]]]            
 ]]     ]]]]]]]  ]]]]]]]]     ]]]]]] ]     ]]                ]]]]            
 ]]]     ]]]]] ]    ]]]  ]     ]]]] ]]]   ]]]]]]]]]  ]]]] ]] ]]]]  ]]   ]]]]]
 ]]]]     ]]]  ]]    ]  ]]]     ]] ]]]]] ]]]]]]   ]] ]]]]]]] ]]]] ]]   ]]]]  
 ]]]]]     ]  ]]]]     ]]]]]      ]]]]]]]] ]]]]   ]] ]]]]    ]]]]]]]    ]]]] 
 ]]]]]]      ]]]]]     ]]]]]]    ]  ]]]]]  ]]]]   ]] ]]]]    ]]]]]]]]    ]]]]
 ]]]]]]]    ]]]]]  ]    ]]]]]]  ]    ]]]   ]]]]   ]] ]]]]    ]]]] ]]]]    ]]]]
 ]]]]]]]]  ]]]]]  ]]]    ]]]]]]]      ]     ]]]]]]]  ]]]]    ]]]]  ]]]] ]]]]]
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]]       Development System
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]]
 ]]]]]]]]]]]]]]]]]]]]]]]]]]]       VxWorks version 5.5.1
 ]]]]]]]]]]]]]]]]]]]]]]]]]]       KERNEL: WIND version 2.6
 ]]]]]]]]]]]]]]]]]]]]]]]]]       Copyright Wind River Systems, Inc., 1984-2002

                               VxWorks (for IBM PowerPC 405GPr Rev. 1.1) version 5.5.1.
Kernel: WIND version 2.6.
Made on Jun  6 2006, 13:48:03.
Boot line: emac(0,0)c:S:/Gruppe/te/CODE/hwdriver/bsp_hcu/2_2_x/2_2_7/obj/hcu4/hcu4_vx_rom e=172.25.1.42 h=172.25.1.3 u=dpu pw=netstal8752 f=0x1000 tn=HCU3
Electronic CPU-ID: 0xe47f1109:0x28321d51
HCU4: 0x00000000
Memory Size: 0x2000000.Unable to open startup script F:/startup.hcu
->   NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tRootTask    usrRoot      1fffe00  47448   208  2800  44648 
printf "2006.06.12 14:24:37: Starting test t010726-1.o"
2006.06.12 14:24:37: Starting test t010726-1.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 33551752 = 0x1fff588 = printBuffer.3 + 0x438
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 33552232 = 0x1fff768 = printBuffer.3 + 0x618
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010726-1.o"
value = 33541912 = 0x1ffcf18 = tests + 0x9f4
-> vx_user_init
value = 0 = 0x0
-> 0x1e349e8 (): task deadt010726-1.c:100: Expected sequence: SEQ("Slicer1",4); got SEQ("Slicer1",151)
0x1e349e8 (): task deadt010726-1.c:101: Expected sequence: SEQ("Slicer2",4); got SEQ("Slicer2",157)
0x1e349e8 (): task deadt010726-1.c:102: Expected sequence: SEQ("Slicer3",4); got SEQ("Slicer3",158)
0x1e349e8 (): task deadt010726-1.c:103 Correct sequence: SEQ("root",2)
0x1e349e8 (): task deadt010726-1.c:104: Expected sequence: SEQ("Slicer1",12); got SEQ("Slicer1",472)
0x1e349e8 (): task deadt010726-1.c:105 Correct sequence: SEQ("root",1)
0x1e349e8 (): task deadt010726-1.c:112, test finished: 4 failures/ 15 tests
0x1e349e8 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1136   8848 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4576  34744 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   656   4344 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:24:47: Starting test t010726-2.o"
2006.06.12 14:24:47: Starting test t010726-2.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 33551192 = 0x1fff358 = printBuffer.3 + 0x208
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 33523272 = 0x1ff8648 = tests + 0x814
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010726-2.o"
value = 33523744 = 0x1ff8820 = tests + 0x9ec
-> vx_user_init
value = 0 = 0x0
-> 0x1e2f818 (root): t010726-2.c:202: TEST failed: qid == 0 && errno == S_msgQLib_INVALID_MSG_LENGTH
0x1e2f818 (): task deadt010726-2.c:314 Correct sequence: SEQ("root",1)
0x1e2f818 (): task deadt010726-2.c:315 Correct sequence: SEQ("Peer",2)
0x1e2f818 (): task deadt010726-2.c:316 Correct sequence: SEQ("root",10)
0x1e2f818 (): task deadt010726-2.c:317 Correct sequence: SEQ("Peer",2)
0x1e2f818 (): task deadt010726-2.c:318 Correct sequence: SEQ("root",8)
0x1e2f818 (): task deadt010726-2.c:319 Correct sequence: SEQ("Peer",14)
0x1e2f818 (): task deadt010726-2.c:320 Correct sequence: SEQ("root",6)
0x1e2f818 (): task deadt010726-2.c:325, test finished: 1 failures/ 103 tests
0x1e2f818 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1136   8848 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4576  34744 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   656   4344 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:24:57: Starting test t010728.o"
2006.06.12 14:24:57: Starting test t010728.ovalue = 44 = 0x2c = ','
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 33512160 = 0x1ff5ae0 = printBuffer.3 + 0x438
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 33544288 = 0x1ffd860
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010728.o"
value = 33513968 = 0x1ff61f0 = printBuffer.3 + 0xb48
-> vx_user_init
value = 31647992 = 0x1e2e8f8
-> 0x1e2e8f8 (): task deadt010728.c:76: TEST failed: rc == 0
0x1e2e8f8 (): task deadt010728.c:84: TEST failed: rc == INTR_LEVEL
0x1e2e8f8 (): task deadt010728.c:91: TEST failed: lockKey == 0
0x1e2e8f8 (): task deadt010728.c:119, test finished: 3 failures/ 4 tests
0x1e2e8f8 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1136   8848 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4576  34744 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   672   4328 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:25:07: Starting test t010820-1.o"
2006.06.12 14:25:07: Starting test t010820-1.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 33508232 = 0x1ff4b88
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 33544760 = 0x1ffda38
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010820-1.o"
value = 33508752 = 0x1ff4d90
-> vx_user_init
value = 0 = 0x0
-> 0x1e21820 (): task deadt010820-1.c:80 Correct sequence: SEQ("Test1",1)
0x1e21820 (): task deadt010820-1.c:81 Correct sequence: SEQ("Test2",1)
0x1e21820 (): task deadt010820-1.c:82 Correct sequence: SEQ("Test1",2)
0x1e21820 (): task deadt010820-1.c:83 Correct sequence: SEQ("Test2",3)
0x1e21820 (): task deadt010820-1.c:84 Correct sequence: SEQ("Test1",3)
0x1e21820 (): task deadt010820-1.c:92, test finished: 0 failures/ 23 tests
0x1e21820 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1140   8844 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4576  34744 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   672   4328 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:25:17: Starting test t010820-2.o"
2006.06.12 14:25:17: Starting test t010820-2.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 31639096 = 0x1e2c638 = tRoot + 0x9c8
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 31639552 = 0x1e2c800 = tRoot + 0xb90
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010820-2.o"
value = 31636920 = 0x1e2bdb8 = tRoot + 0x148
-> vx_user_init
value = 0 = 0x0
-> 0x1e267e8 (): task deadt010820-2.c:77 Correct sequence: SEQ("root",3)
0x1e267e8 (): task deadt010820-2.c:78: Expected sequence: SEQ("ROOT",1); got SEQ("tShell",1)
0x1e267e8 (): task deadt010820-2.c:79 Correct sequence: SEQ("root",3)
0x1e267e8 (): task deadt010820-2.c:82, test finished: 1 failures/ 12 tests
0x1e267e8 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1140   8844 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4576  34744 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   672   4328 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:25:26: Starting test t010823-1.o"
2006.06.12 14:25:26: Starting test t010823-1.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 31640088 = 0x1e2ca18 = tRoot + 0xda8
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 33548264 = 0x1ffe7e8 = printBuffer.3 + 0x258
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010823-1.o"
value = 31653608 = 0x1e2fee8 = vx_user_exit + 0x5ec
-> vx_user_init
value = 0 = 0x0
-> 0x1e21228 (): task deadt010823-1.c:114 Correct sequence: SEQ("root",2)
0x1e21228 (): task deadt010823-1.c:115 Correct sequence: SEQ("peerTask",2)
0x1e21228 (): task deadt010823-1.c:116 Correct sequence: SEQ("root",1)
0x1e21228 (): task deadt010823-1.c:123, test finished: 0 failures/ 17 tests
0x1e21228 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1140   8844 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4580  34740 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   672   4328 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:25:36: Starting test t010823-2.o"
2006.06.12 14:25:36: Starting test t010823-2.ovalue = 46 = 0x2e = '.'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 31590848 = 0x1e209c0 = printBuffer.3 + 0x438
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 31591328 = 0x1e20ba0 = printBuffer.3 + 0x618
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/t010823-2.o"
value = 31581008 = 0x1e1e350 = tests + 0x9f4
-> vx_user_init
value = 0 = 0x0
-> 0x1e0f3b8 (): task deadt010823-2.c:154 Correct sequence: SEQ("root",1)
0x1e0f3b8 (): task deadt010823-2.c:155 Correct sequence: SEQ("Test2",1)
0x1e0f3b8 (): task deadt010823-2.c:156 Correct sequence: SEQ("root",1)
0x1e0f3b8 (): task deadt010823-2.c:157 Correct sequence: SEQ("Test2",1)
0x1e0f3b8 (): task deadt010823-2.c:158 Correct sequence: SEQ("Test1",2)
0x1e0f3b8 (): task deadt010823-2.c:159 Correct sequence: SEQ("Test2",1)
0x1e0f3b8 (): task deadt010823-2.c:160 Correct sequence: SEQ("root",1)
0x1e0f3b8 (): task deadt010823-2.c:161 Correct sequence: SEQ("Test1",1)
0x1e0f3b8 (): task deadt010823-2.c:162 Correct sequence: SEQ("root",2)
0x1e0f3b8 (): task deadt010823-2.c:163: Expected sequence: SEQ("Test2",2009); got SEQ("Test2",4244)
0x1e0f3b8 (): task deadt010823-2.c:164 Correct sequence: SEQ("root",1)
0x1e0f3b8 (): task deadt010823-2.c:166, test finished: 1 failures/ 33 tests
0x1e0f3b8 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0
-> checkStack
  NAME        ENTRY        TID     SIZE   CUR  HIGH  MARGIN
------------ ------------ -------- ----- ----- ----- ------
tExcTask     excTask      1f73ee0  47984   288   576  47408 
tNetTask     netTask      1f0de78   9984   240  1140   8844 
tPortmapd    portmapd     1e88f00   9984   608   896   9088 
tFtpdTask    0x00000b6088 1e86200  11984   432   720  11264 
tShell       shell        1e3f2e8  39320  1056  4580  34740 
tLogTask     logTask      1f678b8  47984   272  1456  46528 
tFfsRecl     flashFsRecla 1e81f20   5104   304   592   4512 
INTERRUPT                           5000     0   672   4328 
value = 36 = 0x24 = '$'
-> printf "2006.06.12 14:25:46: Starting test trestart.o"
2006.06.12 14:25:46: Starting test trestart.ovalue = 45 = 0x2d = '-'
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest_printf.o"
value = 31592896 = 0x1e211c0 = printBuffer.3 + 0xc38
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/xntest.o"
value = 31569184 = 0x1e1b520
-> ld 1,1,"H:/xrun/xenomai/sim/skins/vxworks/testsuite/trestart.o"
value = 31566064 = 0x1e1a8f0
-> vx_user_init
value = 0 = 0x0
-> 0x1e0c8f8 (): task deadtrestart.c:89 Correct sequence: SEQ("nop",2)
0x1e0c8f8 (): task deadtrestart.c:90 Correct sequence: SEQ("restart",1)
0x1e0c8f8 (): task deadtrestart.c:91 Correct sequence: SEQ("nop",1)
0x1e0c8f8 (): task deadtrestart.c:92 Correct sequence: SEQ("restart",1)
0x1e0c8f8 (): task deadtrestart.c:93 Correct sequence: SEQ("nop",1)
0x1e0c8f8 (): task deadtrestart.c:94 Correct sequence: SEQ("create",1)
0x1e0c8f8 (): task deadtrestart.c:97, test finished: 0 failures/ 15 tests
0x1e0c8f8 (): task deadNormal exit.
i

  NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO  DELAY
---------- ------------ -------- --- ---------- -------- -------- ------- -----
tExcTask   excTask       1f73ee0   0 PEND         155938  1f73dc0       0     0
tNetTask   netTask       1f0de78  50 PEND         147148  1f0dd88       0     0
tPortmapd  portmapd      1e88f00  54 PEND         147148  1e88ca0  3d0002     0
tFtpdTask  b6088         1e86200  55 PEND         147148  1e86050       0     0
tShell     shell         1e3f2e8 180 READY        14c83c  1e3eec8  8800dd     0
tLogTask   logTask       1f678b8 181 PEND         155938  1f677a8  3d0001     0
tFfsRecl   flashFsRecla  1e81f20 200 PEND         155938  1e81df0       0     0
value = 0 = 0x0

--Boundary-00=_KlbjEKECG7qIvB/--

