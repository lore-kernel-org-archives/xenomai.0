From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH 5/7] testsuite/smokey: trace test startup with verbose=2
Date: Wed, 12 May 2021 12:05:55 +0200
Message-Id: <7b14bedc2a3c8c6499e9c907c4e02e5e9a267d49.1620813957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1620813957.git.jan.kiszka@siemens.com>
References: <cover.1620813957.git.jan.kiszka@siemens.com>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/smokey/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/smokey/main.c b/testsuite/smokey/main.c
index 5702e825a0..f24c1e990b 100644
--- a/testsuite/smokey/main.c
+++ b/testsuite/smokey/main.c
@@ -31,6 +31,7 @@ int main(int argc, char *const argv[])
 
 	for_each_smokey_test(t) {
 		pthread_setschedparam(pthread_self(), SCHED_OTHER, &param);
+		smokey_trace("\n===  running %s ===\n", t->name);
 		ret = t->run(t, argc, argv);
 		if (ret) {
 			if (ret == -ENOSYS) {
-- 
2.26.2


