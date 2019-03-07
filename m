From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 4/5] libcobalt: improve documentation regarding condvar
 initializers
Date: Thu,  7 Mar 2019 14:21:58 +0100
Message-Id: <20190307132159.31206-4-norbert.lange@andritz.com>
In-Reply-To: <20190307132159.31206-1-norbert.lange@andritz.com>
References: <20190307132159.31206-1-norbert.lange@andritz.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/cobalt/cond.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/lib/cobalt/cond.c b/lib/cobalt/cond.c
index 92eb230ff..cdbd512ae 100644
--- a/lib/cobalt/cond.c
+++ b/lib/cobalt/cond.c
@@ -47,9 +47,13 @@
  * several processes (it may not be shared by default, see
  * pthread_condattr_setpshared()).
  *
- * Note that only pthread_cond_init() may be used to initialize a condition
- * variable, using the static initializer @a PTHREAD_COND_INITIALIZER is
- * not supported.
+ * Note that pthread_cond_init() should be used to initialize a condition
+ * variable, using the static initializer @a PTHREAD_COND_INITIALIZER will
+ * delay the initialization to the first method called on the condition
+ * variable and will most likely introduce switches to secondary mode.
+ * The documentation (and specififcally api-tags) of the
+ * condition variable services assumes the condition variable was explicitely
+ * initialised with pthread_cond_init().
  *
  *@{
  */
-- 
2.20.1


