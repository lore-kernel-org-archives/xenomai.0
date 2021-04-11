From: Jan Kiszka <jan.kiszka@web.de>
Subject: [PATCH 2/4] drivers/net: Account for renaming of
 pci_cleanup_aer_uncorrect_error_status in 5.7
Date: Sun, 11 Apr 2021 09:54:19 +0200
Message-Id: <896969c80aabcce00a32ccd3feb720220d2ac30e.1618127660.git.jan.kiszka@web.de>
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

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 kernel/cobalt/include/asm-generic/xenomai/wrappers.h | 4 ++++
 kernel/drivers/net/drivers/e1000e/netdev.c           | 2 +-
 kernel/drivers/net/drivers/igb/igb_main.c            | 4 ++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h b/kernel=
/cobalt/include/asm-generic/xenomai/wrappers.h
index 2bb344d737..be62ab744b 100644
=2D-- a/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
+++ b/kernel/cobalt/include/asm-generic/xenomai/wrappers.h
@@ -199,4 +199,8 @@ devm_hwmon_device_register_with_groups(struct device *=
dev, const char *name,
 #define vmalloc_kernel(__size, __flags)	__vmalloc(__size, GFP_KERNEL|__fl=
ags)
 #endif

+#if LINUX_VERSION_CODE < KERNEL_VERSION(5,7,0)
+#define pci_aer_clear_nonfatal_status	pci_cleanup_aer_uncorrect_error_sta=
tus
+#endif
+
 #endif /* _COBALT_ASM_GENERIC_WRAPPERS_H */
diff --git a/kernel/drivers/net/drivers/e1000e/netdev.c b/kernel/drivers/n=
et/drivers/e1000e/netdev.c
index 5beaf2b552..5ce4679113 100644
=2D-- a/kernel/drivers/net/drivers/e1000e/netdev.c
+++ b/kernel/drivers/net/drivers/e1000e/netdev.c
@@ -3778,7 +3778,7 @@ static pci_ers_result_t e1000_io_slot_reset(struct p=
ci_dev *pdev)
 		result =3D PCI_ERS_RESULT_RECOVERED;
 	}

-	pci_cleanup_aer_uncorrect_error_status(pdev);
+	pci_aer_clear_nonfatal_status(pdev);

 	return result;
 }
diff --git a/kernel/drivers/net/drivers/igb/igb_main.c b/kernel/drivers/ne=
t/drivers/igb/igb_main.c
index 01960a6c26..2f49ba17fe 100644
=2D-- a/kernel/drivers/net/drivers/igb/igb_main.c
+++ b/kernel/drivers/net/drivers/igb/igb_main.c
@@ -5437,10 +5437,10 @@ static pci_ers_result_t igb_io_slot_reset(struct p=
ci_dev *pdev)
 		result =3D PCI_ERS_RESULT_RECOVERED;
 	}

-	err =3D pci_cleanup_aer_uncorrect_error_status(pdev);
+	err =3D pci_aer_clear_nonfatal_status(pdev);
 	if (err) {
 		dev_err(&pdev->dev,
-			"pci_cleanup_aer_uncorrect_error_status failed 0x%0x\n",
+			"pci_aer_clear_nonfatal_status failed 0x%0x\n",
 			err);
 		/* non-fatal, continue */
 	}
=2D-
2.26.2


