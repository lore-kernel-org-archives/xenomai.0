Date: Wed, 15 Jul 2015 12:45:49 +0000 (UTC)
From: Frederik Bayart <frederik_bayart@yahoo.co.uk>
Message-ID: <1504864203.3834276.1436964349384.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <55A4DC2F.1090608@xenomai.org>
References: <55A4DC2F.1090608@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] xenomai-3.0-rc5 : binding named semaphores from
 external process
Reply-To: Frederik Bayart <frederik_bayart@yahoo.co.uk>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

> On Tuesday, 14 July 2015, 11:53, Philippe Gerum <rpm@xenomai.org> wrote:
>
>
>On 07/13/2015 03:37 PM, Frederik Bayart wrote:
>
>> Hallo,
>>
>> I have problems to bind named semaphores from an external process using
>> the alchemy API.  Below a detailed description. Does anyone have a suggestion
>>
>> what could be wrong or what I could do to solve the problem ?
>> Kind regards,
>>
>> Frederik
>>
>> In attachment an example to reproduce my problem (makefile, stest.c).
>> If you run 'sudo ./stest 1', a named semaphore is created and a task is started
>> that binds it and perform a p operation. The main task is waiting on CTRL+C,
>> and then ask the numer of waiters and performs v operations.
>> If you run 'sudo ./stest 0', the named semaphore is not created, only a task is
>> started that binds it and perform a p operation.
>>
>> I start first 'sudo ./stest 1'. The process binds the semaphore and blocks on rt_sem_p.
>> The content of /var/run/xenomai is :
>
>>
>
>[snip]
>
>The key issue is that multiple programs forming a single application
>must belong to the same Xenomai session, for sharing data/objects. The
>notion of "session" was introduced by Xenomai 3.
>
>So, all you need to do, is to tell the application bootstrap code about
>the session you want to create between several programs, e.g.:
>
># ./stest --session=foo 1
># ./stest --session=foo 0
>
>-- 
>Philippe.

This works. I still notice 2 issues :

1) If you execute reversely

./stest --session=foo 0
./stest --session=foo 1

The first process binds to the named semaphore which is not yet created. According to the description of rt_sem_bind,  if the object does not exist on entry, the caller may block until a semaphore of the given name is created.

So based on this description, I would I expect that if the second process is started, the first process would bind and continue and blocks in the p operation. The same for the 2nd process. Is this correct ? At the moment, if I start the 2nd process, I get a segfault in rt_sem_create :

[ 9758.887921] [Xenomai] switching main to secondary mode after exception #14 from user-space at 0x7f6ad8c4a43e (pid 9256)
[ 9758.887930] main[9256]: segfault at 7f903bf6e038 ip 00007f6ad8c4a43e sp 00007fffbd2c2eb8 error 6 in libcobalt.so.2.0.0[7f6ad8c3d000+1e000]


2)

The fuse filesystem is not unmounted. This is because in xenomai-3.0-rc5/lib/copperplate/regd/regd.c the fullpath is hardcoded to fusermount and umount

sh: 1: /usr/bin/fusermount: not found
sysregd: create_directory_recursive("/var/run/xenomai/root/stest/system"): Transport endpoint is not connected
sh: 1: /usr/bin/fusermount: not found
sysregd: create_directory_recursive("/var/run/xenomai/root/stest/system"): Transport endpoint is not connected
sh: 1: /usr/bin/fusermount: not found
sysregd: create_directory_recursive("/var/run/xenomai/root/stest/system"): Transport endpoint is not connected
0"602.802| WARNING: [main] cannot connect to registry daemon
0"602.875| WARNING: [main] setup call copperplate failed
0"602.929| BUG in xenomai_init(): [main] initialization failed, EAGAIN

In the code is written :

/usr/bin/fusermount
/usr/bin/umount

However, on debian jessie, these binaries are in /bin, not in /usr/bin.
It's hardcoded, so if I think this is not a configure problem.

I could fixed it, with the diff below. It's not clear to me why access of umount is tested and not from fusermount.


Frederik


--- regd.c.old    2015-07-14 15:58:09.748049358 +0200
+++ regd.c.new    2015-07-15 14:41:52.798401291 +0200
@@ -22,6 +22,7 @@
#include <sys/select.h>
#include <sys/timerfd.h>
#include <sys/un.h>
+#include <linux/limits.h>
#include <signal.h>
#include <stdio.h>
#include <limits.h>
@@ -65,6 +66,8 @@
struct pvholder next;
};

+static char *umount_fullpath = NULL;
+
static DEFINE_PRIVATE_LIST(client_list);

static void usage(void)
@@ -76,6 +79,36 @@
fprintf(stderr, "               [--linger]       disable timed exit on idleness\n");
}

+static char *afullpath(const char *cmd)
+{
+    FILE *fp;
+    char *which_cmd;
+    char path[PATH_MAX];
+    char *fullpath;
+    int len;
+
+    if (asprintf(&which_cmd, "which %s", cmd) == -1)
+        return NULL;
+
+    fp = popen(which_cmd, "r");
+    free(which_cmd);
+    if (fp == NULL)
+        return NULL;
+
+    if (fgets(path, sizeof(path), fp) == NULL) {
+        pclose(fp);
+        return NULL;
+    }
+
+    pclose(fp);
+    len = strlen(path) - 1;
+    if (path[len] == '\n')
+        path[len--] = '\0';
+    fullpath = malloc(len+2);
+    strcpy(fullpath, path);
+    return fullpath;
+}
+
static const struct option options[] = {
{
#define help_opt    0
@@ -279,7 +312,7 @@
if (flags >= 0)
fcntl(2, F_SETFD, flags | FD_CLOEXEC);

-    ret = asprintf(&cmd, "/usr/bin/fusermount -uzq %s", path);
+    ret = asprintf(&cmd, "fusermount -uzq %s", path);
if (ret < 0)
return;

@@ -288,10 +321,10 @@
if (ret != -1 && WIFEXITED(ret) && WEXITSTATUS(ret) == 0)
return;

-    if (access("/usr/bin/umount", X_OK))
+    if (access(umount_fullpath, X_OK))
return;

-    ret = asprintf(&cmd, "/usr/bin/umount -l %s", path);
+    ret = asprintf(&cmd, "%s -l %s", umount_fullpath, path);
if (ret < 0)
return;

@@ -529,6 +562,10 @@
if (rootdir == NULL)
error(1, EINVAL, "--root must be given");

+    umount_fullpath = afullpath("umount");
+    if (umount_fullpath == NULL)
+        error(1, ENOENT, "umount not found in path");
+
memset(&sa, 0, sizeof(sa));
sa.sa_handler = SIG_IGN;
sigaction(SIGCHLD, &sa, NULL);
@@ -544,6 +581,7 @@
bind_socket();
create_system_fs(argv[0], rootdir, flags);
handle_requests();
+    free(umount_fullpath);

return 0;

}

