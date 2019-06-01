From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 5/8] testsuite/smokey: reset main()'s SCHED_OTHER policy
 before each test
Date: Sat,  1 Jun 2019 17:14:59 +0200
Message-Id: <20190601151502.27216-6-rpm@xenomai.org>
In-Reply-To: <20190601151502.27216-1-rpm@xenomai.org>
References: <20190601151502.27216-1-rpm@xenomai.org>
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
index 12321dfc5..5702e825a 100644
--- a/testsuite/smokey/main.c
+++ b/testsuite/smokey/main.c
@@ -22,6 +22,7 @@
 
 int main(int argc, char *const argv[])
 {
+	struct sched_param param = { .sched_priority = 0 };
 	struct smokey_test *t;
 	int ret, fails = 0;
 
@@ -29,6 +30,7 @@ int main(int argc, char *const argv[])
 		return 0;
 
 	for_each_smokey_test(t) {
+		pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
 		ret = t->run(t, argc, argv);
 		if (ret) {
 			if (ret == -ENOSYS) {
-- 
2.20.1


