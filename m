Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867C04C67
	for <xenomai@lists.linux.dev>; Wed, 31 May 2023 06:53:36 +0000 (UTC)
X-GND-Sasl: rpm@xenomai.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xenomai.org; s=gm1;
	t=1685516012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6Xao60y10W9l/OHgPceCbvVqu0S78x+Fe51ssqzYCs=;
	b=MjzT3Q13+MXSBeE74DHYOqbiCtL2TfrvzgAZRfduLQPaQ1eJWmxQfdA/V5k2JZ+uQClXIr
	nYPTmjZieuZ4QoInTG/T0J1nlB17/PPYmuP9U++U/qM8YP/7Wt2DlqjWgG6TTntcLWSx96
	v6e8IKFpRoIP0R3/cw5AiHNNd5Bhk3qlr5JWj4aXZxBfiwu5sIII6Lqh8s2ocwhQ7bhAAv
	jXgyANmMaEbfaqNN0oi1LzhqcOWi9eMe9IQPfLfbXrqzpBWQrNRa9n+9rzdDYeExfHHzGn
	a2LIjpO+hYzaI2NapZYGiJL3X5Efi5j2XLZnPeXy48bjNXAyCe3lFWEZIImIPw==
X-GND-Sasl: rpm@xenomai.org
X-GND-Sasl: rpm@xenomai.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id ED924240003;
	Wed, 31 May 2023 06:53:31 +0000 (UTC)
References: <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
User-agent: mu4e 1.8.11; emacs 28.2
From: Philippe Gerum <rpm@xenomai.org>
To: Dave Rolenc <Dave.Rolenc@kratosdefense.com>
Cc: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>, Russell Johnson
 <russell.johnson@kratosdefense.com>
Subject: Re: [PATCH 0/1] rwsem_down_write_slowpath check if oob() before
 skipping schedule()
Date: Wed, 31 May 2023 08:22:34 +0200
In-reply-to: <e5624d226deb4a49bbe28867e15eadf9@PH1P110MB1666.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <87jzwpxa8l.fsf@xenomai.org>
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain


Dave Rolenc <Dave.Rolenc@kratosdefense.com> writes:

> This fixes a timing-dependent bug that would cause a tight loop without
> schedule() when running in-band. The rwsem would get released enough to
> allow this tight loop without schedule() to execute when the handoff
> bit got set, but it would never allow the previous on-CPU owner to
> finish releasing the rwsem. Checking to see if we are running oob before
> skipping the schedule() seems to fix the problem. This problem was nasty
> when the global kernfs_rwsem was the target semaphore since many tasks
> ended up in D state waiting on the kernfs_rwsem. 
>
> We would typically see this problem when repeatedly starting/stopping an
> EVL-enabled application, which would create and tear-down a lot of EVL
> elements. Eventually, the timing worked out to where we'd get a stuck
> CPU message and a bunch of tasks in D-state waiting on the kernfs_rwsem.
> The cuplrit task was stuck in a forever loop in
> rwsem_down_write_slowpath() with the handoff bit set and skipping the
> schedule() call. 
>
> This patch is based on 5.15.98.
>
> This is also my first patch submission to this group, so if you need me
> to follow some specific procedure or checklist for patch submission,
> please let me know and I'll comply.
>
> Dave Rolenc (1):
>   rwsem_down_write_slowpath check if oob() before skipping schedule()
>
>  kernel/locking/rwsem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Mm, nasty. Thanks for digging into this. What's even worse and the root
cause of that issue is that no task on the oob stage should ever run
rwsem_down_write_slowpath() in the first place. Generally speaking, oob
execution is an NMI-like context, therefore taking regular locks and/or
(re)scheduling is not allowed, which means rwsem_down_write_slowpath()
should not be entered by a task running oob. In other words, Houston
we've had a problem here.

In order to figure out what happened, could you please check whether the
following patch causes a kernel splat when the bug triggers?  We are
trying to find out who calls rwsem_down_write_slowpath() from the wrong
context. The second hunk in this patch is making sure nothing weird
happens due to transitioning from inband to oob context - when Dovetail
is enabled, the tail code of the logic performing such transition lives
in the regular/inband schedule() code, but that should never leak into
the common in-band code.

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index f0287a16b4ec8..12f4956842fdb 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1070,6 +1070,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	struct rwsem_waiter waiter;
 	DEFINE_WAKE_Q(wake_q);
 
+	WARN_ON_ONCE(running_oob());
+
 	/* do optimistic spinning and steal lock if possible */
 	if (rwsem_can_spin_on_owner(sem) && rwsem_optimistic_spin(sem)) {
 		/* rwsem_optimistic_spin() implies ACQUIRE on success */
@@ -1155,6 +1157,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		}
 
 		schedule();
+		WARN_ON_ONCE(running_oob());
 		lockevent_inc(rwsem_sleep_writer);
 		set_current_state(state);
 trylock_again:

-- 
Philippe.
