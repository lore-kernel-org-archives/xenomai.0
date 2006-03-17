Message-ID: <441AD867.8070506@domain.hid>
Date: Fri, 17 Mar 2006 16:40:23 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] VxWorks skin improvement
References: <1142608418.28368.256877984@domain.hid>
In-Reply-To: <1142608418.28368.256877984@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Alessandro Pittaluga <xpit@domain.hid>
Cc: xenomai@xenomai.org, xenomai@xenomai.org

Alessandro Pittaluga wrote:
> Philippe, 
> Here follow some tests carried on by my SW lab.
> Hoping this may help.
>

It does, and confirms the other inputs I've had recently on these issues.

Ok, problem solved. Thanks to everyone who helped out.

> Regards
> 
> Alessandro
> 
> ANSWER 1
> As shown below calling taskName with a null argument will return the
> same result returned by taskName called with the return value of
> taskIdSelf().
> 	OUTPUT:
> 	Spawned task xeno_test taskId=0x01a59a48
> 	    This is task_entry_pnt() of task 0x01a59a48
>         	taskName(0)=xeno_test  taskName(taskIdSelf())=xeno_test
>         	taskName(0x01a59a48)=xeno_test
> 
> 
> ANSWER 2
> MSG_PRI_NORMAL is defined 0 and MSG_PRI_URGENT is defined 1. It seems
> that all non 0 priority
> messages are managed as urgent. The first message extracted from the
> queue by a receiver is
> the last inserted into the queue with a non 0 priority.
> The following 7 cases show the calling sequence of a sending task and
> the received message
> lengths of a receiving task.
> 
> CASE 1
> 	[Sending task]: [msgQSend(qid,"a"         , 1, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 	[Sending task]: [msgQSend(qid,"ab"        , 2, NO_WAIT, MSG_PRI_URGENT)] returned OK
> 	[Sending task]: [msgQSend(qid,"abc"       , 3, NO_WAIT, 2)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcd"      , 4, NO_WAIT, 3)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcde"     , 5, NO_WAIT, 4)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdef"    , 6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefg"   , 7, NO_WAIT, 6)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  , 8, NO_WAIT, 7)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefghi" , 9, NO_WAIT, 8)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefghij",10, NO_WAIT, 9)] returned OK
> 
> 	[Receiving task]: Received 10 bytes from queue
> 	[Receiving task]: Received  9 bytes from queue
> 	[Receiving task]: Received  8 bytes from queue
> 	[Receiving task]: Received  7 bytes from queue
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  5 bytes from queue
> 	[Receiving task]: Received  4 bytes from queue
> 	[Receiving task]: Received  3 bytes from queue
> 	[Receiving task]: Received  2 bytes from queue
> 	[Receiving task]: Received  1 bytes from queue
> 
> CASE 2
> 	[Sending task]: [msgQSend(qid,"abcdefghij",10, NO_WAIT, 9)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefghi" , 9, NO_WAIT, 8)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  , 8, NO_WAIT, 7)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefg"   , 7, NO_WAIT, 6)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdef"    , 6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcde"     , 5, NO_WAIT, 4)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcd"      , 4, NO_WAIT, 3)] returned OK
> 	[Sending task]: [msgQSend(qid,"abc"       , 3, NO_WAIT, 2)] returned OK
> 	[Sending task]: [msgQSend(qid,"ab"        , 2, NO_WAIT, MSG_PRI_URGENT)] returned OK
> 	[Sending task]: [msgQSend(qid,"a"         , 1, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 
> 	[Receiving task]: Received  2 bytes from queue
> 	[Receiving task]: Received  3 bytes from queue
> 	[Receiving task]: Received  4 bytes from queue
> 	[Receiving task]: Received  5 bytes from queue
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  7 bytes from queue
> 	[Receiving task]: Received  8 bytes from queue
> 	[Receiving task]: Received  9 bytes from queue
> 	[Receiving task]: Received 10 bytes from queue
> 	[Receiving task]: Received  1 bytes from queue
> 
> CASE 3
> 	[Sending task]: [msgQSend(qid,"abcdef"    ,6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  ,8, NO_WAIT, 7)] returned OK
> 
> 	[Receiving task]: Received  8 bytes from queue
> 	[Receiving task]: Received  6 bytes from queue
> 
> CASE 4
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  ,8, NO_WAIT, 7)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdef"    ,6, NO_WAIT, 5)] returned OK
> 
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  8 bytes from queue
> 
> CASE 5
> 	[Sending task]: [msgQSend(qid,"abcdef"    ,6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"a"         ,1, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  ,8, NO_WAIT, 7)] returned OK
> 
> 	[Receiving task]: Received  8 bytes from queue
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  1 bytes from queue
> 
> CASE 6
> 	[Sending task]: [msgQSend(qid,"abcdef"    ,6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"a"         ,1, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 	[Sending task]: [msgQSend(qid,"ab"        ,2, NO_WAIT,-1)] returned OK
> 
> 	[Receiving task]: Received  2 bytes from queue
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  1 bytes from queue
> 
> CASE 7
> 	[Sending task]: [msgQSend(qid,"abcdef"    ,6, NO_WAIT, 5)] returned OK
> 	[Sending task]: [msgQSend(qid,"a"         ,1, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 	[Sending task]: [msgQSend(qid,"abcdefgh"  ,8, NO_WAIT, MSG_PRI_NORMAL)] returned OK
> 	
> 	[Receiving task]: Received  6 bytes from queue
> 	[Receiving task]: Received  1 bytes from queue
> 	[Receiving task]: Received  8 bytes from queue
> 
> ANSWER 3
> Calling taskInit() with invalid flags won't return any error code.
> 
> SPAWN:  taskInit(&tcb, "xeno_test3", 113, 0xffffffff,
> stack+TASK_STACK_SIZE, 
> 		 TASK_STACK_SIZE, (FUNCPTR)task_entry_pnt, 0,0,0,0,0,0,0,0,0,0)
> INFO:   taskInfoGet((int)&tcb, &td)  ---> td.td_options = 0xffffffff
> 
> The ti funcion returns the following outoput
> -> ti "xeno_test3"
> 
>   NAME        ENTRY       TID    PRI   STATUS      PC       SP     ERRNO
>    DELAY
> ---------- ------------ -------- --- ---------- -------- --------
> ------- -----
> xeno_test3 task_entry_p  1b66090 113 SUSPEND      1969f8  1b6a250      
> 0     0
> 
> stack: base 0x1b6a290  end 0x1b66290  size 16104  high   ???  margin  
> ???
> 
> options: 0xffffffff
> VX_SUPERVISOR_MODE  VX_UNBREAKABLE      VX_DEALLOC_STACK    VX_FP_TASK  
>        VX_STDIO            VX_ADA_DEBUG        VX_FORTRAN         
> VX_PRIVATE_ENV     VX_NO_STACK_FILL
> 
> 
> 


-- 

Philippe.

