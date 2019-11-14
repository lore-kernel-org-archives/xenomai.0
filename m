From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtdm: Do not return an error from send/recvmmsg if there are
 packets
Message-ID: <02a4475e-f687-8e87-1971-1948cecfbf34@siemens.com>
Date: Thu, 14 Nov 2019 19:59:13 +0100
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

This is in line with Linux behavior.

We likely still miss an equivalent to sk_err in recvmmsg, though.

Reported-by: Lange Norbert <norbert.lange@andritz.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 0a1c6e44ed..5b2c3834da 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -734,14 +734,12 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		xnlock_put_irqrestore(&nklock, s);
 	}
 
-	if (datagrams > 0 &&
-	    (ret == 0 || ret == -ETIMEDOUT || ret == -EWOULDBLOCK)) {
-		/* NOTE: SO_ERROR should be honored for other errors. */
-		rtdm_fd_put(fd);
-		return datagrams;
-	}
 fail:
 	rtdm_fd_put(fd);
+
+	if (datagrams > 0)
+		ret = datagrams;
+
 out:
 	trace_cobalt_fd_recvmmsg_status(current, fd, ufd, ret);
 
@@ -826,13 +824,11 @@ int __rtdm_fd_sendmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		datagrams++;
 	}
 
-	if (datagrams > 0 && (ret == 0 || ret == -EWOULDBLOCK)) {
-		/* NOTE: SO_ERROR should be honored for other errors. */
-		rtdm_fd_put(fd);
-		return datagrams;
-	}
-
 	rtdm_fd_put(fd);
+
+	if (datagrams > 0)
+		ret = datagrams;
+
 out:
 	trace_cobalt_fd_sendmmsg_status(current, fd, ufd, ret);
 
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

