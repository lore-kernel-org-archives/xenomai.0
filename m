From: Henning Schild <henning.schild@siemens.com>
Date: Tue, 24 Apr 2018 14:37:43 +0200
Message-Id: <20180424123745.7015-2-henning.schild@siemens.com>
In-Reply-To: <20180424123745.7015-1-henning.schild@siemens.com>
References: <20180424123745.7015-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 1/3] Revert "boilerplate/setup: introduce
	destructors for __setup_call"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

In fact we would need real destructors for all setup_descriptor s. Stop
pretending that we know how to dlclose or destruct.

This reverts commit 5511e76040444af875ae1bb099c13a25b16336fc.
---
 include/boilerplate/setup.h | 7 -------
 lib/boilerplate/setup.c     | 6 ------
 2 files changed, 13 deletions(-)

diff --git a/include/boilerplate/setup.h b/include/boilerplate/setup.h
index 83af91f38..7df3cfecc 100644
--- a/include/boilerplate/setup.h
+++ b/include/boilerplate/setup.h
@@ -78,16 +78,10 @@ struct setup_descriptor {
 #define __early_ctor		__attribute__ ((constructor(210)))
 #define __bootstrap_ctor	__attribute__ ((constructor(220)))
 
-#define __setup_dtor		__attribute__ ((destructor(200)))
-
 #define __setup_call(__name, __id)			\
 static __setup_ctor void __declare_ ## __name(void)	\
 {							\
 	__register_setup_call(&(__name), __id);		\
-}							\
-static __setup_dtor void __undeclare_ ## __name(void)	\
-{							\
-	__unregister_setup_call(&(__name), __id);	\
 }
 
 #define core_setup_call(__name)		__setup_call(__name, 0)
@@ -102,7 +96,6 @@ extern "C" {
 #endif
 
 void __register_setup_call(struct setup_descriptor *p, int id);
-void __unregister_setup_call(struct setup_descriptor *p, int id);
 
 extern pid_t __node_id;
 
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index 2a6442726..8b363efee 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -701,12 +701,6 @@ void __register_setup_call(struct setup_descriptor *p, int id)
 	pvlist_prepend(&p->__reserved.next, &setup_list);
 }
 
-void __unregister_setup_call(struct setup_descriptor *p, int id)
-{
-	pvlist_remove(&p->__reserved.next);
-}
-
-
 const char *get_program_name(void)
 {
 	return basename(__base_setup_data.arg0 ?: "program");
-- 
2.16.1


