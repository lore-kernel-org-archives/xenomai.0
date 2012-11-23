From: stefan.roese@gmail.com
Date: Fri, 23 Nov 2012 14:50:07 +0100
Message-Id: <1353678609-9730-2-git-send-email-stefan.roese@gmail.com>
In-Reply-To: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
References: <1353678609-9730-1-git-send-email-stefan.roese@gmail.com>
Subject: [Xenomai] [PATCH v3 1/3] Add RTDM_CLASS_CUSTOM for custom RTDM
	device drivers
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Stefan Roese <sr@denx.de>

From: Stefan Roese <sr@denx.de>

As suggested by Jan Kriszka, define a new class for custom RTDM device
drivers.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 include/rtdm/rtdm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/rtdm/rtdm.h b/include/rtdm/rtdm.h
index d907f08..581f98a 100644
--- a/include/rtdm/rtdm.h
+++ b/include/rtdm/rtdm.h
@@ -121,6 +121,7 @@ typedef int64_t nanosecs_rel_t;
 #define RTDM_CLASS_RTMAC		5
 #define RTDM_CLASS_TESTING		6
 #define RTDM_CLASS_RTIPC		7
+#define RTDM_CLASS_CUSTOM		8
 /*
 #define RTDM_CLASS_USB			?
 #define RTDM_CLASS_FIREWIRE		?
-- 
1.8.0


