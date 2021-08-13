From: Fabrice Fontaine <fontaine.fabrice@gmail.com>
Subject: [PATCH v2,1/2] fix build on arc and riscv32
Date: Fri, 13 Aug 2021 17:04:31 +0200
Message-Id: <20210813150432.3215777-1-fontaine.fabrice@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Fix the following build failures on arc and riscv32 (same issue in
demo/alchemy/altency.c and testsuite/latency/latency.c):

altency.c: In function ‘display’:
altency.c:262:21: error: format ‘%ld’ expects argument of type ‘long int’, but argument 2 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
      |                 ~~~~^
      |                     |
      |                     long int
      |                 %.2lld
  263 |          "priority %d)\n", dt / 3600,
      |                            ~~~~~~~~~
      |                               |
      |                               time_t {aka long long int}
altency.c:262:27: error: format ‘%ld’ expects argument of type ‘long int’, but argument 3 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
      |                       ~~~~^
      |                           |
      |                           long int
      |                       %.2lld
  263 |          "priority %d)\n", dt / 3600,
  264 |          (dt / 60) % 60, dt % 60,
      |          ~~~~~~~~~~~~~~
      |                    |
      |                    time_t {aka long long int}
altency.c:262:33: error: format ‘%ld’ expects argument of type ‘long int’, but argument 4 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  262 |         ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
      |                             ~~~~^
      |                                 |
      |                                 long int
      |                             %.2lld
  263 |          "priority %d)\n", dt / 3600,
  264 |          (dt / 60) % 60, dt % 60,
      |                          ~~~~~~~
      |                             |
      |                             time_t {aka long long int}
altency.c: In function ‘cleanup’:
altency.c:417:7: error: format ‘%ld’ expects argument of type ‘long int’, but argument 7 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  417 |      ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
  420 |       goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
      |                              ~~~~~~~~~~~~~~~~~~~~~~
      |                                              |
      |                                              time_t {aka long long int}
altency.c:418:49: note: format string is defined here
  418 |       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
      |                                             ~~~~^
      |                                                 |
      |                                                 long int
      |                                             %.2lld
altency.c:417:7: error: format ‘%ld’ expects argument of type ‘long int’, but argument 8 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  417 |      ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
  420 |       goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
      |                                                      ~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                                                                             |
      |                                                                             time_t {aka long long int}
altency.c:418:55: note: format string is defined here
  418 |       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
      |                                                   ~~~~^
      |                                                       |
      |                                                       long int
      |                                                   %.2lld
altency.c:417:7: error: format ‘%ld’ expects argument of type ‘long int’, but argument 9 has type ‘time_t’ {aka ‘long long int’} [-Werror=format=]
  417 |      ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
      |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
......
  421 |       actual_duration % 60, test_duration / 3600,
      |       ~~~~~~~~~~~~~~~~~~~~
      |                       |
      |                       time_t {aka long long int}
altency.c:418:61: note: format string is defined here
  418 |       "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
      |                                                         ~~~~^
      |                                                             |
      |                                                             long int
      |                                                         %.2lld

Fixes:
 - http://autobuild.buildroot.org/results/448efe22e8fe058a1b354a3c124874e30b9ce138

Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>
---
Changes v1 -> v2 (after review of Jan Kiszka)
 - Reword original patch and add a patch to fix issues

 demo/alchemy/altency.c      | 4 ++--
 testsuite/latency/latency.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/demo/alchemy/altency.c b/demo/alchemy/altency.c
index e7c31d7c1..6b81f11d9 100644
--- a/demo/alchemy/altency.c
+++ b/demo/alchemy/altency.c
@@ -259,7 +259,7 @@ static void display(void *cookie)
 				time(&now);
 				dt = now - start - WARMUP_TIME;
 				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
+				    ("RTT|  %.2lld:%.2lld:%.2lld  (%s, %Ld us period, "
 				     "priority %d)\n", dt / 3600,
 				     (dt / 60) % 60, dt % 60,
 				     test_mode_names[test_mode],
@@ -415,7 +415,7 @@ static void cleanup(void)
 
 	printf
 	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
+	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
 	     (double)gminj / 1000, (double)gavgj / 1000, (double)gmaxj / 1000,
 	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
 	     actual_duration % 60, test_duration / 3600,
diff --git a/testsuite/latency/latency.c b/testsuite/latency/latency.c
index a0e6f4826..41717253e 100644
--- a/testsuite/latency/latency.c
+++ b/testsuite/latency/latency.c
@@ -323,7 +323,7 @@ static void *display(void *cookie)
 				time(&now);
 				dt = now - start - WARMUP_TIME;
 				printf
-				    ("RTT|  %.2ld:%.2ld:%.2ld  (%s, %Ld us period, "
+				    ("RTT|  %.2lld:%.2lld:%.2lld  (%s, %Ld us period, "
 				     "priority %d)\n", dt / 3600,
 				     (dt / 60) % 60, dt % 60,
 				     test_mode_names[test_mode],
@@ -517,7 +517,7 @@ static void cleanup(void)
 
 	printf
 	    ("---|-----------|-----------|-----------|--------|------|-------------------------\n"
-	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2ld:%.2ld:%.2ld/%.2d:%.2d:%.2d\n",
+	     "RTS|%11.3f|%11.3f|%11.3f|%8d|%6u|    %.2lld:%.2lld:%.2lld/%.2d:%.2d:%.2d\n",
 	     (double)gminjitter / 1000, (double)gavgjitter / 1000, (double)gmaxjitter / 1000,
 	     goverrun, max_relaxed, actual_duration / 3600, (actual_duration / 60) % 60,
 	     actual_duration % 60, test_duration / 3600,
-- 
2.30.2


