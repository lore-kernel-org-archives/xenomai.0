Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <7223c73f876d31388593.1481802442@devws148.be.alcatel-lucent.com>
Date: Thu, 15 Dec 2016 12:47:22 +0100
From: Ronny Meeus <ronny.meeus@gmail.com>
Subject: [Xenomai] [PATCH] boilerplate: do not call xenomai_init 2 times
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

bootstrap.o is linked to the application code.
In case the execution of the static constructors is postponed
in the applicaion and the auto-init feature is used, the
xenomai_init is called 2 times:
- once in the path of the wrap_main
- later in the context of the static constructor

A check is already in place to not call xenomain_init when it
is called from __real_main. This patch adds a check in the
static constructor to skip it in case the __real_main already
did the init.

diff --git a/lib/boilerplate/init/bootstrap.c b/lib/boilerplate/init/bootstrap.c
--- a/lib/boilerplate/init/bootstrap.c
+++ b/lib/boilerplate/init/bootstrap.c
@@ -26,6 +26,8 @@ static int early_argc;
 
 static char *const *early_argv;
 
+static int xenomai_init_done;
+
 const int xenomai_auto_bootstrap = 1;
 
 int __real_main(int argc, char *const argv[]);
@@ -37,8 +39,9 @@ int xenomai_main(int argc, char *const a
 {
 	if (early_argc)
 		return __real_main(early_argc, early_argv);
-	
+
 	xenomai_init(&argc, &argv);
+	xenomai_init_done = 1;
 
 	return __real_main(argc, argv);
 }
@@ -49,6 +52,9 @@ int xenomai_main(int argc, char *const a
 	ssize_t len, ret;
 	int fd, n, argc;
 
+	if (xenomai_init_done)
+		return;
+
 	len = 1024;
 
 	for (;;) {

