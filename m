Resent-To: Philippe Gerum <rpm@xenomai.org>
Resent-Message-Id: <4AE2B519.9040908@domain.hid>
From: Jan Kiszka <jan.kiszka@domain.hid>
Date: Sat, 24 Oct 2009 10:03:04 +0200
Message-ID: <20091024080304.22784.93196.stgit@domain.hid>
In-Reply-To: <20091024080304.22784.46688.stgit@domain.hid>
References: <20091024080304.22784.46688.stgit@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: jan.kiszka@domain.hid
Subject: [Xenomai-core] [PATCH 1/2] Fork-safe rt_print
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: xenomai@xenomai.org, Oliver Schlenker <oliver.schlenker@domain.hid>

From: Oliver Schlenker <oliver.schlenker@domain.hid>

Fork-safe initialisation of rt_print library, necessary child initialisation are
done via pthread_atfork() when child process is started.

Signed-off-by: Oliver Schlenker <oliver.schlenker@domain.hid>
Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---

 src/rtdk/rt_print.c |   33 +++++++++++++++++++++++++++++----
 1 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/src/rtdk/rt_print.c b/src/rtdk/rt_print.c
index 0615247..dca9689 100644
--- a/src/rtdk/rt_print.c
+++ b/src/rtdk/rt_print.c
@@ -417,9 +417,35 @@ static void *printer_loop(void *arg)
 	}
 }
 
-void __rt_print_init(void)
+static void spawn_printer_thread(void)
 {
 	pthread_attr_t thattr;
+
+	pthread_attr_init(&thattr);
+	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
+	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
+}
+
+static void forked_child_init(void)
+{
+	struct print_buffer *my_buffer = pthread_getspecific(buffer_key);
+	struct print_buffer **pbuffer = &first_buffer;
+
+	/* re-init to avoid finding it locked by some parent thread */
+	pthread_mutex_init(&buffer_lock, NULL);
+
+	while (*pbuffer) {
+		if (*pbuffer == my_buffer)
+			pbuffer = &(*pbuffer)->next;
+		else
+			cleanup_buffer(*pbuffer);
+	}
+
+	spawn_printer_thread();
+}
+
+void __rt_print_init(void)
+{
 	const char *value_str;
 	unsigned long long period;
 
@@ -456,7 +482,6 @@ void __rt_print_init(void)
 
 	pthread_cond_init(&printer_wakeup, NULL);
 
-	pthread_attr_init(&thattr);
-	pthread_attr_setstacksize(&thattr, PTHREAD_STACK_MIN);
-	pthread_create(&printer_thread, &thattr, printer_loop, NULL);
+	spawn_printer_thread();
+	pthread_atfork(NULL, NULL, forked_child_init);
 }


