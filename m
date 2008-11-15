Message-ID: <491F6162.2090301@domain.hid>
Date: Sun, 16 Nov 2008 00:55:14 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-core] [patch] fault mmaped area upon rtdm_mmap_to_user.
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: Xenomai core <Xenomai-core@domain.hid>

Hi Jan,

I have just commited a modification of the nucleus heap which allows
faulting newly mapped pages. However, I noticed that we should modify
rtdm_mmap_to_user as in the attached patch.

At this chance, I also noticed that there is no way to ask for uncached
memory to rtdm_mmap_to_user, how do you think we should change
rtdm_mmap_to_user to allow this?

Regards.

Index: ksrc/skins/rtdm/drvlib.c
===================================================================
--- ksrc/skins/rtdm/drvlib.c	(revision 4390)
+++ ksrc/skins/rtdm/drvlib.c	(working copy)
@@ -1781,6 +1781,7 @@ static int rtdm_mmap_buffer(struct file
 {
 	struct rtdm_mmap_data *mmap_data = filp->private_data;
 	unsigned long vaddr, paddr, maddr, size;
+	int ret;

 	vma->vm_ops = mmap_data->vm_ops;
 	vma->vm_private_data = mmap_data->vm_private_data;
@@ -1810,15 +1811,25 @@ static int rtdm_mmap_buffer(struct file
 			vaddr += PAGE_SIZE;
 			mapped_size += PAGE_SIZE;
 		}
-		return 0;
+#ifdef xnarch_fault_range
+		xnarch_fault_range(vma);
+#endif /* xnarch_fault_range */
+		ret = 0;
 	} else
 #endif /* CONFIG_MMU */
 	if (mmap_data->src_paddr)
-	  	return xnarch_remap_io_page_range(filp, vma, maddr, paddr,
-						  size, PAGE_SHARED);
-	else
-		return xnarch_remap_kmem_page_range(vma, maddr, paddr,
-						    size, PAGE_SHARED);
+	  	ret = xnarch_remap_io_page_range(filp, vma, maddr, paddr,
+						 size, PAGE_SHARED);
+	else {
+		ret = xnarch_remap_kmem_page_range(vma, maddr, paddr,
+						   size, PAGE_SHARED);
+#ifdef xnarch_fault_range
+		if (!ret)
+			xnarch_fault_range(vma);
+#endif /* xnarch_fault_range */
+	}
+
+	return ret;
 }

 static struct file_operations rtdm_mmap_fops = {


-- 
					    Gilles.

