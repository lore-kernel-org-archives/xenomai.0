Message-ID: <4E04EC53.3010305@domain.hid>
Date: Fri, 24 Jun 2011 21:58:11 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <4E0264CE.9060508@domain.hid> <4E02ED7E.7040204@domain.hid>
	<4E0301C4.8080605@domain.hid> <4E0302B3.3090201@domain.hid>
	<4E0323A7.2040107@domain.hid> <4E03253C.6090208@domain.hid>
In-Reply-To: <4E03253C.6090208@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] RFC: use a pool of pre-allocated buffers in
	rt_printf
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

On 06/23/2011 01:36 PM, Jan Kiszka wrote:
> On 2011-06-23 13:29, Gilles Chanteperdrix wrote:
>> On 06/23/2011 11:09 AM, Jan Kiszka wrote:
>>> On 2011-06-23 11:05, Gilles Chanteperdrix wrote:
>>>> On 06/23/2011 09:38 AM, Jan Kiszka wrote:
>>>>>> +#ifdef CONFIG_XENO_FASTSYNCH
>>>>>> +	if (xeno_get_current() != XN_NO_HANDLE &&
>>>>>> +	    !(xeno_get_current_mode() & XNRELAX) && buf_pool_get()) {
>>>>>> +		struct print_buffer *old;
>>>>>> +
>>>>>> +		old = buf_pool_get();
>>>>>> +		while (old != buffer) {
>>>>>> +			buffer = old;
>>>>>> +			old = buf_pool_cmpxchg(buffer, buffer->pool_next);
>>>>>
>>>>> Though unlikely, it's still possible: The buffer obtained in the last
>>>>> round may have been dequeued meanwhile and then freed (in case a third
>>>>> buffer was released to the pool, filling it up to pool_capacity).
>>>>
>>>> I do not get it: it seems to me that if the current head (that is
>>>> buf_pool_get()) is freed, then the cmpxchg will fail, so we will loop
>>>> and try again.
>>>
>>> Problematic is the dereferencing of the stale buffer pointer obtained
>>> during the last cmpxchg or via buf_pool_get. This happens before the new
>>> cmpxchg.
>>
>> Ok. Got it, that would be a problem only if the stale pointer pointed to
>> an unmapped area, but ok, better avoid freeing the buffers. I guess it
>> would not be a problem as applications tend to have a fixed number of
>> threads anyway.
> 
> That is a risky assumption, proven wrong e.g. by one of our
> applications. Threads may always be created or destroyed depending on
> the mode of an application, specifically if it is a larger one.

Here is another attempt, based on a bitmap.

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 93b711a..fb4820f 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -28,7 +28,9 @@
 #include <syslog.h>
 
 #include <rtdk.h>
+#include <nucleus/types.h>	/* For BITS_PER_LONG */
 #include <asm/xenomai/system.h>
+#include <asm/xenomai/atomic.h>	/* For atomic_cmpxchg */
 #include <asm-generic/stack.h>
 
 #define RT_PRINT_BUFFER_ENV		"RT_PRINT_BUFFER"
@@ -37,6 +39,9 @@
 #define RT_PRINT_PERIOD_ENV		"RT_PRINT_PERIOD"
 #define RT_PRINT_DEFAULT_PERIOD		100 /* ms */
 
+#define RT_PRINT_BUFFERS_COUNT_ENV      "RT_PRINT_BUFFERS_COUNT"
+#define RT_PRINT_DEFAULT_BUFFERS_COUNT  4
+
 #define RT_PRINT_LINE_BREAK		256
 
 #define RT_PRINT_SYSLOG_STREAM		NULL
@@ -75,6 +80,12 @@ static pthread_mutex_t buffer_lock;
 static pthread_cond_t printer_wakeup;
 static pthread_key_t buffer_key;
 static pthread_t printer_thread;
+#ifdef CONFIG_XENO_FASTSYNCH
+static xnarch_atomic_t *pool_bitmap;
+static unsigned pool_bitmap_len;
+static unsigned pool_buf_size;
+static unsigned long pool_start, pool_len;
+#endif /* CONFIG_XENO_FASTSYNCH */
 
 static void cleanup_buffer(struct print_buffer *buffer);
 static void print_buffers(void);
@@ -243,10 +254,36 @@ static void set_buffer_name(struct print_buffer *buffer, const char *name)
 	}
 }
 
+void rt_print_init_inner(struct print_buffer *buffer, size_t size)
+{
+	buffer->size = size;
+
+	memset(buffer->ring, 0, size);
+
+	buffer->read_pos  = 0;
+	buffer->write_pos = 0;
+
+	buffer->prev = NULL;
+
+	pthread_mutex_lock(&buffer_lock);
+
+	buffer->next = first_buffer;
+	if (first_buffer)
+		first_buffer->prev = buffer;
+	first_buffer = buffer;
+
+	buffers++;
+	pthread_cond_signal(&printer_wakeup);
+
+	pthread_mutex_unlock(&buffer_lock);
+}
+
 int rt_print_init(size_t buffer_size, const char *buffer_name)
 {
 	struct print_buffer *buffer = pthread_getspecific(buffer_key);
 	size_t size = buffer_size;
+	unsigned long old_bitmap;
+	unsigned j;
 
 	if (!size)
 		size = default_buffer_size;
@@ -260,39 +297,56 @@ int rt_print_init(size_t buffer_size, const char *buffer_name)
 			return 0;
 		}
 		cleanup_buffer(buffer);
+		buffer = NULL;
 	}
 
