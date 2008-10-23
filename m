From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Thu, 23 Oct 2008 12:00:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200810231200.02851.niklaus.giger@domain.hid>
Subject: [Xenomai-core] [PATCH] vxWorks/lstLib: Check for nil-pointer
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai-core <xenomai@xenomai.org>

Here some trivial fixes with their respective tests to handle the case of nil pointers corrrectly.

Signed-off-by: Niklaus Giger <niklaus.giger@domain.hid>
---
 include/vxworks/lstLib.h  |    6 +++---
 vxworks/lstLib.c          |    4 +++-
 vxworks/testsuite/lst-1.c |   17 +++++++----------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/vxworks/lstLib.h b/include/vxworks/lstLib.h
index b78c2c3..38f0598 100644
--- a/include/vxworks/lstLib.h
+++ b/include/vxworks/lstLib.h
@@ -65,7 +65,7 @@ static inline void lstDelete(LIST *l, NODE *n)

 static inline NODE *lstFirst(LIST *l)
 {
-	if (list_empty(&l->list))
+	if (l == NULL || list_empty(&l->list))
 		return NULL;

 	return list_first_entry(&l->list, struct NODE, link);
@@ -75,7 +75,7 @@ static inline NODE *lstGet(LIST *l)
 {
 	struct NODE *n;

-	if (list_empty(&l->list))
+	if (l == NULL || list_empty(&l->list))
 		return NULL;

 	n = list_pop_entry(&l->list, struct NODE, link);
@@ -100,7 +100,7 @@ static inline void lstInsert(LIST *l, NODE *nprev, NODE *n)

 static inline NODE *lstLast(LIST *l)
 {
-	if (list_empty(&l->list))
+	if (l == NULL || list_empty(&l->list))
 		return NULL;

 	return list_last_entry(&l->list, struct NODE, link);
diff --git a/vxworks/lstLib.c b/vxworks/lstLib.c
index 58358f0..56880b4 100644
--- a/vxworks/lstLib.c
+++ b/vxworks/lstLib.c
@@ -44,7 +44,7 @@ NODE *lstNth(LIST *l, int nodenum)
 	struct holder *holder;
 	int nth;

-	if (nodenum <= 0)
+	if (l == 0 || nodenum <= 0)
 		return NULL;

 	if (nodenum <= l->count >> 2) { /* nodenum is 1-based. */
@@ -89,6 +89,8 @@ int lstFind(LIST *l, NODE *n)
 {
 	struct holder *holder;
 	int nth = 1;
+	if (l == 0)
+		return ERROR;

 	list_for_each(holder, &l->list) {
 		if (holder == &n->link)
diff --git a/vxworks/testsuite/lst-1.c b/vxworks/testsuite/lst-1.c
index 8b42692..d95d8b8 100644
--- a/vxworks/testsuite/lst-1.c
+++ b/vxworks/testsuite/lst-1.c
@@ -12,16 +12,15 @@ void rootTask(long a0, long a1, long a2, long a3, long a4,
 {
 	NODE first, second, third, fourth;
 	LIST list;
-	int ret;

 	traceobj_enter(&trobj);

-/*
-  traceobj_assert(&trobj, 0 == lstNth (0, 1));
-  traceobj_assert(&trobj, 0 == lstFirst(0));
-  traceobj_assert(&trobj, 0 == lstLast(0));
-*/
- 	lstInit(&list);
+	traceobj_assert(&trobj, 0 == lstNth (0, 1));
+	traceobj_assert(&trobj, 0 == lstFirst(0));
+	traceobj_assert(&trobj, 0 == lstLast(0));
+	traceobj_assert(&trobj, 0 == lstGet(0));
+
+	lstInit(&list);
 	traceobj_assert(&trobj, 0 == lstCount(&list));
 	traceobj_assert(&trobj, NULL == lstFirst(&list));
 	traceobj_assert(&trobj, 0 == lstNth(&list, 0));
@@ -41,7 +40,7 @@ void rootTask(long a0, long a1, long a2, long a3, long a4,
 	traceobj_assert(&trobj, 2 == lstCount(&list));
 	traceobj_assert(&trobj, &first == lstFirst(&list));
 	traceobj_assert(&trobj, &second == lstLast(&list));
-	traceobj_assert(&trobj, NULL == lstPrevious(&first)); // breaks here under xenomai-solo
+	traceobj_assert(&trobj, NULL == lstPrevious(&first));
 	traceobj_assert(&trobj, 0 == lstNth(&list, 0));
 	traceobj_assert(&trobj, &first  == lstNth(&list, 1));
 	traceobj_assert(&trobj, &second == lstNth(&list, 2));
@@ -127,8 +126,6 @@ void rootTask(long a0, long a1, long a2, long a3, long a4,
 	traceobj_assert(&trobj, 0 == lstNth(&list, 4));
 	traceobj_assert(&trobj, 0 == lstNth(&list, 5));

-	traceobj_assert(&trobj, ret == OK);
-
 	traceobj_exit(&trobj);
 }

--
1.6.0.2



