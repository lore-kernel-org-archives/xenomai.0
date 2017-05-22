From: Mauro Salvini <mauro.salvini@smigroup.net>
Date: Mon, 22 May 2017 08:18:12 +0200
Message-Id: <1495433892-4881-1-git-send-email-mauro.salvini@smigroup.net>
Subject: [Xenomai] [PATCH] lib/alchemy: fix some documentation lacks
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

For some functions was not documented that TM_INFINITE and
TM_NONBLOCK values could be used as argument.
---
 lib/alchemy/buffer.c | 20 ++++++++++++++++++--
 lib/alchemy/cond.c   | 10 ++++++++--
 lib/alchemy/event.c  | 10 +++++++++-
 lib/alchemy/heap.c   | 10 +++++++++-
 lib/alchemy/mutex.c  |  8 +++++++-
 lib/alchemy/pipe.c   | 10 +++++++++-
 lib/alchemy/queue.c  | 20 ++++++++++++++++++--
 lib/alchemy/sem.c    | 10 +++++++++-
 lib/alchemy/task.c   | 20 ++++++++++++++++++--
 9 files changed, 105 insertions(+), 13 deletions(-)

diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index 88bcb9a..ac4a9ba 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -345,7 +345,11 @@ out:
  * @param len The length in bytes of the memory area pointed to by @a
  * ptr.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until enough
+ * data is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case not enough data is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -366,6 +370,10 @@ out:
  * ptr.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * enough data is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case not enough data is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -581,7 +589,11 @@ out:
  *
  * @param len The length in bytes of the message data.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until enough
+ * buffer space is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case of buffer space
+ * shortage.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -601,6 +613,10 @@ out:
  * @param len The length in bytes of the message data.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * enough buffer space is available. Passing TM_NONBLOCK causes the
+ * service to return immediately without blocking in case of buffer
+ * space shortage.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
diff --git a/lib/alchemy/cond.c b/lib/alchemy/cond.c
index e825b80..1f424b1 100644
--- a/lib/alchemy/cond.c
+++ b/lib/alchemy/cond.c
@@ -291,7 +291,9 @@ int rt_cond_broadcast(RT_COND *cond)
  * @param mutex The address of the mutex serializing the access to the
  * shared data.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely. Passing
+ * TM_NONBLOCK causes the caller to return immediately without block.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -309,6 +311,9 @@ int rt_cond_broadcast(RT_COND *cond)
  * shared data.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely.
+ * Passing TM_NONBLOCK causes the caller to return immediately
+ * without block.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -330,7 +335,8 @@ int rt_cond_broadcast(RT_COND *cond)
  * @param abs_timeout An absolute date expressed in clock ticks,
  * specifying a time limit to wait for the condition variable to be
  * signaled  (see note). Passing NULL causes the caller to
- * block indefinitely.
+ * block indefinitely. Passing { .tv_sec = 0, .tv_nsec = 0 } causes
+ * the caller to return immediately without block.
  *
  * @return Zero is returned upon success. Otherwise:
  *
diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index bd42bff..15379fc 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -291,7 +291,11 @@ out:
  *
  * @param mode The pend mode.
  *
- * @param timeout A delay expressed in clock ticks,
+ * @param timeout A delay expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * the request is satisfied. Passing TM_NONBLOCK causes the service
+ * to return without blocking in case the request cannot be satisfied
+ * immediately.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -313,6 +317,10 @@ out:
  * @param mode The pend mode.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * the request is satisfied. Passing TM_NONBLOCK causes the service
+ * to return without blocking in case the request cannot be satisfied
+ * immediately.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index 1caf5e3..84daed3 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -337,6 +337,10 @@ out:
  *
  * This routine is a variant of rt_heap_alloc_timed() accepting a
  * relative timeout specification expressed as a scalar value.
+ * Passing TM_INFINITE in @a timeout causes the caller to block
+ * indefinitely until a block is available. Passing TM_NONBLOCK
+ * causes the service to return immediately without blocking in case
+ * a block is not available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -347,6 +351,10 @@ out:
  *
  * This routine is a variant of rt_heap_alloc_timed() accepting an
  * absolute timeout specification expressed as a scalar value.
