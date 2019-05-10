Subject: Re: select() unblocks when no data to read()
References: <VpFdLbJqKpBKdxuwpEr9vxR2VBu2j4uXIps1EM68ktxueh7Q9bRQeHRA56sFDKeY1xbPcvb6TuGG01MVtxNt03OdF6N1b3YIEPjJnzbRjqk=@codecraftsmen.org>
 <CALLqZ8TJt66aooCz+wCFhg_k3+xwoQ6BFqc+7TvFtA+Au71zzw@mail.gmail.com>
 <Wc_l4MYuhmN-h0Z9zuurZ_MxUaMovQA6xNvZE6EMmf7-zD8ZywQlT_X6AovXAczK01iesjy5RdARBztqwtsVxOhOBSgF3CNpXy2z8lpjU-g=@codecraftsmen.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <5dbf6ceb-950a-ac49-2331-b6fe54fa0808@xenomai.org>
Date: Fri, 10 May 2019 10:24:17 +0200
MIME-Version: 1.0
In-Reply-To: <Wc_l4MYuhmN-h0Z9zuurZ_MxUaMovQA6xNvZE6EMmf7-zD8ZywQlT_X6AovXAczK01iesjy5RdARBztqwtsVxOhOBSgF3CNpXy2z8lpjU-g=@codecraftsmen.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jeff Webb <w1@codecraftsmen.org>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 5/10/19 3:26 AM, Jeff Webb via Xenomai wrote:
> 
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Thursday, May 9, 2019 9:19 AM, Greg Gallagher <greg@embeddedgreg.com> wrote:
> 
>> On Tue, May 7, 2019 at 9:54 PM Jeff Webb via Xenomai
>> xenomai@xenomai.org wrote:
>>
>>> I am having trouble using select() to perform a timed wait on a UDD file descriptor to detect interrupts from a custom PCI card. After some searching, I came across this thread from 2017 that describes my exact issue:
>>> https://xenomai.org/pipermail/xenomai/2017-July/037494.html
>>> I am using x86-64 instead of ARM, but I am having the same trouble. The original poster did a great job of describing the problem, so I won't repeat it. If I use only read() without select(), things work as expected, but I need to implement a timeout.
>>> It sounds like Philippe was going to look into the issue further. Has any progress on this issue been made since the last post in this thread?
>>> Thanks,
>>> -Jeff Webb
>>
>> There was a fix posted to the list a while ago but it wasn't a patch
>> it was the whole c file. I don't think a patch was ever made, I'll
>> see if I can dig it up.
> 
> Thanks for looking into it, Greg.  I must have missed that post.  The original poster's solution of adding this line:
> 
>   rtdm_event_clear(&ur->pulse);
> 
> just before the return statement in udd_read_rt() is working for me.  Philippe mentioned that this might be racy, but maybe it's okay (or maybe not?) if there are no shared interrupts and interrupts are unmasked by the userspace application after the read completes.
> 

There is a logic flaw on entry to read_rt, when an interrupt already occurred before we consider waiting for the next one; in that case, the selector block is not reset as it should, which would explain why you get those spurious select() events. Could you try the following change?

Thanks,

diff --git a/include/cobalt/kernel/rtdm/udd.h b/include/cobalt/kernel/rtdm/udd.h
index 550ba9d24..bc2a68db6 100644
--- a/include/cobalt/kernel/rtdm/udd.h
+++ b/include/cobalt/kernel/rtdm/udd.h
@@ -306,7 +306,7 @@ struct udd_device {
 	/** Reserved to the UDD core. */
 	struct udd_reserved {
 		rtdm_irq_t irqh;
-		atomic_t event;
+		u32 event_count;
 		struct udd_signotify signfy;
 		struct rtdm_event pulse;
 		struct rtdm_driver driver;
diff --git a/kernel/drivers/udd/udd.c b/kernel/drivers/udd/udd.c
index 972db1225..b086096cc 100644
--- a/kernel/drivers/udd/udd.c
+++ b/kernel/drivers/udd/udd.c
@@ -117,7 +117,8 @@ static ssize_t udd_read_rt(struct rtdm_fd *fd,
 	struct udd_context *context;
 	struct udd_reserved *ur;
 	struct udd_device *udd;
-	ssize_t ret;
+	rtdm_lockctx_t ctx;
+	ssize_t ret = 0;
 	u32 count;
 
 	if (len != sizeof(count))
@@ -130,15 +131,20 @@ static ssize_t udd_read_rt(struct rtdm_fd *fd,
 	ur = &udd->__reserved;
 	context = rtdm_fd_to_private(fd);
 
-	for (;;) {
-		if (atomic_read(&ur->event) != context->event_count)
-			break;
+	cobalt_atomic_enter(ctx);
+
+	if (ur->event_count != context->event_count)
+		rtdm_event_clear(&ur->pulse);
+	else
 		ret = rtdm_event_wait(&ur->pulse);
-		if (ret)
-			return ret;
-	}
 
-	count = atomic_read(&ur->event);
+	count = ur->event_count;
+
+	cobalt_atomic_leave(ctx);
+
+	if (ret)
+		return ret;
+
 	context->event_count = count;
 	ret = rtdm_copy_to_user(fd, buf, &count, sizeof(count));
 
@@ -404,7 +410,7 @@ int udd_register_device(struct udd_device *udd)
 	} else
 		ur->mapper_name = NULL;
 
-	atomic_set(&ur->event, 0);
+	ur->event_count = 0;
 	rtdm_event_init(&ur->pulse, 0);
 	ur->signfy.pid = -1;
 
@@ -501,12 +507,15 @@ void udd_notify_event(struct udd_device *udd)
 {
 	struct udd_reserved *ur = &udd->__reserved;
 	union sigval sival;
+	rtdm_lockctx_t ctx;
 
-	atomic_inc(&ur->event);
+	cobalt_atomic_enter(ctx);
+	ur->event_count++;
 	rtdm_event_signal(&ur->pulse);
+	cobalt_atomic_leave(ctx);
 
 	if (ur->signfy.pid > 0) {
-		sival.sival_int = atomic_read(&ur->event);
+		sival.sival_int = (int)ur->event_count;
 		__cobalt_sigqueue(ur->signfy.pid, ur->signfy.sig, &sival);
 	}
 }

-- 
Philippe.

