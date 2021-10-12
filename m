From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 4/4] lib/alchemy: Fix/clarify documentation of *_timed
 functions regarding abs_timeout
Date: Tue, 12 Oct 2021 20:19:20 +0200
Message-Id: <cb3c5ab3ccb459b9be0d65d67a954674960ecc00.1634062760.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1634062760.git.jan.kiszka@siemens.com>
References: <cover.1634062760.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

abs_timeout is not provided in ticks but actually seconds/nanoseconds.
Clarify this and remove the related wrong note from those functions
headers.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 lib/alchemy/buffer.c | 28 ++++++++++------------------
 lib/alchemy/cond.c   | 14 +++++---------
 lib/alchemy/event.c  | 16 ++++++----------
 lib/alchemy/heap.c   | 16 ++++++----------
 lib/alchemy/mutex.c  | 12 ++++--------
 lib/alchemy/pipe.c   | 16 ++++++----------
 lib/alchemy/queue.c  | 32 ++++++++++++--------------------
 lib/alchemy/sem.c    | 16 ++++++----------
 lib/alchemy/task.c   | 27 ++++++++++-----------------
 9 files changed, 65 insertions(+), 112 deletions(-)

diff --git a/lib/alchemy/buffer.c b/lib/alchemy/buffer.c
index 4e814459e5..1fa281f3a2 100644
--- a/lib/alchemy/buffer.c
+++ b/lib/alchemy/buffer.c
@@ -396,12 +396,12 @@ out:
  * error value. However, short reads are allowed when a potential
  * deadlock situation is detected (see note below).
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for a message to be available from
- * the buffer (see note). Passing NULL causes the caller to block
- * indefinitely until enough data is available. Passing { .tv_sec = 0,
- * .tv_nsec = 0 } causes the service to return immediately without
- * blocking in case not enough data is available.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for a
+ * message to be available from the buffer. Passing NULL causes the caller
+ * to block indefinitely until enough data is available. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return immediately
+ * without blocking in case not enough data is available.
  *
  * @return The number of bytes read from the buffer is returned upon
  * success. Otherwise:
