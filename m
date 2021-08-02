From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ci: Include FEC Ethernet driver
Message-ID: <91c509f2-61a3-7379-48a9-307864c4ab00@siemens.com>
Date: Mon, 2 Aug 2021 10:38:06 +0200
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 0d354c04d7..05b226b474 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -135,6 +135,7 @@ variables:
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_3C59X
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_E1000_NEW
     - ./scripts/config -m XENO_DRIVERS_NET_DRV_RT2500
+    - ./scripts/config -m XENO_DRIVERS_NET_FEC
     - ./scripts/config -m XENO_DRIVERS_NET_ADDON_RTCAP
     - ./scripts/config -m XENO_DRIVERS_NET_ADDON_PROXY
     - ./scripts/config -e XENO_DRIVERS_NET_ADDON_PROXY_ARP
-- 
2.31.1

