Date: Fri, 26 Apr 2019 00:44:27 +0000
From: Jeff Webb <w1@codecraftsmen.org>
Reply-To: Jeff Webb <w1@codecraftsmen.org>
Subject: [PATCH] drivers/serial: 16550A: fix tx timeout bug in rt_16550_write
Message-ID: <Ck9Qvyw1mkelhwhpAZSIDipLnkcOa-Z1S9cL_oVq6p20rVpOSTJr97KCzuEoDqNucszDkzc32NYktwFWWQ9TJbVVH2wNoy6s4nd3NdzGBPc=@codecraftsmen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

From: Jeff Webb <jeff.webb@codecraftsmen.org>

This was likely a copy-and-paste error that resulted in
rx_timeout being used instead of tx_timeout in two places.

Signed-off-by: Jeff Webb <jeff.webb@codecraftsmen.org>
---
 kernel/drivers/serial/16550A.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/drivers/serial/16550A.c b/kernel/drivers/serial/16550A.=
c
index 24415cf..923211b 100644
--- a/kernel/drivers/serial/16550A.c
+++ b/kernel/drivers/serial/16550A.c
@@ -963,10 +963,10 @@ ssize_t rt_16550_write(struct rtdm_fd *fd, const void=
 *buf, size_t nbyte)

 =09ctx =3D rtdm_fd_to_private(fd);

-=09rtdm_toseq_init(&timeout_seq, ctx->config.rx_timeout);
+=09rtdm_toseq_init(&timeout_seq, ctx->config.tx_timeout);

 =09/* Make write operation atomic. */
-=09ret =3D rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.rx_timeout,
+=09ret =3D rtdm_mutex_timedlock(&ctx->out_lock, ctx->config.tx_timeout,
 =09=09=09=09   &timeout_seq);
 =09if (ret)
 =09=09return ret;
--
2.17.1



