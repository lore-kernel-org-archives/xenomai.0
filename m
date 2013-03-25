Message-ID: <515072C0.5010607@xenomai.org>
Date: Mon, 25 Mar 2013 16:52:32 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <CAMJ=MEdEOxm2_7_3On9vdzfQq1+5oyqXt+R+5RMPc30u_GNcKw@mail.gmail.com>
In-Reply-To: <CAMJ=MEdEOxm2_7_3On9vdzfQq1+5oyqXt+R+5RMPc30u_GNcKw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-forge: psos skin: t_delete assertion when
 task was not able to run before it is deleted.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Ronny Meeus <ronny.meeus@gmail.com>
Cc: xenomai@xenomai.org

On 03/25/2013 03:16 PM, Ronny Meeus wrote:
> Hello
> 
> I'm doing some more tests related to task creation and deletion.
> The complete testcode is attached to the mail.
> 
> I basically have a task that creates, starts and deletes other tasks in a loop:
> 
>    for (i=0;i<500;i++) {
>      printf("Priority %d\n",i);
>      check("t_create loop3",t_create ("TEST",(i%HIGH_PRIO)+2,100000,0,0,&tid),0);
>      check("t_start loop3",t_start(tid,T_PREEMPT,test_taskcreation_body,args),0);
>      check("t_delete loop3",t_delete(tid),0);
>    }
> 
> If the code above is execute by a task running at priority 1, there is no issue.
> Note that the task that are being created range from prio 2 to 97
> (HIGH_PRIO=95).
> 
> If the task that executes the code is running at a higher priority
> (for example 3), I observe this:
> # taskset 2 ./createdelete.exe
>     0"000.492| WARNING: [main] Xenomai compiled with full debug enabled,
>                                very high latencies expected [--enable-debug=full]
> Priority 0
> createdelete.exe: ../../include/copperplate/threadobj.h:205:
> __threadobj_tag_unlocked: Assertion `thobj->status & 0x20' failed.
> Aborted
> 
> Conclusion is: as soon as a task that is being created/started/deleted
> has a lower priority than the task that creates it, the code crashes
> in t_delete with the assertion above.
>

Sloppy state tracking. Any improvement with this patch?

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 3891536..c9c720f 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -1002,7 +1002,9 @@ static void cancel_sync(struct threadobj *thobj) /* thobj->lock held */
 
 	while (thobj->status & THREADOBJ_WARMUP) {
 		oldstate = thobj->cancel_state;
+		__threadobj_tag_unlocked(thobj);
 		__RT(pthread_cond_wait(&thobj->barrier, &thobj->lock));
+		__threadobj_tag_locked(thobj);
 		thobj->cancel_state = oldstate;
 	}
 
-- 
Philippe.

