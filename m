Message-ID: <49A6A2AE.9080800@domain.hid>
Date: Thu, 26 Feb 2009 15:09:50 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [PATCH] rtdk: Suspend/resume printer thread
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

If someone is linking against rtdk for other reasons than using
rt_print, we should not let the printer thread poll the buffers
needlessly. So suspend it in case no buffer exists and resume once some
thread starts to use RT printing services.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/rtdk/rt_print.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 2d6875f..0615247 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -61,11 +61,13 @@ struct print_buffer {
 };
 
 static struct print_buffer *first_buffer;
+static int buffers;
 static uint32_t seq_no;
 static size_t default_buffer_size;
 static struct timespec print_period;
 static int auto_init;
 static pthread_mutex_t buffer_lock;
+static pthread_cond_t printer_wakeup;
 static pthread_key_t buffer_key;
 static pthread_t printer_thread;
 
@@ -258,6 +260,9 @@ int rt_print_init(size_t buffer_size, const char *buffer_name)
 		first_buffer->prev = buffer;
 	first_buffer = buffer;
 
+	buffers++;
+	pthread_cond_signal(&printer_wakeup);
+
 	pthread_mutex_unlock(&buffer_lock);
 
 	pthread_setspecific(buffer_key, buffer);
@@ -329,6 +334,8 @@ static void cleanup_buffer(struct print_buffer *buffer)
 	if (next)
 		next->prev = prev;
 
+	buffers--;
+
 	pthread_mutex_unlock(&buffer_lock);
 
 	free(buffer->ring);
@@ -397,13 +404,16 @@ static void print_buffers(void)
 static void *printer_loop(void *arg)
 {
 	while (1) {
-		nanosleep(&print_period, NULL);
-
 		pthread_mutex_lock(&buffer_lock);
 
+		while (buffers == 0)
+			pthread_cond_wait(&printer_wakeup, &buffer_lock);
+
 		print_buffers();
 
 		pthread_mutex_unlock(&buffer_lock);
+
+		nanosleep(&print_period, NULL);
 	}
 }
 
@@ -444,6 +454,8 @@ void __rt_print_init(void)
 	pthread_mutex_init(&buffer_lock, NULL);
 	pthread_key_create(&buffer_key, (void (*)(void*))cleanup_buffer);
 
+	pthread_cond_init(&printer_wakeup, NULL);
+
 	pthread_attr_init(&thattr);
 	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
 	pthread_create(&printer_thread, &thattr, printer_loop, NULL);

