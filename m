References: <CGME20180130002607epcas2p15e106753c180b0e90d445b3b1d0c4b70@epcas2p1.samsung.com>
 <1517272015-6274-1-git-send-email-jy0922.shim@samsung.com>
 <32c7375e-bc97-e629-3179-4737cd192f74@siemens.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <79c7ef15-c44c-5194-1693-74055f859377@xenomai.org>
Date: Tue, 30 Jan 2018 10:58:40 +0100
MIME-Version: 1.0
In-Reply-To: <32c7375e-bc97-e629-3179-4737cd192f74@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rtnet/tdma: fix lockup issue
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>, Joonyoung Shim <jy0922.shim@samsung.com>, xenomai@xenomai.org

On 01/30/2018 07:59 AM, Jan Kiszka wrote:
> On 2018-01-30 01:26, Joonyoung Shim wrote:
>> Sometimes the kernel lockup occurs with "rtifconfig rteth0 down" command
>> execution on TDMA slave.
>>
>> [525182.648366] INFO: rcu_sched detected stalls on CPUs/tasks:
>> [525182.648372] 	7-...: (0 ticks this GP) idle=415/140000000000000/0 softirq=1249048/1249048 fqs=6628
>> [525182.648374] 	(detected by 0, t=15002 jiffies, g=2145322, c=2145321, q=131873)
>> [525182.648376] Task dump for CPU 7:
>> [525182.648377] rtifconfig      R  running task        0 24290  24278 0x0000000c
>> [525182.648381]  0000000000000000 ffff888b9ede5640 0000000000000001 ffff8888a35bbc00
>> [525182.648384]  ffff888b8be78000 ffffb20f8413bc10 ffffffffa446e80d 000000000001aa50
>> [525182.648387]  ffff888b9ede5480 ffffb20f8413bc50 ffffffffa459720d ffff888b88510440
>> [525182.648390] Call Trace:
>> [525182.648395]  [<ffffffffa446e80d>] ? xnarch_switch_to+0x5d/0xa0
>> [525182.648398]  [<ffffffffa459720d>] ___xnsched_run.part.64+0x1ed/0x390
>> [525182.648400]  [<ffffffffa4597af3>] __xnsched_run_handler+0xc3/0xe0
>> [525182.648402]  [<ffffffffa453618c>] __ipipe_do_sync_stage+0xdc/0x170
>> [525182.648404]  [<ffffffffa45362c3>] __ipipe_do_sync_pipeline+0x33/0x90
>> [525182.648405]  [<ffffffffa453638d>] __ipipe_restore_head+0x6d/0xb0
>> [525182.648407]  [<ffffffffa45a5648>] __rtdm_synch_flush+0xf8/0x130
>> [525182.648410]  [<ffffffffa45a5781>] rtdm_event_destroy+0x21/0x70
>> [525182.648412]  [<ffffffffc0961cdb>] tdma_detach+0x1b/0x100 [tdma]
>> [525182.648415]  [<ffffffffc0956044>] rtmac_disc_detach+0x44/0xd0 [rtmac]
>> [525182.648418]  [<ffffffffc091f5f8>] rtnet_core_ioctl+0x2b8/0x490 [rtnet]
>> [525182.648421]  [<ffffffffc091f2f3>] rtnet_ioctl+0x103/0x150 [rtnet]
>> [525182.648423]  [<ffffffffa466cee1>] do_vfs_ioctl+0xa1/0x5d0
>> [525182.648425]  [<ffffffffa4668ac4>] ? putname+0x54/0x60
>> [525182.648426]  [<ffffffffa466d489>] SyS_ioctl+0x79/0x90
>> [525182.648429]  [<ffffffffa4c73257>] entry_SYSCALL_64_fastpath+0x16/0x1b
>>
>> It is suspected of causing the lockup that the sync_event used in the
>> task is destroyed in advance before the task is destroyed.
>>
>> Fixes: bd971c3a9624 ("rtnet: adapt to RTDM task management changes")
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>>  kernel/drivers/net/stack/rtmac/tdma/tdma_module.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
>> index e367d21..854a996 100644
>> --- a/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
>> +++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_module.c
>> @@ -227,14 +227,14 @@ int tdma_detach(struct rtnet_device *rtdev, void *priv)
>>      struct tdma_job     *job, *tmp;
>>  
>>  
>> +    rtdm_task_destroy(&tdma->worker_task);
>> +
>>      rtdm_event_destroy(&tdma->sync_event);
>>      rtdm_event_destroy(&tdma->xmit_event);
>>      rtdm_event_destroy(&tdma->worker_wakeup);
>>  
>>      tdma_dev_release(tdma);
>>  
>> -    rtdm_task_destroy(&tdma->worker_task);
>> -
>>      list_for_each_entry_safe(job, tmp, &tdma->first_job->entry, entry) {
>>  	if (job->id >= 0)
>>  	    tdma_cleanup_slot(tdma, SLOT_JOB(job));
>>
> 
> That used to work properly: The rtdm_event_destroy call would have woken
> up the worker thread when blocked on the events, they detected the
> destruction and terminated themselves.
> 
> Philippe, did something related change when mapping RTDM on Xenomai 3?
> I'm seeing in bd971c3a9624 some other places in RTnet that were
> reordered in the way like above, but I'm not finding a reference in the
> migration guide Xenomai 2->3.
> 
> Jan
> 

For the original scheme to work reliably, I would have added this:

diff --git a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
b/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
index ad29d5dab..d21cdb5f6 100644
--- a/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
+++ b/kernel/drivers/net/stack/rtmac/tdma/tdma_worker.c
@@ -189,7 +189,9 @@ void tdma_worker(void *arg)
         switch (job->id) {
             case WAIT_ON_SYNC:
                 rtdm_lock_put_irqrestore(&tdma->lock, lockctx);
-                rtdm_event_wait(&tdma->sync_event);
+                ret = rtdm_event_wait(&tdma->sync_event);
+		if (ret == -EIDRM)
+			return;
                 rtdm_lock_get_irqsave(&tdma->lock, lockctx);
                 break;

AFAIU, the cancellation request is issued on behalf of a regular linux
context calling a discipline detach handler, which originally led to the
following sequence with v2:

[detach_handler] xnsynch_destroy(&sync_event)
                       xnsynch_flush(&sync_event, XNRMID)
                       release event resources
[tdma_worker]    back from rtdm_event_wait() => -ERMID
[tdma_worker]    back sleeping on rtdm_event_wait()
[detach_handler] rtdm_task_destroy(&tdma_worker)
                       xnpod_delete_thread(&tdma_worker)
                           <rip sleeping tdma_worker out of sched>

Now that v3 rt threads are normal kthreads on steroids,
rtdm_task_destroy() sends a cancellation request, but may not forcibly
rip the canceled thread out of the scheduler like in v2. It has to wait
for the latter to notice the pending request then act upon it, i.e.
exit. So the new sequence is as follows:

[detach_handler] xnsynch_destroy(&sync_event)
                       xnsynch_flush(&sync_event, XNRMID)
                       release event resources
[tdma_worker]    back from rtdm_event_wait() => -ERMID
[tdma_worker]    back sleeping on rtdm_event_wait()
[detach_handler] rtdm_task_destroy(&tdma_worker)
                       raise cancellation flag
                       xnthread_resume(&tdma_worker)
[tdma_worker]    ## tread on stale sync_event memory ##

Moving rtdm_task_destroy() before the event deletion call fixes the
issue with v3, since the former is synchronized, returning to the caller
only when the task traverses a cancellation point, honoring the
cancellation request and therefore exiting.

This said, it seems a good idea to first stop the worker before dropping
any resources it may use. An entry about the change in semantics of
rtdm_task_destroy() in the migration guide may indeed help.

-- 
Philippe.

