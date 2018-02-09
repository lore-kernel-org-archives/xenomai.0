From: Henning Schild <henning.schild@siemens.com>
Date: Fri,  9 Feb 2018 17:13:13 +0100
Message-Id: <20180209161313.32524-1-henning.schild@siemens.com>
Subject: [Xenomai] [PATCH] boilerplate: introduce big lock to serialze dso
	init calls
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

When using dlopen() to include xenomai libraries into an application,
__xenomai_init could be running in multiple threads at a time. That
happens if the application dlopens multiple libs in multiple threads.

Introduce a big lock to serialize all calls to __xenomai_init.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 lib/boilerplate/setup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/boilerplate/setup.c b/lib/boilerplate/setup.c
index f749828b91..653bbae104 100644
--- a/lib/boilerplate/setup.c
+++ b/lib/boilerplate/setup.c
@@ -55,6 +55,9 @@ static int main_init_done;
 
 static DEFINE_PRIVATE_LIST(setup_list);
 
+// serialize dlopen() init calls, which come potentially multi-threaded
+static pthread_mutex_t dso_init_lock = PTHREAD_MUTEX_INITIALIZER;
+
 static const struct option base_options[] = {
 	{
 #define help_opt	0
@@ -657,7 +660,9 @@ void xenomai_init(int *argcp, char *const **argvp)
 
 void xenomai_init_dso(int *argcp, char *const **argvp)
 {
+	write_lock_nocancel(&dso_init_lock);
 	__xenomai_init(argcp, argvp, "DSO");
+	write_unlock(&dso_init_lock);
 	trace_me("DSO bootstrap done");
 }
 
-- 
2.13.6


