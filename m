From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] rtnet: e1000e: Fix build on 4.12+
Message-ID: <92a0d34a-e180-bf97-10bc-3fd308a3dbb5@siemens.com>
Date: Thu, 4 Apr 2019 07:04:10 +0200
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

This is not yet the final solution, we need pci_alloc_irq_vectors on the
long run, but that will require more wrapping or deprecation of older
kernels.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kernel/drivers/net/drivers/e1000e/netdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/net/drivers/e1000e/netdev.c
index f556ffe572..9feaf071a1 100644
--- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -1222,9 +1222,10 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 				for (i = 0; i < adapter->num_vectors; i++)
 					adapter->msix_entries[i].entry = i;
 
-				err = pci_enable_msix(adapter->pdev,
-						      adapter->msix_entries,
-						      adapter->num_vectors);
+				err = pci_enable_msix_range(adapter->pdev,
+							adapter->msix_entries,
+							adapter->num_vectors,
+							adapter->num_vectors);
 				if (err == 0)
 					return;
 			}
-- 
2.16.4

