Message-ID: <52C02780.2050104@xenomai.org>
Date: Sun, 29 Dec 2013 14:45:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52AEB440.5090103@xenomai.org> <52AF2686.7010907@xenomai.org>
 <52AF26C1.1060300@xenomai.org> <52AF2BDF.9000801@xenomai.org>
 <52AF2C6E.8010701@xenomai.org> <52AF2ED5.8070503@xenomai.org>
In-Reply-To: <52AF2ED5.8070503@xenomai.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] rehashing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

On 12/16/2013 05:48 PM, Philippe Gerum wrote:
> On 12/16/2013 05:38 PM, Gilles Chanteperdrix wrote:
>> On 12/16/2013 05:35 PM, Philippe Gerum wrote:
>>> On 12/16/2013 05:13 PM, Gilles Chanteperdrix wrote:
>>>> On 12/16/2013 05:12 PM, Philippe Gerum wrote:
>>>>> On 12/16/2013 09:05 AM, Gilles Chanteperdrix wrote:
>>>>>>
>>>>>> Hi Philippe,
>>>>>>
>>>>>> looking at the registry code, I had an idea: we could increase the
>>>>>> number of descriptors dynamically when they are exhausted, and
>>>>>> increase
>>>>>> the hash size as well. This would make the configurable number of
>>>>>> slots
>>>>>> a starting point, but not a liimit. The access to the registry by name
>>>>>> does not really need to be fast, so we could protect it with a mutex
>>>>>
>>>>> The registry hash is a low contention resource, so using a dedicated
>>>>> mutex is likely more efficient than grabbing the big nklock in most
>>>>> cases anyway.
>>>>>
>>>>>> (that would mean that all services accessing the registry by name
>>>>>> would
>>>>>> need to run in secondary mode, but I am not sure we care, and if we
>>>>>> do,
>>>>>> we can use an xnsynch instead).
>>>>>>
>>>>>> What do you think?
>>>>>>
>>>>>
>>>>> Recent Cobalt users of the registry put aside, this is basically about
>>>>> deciding whether:
>>>>>
>>>>> - issuing connect() on a rtipc socket should switch the caller to
>>>>> secondary mode, since other in-kernel users disappeared during the
>>>>> Great
>>>>> Refactoring (tm). bind() does have such requirement already.
>>>>>
>>>>> - all present and future callers of xnregistry_remove() should run in
>>>>> secondary mode as well. There is only one caller remaining so far, and
>>>>> it does (i.e. thread cleanup code).
>>>>
>>>> sem_destroy/sem_close/sem_unlink, pthread_mutex_destroy, and
>>>> pthread_cond_destroy now call xnregistry_remove.
>>>>
>>>
>>> Since your recent additions involve dropping keys from the registry from
>>> mutex and cond deletion routines, I would then stick with an
>>> implementation that allows primary-mode calls.
>>
>> Ok, just forgot that mutex and conds are anonymous, so, they need not
>> access the hash table, only sem_unlink and sem_open will access the
>> hash. Ok, I need to see what exactly needs to be protected during the
>> rehash. Maybe not much after all.
>>
> 
> You also have to serialize access to the handle table, and keep key 
> indexing and handle registration seen as a single atomic operation from 
> external code.
> 
Ok, I think I have found a way. It is not very complicated finally. I
guess I found out something everybody knew already... When we know we
are rehashing:
- any search searches both in the old and the new hash
- any insertion goes straight to the new hash.
So, no wait for the rehash end is needed, except for the unlucky caller
of the hash insertion routine which is doing the rehash.

Here is the patch for the "xnid_table" hash, pushed yesterday, and used
for named semaphores, file descriptors and timer ids.

