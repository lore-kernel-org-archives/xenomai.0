Message-ID: <4E0264CE.9060508@domain.hid>
Date: Wed, 22 Jun 2011 23:55:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] RFC: use a pool of pre-allocated buffers in rt_printf
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Xenomai core <Xenomai-core@domain.hid>


Hi,

I would like to better integrate rtdk and the posix skin by forcibly 
wrapping the calls to malloc/free and also wrap printf to call 
rt_printf.

However, currently, rt_printf can not really be used as a drop-in 
replacement of printf:
- it is necessary to call rt_printf_auto_init, we can do it in the 
library init code;
- the first rt_printf causes a memory allocation, so a potential switch 
to secondary mode, which is what using rt_printf was trying to avoid in
the first place.

In order to solve this second issue, and to avoid forcibly creating a 
buffer for each thread, which would be wasteful, here is a patch, which, 
following an idea of Philippe, creates a pool of pre-allocated buffers. 
The pool is handled in a lockless fashion, using xnarch_atomic_cmpxchg 
(so, will only work with CONFIG_XENO_FASTSYNCH).

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 93b711a..2ed2209 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -30,6 +30,8 @@
 #include <rtdk.h>
 #include <asm/xenomai/system.h>
 #include <asm-generic/stack.h>
+#include <asm/xenomai/atomic.h>
+#include <asm-generic/bits/current.h>
 
 #define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
 #define RT_PRINT_DEFAULT_BUFFER		16*1024
@@ -37,6 +39,9 @@
 #define RT_PRINT_PERIOD_ENV		"RT_PRINT_PERIOD"
 #define RT_PRINT_DEFAULT_PERIOD		100 /* ms */
 
+#define RT_PRINT_BUFFERS_COUNT_ENV      "RT_PRINT_BUFFERS_COUNT"
+#define RT_PRINT_DEFAULT_BUFFERS_COUNT  4
+
 #define RT_PRINT_LINE_BREAK		256
 
 #define RT_PRINT_SYSLOG_STREAM		NULL
@@ -63,6 +68,9 @@ struct print_buffer {
 	 * caching on SMP.
 	 */
 	off_t read_pos;
+#ifdef CONFIG_XENO_FASTSYNCH
+	struct print_buffer *pool_next;
+#endif /* CONFIG_XENO_FASTSYNCH */
 };
 
 static struct print_buffer *first_buffer;
@@ -75,6 +83,17 @@ static pthread_mutex_t buffer_lock;
 static pthread_cond_t printer_wakeup;
 static pthread_key_t buffer_key;
 static pthread_t printer_thread;
+#ifdef CONFIG_XENO_FASTSYNCH
+static xnarch_atomic_t buffer_pool;
+static unsigned pool_capacity;
+static xnarch_atomic_t pool_count;
+
+#define buf_pool_set(buf) xnarch_atomic_set(&buffer_pool, (unsigned long)buf)
+#define buf_pool_get() (struct print_buffer *)xnarch_atomic_get(&buffer_pool)
+#define buf_pool_cmpxchg(oldval, newval) \
+	((struct print_buffer *)xnarch_atomic_cmpxchg			\
+	 (&buffer_pool, (unsigned long)oldval, (unsigned long)newval))
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 static void cleanup_buffer(struct print_buffer *buffer);
 static void print_buffers(void);
@@ -243,43 +262,28 @@ static void set_buffer_name(struct print_buffer *buffer, const char *name)
 	}
 }
 
