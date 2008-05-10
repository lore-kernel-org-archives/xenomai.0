Message-ID: <4826058B.4090103@domain.hid>
Date: Sat, 10 May 2008 22:28:59 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <4e888e043f64dd610bf15a02a955a84b@domain.hid>
In-Reply-To: <4e888e043f64dd610bf15a02a955a84b@domain.hid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] VxWorks skin problem concerning WIND_TCB
	structure
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: matthieu.connaulte_xenomai@domain.hid
Cc: xenomai@xenomai.org

Matthieu wrote:
> I’m currently porting a VxWorks Application in SuSE Linux patched with
> Xenomai. I encounter some problems with the taskLib.h emulation. Indeed,
> I’ve got an error concerning WIND_TCB structure. I think that not the
> whole structure is implemented or maybe it’s implemented by Xenomai
> Native API and not VxWorks skin.
>

Implementing the whole WIND_TCB structure is out of scope. Most of the fields
you attempt to access in your app are dependent on the VxWorks innards, which is
meaningless in an emulation environment. You can emulate the others (or their
meaning) fairly easily (e.g. pStackBase and status).

> Here are extracts of Code.c:
>  #include <vxworks/vxworks.h>
>  WIND_TCB * pTcb;
>  pTcb->entry
>  pTcb->lockCnt
>  pTcb->pSignalInfo->sigt_blocked
>  pTcb->pStackBase 
>  … 
> 
> Here are the errors:
>  Code.c:270: warning: implicit declaration of function ‘taskTcb’ 
>  Code.c:270: warning: assignment makes pointer from integer without a cast 
>  Code.c:286: error: ‘WIND_TCB’ has no member named ‘entry’ 
>  Code.c:292: error: ‘WIND_TCB’ has no member named ‘entry’ 
>  Code.c:315: error: ‘WIND_TCB’ has no member named ‘lockCnt’ 
>  Code.c:324: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’ 
>  Code.c:339: error: ‘WIND_TCB’ has no member named ‘pStackBase’ 
>  Code.c:474: warning: assignment makes pointer from integer without a cast 
>  Code.c:492: error: ‘WIND_TCB’ has no member named ‘safeCnt’ 
>  Code.c:493: warning: implicit declaration of function ‘TASK_UNSAFE’ 
>  Code.c:511: warning: implicit declaration of function ‘intLock’ 
>  Code.c:512: error: ‘WIND_TCB’ has no member named ‘safeCnt’ 
>  Code.c:513: error: ‘WIND_TCB’ has no member named ‘status’ 
>  Code.c:513: error: ‘WIND_READY’ undeclared (first use in this
> function) 
>  Code.c:513: error: (Each undeclared identifier is reported only once 
>  Code.c:513: error: for each function it appears in.) 
>  Code.c:513: error: ‘WIND_TCB’ has no member named ‘lockCnt’
>  Code.c:517: warning: implicit declaration of function ‘intUnlock’
>  Code.c:519: error: ‘taskIdCurrent’ undeclared (first use in this
> function)
>  Code.c:522: error: ‘WIND_TCB’ has no member named ‘safeCnt’
>  Code.c:523: error: ‘WIND_TCB’ has no member named ‘lockCnt’
>  Code.c:525: warning: implicit declaration of function ‘Q_FIRST’
>  Code.c:525: error: ‘WIND_TCB’ has no member named ‘safetyQHead’
>  Code.c:525: warning: comparison between pointer and integer
>  Code.c:526: warning: implicit declaration of function ‘windPendQFlush’
>  Code.c:526: error: ‘WIND_TCB’ has no member named ‘safetyQHead’
>  Code.c:532: warning: implicit declaration of function ‘windPendQPut’
>  Code.c:532: error: ‘WIND_TCB’ has no member named ‘safetyQHead’
>  Code.c:553: warning: implicit declaration of function ‘TASK_ID_VERIFY’
>  Code.c:566: warning: implicit declaration of function ‘TASK_SAFE’
>  Code.c:578: error: ‘WIND_TCB’ has no member named ‘pTaskVar’
>  Code.c:579: error: ‘WIND_TCB’ has no member named ‘pTaskVar’
>  Code.c:583: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’
>  Code.c:620: error: ‘WIND_TCB’ has no member named ‘pStackBase’
>  Code.c:638: error: ‘WIND_TCB’ has no member named ‘options’
>  Code.c:644: warning: implicit declaration of function ‘taskRestart’
>  Code.c:654: error: ‘WIND_TCB’ has no member named ‘pTaskVar’
>  Code.c:658: error: invalid application of ‘sizeof’ to incomplete type
> ‘struct sigtcb’
>  Code.c:659: error: ‘_NSIGS’ undeclared (first use in this function)
>  Code.c:660: error: dereferencing pointer to incomplete type
>  Code.c:660: error: dereferencing pointer to incomplete type
>  Code.c:660: error: dereferencing pointer to incomplete type
>  Code.c:667: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’
>  Code.c:876: warning: suggest explicit braces to avoid ambiguous ‘else’
>  Code.c: In function ‘sigTcbPut’:
>  Code.c:994: warning: implicit declaration of function ‘INT_RESTRICT’
>  Code.c:997: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’
>  Code.c:998: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’
>  Code.c:1000: warning: implicit declaration of function
> ‘taskStackAllot’
>  Code.c:1001: error: invalid application of ‘sizeof’ to incomplete type
> ‘struct sigtcb’
>  Code.c:1008: error: ‘WIND_TCB’ has no member named ‘pSignalInfo’
>  Code.c:1009: error: invalid application of ‘sizeof’ to incomplete type
> ‘struct sigtcb’
>  Code.c:1011: error: ‘_NSIGS’ undeclared (first use in this function)
>  Code.c:1012: error: dereferencing pointer to incomplete type
>  Code.c:1012: error: dereferencing pointer to incomplete type 
>  Code.c:1013: error: dereferencing pointer to incomplete type What are my
> issues?
> 
> Thanks in advance 
> 
> 
> 
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help


-- 
Philippe.