diff --git a/include/cobalt/kernel/id_table.h
b/include/cobalt/kernel/id_table.h
index ea9256b..e7417e9 100644
--- a/include/cobalt/kernel/id_table.h
+++ b/include/cobalt/kernel/id_table.h
@@ -21,7 +21,9 @@

 struct xnid_table {
 	struct hlist_head *hash;
-	unsigned mm_mult, mm_shift, hash_size;
+	unsigned mm_mult, mm_shift, hash_size, nrelems;
+	struct xnid_table *rehash;
+	struct xnlock *lock;
 };

 struct xnid {
@@ -30,7 +32,12 @@ struct xnid {
 	struct hlist_node hlink;
 };

-int xnid_table_init(struct xnid_table *t, unsigned size);
+int _xnid_table_init(struct xnid_table *t, unsigned size, struct xnlock
*lock);
+#ifdef CONFIG_SMP
+#define xnid_table_init _xnid_table_init
+#else
+#define xnid_table_init(t, size, lock) _xnid_table_init(t, size, NULL)
+#endif

 int xnid_enter(struct xnid_table *t, struct xnid *xnid,
 	struct mm_struct *mm, unsigned long id);
diff --git a/kernel/cobalt/id_table.c b/kernel/cobalt/id_table.c
index f69ab44..ee16359 100644
--- a/kernel/cobalt/id_table.c
+++ b/kernel/cobalt/id_table.c
@@ -19,16 +19,22 @@
 #include <linux/err.h>
 #include <linux/list.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <cobalt/kernel/sched.h>
 #include <cobalt/kernel/registry.h>
 #include <cobalt/kernel/id_table.h>

-int xnid_table_init(struct xnid_table *t, unsigned size)
+int _xnid_table_init(struct xnid_table *t, unsigned size, struct xnlock
*lock)
 {
 	unsigned i;
 	
 	t->hash_size = xnregistry_hash_size(size);
-	t->hash = kmalloc(t->hash_size * sizeof(*t->hash), GFP_KERNEL);
+	size = t->hash_size * sizeof(*t->hash);
+	if (size <= PAGE_SIZE)
+		t->hash = kmalloc(size, GFP_KERNEL);
+	else
+		t->hash = vmalloc(size);
 	if (t->hash == NULL)
 		return -ENOMEM;
 	
@@ -38,6 +44,10 @@ int xnid_table_init(struct xnid_table *t, unsigned size)
 	i = int_sqrt(t->hash_size);
 	t->mm_shift = 32 - fls(i);
 	t->mm_mult = (i << t->mm_shift) / sizeof(struct mm_struct);
+	t->nrelems = 0;
+	t->rehash = NULL;
+	t->lock = lock;
+
 	return 0;
 }

@@ -54,25 +64,109 @@ struct xnid *xnid_fetch(struct xnid_table *t,
 {
 	unsigned bucket = xnid_crunch(t, id, mm);
 	struct xnid *i;
-	
+
+	if (t->rehash && t->rehash->nrelems >= t->nrelems) {
+		i = xnid_fetch(t->rehash, mm, id);
+		if (i)
+			return i;
+	}
+
 	hlist_for_each_entry(i, &t->hash[bucket], hlink)
 		if (i->id == id && i->mm == mm)
 			return i;
+
+	if (t->rehash && t->rehash->nrelems < t->nrelems)
+		return xnid_fetch(t->rehash, mm, id);
 	
 	return NULL;
 }

+int xnid_table_rehash(struct xnid_table *t, unsigned new_size)
+{
+	struct xnid_table rehash, tmph;
+	struct hlist_node *tmp;
+	unsigned bucket;
+	struct xnid *i;
+	spl_t s;
+	int err;
+
+	xnlock_clear_irqon(t->lock);
+
+	err = xnid_table_init(&rehash, new_size, t->lock);
+	if (err < 0)
+		goto out_relock;
+	
+	xnlock_get_irqsave(t->lock, s);
+	if (t->rehash) {
+		/* Someone else won the race */
+		err = 0;
+		goto out_table_cleanup;
+	}
+	t->rehash = &rehash;
+	
+	for (bucket = 0; bucket < t->hash_size && t->nrelems; bucket++)
+		hlist_for_each_entry_safe(i, tmp, &t->hash[bucket], hlink) {
+			xnid_remove(t, i);
+			xnid_enter(t, i, i->mm, i->id);
+			xnlock_put_irqrestore(t->lock, s);
+			
+			xnlock_get_irqsave(t->lock, s);
+		}
+
+	/* Swap the tables */
+	tmph = *t;
+	*t = rehash;
+	rehash = tmph;
+	rehash.rehash = NULL;
+  out_table_cleanup:
+	xnlock_put_irqrestore(t->lock, s);
+	
+	xnid_table_cleanup(&rehash);
+
+  out_relock:
+	xnlock_get_irqsave(t->lock, s);
+	
+	return err;
+}
+
 int xnid_enter(struct xnid_table *t, struct xnid *xnid,
 	struct mm_struct *mm, unsigned long id)
 {
-	unsigned bucket = xnid_crunch(t, id, mm);
+	unsigned bucket;
+	bool rehashing;
+	int err;
+
+	if (!xnsched_root_p())
+		return -EPERM;
+
+	rehashing = t->rehash;
+	if (rehashing)
+		t = t->rehash;
+
 #if XENO_DEBUG(NUCLEUS)
 	if (xnid_fetch(t, mm, id))
 		return -EBUSY;
 #endif
+	if (!rehashing)
+		while (t->nrelems >= 8 * t->hash_size / 10) {
+			unsigned new_size = t->hash_size;
+			do {
+				new_size *= 2;
+			} while (t->nrelems >= 8 * new_size / 10);
+
+			if (xnregistry_hash_size(new_size) == t->hash_size)
+				break;
+
+			err = xnid_table_rehash(t, new_size);
+			if (err < 0)
+				return err;
+		}
+
+	bucket = xnid_crunch(t, id, mm);
 	xnid->mm = mm;
 	xnid->id = id;
 	hlist_add_head(&xnid->hlink, &t->hash[bucket]);
+	++t->nrelems;
 	return 0;
 }

@@ -83,11 +177,20 @@ int xnid_remove(struct xnid_table *t, struct xnid
*xnid)
 		return -EBADF;
 #endif
 	hlist_del(&xnid->hlink);
+	--t->nrelems;
 	return 0;
 }

 void xnid_table_cleanup(struct xnid_table *t)
 {
-	kfree(t->hash);
+	unsigned size;
+
+	BUG_ON(t->rehash);
+	size = t->hash_size * sizeof(*t->hash);
+	if (size <= PAGE_SIZE)
+		kfree(t->hash);
+	else
+		vfree(t->hash);
 	t->hash = NULL;
 }
+


-- 
                                                                Gilles.

