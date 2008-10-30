From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Fri, 31 Oct 2008 00:20:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810310020.40023.niklaus.giger@domain.hid>
Subject: [Xenomai-core] vxWorks.skin: Error in taskActivate
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

Hi

While testing my application I found an error in the vxWorks skin.

When calling it on my PPC405 system I found that taskInit does not mimick 
exactly the behaviour.  As the WIND_TDB in xenomai/vxworks is just an integer
one has to add an ifdef if one wants to use this function properly

E.g. I added the following switch in my code

   status = taskInit (tcb_base,    <..mor parameters>);
#ifdef RUNNING_XENOMAI_VXWORKS_SKIN
  status = taskActivate(*(int *)tcb_base);
#else
   status = taskActivate((int)tcb_base);
#endif
 
Is my interpretation correct? Shouldn't this behaviour be documented under 
doc/skins/vxworks-skin.txt?

My proposal is:

Index: doc/txt/vxworks-skin.txt
===================================================================
--- doc/txt/vxworks-skin.txt    (Revision 4311)
+++ doc/txt/vxworks-skin.txt    (Arbeitskopie)
@@ -13,7 +13,7 @@
 The VxWorks (R) emulation module currently mimicks the following
 services:

-taskSpawn, taskInit, taskActivate, taskDelete, taskDeleteForce, taskSuspend,
+taskSpawn, taskInit, taskActivate, taskDelete, taskDeleteForce, taskSuspend,
 taskResume, taskPrioritySet, taskPriorityGet, taskLock, taskUnlock, 
taskIdSelf,
 taskSafe, taskUnsafe, taskDelay, taskIdVerify, taskTcb, taskRestart

@@ -52,6 +52,12 @@

 - taskInit gives a default name if NULL was passed as argument.

+- taskInit stores in WIND_TCB pointed by *pTcb a integer, which can be used
+  in the subsequent call to taskActivate. E.g. change your code from
+  status = taskActivate((int)pTcb);
+  to
+  status = taskActivate(*(int *)pTcb);
+
 - For the moment, the status member of task control blocks is never updated 
to
   reflect the status of a task.

----

Best regards

Niklaus

