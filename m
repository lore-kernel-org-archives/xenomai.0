From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 1/5] testsuite/gpiotest: define missing 'timestamp' argument
Date: Wed, 20 Mar 2019 16:44:21 +0100
Message-Id: <20190320154425.30639-2-rpm@xenomai.org>
In-Reply-To: <20190320154425.30639-1-rpm@xenomai.org>
References: <20190320154425.30639-1-rpm@xenomai.org>
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

Signed-off-by: Philippe Gerum <rpm@xenomai.org>
---
 testsuite/gpiotest/gpiotest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testsuite/gpiotest/gpiotest.c b/testsuite/gpiotest/gpiotest.c
index 7347ac506..2e4b1bf4d 100644
--- a/testsuite/gpiotest/gpiotest.c
+++ b/testsuite/gpiotest/gpiotest.c
@@ -35,6 +35,7 @@ smokey_test_plugin(interrupt,
 			   SMOKEY_STRING(device),
 			   SMOKEY_STRING(trigger),
 			   SMOKEY_BOOL(select),
+			   SMOKEY_BOOL(timestamp),
 		   ),
    "Wait for interrupts from a GPIO pin.\n"
    "\tdevice=<device-path>\n"
-- 
2.20.1


