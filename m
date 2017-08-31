MIME-Version: 1.0
From: Ronny Meeus <ronny.meeus@gmail.com>
Date: Thu, 31 Aug 2017 16:02:25 +0200
Message-ID: <CAMJ=MEf5=ZhKBss8GD=ju8efx5GiO_vrGdu1jerW1orpw6+MPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Xenomai] mercury/psos: dump of long message queue causes
	application crash
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello

I have a test application that creates a psos queue and sends a lot of
messages to it.
The application code can be found below.

Depending on the memory configuration it can be that error are
generated after some
time but that is not the issue. When dump the queue in the debug
interface I see a crash
of the application:

/mnt/xenomai/anon/root/anon/11091/psos/queues # cat LINE
memory exhausted
cat: can't open 'LINE': Software caused connection abort

The root-cause of this is that the size of the obstack used in the
registry is in fact unlimited.
In case it needs to grow and there is no memory anymore, a handler is
called that is
reporting the memory shortage condition and triggers an exit.

In my opinion it is not correct that this condition triggers an
application reset. I would rather
prefer that in case there is a memory shortage, the dump is just
stopped or that we limit the
memory that is used worst case in the obstack in the registry.

The patch below solves the issue but I do not whether it is the right direction.
Depending on the available memory it might still crash ...

diff --git a/include/copperplate/registry-obstack.h
b/include/copperplate/registry-obstack.h
--- a/include/copperplate/registry-obstack.h
diff --git a/include/copperplate/registry-obstack.h
b/include/copperplate/registry-obstack.h
--- a/include/copperplate/registry-obstack.h
+++ b/include/copperplate/registry-obstack.h
@@ -35,6 +35,8 @@ struct syncobj;
 #define obstack_chunk_alloc    pvmalloc
 #define obstack_chunk_free     pvfree

+#define OBSTACK_MAX_SIZE 65536
+
 struct threadobj;

 struct fsobstack {
diff --git a/lib/copperplate/registry.c b/lib/copperplate/registry.c
--- a/lib/copperplate/registry.c
+++ b/lib/copperplate/registry.c
@@ -880,9 +880,10 @@ int fsobstack_grow_format(struct fsobsta
               n = vsnprintf(p, len, fmt, ap);
               va_end(ap);

-              if (n > 0 && n < len)
-                      obstack_grow(&o->obstack, p, n);
-
+               if (n > 0 && n < len) {
+                       if (obstack_object_size(&o->obstack) < OBSTACK_MAX_SIZE)
+                               obstack_grow(&o->obstack, p, n);
+               }
               if (p != buf)
                       pvfree(p);

@@ -900,12 +901,14 @@ int fsobstack_grow_format(struct fsobsta

 void fsobstack_grow_string(struct fsobstack *o, const char *s)
 {
-       obstack_grow(&o->obstack, s, strlen(s));
+       if (obstack_object_size(&o->obstack) < OBSTACK_MAX_SIZE)
+               obstack_grow(&o->obstack, s, strlen(s));
 }

 void fsobstack_grow_char(struct fsobstack *o, char c)
 {
-       obstack_1grow(&o->obstack, c);
+       if (obstack_object_size(&o->obstack) < OBSTACK_MAX_SIZE)
+               obstack_1grow(&o->obstack, c);
 }

 int fsobstack_grow_file(struct fsobstack *o, const char *path)
@@ -925,7 +928,8 @@ int fsobstack_grow_file(struct fsobstack
                                len = -errno;
                        break;
                }
-               obstack_1grow(&o->obstack, c);
+               if (obstack_object_size(&o->obstack) < OBSTACK_MAX_SIZE)
+               i       obstack_1grow(&o->obstack, c);
                len++;
        }

@@ -1007,8 +1011,10 @@ redo:
        e = obstack_next_free(&cache);
        p = obstack_finish(&cache);
        if (ops->format_data == NULL) {
-               if (e != p)
-                       obstack_grow(&o->obstack, p, e - p);
+               if (e != p) {
+                       if (obstack_object_size(&o->obstack) < OBSTACK_MAX_SIZE)
+                               obstack_grow(&o->obstack, p, e - p);
+               }
                goto out;


Any hints/suggestions for a better implementation/solution are welcome.
Thanks

Best regards
Ronny

TEST application:

#include <version.h>
#include <psos.h>
#include <stdio.h>

static void main_test_task(u_long a,u_long b,u_long c,u_long d)
{
        unsigned long qid, err;
        int i;
        unsigned long message_count = 1000000;
        unsigned long mesg[4];

        q_create("LINE",0,Q_NOLIMIT|Q_PRIOR,&qid);
        for (i=0;i<message_count;i++)
        {
                err = q_send(qid, mesg);
                if (err != 0)
                    printf("Error: q_send err=%ld count=%d\n", err, i);
        }
        printf("SUCCESS: Test passed (nr messages sent=%ld)\n",message_count);

        while (1)
                tm_wkafter(1000);
}

int main(int argc, char * const *argv)
{
        unsigned long tid;
        unsigned long args[4] = {0,0,0,0};

        t_create("MAIN",25,16000,16000,0,&tid);
        t_start(tid,T_PREEMPT|T_TSLICE,main_test_task,args);
        while (1)
                tm_wkafter(1000);
}

