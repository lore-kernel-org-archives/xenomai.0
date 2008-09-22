From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Mon, 22 Sep 2008 21:45:22 +0200
References: <200809212234.06587.niklaus.giger@domain.hid>
	<48D7C506.8000109@domain.hid>
In-Reply-To: <48D7C506.8000109@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200809222145.23158.niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core]
 =?iso-8859-1?q?xenomai-solo_vxWorks=3A_know_whethe?=
 =?iso-8859-1?q?r_a_task_is_safe_or=09not?=
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-core <xenomai@xenomai.org>

Am Montag 22 September 2008 18.17:10 schrieb Philippe Gerum:
> Niklaus Giger wrote:
> > Hi
> >
> > For various reasons we were forced to examine under vxWorks 5.5 the
> > private WIND_TCB safeCnt field to determine whether a task was "safe" or
> > not.
> >
> > With the attached patch I try to add a taskIsSafe procedure to
> > xenomai-solo. It is probably not free from race condition, as I do not
> > know how to access a pthread_mutex.
> >
> > Would such (may be improved) patch find its way into the "official"
> > trunk?
>
> Assuming that VxWorks tracks the locking depth in safeCnt, that
> implementation would not properly account for nested locking (safelock is a
> recursive mutex). Additionally, since WIND_TCB is something of a
> semi-public structure in 5.x and earlier versions, we could just track the
> safe counter there as well, instead of adding a non-standard taskIsSafe()
> call; we already do that for the status field anyway. Here is a possible
> implementation:

This implementation is okay for me, too. It seems to work, as far I could
test it.

I however still have some issues because we used sometimes (for historical 
reasons in order to emulate a pre-vxWorks home grown cooperative mulit-tasking 
operation system) a taskInit/taskActivate/taskRestart combination. 

Would it be a lot of work for you to add taskRestart to xenomai-solo?

Best regards

Niklaus 

> diff --git a/include/vxworks/taskLib.h b/include/vxworks/taskLib.h
> index 510dabb..6334396 100644
> --- a/include/vxworks/taskLib.h
> +++ b/include/vxworks/taskLib.h
> @@ -49,6 +49,7 @@ typedef struct WIND_TCB {
>  	void *opaque;
>  	int magic;
>  	int status;
> +	int safeCnt;
>  	int flags;
>  	FUNCPTR entry;
>  } WIND_TCB;
> diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
> index f6253b2..a9e12e7 100644
> --- a/vxworks/taskLib.c
> +++ b/vxworks/taskLib.c
> @@ -283,7 +283,6 @@ static STATUS __taskInit(struct wind_task *task,
>  	int ret;
>
>  	ret = check_task_priority(prio);
> -
>  	if (ret) {
>  		errno = ret;
>  		return ERROR;
> @@ -307,6 +306,7 @@ static STATUS __taskInit(struct wind_task *task,
>  	tcb->magic = task_magic;
>  	tcb->opaque = task;
>  	tcb->status = WIND_SUSPEND;
> +	tcb->safeCnt = 0;
>  	tcb->flags = flags;
>  	tcb->entry = entry;
>
> @@ -588,13 +588,13 @@ STATUS taskSafe(void)
>  	}
>
>  	current = wind_task_current();
> -
>  	if (current == NULL) {
>  		errno = S_objLib_OBJ_NO_METHOD;
>  		return ERROR;
>  	}
>
>  	pthread_mutex_lock(&current->safelock);
> +	current->tcb->safeCnt++;
>
>  	return OK;
>  }
> @@ -602,6 +602,7 @@ STATUS taskSafe(void)
>  STATUS taskUnsafe(void)
>  {
>  	struct wind_task *current;
> +	int ret;
>
>  	if (threadobj_async_p()) {
>  		errno = S_intLib_NOT_ISR_CALLABLE;
> @@ -609,13 +610,14 @@ STATUS taskUnsafe(void)
>  	}
>
>  	current = wind_task_current();
> -
>  	if (current == NULL) {
>  		errno = S_objLib_OBJ_NO_METHOD;
>  		return ERROR;
>  	}
>
> -	pthread_mutex_unlock(&current->safelock);
> +	ret = pthread_mutex_unlock(&current->safelock);
> +	if (ret == 0)
> +		current->tcb->safeCnt--;
>
>  	return OK;
>  }

-- 
NIklaus Giger
Wieshoschet 6
CH-8753 Mollis
+41  (0)55 612 20 54 P
+41  (0)55 618 64 68 G

