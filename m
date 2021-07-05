From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] drivers/ipc: bufp: Add missing initialization of rdsem/wrsem
Message-ID: <94b17b84-0e9f-573b-4d74-c3733c0b6eac@siemens.com>
Date: Mon, 5 Jul 2021 08:15:39 +0200
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

This caused random values in those vars, and that led to premature
leaving of __bufp_readbuf and __bufp_writebuf with waiter states not
properly updated, e.g.

Fixes: 0a67a85bdd00 ("drivers/ipc: bufp: fix rd/rd and wr/wr races")
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/ipc/bufp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/drivers/ipc/bufp.c b/kernel/drivers/ipc/bufp.c
index 5692f31469..d673ee8f32 100644
--- a/kernel/drivers/ipc/bufp.c
+++ b/kernel/drivers/ipc/bufp.c
@@ -120,6 +120,8 @@ static int bufp_socket(struct rtdm_fd *fd)
 	sk->fillsz = 0;
 	sk->rdrsvd = 0;
 	sk->wrrsvd = 0;
+	sk->rdsem = 0;
+	sk->wrsem = 0;
 	sk->status = 0;
 	sk->handle = 0;
 	sk->rx_timeout = RTDM_TIMEOUT_INFINITE;
-- 
2.26.2

