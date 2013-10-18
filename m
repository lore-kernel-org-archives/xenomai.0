Message-ID: <5261324E.9090200@xenomai.org>
Date: Fri, 18 Oct 2013 15:06:22 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
In-Reply-To: <patchbomb.1382100607@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0 of 2] Xenomai-forge thread_obj: unset
 __THREAD_S_SAFE when not needed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 10/18/2013 02:50 PM, Kim De Mey wrote:
> Hello list,
>
> I believe that there is a problem in xenomai-forge when you create tasks
> from within another task and the newly created tasks have a lower
> priority than the priority of the task where you created them from.
>
> In the threadobj_start() function the thobj->status is set to
> __THREAD_S_STARTED|__THREAD_S_SAFE. After this there is a check if the
> thobj priority is lower or equal to the current thobj priority. If that
> is the case, it will return there. If it is not the case,
> synchronization needs to be done.
>
> As far as I understand the code, however, I think that the
> __THREAD_S_SAFE is only set there because you don't want the
> finalize_thread to already clean up the thobj in case you are still
> waiting for the synchronization in the threadobj_start(). Correct?
> If so then this is where I think there is a problem. In case that you
> don't need to wait for the synchronization and return already before it,
> the __THREAD_S_SAFE is set but never unset. This has as result that in
> the finalize_thread() (on deletion) the destroy_thread() function will
> not be called, which has as consequence that proper clean up is not
> done. The first patch should fix this.
>

Ack. Thanks for spotting this. The patch below should fix it the same 
way, avoiding the additional bit toggling.

diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
index 8aff287..a283b22 100644
--- a/lib/copperplate/threadobj.c
+++ b/lib/copperplate/threadobj.c
@@ -926,7 +926,7 @@ int threadobj_start(struct threadobj *thobj)	/* 
thobj->lock held. */
  	if (thobj->status & __THREAD_S_STARTED)
  		return 0;

-	thobj->status |= __THREAD_S_STARTED|__THREAD_S_SAFE;
+	thobj->status |= __THREAD_S_STARTED;
  	__RT(pthread_cond_signal(&thobj->barrier));

  	if (current && thobj->priority <= current->priority)
@@ -943,6 +943,7 @@ int threadobj_start(struct threadobj *thobj)	/* 
thobj->lock held. */
  	 */
  	pthread_setcancelstate(PTHREAD_CANCEL_DISABLE, &oldstate);

+	thobj->status |= __THREAD_S_SAFE;
  	wait_on_barrier(thobj, __THREAD_S_ACTIVE);
  	thobj->status &= ~__THREAD_S_SAFE;

-- 
Philippe.

