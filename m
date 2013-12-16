Message-ID: <52AF4211.80203@siemens.com>
Date: Mon, 16 Dec 2013 19:10:25 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [Xenomai] forge: Trying to understand new semaphore code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

Hi Gilles,

while rebasing my half-done ftrace instrumentation over next, I got
stuck reading nsem_open. Find my questions inline:

> static struct __shadow_sem __user *
> nsem_open(struct __shadow_sem __user *ushadow, const char *name, 
> 	int oflags, mode_t mode, unsigned value)
> {
> 	struct __shadow_sem shadow;
> 	struct cobalt_sem *sem;
> 	struct nsem *u, *v;
> 	xnhandle_t handle;
> 	spl_t s;
> 	int rc;
> 
> 	trace_xn_sys_sem_open(name, oflags, mode, value);
> 
> 	if (name[0] != '/' || name[1] == '\0')
> 		return ERR_PTR(-EINVAL);
> 
>   retry_bind:
> 	rc = xnregistry_bind(&name[1], XN_NONBLOCK, XN_RELATIVE, &handle);
> 	switch (rc) {
> 	case 0:
> 		/* Found */
> 		if ((oflags & (O_CREAT | O_EXCL)) == (O_CREAT | O_EXCL))
> 			return ERR_PTR(-EEXIST);
> 
> 		xnlock_get_irqsave(&nsem_lock, s);
> 		u = nsem_hash_search(handle, current->mm);
> 		if (u) {
> 			++u->refs;
> 			xnlock_put_irqrestore(&nsem_lock, s);
> 			return u->usem;
> 		}
> 		xnlock_put_irqrestore(&nsem_lock, s);
> 
> 		xnlock_get_irqsave(&nklock, s);
> 		sem = xnregistry_fetch(handle);
> 		if (sem && sem->magic != COBALT_SEM_MAGIC) {
> 			xnlock_put_irqrestore(&nklock, s);
> 			return ERR_PTR(-EINVAL);
> 		}
> 			
> 		if (sem) {
> 			++sem->refs;
> 			xnlock_put_irqrestore(&nklock, s);
> 		} else {
> 			xnlock_put_irqrestore(&nklock, s);
> 			goto retry_bind;
> 		}
> 		break;
> 		
> 	case -EWOULDBLOCK:
> 		/* Not found */
> 		if ((oflags & O_CREAT) == 0)
> 			return ERR_PTR(-ENOENT);
> 
> 		rc = cobalt_sem_init_inner
> 			(&name[1], &shadow, SEM_PSHARED, value);
> 		if (rc < 0) {
> 			if (rc == -EEXIST)
> 				goto retry_bind;
> 			return ERR_PTR(rc);
> 		}
> 
> 		if (__xn_safe_copy_to_user(ushadow, &shadow, sizeof(shadow))) {
> 			cobalt_sem_destroy_inner(shadow.handle);
> 			return ERR_PTR(-EFAULT);
> 		}
> 		handle = shadow.handle;
> 		sem = xnregistry_fetch(handle);
> 		++sem->refs;

Why doesn't this lookup and referencing require nklock protection? After
cobalt_sem_init_inner, sem is now globally visible, so someone else
(like a competing nsem_open) could fetch it and reference it, no?

> 	}
> 
> 	u = xnmalloc(sizeof(*u));
> 	if (u == NULL) 
> 		return ERR_PTR(-ENOMEM);
> 
> 	u->sem = sem;
> 	u->mm = current->mm;
> 	u->usem = ushadow;
> 	u->refs = 1;
> 
> 	xnlock_get_irqsave(&nsem_lock, s);
> 	v = nsem_hash_search(handle, current->mm);
> 	if (v) {
> 		++v->refs;
> 		xnlock_put_irqrestore(&nsem_lock, s);
> 		xnlock_get_irqsave(&nklock, s);
> 		--sem->refs;
> 		xnlock_put_irqrestore(&nklock, s);
> 
> 		if (rc == -EWOULDBLOCK)
> 			cobalt_sem_destroy_inner(sem->handle);

I'm still not sure I fully understand the reason (and safety) of this
release. We get here when we lost the race to enter handle in the
current process' nsem hash table, right? So v != u, ok. But both v and u
must point to a sem object with the same handle value, otherwise they
wouldn't end up in the same hash table slot. But which of those sem
objects is now registered with the xnregistry? I mean, is this destroy
really working on the right one, the one we created in the current context?

> 
> 		xnfree(u);
> 		u = v;
> 	} else {
> 		nsem_hash_enter(handle, u);
> 		list_add(&u->link, &cobalt_process_context()->usems);
> 		xnlock_put_irqrestore(&nsem_lock, s);
> 	}
> 
> 	trace_xn_sys_sem_open_return(handle);
> 
> 	return u->usem;
> }

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

