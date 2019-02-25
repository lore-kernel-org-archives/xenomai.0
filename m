From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: Add kernel/rtdm/net.h to packaged header list
Message-ID: <8d905265-ef32-da52-abff-cdc244a3c0bb@siemens.com>
Date: Mon, 25 Feb 2019 19:08:38 +0100
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

Missed by e8178c98137c.

Reported-by: Edouard Tisserant <edouard.tisserant@gmail.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Will go to stable as well and make 3.0.9 be fine again.

 include/cobalt/kernel/rtdm/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/cobalt/kernel/rtdm/Makefile.am b/include/cobalt/kernel/rtdm/Makefile.am
index 5fc6783aaf..fe2e4d5c99 100644
--- a/include/cobalt/kernel/rtdm/Makefile.am
+++ b/include/cobalt/kernel/rtdm/Makefile.am
@@ -8,6 +8,7 @@ noinst_HEADERS =	\
 	fd.h		\
 	gpio.h		\
 	ipc.h		\
+	net.h		\
 	rtdm.h		\
 	serial.h	\
 	testing.h	\
-- 
2.16.4

