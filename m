From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH v2 2/5] libcobalt: improve documentation regarding mutex
 initializers
Date: Thu,  7 Mar 2019 14:31:53 +0100
Message-Id: <20190307133156.31749-3-norbert.lange@andritz.com>
In-Reply-To: <20190307133156.31749-1-norbert.lange@andritz.com>
References: <20190307133156.31749-1-norbert.lange@andritz.com>
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
 lib/cobalt/mutex.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/cobalt/mutex.c b/lib/cobalt/mutex.c
index be9f6ed80..125981d40 100644
--- a/lib/cobalt/mutex.c
+++ b/lib/cobalt/mutex.c
@@ -49,8 +49,12 @@
  * By default, Cobalt mutexes are of the normal type, use no
  * priority protocol and may not be shared between several processes.
  *
- * Note that only pthread_mutex_init() may be used to initialize a mutex, using
- * the static initializer @a PTHREAD_MUTEX_INITIALIZER is not supported.
+ * Note that pthread_mutex_init() should be used to initialize a mutex, using
+ * the static initializer @a PTHREAD_MUTEX_INITIALIZER will delay the
+ * initialization to the first method called on the mutex and will
+ * most likely introduce switches to secondary mode.
+ * The documentation (and specififcally api-tags) of the mutex services assumes
+ * a mutex was explicitely initialised with pthread_mutex_init().
  *
  *@{
  */
-- 
2.20.1