@@ -449,10 +449,6 @@ out:
  * should likely be fixed, in order to eliminate such condition.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_buffer_read_timed(RT_BUFFER *bf,
 			     void *ptr, size_t size,
@@ -638,10 +634,10 @@ out:
  * value, in which case the buffer is left untouched, and zero is
  * returned to the caller.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for enough buffer space to be
- * available to hold the message (see note). Passing NULL causes the
- * caller to block indefinitely until enough buffer space is
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for enough
+ * buffer space to be available to hold the message. Passing NULL causes
+ * the caller to block indefinitely until enough buffer space is
  * available. Passing { .tv_sec = 0, .tv_nsec = 0 } causes the service
  * to return immediately without blocking in case of buffer space
  * shortage.
@@ -672,10 +668,6 @@ out:
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_buffer_write_timed(RT_BUFFER *bf,
 			      const void *ptr, size_t size,
diff --git a/lib/alchemy/cond.c b/lib/alchemy/cond.c
index 8c9adbb83e..e4ad71454f 100644
--- a/lib/alchemy/cond.c
+++ b/lib/alchemy/cond.c
@@ -332,11 +332,11 @@ int rt_cond_broadcast(RT_COND *cond)
  * @param mutex The address of the mutex serializing the access to the
  * shared data.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for the condition variable to be
- * signaled  (see note). Passing NULL causes the caller to
- * block indefinitely. Passing { .tv_sec = 0, .tv_nsec = 0 } causes
- * the caller to return immediately without block.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for the
+ * condition variable to be signaled. Passing NULL causes the caller to
+ * block indefinitely. Passing { .tv_sec = 0, .tv_nsec = 0 } causes the
+ * caller to return immediately without block.
  *
  * @return Zero is returned upon success. Otherwise:
  *
@@ -360,10 +360,6 @@ int rt_cond_broadcast(RT_COND *cond)
  * called from a Xenomai thread.
  *
  * @apitags{xthread-only, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 int rt_cond_wait_timed(RT_COND *cond, RT_MUTEX *mutex,
 		       const struct timespec *abs_timeout)
diff --git a/lib/alchemy/event.c b/lib/alchemy/event.c
index 40bd15e9f1..8ccd99b860 100644
--- a/lib/alchemy/event.c
+++ b/lib/alchemy/event.c
@@ -352,12 +352,12 @@ out:
  * means that the request is fulfilled when at all bits set into @a
  * mask are set in the current event mask.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for the request to be satisfied
- * (see note). Passing NULL causes the caller to block indefinitely
- * until the request is satisfied. Passing { .tv_sec = 0, .tv_nsec = 0
- * } causes the service to return without blocking in case the request
- * cannot be satisfied immediately.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for the
+ * request to be satisfied. Passing NULL causes the caller to block
+ * indefinitely until the request is satisfied. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return without
+ * blocking in case the request cannot be satisfied immediately.
  *
  * @return Zero is returned upon success. Otherwise:
  *
@@ -382,10 +382,6 @@ out:
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout value is interpreted as a multiple of the
- * Alchemy clock resolution (see --alchemy-clock-resolution option,
- * defaults to 1 nanosecond).
  */
 int rt_event_wait_timed(RT_EVENT *event,
 			unsigned int mask, unsigned int *mask_r,
diff --git a/lib/alchemy/heap.c b/lib/alchemy/heap.c
index 4715375c3f..c658c46b2e 100644
--- a/lib/alchemy/heap.c
+++ b/lib/alchemy/heap.c
@@ -376,12 +376,12 @@ out:
  * case, the same block covering the entire heap space is returned to
  * all callers of this service.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for a block of the requested size
- * to be available from the heap (see note). Passing NULL causes the
- * caller to block indefinitely until a block is available. Passing {
- * .tv_sec = 0, .tv_nsec = 0 } causes the service to return
- * immediately without blocking in case a block is not available.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for a block
+ * of the requested size to be available from the heap. Passing NULL causes
+ * the caller to block indefinitely until a block is available. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return immediately
+ * without blocking in case a block is not available.
  *
  * @param blockp A pointer to a memory location which will be written
  * upon success with the address of the allocated block, or the start
@@ -420,10 +420,6 @@ out:
  * next page size. The allocation page size is currently 512 bytes
  * long (HOBJ_PAGE_SIZE), which means that any request larger than 1k
  * will be rounded up to the next 512 byte boundary.
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 int rt_heap_alloc_timed(RT_HEAP *heap,
 			size_t size, const struct timespec *abs_timeout,
diff --git a/lib/alchemy/mutex.c b/lib/alchemy/mutex.c
index 42cd1375b3..09eb1364ef 100644
--- a/lib/alchemy/mutex.c
+++ b/lib/alchemy/mutex.c
@@ -261,10 +261,10 @@ out:
  *
  * @param mutex The mutex descriptor.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for the mutex to be available (see
- * note). Passing NULL the caller to block indefinitely. Passing {
- * .tv_sec = 0, .tv_nsec = 0 } causes the service to return
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for the
+ * mutex to be available. Passing NULL the caller to block indefinitely.
+ * Passing { .tv_sec = 0, .tv_nsec = 0 } causes the service to return
  * immediately without blocking in case @a mutex is already locked by
  * another task.
  *
@@ -294,10 +294,6 @@ out:
  * Over the Cobalt core, an Alchemy task with priority zero keeps
  * running in primary mode until it releases the mutex, at which point
  * it is switched back to secondary mode automatically.
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 int rt_mutex_acquire_timed(RT_MUTEX *mutex,
 			   const struct timespec *abs_timeout)
diff --git a/lib/alchemy/pipe.c b/lib/alchemy/pipe.c
index 4b2c389806..c334349aa0 100644
--- a/lib/alchemy/pipe.c
+++ b/lib/alchemy/pipe.c
@@ -393,12 +393,12 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
  * be lost. If @a size is zero, this call returns immediately with no
  * other action.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for a message to be available from
- * the pipe (see note). Passing NULL causes the caller to block
- * indefinitely until a message is available. Passing { .tv_sec = 0,
- * .tv_nsec = 0 } causes the service to return immediately without
- * blocking in case no message is available.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for a
+ * message to be available from the pipe. Passing NULL causes the caller
+ * to block indefinitely until a message is available. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return immediately
+ * without blocking in case no message is available.
  *
  * @return The number of bytes available from the received message is
  * returned upon success. Otherwise:
@@ -423,10 +423,6 @@ ssize_t rt_pipe_read(RT_PIPE *pipe,
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_pipe_read_timed(RT_PIPE *pipe,
 			   void *buf, size_t size,
diff --git a/lib/alchemy/queue.c b/lib/alchemy/queue.c
index b720059214..c45e424547 100644
--- a/lib/alchemy/queue.c
+++ b/lib/alchemy/queue.c
@@ -764,12 +764,12 @@ out:
  * with the address of the received message, upon success. Once
  * consumed, the message space should be freed using rt_queue_free().
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for a message to be available from
- * the queue (see note). Passing NULL causes the caller to block
- * indefinitely until a message is available. Passing { .tv_sec = 0,
- * .tv_nsec = 0 } causes the service to return immediately without
- * blocking in case no message is available.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for a
+ * message to be available from the queue. Passing NULL causes the caller
+ * to block indefinitely until a message is available. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return immediately
+ * without blocking in case no message is available.
  *
  * @return The number of bytes available from the received message is
  * returned upon success. Zero is a possible value corresponding to a
@@ -796,10 +796,6 @@ out:
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_queue_receive_timed(RT_QUEUE *queue, void **bufp,
 			       const struct timespec *abs_timeout)
@@ -929,12 +925,12 @@ out:
  * @param size The length in bytes of the memory area pointed to by @a
  * buf. Messages larger than @a size are truncated appropriately.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for a message to be available from
- * the queue (see note). Passing NULL causes the caller to block
- * indefinitely until a message is available. Passing { .tv_sec = 0,
- * .tv_nsec = 0 } causes the service to return immediately without
- * blocking in case no message is available.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for a
+ * message to be available from the queue. Passing NULL causes the
+ * caller to block indefinitely until a message is available. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return immediately
+ * without blocking in case no message is available.
  *
  * @return The number of bytes copied to @a buf is returned upon
  * success. Zero is a possible value corresponding to a zero-sized
@@ -960,10 +956,6 @@ out:
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_queue_read_timed(RT_QUEUE *queue,
 			    void *buf, size_t size,
diff --git a/lib/alchemy/sem.c b/lib/alchemy/sem.c
index 9e43c6b318..497756ebd2 100644
--- a/lib/alchemy/sem.c
+++ b/lib/alchemy/sem.c
@@ -336,12 +336,12 @@ out:
  *
  * @param sem The semaphore descriptor.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for the request to be satisfied
- * (see note). Passing NULL causes the caller to block indefinitely
- * until the request is satisfied. Passing { .tv_sec = 0, .tv_nsec = 0
- * } causes the service to return without blocking in case the request
- * cannot be satisfied immediately.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for the
+ * request to be satisfied. Passing NULL causes the caller to block
+ * indefinitely until the request is satisfied. Passing { .tv_sec = 0,
+ * .tv_nsec = 0 } causes the service to return without blocking in case
+ * the request cannot be satisfied immediately.
  *
  * @return Zero is returned upon success. Otherwise:
  *
@@ -365,10 +365,6 @@ out:
  * called from a Xenomai thread.
  *
  * @apitags{xthread-nowait, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 int rt_sem_p_timed(RT_SEM *sem, const struct timespec *abs_timeout)
 {
diff --git a/lib/alchemy/task.c b/lib/alchemy/task.c
index 9afa2af579..9e6101df59 100644
--- a/lib/alchemy/task.c
+++ b/lib/alchemy/task.c
@@ -1678,13 +1678,13 @@ out:
  * Upon return, mcb_r->opcode will contain the status code sent back
  * from the remote task using rt_task_reply(), or zero if unspecified.
  *
- * @param abs_timeout An absolute date expressed in clock ticks,
- * specifying a time limit to wait for the recipient task to reply to
- * the initial message (see note). Passing NULL causes the caller to
- * block indefinitely until a reply is received.  Passing { .tv_sec =
- * 0, .tv_nsec = 0 } causes the service to return without blocking in
- * case the recipient task is not waiting for messages at the time of
- * the call.
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying a time limit to wait for the
+ * recipient task to reply to the initial message. Passing NULL causes
+ * the caller to block indefinitely until a reply is received. Passing
+ * { .tv_sec = 0, .tv_nsec = 0 } causes the service to return without
+ * blocking in case the recipient task is not waiting for messages at
+ * the time of the call.
  *
  * @return A positive value is returned upon success, representing the
  * length (in bytes) of the reply message returned by the remote
@@ -1714,10 +1714,6 @@ out:
  * task.
  *
  * @apitags{xthread-only, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 ssize_t rt_task_send_timed(RT_TASK *task,
 			   RT_TASK_MCB *mcb_s, RT_TASK_MCB *mcb_r,
@@ -1892,8 +1888,9 @@ out:
  * Upon return, mcb_r->opcode will contain the operation code sent
  * from the remote task using rt_task_send().
  *
- * @param abs_timeout The number of clock ticks to wait for receiving
- * a message (see note). Passing NULL causes the caller to block
+ * @param abs_timeout An absolute date expressed in seconds / nanoseconds,
+ * based on the Alchemy clock, specifying the time limit to wait for
+ * receiving a message. Passing NULL causes the caller to block
  * indefinitely until a remote task eventually sends a message.
  * Passing { .tv_sec = 0, .tv_nsec = 0 } causes the service to return
  * immediately without waiting if no remote task is currently waiting
@@ -1921,10 +1918,6 @@ out:
  * timeout.
  *
  * @apitags{xthread-only, switch-primary}
- *
- * @note @a abs_timeout is interpreted as a multiple of the Alchemy
- * clock resolution (see --alchemy-clock-resolution option, defaults
- * to 1 nanosecond).
  */
 int rt_task_receive_timed(RT_TASK_MCB *mcb_r,
 			  const struct timespec *abs_timeout)
-- 
2.31.1


