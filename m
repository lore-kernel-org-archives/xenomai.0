From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 9/9] net/igb: igb_ioctl() requires execution in secondary mode
Date: Fri, 26 Oct 2018 16:08:25 +0200
Message-Id: <20181026140825.5251-9-rpm@xenomai.org>
In-Reply-To: <20181026140825.5251-1-rpm@xenomai.org>
References: <20181026140825.5251-1-rpm@xenomai.org>
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Philippe Gerum <rpm@xenomai.org>

We may have to call the regular MII layer from this routine.
---
 kernel/drivers/net/drivers/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 0a6cd4bd6..c1d1000ea 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -5067,6 +5067,9 @@ static int igb_mii_ioctl(struct rtnet_device *netdev, struct ifreq *ifr, int cmd
  **/
 static int igb_ioctl(struct rtnet_device *netdev, struct ifreq *ifr, int cmd)
 {
+	if (rtdm_in_rt_context())
+		return -ENOSYS;
+	
 	switch (cmd) {
 	case SIOCGMIIPHY:
 	case SIOCGMIIREG:
-- 
2.17.2


