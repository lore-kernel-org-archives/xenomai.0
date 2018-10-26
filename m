From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 8/9] net/igb: down interface upon PCI unregister
Date: Fri, 26 Oct 2018 16:08:24 +0200
Message-Id: <20181026140825.5251-8-rpm@xenomai.org>
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

Allow to safely unload the IGB driver module still hosting an active
rtnet interface, by forcing this interface down on behalf on the PCI
device removal handler.
---
 kernel/drivers/net/drivers/igb/igb_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/net/drivers/igb/igb_main.c
index 67a34b539..0a6cd4bd6 100644
--- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -2432,6 +2432,7 @@ static void igb_remove(struct pci_dev *pdev)
 	struct igb_adapter *adapter = rtnetdev_priv(netdev);
 	struct e1000_hw *hw = &adapter->hw;
 
+	rtdev_down(netdev);
 	igb_down(adapter);
 
 	pm_runtime_get_noresume(&pdev->dev);
-- 
2.17.2


