From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH v2 2/3] testsuite/gpiobench: Explicitly request monotonic
 timestamps
Date: Tue, 31 Aug 2021 09:15:07 +0200
Message-Id: <7bc3ba39b57efc5810afb8410046196bde7cdb8c.1630394108.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1630394108.git.jan.kiszka@siemens.com>
References: <cover.1630394108.git.jan.kiszka@siemens.com>
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

From: Jan Kiszka <jan.kiszka@siemens.com>

The API's default will change, so select monotonic explicitly.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/gpiobench/gpiobench.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/gpiobench/gpiobench.c b/testsuite/gpiobench/gpiobench.c
index f83d7689f4..50afbd418a 100644
--- a/testsuite/gpiobench/gpiobench.c
+++ b/testsuite/gpiobench/gpiobench.c
@@ -619,7 +619,7 @@ int main(int argc, char **argv)
 			goto out;
 		}
 
-		ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS, &value);
+		ret = ioctl(ti.fd_dev_intr, GPIO_RTIOC_TS_MONO, &value);
 		if (ret) {
 			printf("ioctl gpio port ts, failed\n");
 			goto out;
-- 
2.31.1


