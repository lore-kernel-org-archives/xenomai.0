From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 6/6] alchemytests: Fix gcc warning in task-9
Date: Fri,  8 Apr 2022 10:04:01 +0200
Message-Id: <20220408080401.22235-7-richard@nod.at>
In-Reply-To: <20220408080401.22235-1-richard@nod.at>
References: <20220408080401.22235-1-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Richard Weinberger <richard@nod.at>

Make it static, no prototype needed anymore.

Fixes:
task-9.c:13:6: error: no previous prototype for =E2=80=98sighandler=E2=80=
=99 [-Werror=3Dmissing-prototypes]
 void sighandler(int sig)

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 testsuite/alchemytests/task-9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/alchemytests/task-9.c b/testsuite/alchemytests/tas=
k-9.c
index e358154c5..4b62a17be 100644
--- a/testsuite/alchemytests/task-9.c
+++ b/testsuite/alchemytests/task-9.c
@@ -10,7 +10,7 @@ static RT_TASK t_test;
=20
 #define ONE_SECOND  1000000000ULL
=20
-void sighandler(int sig)
+static void sighandler(int sig)
 {
 	/* nop */
 }
--=20
2.34.1