+ * Passing TM_INFINITE in @a timeout causes the caller to block
+ * indefinitely until a block is available. Passing TM_NONBLOCK
+ * causes the service to return immediately without blocking in case
+ * a block is not available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -374,7 +382,7 @@ out:
  * to be available from the heap (see note). Passing NULL causes the
  * caller to block indefinitely until a block is available. Passing {
  * .tv_sec = 0, .tv_nsec = 0 } causes the service to return
- * immediately without blocking in case not block is available.
+ * immediately without blocking in case a block is not available.
  *
  * @param blockp A pointer to a memory location which will be written
  * upon success with the address of the allocated block, or the start
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 0924c31..3aa55dd 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -220,7 +220,10 @@ out:
  *
  * @param mutex The mutex descriptor.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE the caller to block indefinitely. Passing TM_NONBLOCK
+ * causes the service to return immediately without blocking in case
+ * @a mutex is already locked by another task.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -235,6 +238,9 @@ out:
  * @param mutex The mutex descriptor.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE the caller to block indefinitely. Passing
+ * TM_NONBLOCK causes the service to return immediately without
+ * blocking in case @a mutex is already locked by another task.
  *
  * @apitags{xthread-only, switch-primary}
  */
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index 9973668..1b6c4a7 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -303,7 +303,11 @@ out:
  * be lost. If @a size is zero, this call returns immediately with no
  * other action.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -327,6 +331,10 @@ out:
  * other action.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index 24bfba1..de85543 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -722,7 +722,11 @@ out:
  * @param bufp A pointer to a memory location which will be written
  * with the address of the received message.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -740,6 +744,10 @@ out:
  * with the address of the received message.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -870,7 +878,11 @@ out:
  * @param size The length in bytes of the memory area pointed to by @a
  * buf.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -891,6 +903,10 @@ out:
  * buf.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * a message is available. Passing TM_NONBLOCK causes the service
+ * to return immediately without blocking in case no message is
+ * available.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
diff --git a/lib/alchemy/sem.c b/lib/alchemy/sem.c
index cc27ce1..259bf2f 100644
--- a/lib/alchemy/sem.c
+++ b/lib/alchemy/sem.c
@@ -297,7 +297,11 @@ out:
  *
  * @param sem The semaphore descriptor.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until the
+ * request is satisfied. Passing TM_NONBLOCK causes the service to
+ * return without blocking in case the request cannot be satisfied
+ * immediately.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
@@ -312,6 +316,10 @@ out:
  * @param sem The semaphore descriptor.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * the request is satisfied. Passing TM_NONBLOCK causes the service
+ * to return without blocking in case the request cannot be satisfied
+ * immediately.
  *
  * @apitags{xthread-nowait, switch-primary}
  */
diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 045500f..d647d5c 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -1580,7 +1580,11 @@ out:
  * @param mcb_r The address of an optional message control block
  * referring to the reply message area.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until a reply
+ * is received. Passing TM_NONBLOCK causes the service to return
+ * without blocking in case the recipient task is not waiting for
+ * messages at the time of the call.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -1601,6 +1605,10 @@ out:
  * referring to the reply message area.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * a reply is received. Passing TM_NONBLOCK causes the service to
+ * return without blocking in case the recipient task is not waiting
+ * for messages at the time of the call.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -1814,7 +1822,11 @@ out:
  * @param mcb_r The address of a message control block referring to
  * the receive message area.
  *
- * @param timeout A delay expressed in clock ticks.
+ * @param timeout A delay expressed in clock ticks. Passing
+ * TM_INFINITE causes the caller to block indefinitely until a remote
+ * task eventually sends a message.Passing TM_NONBLOCK causes the
+ * service to return immediately without waiting if no remote task is
+ * currently waiting for sending a message.
  *
  * @apitags{xthread-only, switch-primary}
  */
@@ -1830,6 +1842,10 @@ out:
  * the receive message area.
  *
  * @param abs_timeout An absolute date expressed in clock ticks.
+ * Passing TM_INFINITE causes the caller to block indefinitely until
+ * a remote task eventually sends a message.Passing TM_NONBLOCK
+ * causes the service to return immediately without waiting if no
+ * remote task is currently waiting for sending a message.
  *
  * @apitags{xthread-only, switch-primary}
  */
-- 
2.1.4


