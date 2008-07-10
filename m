Message-ID: <48760BC4.9070400@domain.hid>
Date: Thu, 10 Jul 2008 15:16:52 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH 1/2] Include RT_MUTEX_INFO in doxygen
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

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 include/native/mutex.h |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

Index: b/include/native/mutex.h
===================================================================
--- a/include/native/mutex.h
+++ b/include/native/mutex.h
@@ -26,13 +26,17 @@
 
 struct rt_task;
 
+/** Structure containing mutex information useful to users.
+ *
+ *  @see rt_mutex_inquire()
+ */
 typedef struct rt_mutex_info {
 
-	int lockcnt;		/* !< Lock nesting level (> 0 means "locked"). */
+	int lockcnt;		/**< Lock nesting level (> 0 means "locked"). */
 
-	int nwaiters;		/* !< Number of pending tasks. */
+	int nwaiters;		/**< Number of pending tasks. */
 
-	char name[XNOBJECT_NAME_LEN]; /* !< Symbolic name. */
+	char name[XNOBJECT_NAME_LEN]; /**< Symbolic name. */
 
 } RT_MUTEX_INFO;
 

