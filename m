From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 3/4] drivers/net/igb: Replace read_barrier_depends
Date: Sun, 11 Apr 2021 09:54:20 +0200
Message-Id: <e7fe718e258392435b2c14799f2b3e50d1732537.1618127660.git.jan.kiszka@web.de>
In-Reply-To: <cover.1618127660.git.jan.kiszka@web.de>
References: <cover.1618127660.git.jan.kiszka@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Follows upstream commit c4cb99185b4c.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/drivers/net/drivers/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/ne=
t/drivers/igb/igb_main.c
index 2f49ba17fe..1dc4732ee2 100644
=2D-- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -4644,7 +4644,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_=
vector)
 			break;

 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();

 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
=2D-
2.26.2


