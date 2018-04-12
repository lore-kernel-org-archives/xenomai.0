From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <cc53e58a-c3ed-bd99-704b-70b0da168f98@siemens.com>
Date: Thu, 12 Apr 2018 11:03:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [PATCH] copperplate: Do not allow cancellation in
 hash_enter/search_probe
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

It's not really safe to allow a potentially modifying operation to be
canceled in the middle, just dropping the lock during rollback. Better
defer cancellation until the lock is dropped.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/boilerplate/hash.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/boilerplate/hash.c b/lib/boilerplate/hash.c
index 17beb385c..9ce1b7cb7 100644
--- a/lib/boilerplate/hash.c
+++ b/lib/boilerplate/hash.c
@@ -277,6 +277,7 @@ int __hash_enter_probe(struct hash_table *t,
 {
 	struct hash_bucket *bucket;
 	struct hashobj *obj, *tmp;
+	struct service svc;
 	int ret;
 
 	holder_init(&newobj->link);
@@ -285,7 +286,7 @@ int __hash_enter_probe(struct hash_table *t,
 		return ret;
 
 	bucket = do_hash(t, key, len);
-	push_cleanup_lock(&t->lock);
+	CANCEL_DEFER(svc);
 	write_lock(&t->lock);
 
 	if (!list_empty(&bucket->obj_list)) {
@@ -311,7 +312,7 @@ int __hash_enter_probe(struct hash_table *t,
 	list_append(&newobj->link, &bucket->obj_list);
 out:
 	write_unlock(&t->lock);
-	pop_cleanup_lock(&t->lock);
+	CANCEL_RESTORE(svc);
 
 	return ret;
 }
@@ -322,10 +323,11 @@ struct hashobj *hash_search_probe(struct hash_table *t,
 {
 	struct hash_bucket *bucket;
 	struct hashobj *obj, *tmp;
+	struct service svc;
 
 	bucket = do_hash(t, key, len);
 
-	push_cleanup_lock(&t->lock);
+	CANCEL_DEFER(svc);
 	write_lock(&t->lock);
 
 	if (!list_empty(&bucket->obj_list)) {
@@ -345,7 +347,7 @@ struct hashobj *hash_search_probe(struct hash_table *t,
 	obj = NULL;
 out:
 	write_unlock(&t->lock);
-	pop_cleanup_lock(&t->lock);
+	CANCEL_RESTORE(svc);
 
 	return obj;
 }
-- 
2.13.6

