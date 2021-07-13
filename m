From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] testsuite/smokey: rtdm: Give delayed close more time for
 running in QEMU
Message-ID: <81e1134c-cc58-45e0-99ed-a8447ab0862d@siemens.com>
Date: Tue, 13 Jul 2021 18:36:44 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

RTTST_RTIOC_RTDM_DEFER_CLOSE causes a 300 ms delay by the driver. We
only added 1 ms plus the open/close of the second device, and that was
sometimes too short when running in QEMU:

2021-06-18T18:58:41 FAILED run_rtdm:186: open returned -16 instead of 12 - Device or resource busy

Make it 100 ms in that case, to be safe.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 testsuite/smokey/rtdm/rtdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testsuite/smokey/rtdm/rtdm.c b/testsuite/smokey/rtdm/rtdm.c
index 187333770e..0b89228fcd 100644
--- a/testsuite/smokey/rtdm/rtdm.c
+++ b/testsuite/smokey/rtdm/rtdm.c
@@ -182,7 +182,7 @@ static int run_rtdm(struct smokey_test *t, int argc, char *const argv[])
 	check("open", open(devname, O_RDWR), -EBUSY);
 	dev2 = check("open", open(devname2, O_RDWR), dev);
 	check("close", close(dev2), 0);
-	usleep(301000);
+	usleep(smokey_on_vm ? 400000 : 301000);
 	dev = check("open", open(devname, O_RDWR), dev);
 
 	smokey_trace("Normal close");
-- 
2.26.2


-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

