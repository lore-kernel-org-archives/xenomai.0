From: Henning Schild <henning.schild@siemens.com>
Date: Fri, 16 Feb 2018 14:13:35 +0100
Message-Id: <b3c06e9a71d3732551e5518491fa73288f971d9c.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
In-Reply-To: <cover.1518786423.git.henning.schild@siemens.com>
References: <cover.1518786423.git.henning.schild@siemens.com>
Subject: [Xenomai] [PATCH 5/5] boilerplate/setup: introduce destructors for
	__setup_call
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Whit dlclose() we can actually invalidate the setup_list, it might end
up containing pointers to memory that got unmapped with dlclose(). The
next dlopen() will then cause a segfault.
Add destructors to that such referrences are remove from the setup_list
when calling dlclose().
The previous commit added a testcase that fails because of that issue,
with this commit the test runs fine.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 include/boilerplate/setup.h | 7 +++++++
 lib/boilerplate/setup.c     | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/boilerplate/setup.h b/include/boilerplate/setup.h
index 7df3cfecc..83af91f38 100644
--- a/include/boilerplate/setup.h
+++ b/include/boilerplate/setup.h
@@ -78,10 +78,16 @@ struct setup_descriptor {
 #define __early_ctor		__attribute__ ((constructor(210)))
 #define __bootstrap_ctor	__attribute__ ((constructor(220)))
 
+#define __setup_dtor		__attribute__ ((destructor(200)))
+
 #define __setup_call(__name, __id)			\
 static __setup_ctor void __declare_ ## __name(void)	\
 {							\
 	__register_setup_call(&(__name), __id);		\
+}							\
+static __setup_dtor void __undeclare_ ## __name(void)	\
+{							\
+	__unregister_setup_call(&(__name), __id);	\
 }
 
 #define core_setup_call(__name)		__setup_call(__name, 0)
@@ -96,6 +102,7 @@ extern "C" {
 #endif
 
 void __register_setup_call(struct setup_descriptor *p, int id);
+void __unregister_setup_call(struct setup_descriptor *p, int id);
 
 extern pid_t __node_id;
 
diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index f749828b9..9e4ee3410 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -698,6 +698,12 @@ void __register_setup_call(struct setup_descriptor *p, int id)
 	pvlist_prepend(&p->__reserved.next, &setup_list);
 }
 
+void __unregister_setup_call(struct setup_descriptor *p, int id)
+{
+	pvlist_remove(&p->__reserved.next);
+}
+
+
 const char *get_program_name(void)
 {
 	return basename(__base_setup_data.arg0 ?: "program");
-- 
2.16.1


