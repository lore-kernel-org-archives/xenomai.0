From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtdm: Remove early exit from send/recvmmsg on vlan == 0
Message-ID: <fc82c876-9115-7a59-726a-5b4baf01de27@siemens.com>
Date: Fri, 15 Nov 2019 10:44:51 +0100
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

This enables tracing and is not really needed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/cobalt/rtdm/fd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/cobalt/rtdm/fd.c b/kernel/cobalt/rtdm/fd.c
index 5b2c3834da..eb80aa7bf5 100644
--- a/kernel/cobalt/rtdm/fd.c
+++ b/kernel/cobalt/rtdm/fd.c
@@ -656,16 +656,13 @@ int __rtdm_fd_recvmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 	struct cobalt_recvmmsg_timer rq;
 	xntmode_t tmode = XN_RELATIVE;
 	struct timespec ts = { 0 };
-	int ret, datagrams = 0;
+	int ret = 0, datagrams = 0;
 	xnticks_t timeout = 0;
 	struct mmsghdr mmsg;
 	struct rtdm_fd *fd;
 	void __user *u_p;
 	ssize_t len;
 	spl_t s;
-	
-	if (vlen == 0)
-		return 0;
 
 	fd = rtdm_fd_get(ufd, 0);
 	if (IS_ERR(fd)) {
@@ -786,14 +783,11 @@ int __rtdm_fd_sendmmsg(int ufd, void __user *u_msgvec, unsigned int vlen,
 		       int (*get_mmsg)(struct mmsghdr *mmsg, void __user *u_mmsg),
 		       int (*put_mmsg)(void __user **u_mmsg_p, const struct mmsghdr *mmsg))
 {
-	int ret, datagrams = 0;
+	int ret = 0, datagrams = 0;
 	struct mmsghdr mmsg;
 	struct rtdm_fd *fd;
 	void __user *u_p;
 	ssize_t len;
-	
-	if (vlen == 0)
-		return 0;
 
 	fd = rtdm_fd_get(ufd, 0);
 	if (IS_ERR(fd)) {
-- 
2.16.4


-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

