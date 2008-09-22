Message-ID: <48D754D8.30205@domain.hid>
Date: Mon, 22 Sep 2008 10:18:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <48CE7BD7.6060504@domain.hid>
	<48D620DB.2070101@domain.hid>	<48D688EE.7010404@domain.hid>
	<48D68D6D.9070909@domain.hid> <48D69A7A.7090302@domain.hid>
	<48D752BA.3000403@domain.hid>
In-Reply-To: <48D752BA.3000403@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [RFC][PATCH] Factor out xnsynch_acquire/release
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Jan Kiszka wrote:
> Gilles Chanteperdrix wrote:
>> Jan Kiszka wrote:
>>
>>> [1]http://thread.gmane.org/gmane.linux.real-time.xenomai.devel/5412/focus=5405
>>>
>> always-put-xnthread-base-into-registry.patch:
>> 	I understand the need, but I will cowardly let Philippe decide whether
>> he likes the implementation details.
>>
>> handle-base-xn_sys_current-1.patch:
>> 	In some places (pse51_mutex_timedlock_inner for instances) you use
>> XN_NO_HANDLE, in others (pse51_mutex_timedlock for instances) you use
>> NULL, are the two equivalents ? If yes, should not we always use the
>> same consistently ? Otherwise looks ok.
> 
> I fail to find the NULL spots - which pse51_mutex_timedlock do you mean?

A few excerpts:

@@ -101,9 +103,14 @@ pse51_mutex_trylock_internal(xnthread_t
 		return ERR_PTR(-EPERM);
 #endif /* XENO_DEBUG(POSIX) */

-	owner = xnarch_atomic_intptr_cmpxchg(mutex->owner, NULL, cur);
-	if (unlikely(owner != NULL))
+	ownerh = xnarch_atomic_cmpxchg(mutex->owner, XN_NO_HANDLE,
+				       xnthread_handle(cur));
+	if (unlikely(ownerh)) {
+		owner = xnregistry_fetch(clear_claimed(ownerh));
+		if (!owner)
+			return ERR_PTR(-EINVAL);
 		return owner;
+	}

 	shadow->lockcnt = count;
 	return NULL;


@@ -128,32 +136,41 @@ static inline int pse51_mutex_timedlock_
(...)
-		old = xnarch_atomic_intptr_cmpxchg(mutex->owner,
-						   owner, set_claimed(owner, 1));
-		if (likely(old == owner))
+		old = xnarch_atomic_cmpxchg(mutex->owner, ownerh,
+					    set_claimed(ownerh, 1));
+		if (likely(old == ownerh))
 			break;
 	  test_no_owner:
-		if (old == NULL) {
+		if (!old) {
 			/* Owner called fast mutex_unlock
 			   (on another cpu) */
 			xnlock_put_irqrestore(&nklock, s);

@@ -163,7 +163,7 @@ int __wrap_pthread_mutex_lock(pthread_mu
 		goto out;
 	}

-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
 	if (likely(!owner)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);


@@ -210,7 +210,7 @@ int __wrap_pthread_mutex_timedlock(pthre
 	int err = 0;

 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;

 	cur = xeno_get_current();
 	if (!cur)



@@ -224,7 +224,7 @@ int __wrap_pthread_mutex_timedlock(pthre
 		goto out;
 	}	

-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
 	if (likely(!owner)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);

@@ -271,7 +271,7 @@ int __wrap_pthread_mutex_trylock(pthread
 	int err = 0;

 #ifdef CONFIG_XENO_FASTSEM
-	xnthread_t *cur, *owner;
+	xnhandle_t cur, owner;

 	cur = xeno_get_current();
 	if (!cur)

@@ -285,7 +285,7 @@ int __wrap_pthread_mutex_trylock(pthread
 		goto out;
 	}	

-	owner = xnarch_atomic_intptr_cmpxchg(get_ownerp(shadow), NULL, cur);
+	owner = xnarch_atomic_cmpxchg(get_ownerp(shadow), XN_NO_HANDLE, cur);
 	if (likely(!owner)) {
 		shadow->lockcnt = 1;
 		cb_read_unlock(&shadow->lock, s);

@@ -325,8 +325,8 @@ int __wrap_pthread_mutex_unlock(pthread_
 	int err = 0;

 #ifdef CONFIG_XENO_FASTSEM
-	xnarch_atomic_intptr_t *ownerp;
-	xnthread_t *cur;
+	xnarch_atomic_t *ownerp;
+	xnhandle_t cur, owner;

 	cur = xeno_get_current();
 	if (!cur)

-- 
                                                 Gilles.

