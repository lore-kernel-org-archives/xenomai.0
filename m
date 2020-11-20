From: Philippe  Gerum <rpm@xenomai.org>
Subject: [PATCH 2/2] demo/posix/cobalt: add missing __STD() annotation to
 sigwait()
Date: Fri, 20 Nov 2020 18:17:11 +0100
Message-Id: <20201120171711.2784854-2-rpm@xenomai.org>
In-Reply-To: <20201120171711.2784854-1-rpm@xenomai.org>
References: <20201120171711.2784854-1-rpm@xenomai.org>
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

From: Philippe Gerum <rpm@xenomai.org>

We want to wait for ^C or any hangup condition received from the root
stage, make sure to annotate as __STD(sigwait()) to bypass symbol
wrapping.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 demo/posix/cobalt/bufp-label.c     | 2 +-
 demo/posix/cobalt/bufp-readwrite.c | 2 +-
 demo/posix/cobalt/iddp-label.c     | 2 +-
 demo/posix/cobalt/iddp-sendrecv.c  | 2 +-
 demo/posix/cobalt/xddp-echo.c      | 2 +-
 demo/posix/cobalt/xddp-label.c     | 2 +-
 demo/posix/cobalt/xddp-stream.c    | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/demo/posix/cobalt/bufp-label.c b/demo/posix/cobalt/bufp-label.c
index 0b766867a..1141c8913 100644
--- a/demo/posix/cobalt/bufp-label.c
+++ b/demo/posix/cobalt/bufp-label.c
@@ -211,7 +211,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(svtid);
 	pthread_cancel(cltid);
 	pthread_join(svtid, NULL);
diff --git a/demo/posix/cobalt/bufp-readwrite.c b/demo/posix/cobalt/bufp-readwrite.c
index 1796e3018..34d761aeb 100644
--- a/demo/posix/cobalt/bufp-readwrite.c
+++ b/demo/posix/cobalt/bufp-readwrite.c
@@ -176,7 +176,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(svtid);
 	pthread_cancel(cltid);
 	pthread_join(svtid, NULL);
diff --git a/demo/posix/cobalt/iddp-label.c b/demo/posix/cobalt/iddp-label.c
index f4718a442..06fc8814c 100644
--- a/demo/posix/cobalt/iddp-label.c
+++ b/demo/posix/cobalt/iddp-label.c
@@ -228,7 +228,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(svtid);
 	pthread_cancel(cltid);
 	pthread_join(svtid, NULL);
diff --git a/demo/posix/cobalt/iddp-sendrecv.c b/demo/posix/cobalt/iddp-sendrecv.c
index 734d47465..31ee10fde 100644
--- a/demo/posix/cobalt/iddp-sendrecv.c
+++ b/demo/posix/cobalt/iddp-sendrecv.c
@@ -184,7 +184,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(svtid);
 	pthread_cancel(cltid);
 	pthread_join(svtid, NULL);
diff --git a/demo/posix/cobalt/xddp-echo.c b/demo/posix/cobalt/xddp-echo.c
index 7e0af1265..ba8558266 100644
--- a/demo/posix/cobalt/xddp-echo.c
+++ b/demo/posix/cobalt/xddp-echo.c
@@ -238,7 +238,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(rt);
 	pthread_cancel(nrt);
 	pthread_join(rt, NULL);
diff --git a/demo/posix/cobalt/xddp-label.c b/demo/posix/cobalt/xddp-label.c
index fc227b232..9de31fdea 100644
--- a/demo/posix/cobalt/xddp-label.c
+++ b/demo/posix/cobalt/xddp-label.c
@@ -317,7 +317,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(rt1);
 	pthread_cancel(rt2);
 	pthread_cancel(nrt);
diff --git a/demo/posix/cobalt/xddp-stream.c b/demo/posix/cobalt/xddp-stream.c
index b61052a7f..e53729462 100644
--- a/demo/posix/cobalt/xddp-stream.c
+++ b/demo/posix/cobalt/xddp-stream.c
@@ -244,7 +244,7 @@ int main(int argc, char **argv)
 	if (errno)
 		fail("pthread_create");
 
-	sigwait(&set, &sig);
+	__STD(sigwait(&set, &sig));
 	pthread_cancel(rt);
 	pthread_cancel(nrt);
 	pthread_join(rt, NULL);
-- 
2.26.2