-int rt_print_init(size_t buffer_size, const char *buffer_name)
+static struct print_buffer *rt_print_init_inner(size_t size)
 {
-	struct print_buffer *buffer = pthread_getspecific(buffer_key);
-	size_t size = buffer_size;
-
-	if (!size)
-		size = default_buffer_size;
-	else if (size < RT_PRINT_LINE_BREAK)
-		return EINVAL;
+	struct print_buffer *buffer;
 
-	if (buffer) {
-		/* Only set name if buffer size is unchanged or default */
-		if (size == buffer->size || !buffer_size) {
-			set_buffer_name(buffer, buffer_name);
-			return 0;
-		}
-		cleanup_buffer(buffer);
-	}
+	assert_nrt();
 
 	buffer = malloc(sizeof(*buffer));
 	if (!buffer)
-		return ENOMEM;
+		return NULL;
 
 	buffer->ring = malloc(size);
 	if (!buffer->ring) {
 		free(buffer);
-		return ENOMEM;
+		return NULL;
 	}
+	buffer->size = size;
+
 	memset(buffer->ring, 0, size);
 
 	buffer->read_pos  = 0;
 	buffer->write_pos = 0;
 
-	buffer->size = size;
-
-	set_buffer_name(buffer, buffer_name);
-
 	buffer->prev = NULL;
 
 	pthread_mutex_lock(&buffer_lock);
@@ -294,6 +298,52 @@ int rt_print_init(size_t buffer_size, const char *buffer_name)
 
 	pthread_mutex_unlock(&buffer_lock);
 
+	return buffer;
+}
+
+int rt_print_init(size_t buffer_size, const char *buffer_name)
+{
+	struct print_buffer *buffer = pthread_getspecific(buffer_key);
+	size_t size = buffer_size;
+
+	if (!size)
+		size = default_buffer_size;
+	else if (size < RT_PRINT_LINE_BREAK)
+		return EINVAL;
+
+	if (buffer) {
+		/* Only set name if buffer size is unchanged or default */
+		if (size == buffer->size || !buffer_size) {
+			set_buffer_name(buffer, buffer_name);
+			return 0;
+		}
+		cleanup_buffer(buffer);
+		buffer = NULL;
+	}
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	if (xeno_get_current() != XN_NO_HANDLE &&
+	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
+		struct print_buffer *old;
+
+		old = buf_pool_get();
+		while (old != buffer) {
+			buffer = old;
+			old = buf_pool_cmpxchg(buffer, buffer->pool_next);
+		}
+		if (buffer)
+			xnarch_atomic_dec(&pool_count);
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	if (!buffer)
+		buffer = rt_print_init_inner(size);
+
+	if (!buffer)
+		return ENOMEM;
+
+	set_buffer_name(buffer, buffer_name);
+
 	pthread_setspecific(buffer_key, buffer);
 
 	return 0;
@@ -346,12 +396,36 @@ static void cleanup_buffer(struct print_buffer *buffer)
 {
 	struct print_buffer *prev, *next;
 
+	assert_nrt();
+
 	pthread_setspecific(buffer_key, NULL);
 
 	pthread_mutex_lock(&buffer_lock);
 
 	print_buffers();
 
+	pthread_mutex_unlock(&buffer_lock);
+
+#ifdef CONFIG_XENO_FASTSYNCH
+	{
+		struct print_buffer *old;
+
+		old = buf_pool_get();
+		buffer->pool_next = buffer;
+		while (old != buffer->next
+		       && xnarch_atomic_get(&pool_count) < pool_capacity) {
+			buffer->next = old;
+			old = buf_pool_cmpxchg(buffer->pool_next, buffer);
+		}
+		if (old == buffer->pool_next) {
+			xnarch_atomic_inc(&pool_count);
+			return;
+		}
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	pthread_mutex_lock(&buffer_lock);
+
 	prev = buffer->prev;
 	next = buffer->next;
 
@@ -523,6 +597,39 @@ void __rt_print_init(void)
 	print_period.tv_sec  = period / 1000;
 	print_period.tv_nsec = (period % 1000) * 1000000;
 
+#ifdef CONFIG_XENO_FASTSYNCH
+	{
+		unsigned i;
+
+		pool_capacity = RT_PRINT_DEFAULT_BUFFERS_COUNT;
+
+		value_str = getenv(RT_PRINT_BUFFERS_COUNT_ENV);
+		if (value_str) {
+			errno = 0;
+			pool_capacity = strtoul(value_str, NULL, 0);
+			if (errno) {
+				fprintf(stderr, "Invalid %s\n",
+					RT_PRINT_BUFFERS_COUNT_ENV);
+				exit(1);
+			}
+		}
+		for (i = 0; i < pool_capacity; i++) {
+			struct print_buffer *buffer;
+
+			buffer = rt_print_init_inner(default_buffer_size);
+			if (!buffer) {
+				fprintf(stderr, "Error allocating rt_printf "
+					"buffer\n");
+				exit(1);
+			}
+
+			buffer->pool_next = buf_pool_get();
+			buf_pool_set(buffer);
+		}
+		xnarch_atomic_set(&pool_count, pool_capacity);
+	}
+#endif /* CONFIG_XENO_FASTSYNCH */
+
 	pthread_mutex_init(&buffer_lock, NULL);
 	pthread_key_create(&buffer_key, (void (*)(void*))cleanup_buffer);
 


-- 
                                                                Gilles.

