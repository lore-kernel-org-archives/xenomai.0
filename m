Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <304110a1193e48e8304b.1480401144@devws148.be.alcatel-lucent.com>
Date: Tue, 29 Nov 2016 07:32:24 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] psos.h: remove dependency on tunables.h
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

The psos.h file pollutes the application's namespace with defines
of the boilerplate code because the tunables.h is included. In our
application we already have a definition of the list_entry macro,
resulting in a redefinition. The psos.h should be kept clean.

Following small test program clearly shows the issue:

#include <psos/psos.h>
#define list_entry
int main(int argc, char * const argv[])
{
  return 0;
}

When compiling the code above a warning is generated:

simple_test.c:3:1: warning: "list_entry" redefined
In file included from boilerplate/list.h:24,
                 from boilerplate/setup.h:21,
                 from boilerplate/tunables.h:22,
                 from psos/psos.h:28,
                 from simple_test.c:1:
boilerplate/shared-list.h:233:1: warning: this is the location of the previous definition

This patch resolves the issue by just removing the dependency
and all related functions. If the functions are actually needed, better to
move them in a separate header file since they are not part of the 'official'
psos interface.

diff --git a/include/psos/psos.h b/include/psos/psos.h
--- a/include/psos/psos.h
+++ b/include/psos/psos.h
@@ -25,7 +25,6 @@
 #define _XENOMAI_PSOS_PSOS_H
 
 #include <sys/types.h>
-#include <boilerplate/tunables.h>
 
 #ifndef SUCCESS
 #define SUCCESS 0
@@ -372,16 +371,6 @@ u_long psos_task_denormalize_priority(in
 
 extern int psos_long_names;
 
-static inline define_config_tunable(long_names, int, on)
-{
-	psos_long_names = on;
-}
-
-static inline read_config_tunable(long_names, int)
-{
-	return psos_long_names;
-}
-
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */

