From: Norbert Lange <nolange79@gmail.com>
Subject: [PATCH 1/2] lib/copperplate: remove wrapped heap function
Date: Mon,  3 Jun 2019 16:32:27 +0200
Message-Id: <20190603143228.11528-1-norbert.lange@andritz.com>
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

this will remove the dependency to libmodechk,
the original intent was to allow RT threads call
non-RT functions.
As the threads require to have weak scheduling policy,
there is no need to avoid checks (which arent active
in that policy).

Signed-off-by: Norbert Lange <norbert.lange@andritz.com>
---
 lib/copperplate/heapobj-heapmem.c | 14 +++++++-------
 lib/copperplate/heapobj-malloc.c  |  6 +++---
 lib/copperplate/registry.c        | 14 +++++++-------
 lib/copperplate/traceobj.c        |  4 ++--
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/copperplate/heapobj-heapmem.c b/lib/copperplate/heapobj-heapmem.c
index 2737fa7ac..bc6e5f236 100644
--- a/lib/copperplate/heapobj-heapmem.c
+++ b/lib/copperplate/heapobj-heapmem.c
@@ -33,15 +33,15 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 	void *_mem = mem;
 	int ret;
 
-	heap = __STD(malloc(sizeof(*heap)));
+	heap = malloc(sizeof(*heap));
 	if (heap == NULL)
 		return -ENOMEM;
 
 	if (mem == NULL) {
 		size = HEAPMEM_ARENA_SIZE(size); /* Count meta-data in. */
-		mem = __STD(malloc(size));
+		mem = malloc(size);
 		if (mem == NULL) {
-			__STD(free(heap));
+			free(heap);
 			return -ENOMEM;
 		}
 	}
@@ -57,8 +57,8 @@ int __heapobj_init_private(struct heapobj *hobj, const char *name,
 	ret = heapmem_init(hobj->pool, mem, size);
 	if (ret) {
 		if (_mem == NULL)
-			__STD(free(mem));
-		__STD(free(heap));
+			free(mem);
+		free(heap);
 		return ret;
 	}
 
@@ -99,13 +99,13 @@ int heapobj_pkg_init_private(void)
 		size = MIN_HEAPMEM_HEAPSZ;
 #endif
 	size = HEAPMEM_ARENA_SIZE(size);
-	mem = __STD(malloc(size));
+	mem = malloc(size);
 	if (mem == NULL)
 		return -ENOMEM;
 
 	ret = heapmem_init(&heapmem_main, mem, size);
 	if (ret) {
-		__STD(free(mem));
+		free(mem);
 		return ret;
 	}
 
diff --git a/lib/copperplate/heapobj-malloc.c b/lib/copperplate/heapobj-malloc.c
index ec82d7821..a3918cc23 100644
--- a/lib/copperplate/heapobj-malloc.c
+++ b/lib/copperplate/heapobj-malloc.c
@@ -92,7 +92,7 @@ void pvheapobj_destroy(struct heapobj *hobj)
 	struct pool_header *ph = hobj->pool;
 
 	__RT(pthread_mutex_destroy(&ph->lock));
-	__STD(free(ph));
+	free(ph);
 }
 
 int pvheapobj_extend(struct heapobj *hobj, size_t size, void *mem)
@@ -122,7 +122,7 @@ void *pvheapobj_alloc(struct heapobj *hobj, size_t size)
 	write_unlock(&ph->lock);
 
 	/* malloc(3) is not a cancellation point. */
-	ptr = __STD(malloc(size + sizeof(*bh)));
+	ptr = malloc(size + sizeof(*bh));
 	if (ptr == NULL) {
 		write_lock(&ph->lock);
 		goto fail;
@@ -149,7 +149,7 @@ void pvheapobj_free(struct heapobj *hobj, void *ptr)
 	write_lock(&ph->lock);
 	ph->used -= bh->size;
 	write_unlock(&ph->lock);
-	__STD(free(bh));
+	free(bh);
 }
 
 size_t pvheapobj_inquire(struct heapobj *hobj)
diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
index 1d1544805..a60bf9877 100644
--- a/lib/copperplate/registry.c
+++ b/lib/copperplate/registry.c
@@ -400,7 +400,7 @@ static int regfs_open(const char *path, struct fuse_file_info *fi)
 	}
 
 	if (fsobj->privsz) {
-		priv = __STD(malloc(fsobj->privsz));
+		priv = malloc(fsobj->privsz);
 		if (priv == NULL) {
 			ret = -ENOMEM;
 			goto done;
@@ -448,7 +448,7 @@ static int regfs_release(const char *path, struct fuse_file_info *fi)
 		CANCEL_RESTORE(svc);
 	}
 	if (priv)
-		__STD(free(priv));
+		free(priv);
 done:
 	read_unlock(&p->lock);
 	pop_cleanup_lock(&p->lock);
@@ -705,7 +705,7 @@ static int connect_regd(const char *sessdir, char **mountpt, int flags)
 	unsigned int hash;
 	socklen_t addrlen;
 
-	*mountpt = __STD(malloc(PATH_MAX));
+	*mountpt = malloc(PATH_MAX);
 	if (*mountpt == NULL)
 		return -ENOMEM;
 
@@ -720,7 +720,7 @@ static int connect_regd(const char *sessdir, char **mountpt, int flags)
 		s = __STD(socket(AF_UNIX, SOCK_SEQPACKET|SOCK_CLOEXEC, 0));
 		if (s < 0) {
 			ret = -errno;
-			__STD(free(*mountpt));
+			free(*mountpt);
 			return ret;
 		}
 		ret = __STD(connect(s, (struct sockaddr *)&sun, addrlen));
@@ -736,7 +736,7 @@ static int connect_regd(const char *sessdir, char **mountpt, int flags)
 		ret = -EAGAIN;
 	}
 
-	__STD(free(*mountpt));
+	free(*mountpt);
 
 	early_warning("cannot connect to registry daemon");
 
@@ -868,13 +868,13 @@ int fsobstack_grow_format(struct fsobstack *o, const char *fmt, ...)
 		       obstack_grow(&o->obstack, p, n);
 
 	       if (p != buf)
-		       __STD(free(p));
+		       free(p);
 
 	       if (n < len)
 		       return n < 0 ? -EINVAL : n;
 
 	       len = n + 1;
-	       p = __STD(malloc(len));
+	       p = malloc(len);
 	       if (p == NULL)
 		       break;
 	   }
diff --git a/lib/copperplate/traceobj.c b/lib/copperplate/traceobj.c
index 8a3f4f5e6..3c4d69bf8 100644
--- a/lib/copperplate/traceobj.c
+++ b/lib/copperplate/traceobj.c
@@ -78,7 +78,7 @@ int traceobj_init(struct traceobj *trobj, const char *label, int nr_marks)
 	trobj->cur_mark = 0;
 
 	if (nr_marks > 0) {
-		trobj->marks = __STD(malloc(sizeof(struct tracemark) * nr_marks));
+		trobj->marks = malloc(sizeof(struct tracemark) * nr_marks);
 		if (trobj->marks == NULL)
 			panic("cannot allocate mark table for tracing");
 	}
@@ -177,7 +177,7 @@ fail:
 
 void traceobj_destroy(struct traceobj *trobj)
 {
-	__STD(free(trobj->marks));
+	free(trobj->marks);
 	__RT(pthread_mutex_destroy(&trobj->lock));
 }
 
-- 
2.20.1


