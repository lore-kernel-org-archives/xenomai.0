Message-ID: <4357722D.60305@domain.hid>
Date: Thu, 20 Oct 2005 12:32:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200510192218.35921.dmitry.adamushko@domain.hid>
In-Reply-To: <200510192218.35921.dmitry.adamushko@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] Re: [Patch] Anonymous (NULL-named) objects from
	user-space
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Dmitry Adamushko <dmitry.adamushko@domain.hid>
Cc: dmitry.adamushko@domain.hid, xenomai@xenomai.org

Dmitry Adamushko wrote:
> Hi,
> 
> anonymous objects (name == NULL) from user-space get registered under unique 
> names, - which is a string representation of the object's kernel-space 
> address, - but remain not-exported via the /proc interface.
> 

Applied (fixing the comment), thanks.

> Not tested with the all objects yet (well, I have upgraded the system, a 
> compiler in particular err..., so I cannot load the recently rebuilt xeno_* 
> modules at the moment), but the changes are not intrusive so everything 
> should work as expected.
> 

Should be ok.

> 
> ---
> Best regards,
> Dmitry
> 
> 
> ------------------------------------------------------------------------
> 
> --- types.h	2005-10-19 20:59:21.000000000 +0200
> +++ types2.h	2005-10-19 21:07:44.000000000 +0200
> @@ -91,6 +91,12 @@
>  	*dst = '\0';
>  }
>  
> +static inline int xnobject_create_name(
> +		    char *dst, size_t n, void *obj)
> +{
> +    return snprintf(dst, n, "%p", obj);
> +}
> +
>  #define minval(a,b) ((a) < (b) ? (a) : (b))
>  #define maxval(a,b) ((a) > (b) ? (a) : (b))
>  
> 
> 
> ------------------------------------------------------------------------
> 
> diff -ur native/alarm.c native2/alarm.c
> --- native/alarm.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/alarm.c	2005-10-19 21:14:59.000000000 +0200
> @@ -208,9 +208,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(alarm->name,alarm,&alarm->handle,&__alarm_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__alarm_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(alarm->name,sizeof(alarm->name),(void*)alarm);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(alarm->name,alarm,&alarm->handle,pnode);
>  
>          if (err)
>              rt_alarm_delete(alarm);
> diff -ur native/cond.c native2/cond.c
> --- native/cond.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/cond.c	2005-10-19 21:15:07.000000000 +0200
> @@ -168,9 +168,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(cond->name,cond,&cond->handle,&__cond_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__cond_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(cond->name,sizeof(cond->name),(void*)cond);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(cond->name,cond,&cond->handle,pnode);
>  
>          if (err)
>              rt_cond_delete(cond);
> diff -ur native/event.c native2/event.c
> --- native/event.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/event.c	2005-10-19 21:15:11.000000000 +0200
> @@ -190,9 +190,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(event->name,event,&event->handle,&__event_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__event_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(event->name,sizeof(event->name),(void*)event);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(event->name,event,&event->handle,pnode);
>  
>          if (err)
>              rt_event_delete(event);
> diff -ur native/heap.c native2/heap.c
> --- native/heap.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/heap.c	2005-10-19 21:17:42.000000000 +0200
> @@ -287,9 +287,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(heap->name,heap,&heap->handle,&__heap_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__heap_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(heap->name,sizeof(heap->name),(void*)heap);
> +	    pnode = NULL;
> +	    }
> +
> +        err = rt_registry_enter(heap->name,heap,&heap->handle,pnode);
>  
>          if (err)
>              rt_heap_delete(heap);
> diff -ur native/mutex.c native2/mutex.c
> --- native/mutex.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/mutex.c	2005-10-19 21:09:00.000000000 +0200
> @@ -181,9 +181,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(mutex->name,mutex,&mutex->handle,&__mutex_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__mutex_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(mutex->name,sizeof(mutex->name),(void*)mutex);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(mutex->name,mutex,&mutex->handle,pnode);
>  
>          if (err)
>              rt_mutex_delete(mutex);
> diff -ur native/pipe.c native2/pipe.c
> --- native/pipe.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/pipe.c	2005-10-19 21:22:42.000000000 +0200
> @@ -257,9 +257,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(pipe->name,pipe,&pipe->handle,&__pipe_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__pipe_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(pipe->name,sizeof(pipe->name),(void*)pipe);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(pipe->name,pipe,&pipe->handle,pnode);
>  
>          if (err)
>              rt_pipe_delete(pipe);
> diff -ur native/queue.c native2/queue.c
> --- native/queue.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/queue.c	2005-10-19 21:24:51.000000000 +0200
> @@ -281,9 +281,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(q->name,q,&q->handle,&__queue_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__queue_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(q->name,sizeof(q->name),(void*)q);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(q->name,q,&q->handle,pnode);
>  
>          if (err)
>              rt_queue_delete(q);
> diff -ur native/sem.c native2/sem.c
> --- native/sem.c	2005-10-10 19:15:08.000000000 +0200
> +++ native2/sem.c	2005-10-19 21:26:47.000000000 +0200
> @@ -193,9 +193,19 @@
>         complete objects, so that the registry cannot return handles to
>         half-baked objects... */
>  
> -    if (name && *name)
> +    if (name)
>          {
> -        err = rt_registry_enter(sem->name,sem,&sem->handle,&__sem_pnode);
> +	RT_OBJECT_PROCNODE *pnode = &__sem_pnode;
> +	
> +	if (!*name)
> +	    {
> +	    /* Since this is an anonymous object (NULL-named) from user-space,
> +	       it gets registratred under an unique name but remains not-exported via /proc */
> +	    xnobject_create_name(sem->name,sizeof(sem->name),(void*)sem);
> +	    pnode = NULL;
> +	    }
> +	    
> +        err = rt_registry_enter(sem->name,sem,&sem->handle,pnode);
>  
>          if (err)
>              rt_sem_delete(sem);


-- 

Philippe.

