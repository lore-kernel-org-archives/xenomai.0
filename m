From: Philippe Gerum <rpm@xenomai.org>
Subject: [PATCH 2/5] net/drivers: e1000e: stop using deprecated
 pci_enable_msix()
Date: Fri, 22 Mar 2019 10:59:32 +0100
Message-Id: <20190322095935.8066-3-rpm@xenomai.org>
In-Reply-To: <20190322095935.8066-1-rpm@xenomai.org>
References: <20190322095935.8066-1-rpm@xenomai.org>
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

---
 kernel/drivers/net/drivers/e1000e/netdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index 8516dbc89..cb4f0fdcf 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -1224,9 +1224,10 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 				for (i = 0; i < adapter->num_vectors; i++)
 					adapter->msix_entries[i].entry = i;
 
-				err = pci_enable_msix(adapter->pdev,
-						      adapter->msix_entries,
-						      adapter->num_vectors);
+				err = pci_enable_msix_range(adapter->pdev,
+							    adapter->msix_entries,
+							    adapter->num_vectors,
+							    adapter->num_vectors);
 				if (err == 0)
 					return;
 			}
-- 
2.20.1


