Message-ID: <48D0DD10.5070502@domain.hid>
Date: Wed, 17 Sep 2008 12:33:52 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <200809152042.55704.niklaus.giger@domain.hid>
In-Reply-To: <200809152042.55704.niklaus.giger@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] Xenomai-Solo: bug in vxWorks taskSpawn with
 twice the same name
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Niklaus Giger <niklaus.giger@domain.hid>
Cc: xenomai-core <xenomai@xenomai.org>

Niklaus Giger wrote:
> Hi
> 
> Thanks a lot to Philippe for fixing the previous bug so quickly! Never got
> fixed a bug as fast by WindRIver despite having paid quite a lot of money
> for it!
>

inertia = success / competition

> Now my testsuite passes almost all tests but crashes, when it spawns
> twice a task with the same name. E.g. I get the following output:
>> testTask done t1 0x901a0f4 t2 0x901a2b4
>> Xenomai/SOLO: duplicate task name: Test
>> assert passed at task1 line 24
>> assert passed at task1 line 24
>> assert passed at task1 line 26
>> assert passed at task1 line 26
>>
>> Command terminated by signal 11
> 
> Attached my simple test case.
>

I eventually found out that this problem was triggered by the registry support,
in case duplicate names where found. This patch should fix the issue:

diff --git a/base/registry.c b/base/registry.c
index 6ab7461..d0ada62 100644
--- a/base/registry.c
+++ b/base/registry.c
@@ -116,11 +116,28 @@ done:
 	return ret;
 }

-int registry_add_file(struct fsobj *fsobj, struct registry_operations *ops,
-		      int mode, const char *fmt, ...)
+int registry_init_file(struct fsobj *fsobj,  struct registry_operations *ops)
 {
-	char path[PATH_MAX], *basename, *dir;
 	pthread_mutexattr_t mattr;
+
+	if (__no_registry_arg)
+		return 0;
+
+	fsobj->path = NULL;
+	fsobj->ops = ops;
+	holder_init(&fsobj->link);
+
+	pthread_mutexattr_init(&mattr);
+	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
+	pthread_mutex_init(&fsobj->lock, &mattr);
+	pthread_mutexattr_destroy(&mattr);
+
+	return 0;
+}
+
+int registry_add_file(struct fsobj *fsobj, int mode, const char *fmt, ...)
+{
+	char path[PATH_MAX], *basename, *dir;
 	struct hashobj *hobj;
 	struct regfs_dir *d;
 	va_list ap;
@@ -139,16 +156,9 @@ int registry_add_file(struct fsobj *fsobj, struct
registry_operations *ops,

 	fsobj->path = xnstrdup(path);
 	fsobj->basename = fsobj->path + (basename - path) + 1;
-	fsobj->ops = ops;
 	fsobj->mode = mode & O_ACCMODE;
 	clock_gettime(CLOCK_REALTIME, &fsobj->ctime);
 	fsobj->mtime = fsobj->ctime;
-	holder_init(&fsobj->link);
-
-	pthread_mutexattr_init(&mattr);
-	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
-	pthread_mutex_init(&fsobj->lock, &mattr);
-	pthread_mutexattr_destroy(&mattr);

 	pthread_mutex_lock(&regfs_lock);

@@ -161,7 +171,9 @@ int registry_add_file(struct fsobj *fsobj, struct
registry_operations *ops,
 	hobj = hash_search(&regfs_dirtable, dir);
 	if (hobj == NULL) {
 	fail:
+		hash_remove(&regfs_objtable, &fsobj->hobj);
 		xnfree(path);
+		fsobj->path = NULL;
 		ret = -ENOENT;
 		goto done;
 	}
@@ -184,6 +196,10 @@ void registry_remove_file(struct fsobj *fsobj)
 		return;

 	pthread_mutex_lock(&regfs_lock);
+
+	if (fsobj->path == NULL)
+		goto out;	/* Not registered. */
+
 	hash_remove(&regfs_objtable, &fsobj->hobj);

 	pthread_mutex_lock(&fsobj->lock);
@@ -194,7 +210,7 @@ void registry_remove_file(struct fsobj *fsobj)
 	xnfree(fsobj->path);
 	pthread_mutex_unlock(&fsobj->lock);
 	pthread_mutex_destroy(&fsobj->lock);
-
+out:
 	pthread_mutex_unlock(&regfs_lock);
 }

diff --git a/include/xenomai/registry.h b/include/xenomai/registry.h
index 15b98a3..e7f6247 100644
--- a/include/xenomai/registry.h
+++ b/include/xenomai/registry.h
@@ -57,8 +57,10 @@ extern "C" {

 int registry_add_dir(const char *fmt, ...);

+int registry_init_file(struct fsobj *fsobj,
+		       struct registry_operations *ops);
+
 int registry_add_file(struct fsobj *fsobj,
-		      struct registry_operations *ops,
 		      int mode,
 		      const char *fmt, ...);

@@ -89,8 +91,14 @@ int registry_add_dir(const char *fmt, ...)
 }

 static inline
+int registry_init_file(struct fsobj *fsobj,
+		       struct registry_operations *ops)
+{
+	return 0;
+}
+
+static inline
 int registry_add_file(struct fsobj *fsobj,
-		      struct registry_operations *ops,
 		      int mode,
 		      const char *fmt, ...)
 {
diff --git a/vxworks/taskLib.c b/vxworks/taskLib.c
index 8c1e612..f6253b2 100644
--- a/vxworks/taskLib.c
+++ b/vxworks/taskLib.c
@@ -234,17 +234,18 @@ static void *task_trampoline(void *arg)
 		goto done;
 	}

+	ret = registry_init_file(&task->fsobj, &registry_ops);
+
 	if (hash_enter(&wind_task_table, task->name, &task->obj)) {
 		warning("duplicate task name: %s", task->name);
 		/* Make sure we won't un-hash the previous one. */
 		strcpy(task->name, "(dup)");
-	} else {
-		ret = registry_add_file(&task->fsobj, &registry_ops, O_RDONLY,
+	} else if (ret == 0)
+		ret = registry_add_file(&task->fsobj, O_RDONLY,
 					"/vxworks/tasks/%s", task->name);
-		if (ret)
-			warning("failed to export task %s to registry",
-				task->name);
-	}
+	if (ret)
+		warning("failed to export task %s to registry",
+			task->name);

 	pthread_setcancelstate(PTHREAD_CANCEL_ENABLE, NULL);
 	pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL);

-- 
Philippe.


