From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rJFwV9PlVZ"
Content-Transfer-Encoding: 7bit
Message-ID: <17286.64964.4382.190611@domain.hid>
Date: Fri, 25 Nov 2005 13:04:20 +0100
Subject: Re: [Xenomai-help] Interrupt processing crashes in semTake
In-Reply-To: <4386EACC.1080501@domain.hid>
References: <001f01c5f1a6$cffd8250$1000000a@domain.hid>
	<4386EACC.1080501@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai-help@domain.hid


--rJFwV9PlVZ
Content-Type: text/plain; charset=us-ascii
Content-Description: message body and .signature
Content-Transfer-Encoding: 7bit

Philippe Gerum wrote:
 > Hans-J. Ude wrote:
 > > I'm porting an vxWorks application to Xenomai at the moment. When it comes
 > > to interrupt handling, there is nothing in the vx skin to handle that (did i
 > > overlook something?). First I've tried to handle that down in the xenomai
 > > layer but problems occured and someone advised me to use a native interrupt
 > > task using rt_intr_wait. I did so but the program segfaults after a minute
 > > or so. I've put a sigsegv handler with a stack backtrace function into the
 > > code. That shows the crash happens in the internals of semTake. Is it
 > > problematic to make skin calls (semGive in my case) from inside the native
 > > irq handler?
 > 
 > Yes, it's indeed a problem. When calling semTake from the in-kernel 
 > VxWorks skin, the invoked code expects a VxWorks task to be current in 
 > order to put it to sleep, but in your case, it's a native skin task. 
 > Since both TCBs have obviously different memory layouts, the segfault is 
 > inevitable. The same goes when calling semGive from a native task, since 
 > the latter code needs to fiddle with the caller's internals. That's a 
 > limitation of possible skin interactions.

Looking at the code, it seems that semTake should return an error when
called from an ISR, and semGive should work when called from an ISR, for
semaphores created with semBCreate or semCCreate, but not for those
created with semMCreate. 

But there is an issue with wind_errnoset not checking whether the value
returned by wind_current_task is not NULL, this should explain the
segfault, but will not be make semTake work from an ISR.

Could you check whether the attached patch removes the segfault ?

It should applied to the vxworks skin defs.h file; its location depends
on the Xenomai branch you are using.

-- 


					    Gilles Chanteperdrix.

--rJFwV9PlVZ
Content-Type: text/plain
Content-Disposition: inline;
	filename="wind_errnoset.diff"
Content-Transfer-Encoding: 7bit

Index: defs.h
===================================================================
--- defs.h	(revision 153)
+++ defs.h	(working copy)
@@ -55,7 +55,11 @@
 {                                                                       \
     if(!xnpod_asynch_p() &&                                             \
        xnthread_test_flags(xnpod_current_thread(), IS_WIND_TASK))       \
-        wind_current_task()->errorStatus = value;                       \
+        {                                                               \
+        wind_task_t *_cur = wind_current_task();                        \
+        if (_cur)                                                       \
+            _cur->errorStatus = value;                                  \
+        }                                                               \
 } while(0)
 
 

--rJFwV9PlVZ--