-	buffer = malloc(sizeof(*buffer));
-	if (!buffer)
-		return ENOMEM;
+#ifdef CONFIG_XENO_FASTSYNCH
+	/* Find a free buffer in the pool */
+	do {
+		unsigned long bitmap;
+		unsigned i;
 
-	buffer->ring = malloc(size);
-	if (!buffer->ring) {
-		free(buffer);
-		return ENOMEM;
-	}
-	memset(buffer->ring, 0, size);
+		for (i = 0; i < pool_bitmap_len; i++) {
+			old_bitmap = xnarch_atomic_get(&pool_bitmap[i]);
+			if (old_bitmap)
+				goto acquire;
+		}
 
-	buffer->read_pos  = 0;
-	buffer->write_pos = 0;
+		goto not_found;
 
-	buffer->size = size;
+	  acquire:
+		do {
+			bitmap = old_bitmap;
+			j = __builtin_ffsl(bitmap) - 1;
+			old_bitmap = xnarch_atomic_cmpxchg(&pool_bitmap[i],
+							   bitmap,
+							   bitmap & ~(1UL << j));
+		} while (old_bitmap != bitmap && old_bitmap);
+		j += i * BITS_PER_LONG;
+	} while (!old_bitmap);
 
-	set_buffer_name(buffer, buffer_name);
+	buffer = (struct print_buffer *)(pool_start + j * pool_buf_size);
 
-	buffer->prev = NULL;
+  not_found:
+#endif /* CONFIG_XENO_FASTSYNCH */
 
-	pthread_mutex_lock(&buffer_lock);
+	if (!buffer) {
+		assert_nrt();
 
-	buffer->next = first_buffer;
-	if (first_buffer)
-		first_buffer->prev = buffer;
-	first_buffer = buffer;
+		buffer = malloc(sizeof(*buffer));
+		if (!buffer)
+			return ENOMEM;
 
-	buffers++;
-	pthread_cond_signal(&printer_wakeup);
+		buffer->ring = malloc(size);
+		if (!buffer->ring) {
+			free(buffer);
+			return ENOMEM;
+		}
 
-	pthread_mutex_unlock(&buffer_lock);
+		rt_print_init_inner(buffer, size);
+	}
+
+	set_buffer_name(buffer, buffer_name);
 
 	pthread_setspecific(buffer_key, buffer);
 
@@ -346,12 +400,44 @@ static void cleanup_buffer(struct print_buffer *buffer)
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
+	/* Return the buffer to the pool */
+	{
+		unsigned long old_bitmap, bitmap;
+		unsigned i, j;
+
+		if ((unsigned long)buffer - pool_start >= pool_len)
+			goto dofree;
+
+		j = ((unsigned long)buffer - pool_start) / pool_buf_size;
+		i = j / BITS_PER_LONG;
+		j = j % BITS_PER_LONG;
+
+		old_bitmap = xnarch_atomic_get(&pool_bitmap[i]);
+		do {
+			bitmap = old_bitmap;
+			old_bitmap = xnarch_atomic_cmpxchg(&pool_bitmap[i],
+							   bitmap,
+							   bitmap | (1UL << j));
+		} while (old_bitmap != bitmap);
+
+		return;
+	}
+  dofree:
+#endif /* CONFIG_XENO_FASTSYNCH */
+
+	pthread_mutex_lock(&buffer_lock);
+
 	prev = buffer->prev;
 	next = buffer->next;
 
@@ -523,6 +609,64 @@ void __rt_print_init(void)
 	print_period.tv_sec  = period / 1000;
 	print_period.tv_nsec = (period % 1000) * 1000000;
 
+#ifdef CONFIG_XENO_FASTSYNCH
+	/* Fill the buffer pool */
+	{
+		unsigned buffers_count, i;
+
+		buffers_count = RT_PRINT_DEFAULT_BUFFERS_COUNT;
+
+		value_str = getenv(RT_PRINT_BUFFERS_COUNT_ENV);
+		if (value_str) {
+			errno = 0;
+			buffers_count = strtoul(value_str, NULL, 0);
+			if (errno) {
+				fprintf(stderr, "Invalid %s\n",
+					RT_PRINT_BUFFERS_COUNT_ENV);
+				exit(1);
+			}
+		}
+
+		pool_bitmap_len = (buffers_count + BITS_PER_LONG - 1)
+			/ BITS_PER_LONG;
+		if (!pool_bitmap_len)
+			goto done;
+
+		pool_bitmap = malloc(pool_bitmap_len * sizeof(*pool_bitmap));
+		if (!pool_bitmap) {
+			fprintf(stderr, "Error allocating rt_printf "
+				"buffers\n");
+			exit(1);
+		}
+
+		pool_buf_size = sizeof(struct print_buffer) + default_buffer_size;
+		pool_len = buffers_count * pool_buf_size;
+		pool_start = (unsigned long)malloc(pool_len);
+		if (!pool_start) {
+			fprintf(stderr, "Error allocating rt_printf "
+				"buffers\n");
+			exit(1);
+		}
+
+		for (i = 0; i < buffers_count / BITS_PER_LONG; i++)
+			xnarch_atomic_set(&pool_bitmap[i], ~0UL);
+		if (buffers_count % BITS_PER_LONG)
+			xnarch_atomic_set(&pool_bitmap[i],
+					  (1UL << (buffers_count % BITS_PER_LONG))					  - 1);
+
+		for (i = 0; i < buffers_count; i++) {
+			struct print_buffer *buffer =
+				(struct print_buffer *)
+				(pool_start + i * pool_buf_size);
+
+			buffer->ring = (char *)(buffer + 1);
+
+			rt_print_init_inner(buffer, default_buffer_size);
+		}
+	}
+  done:
+#endif /* CONFIG_XENO_FASTSYNCH */
+
 	pthread_mutex_init(&buffer_lock, NULL);
 	pthread_key_create(&buffer_key, (void (*)(void*))cleanup_buffer);
 

-- 
                                                                Gilles.

