From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] ipipe: Fix get_user_pages usage in __ipipe_pin_vma
Message-ID: <ecf9f46b-fe92-95d3-2234-ee6264bfc41e@siemens.com>
Date: Tue, 2 Apr 2019 14:47:37 +0200
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
To: Philippe Gerum <rpm@xenomai.org>
Cc: Xenomai <xenomai@xenomai.org>

From: Jan Kiszka <jan.kiszka@siemens.com>

Since 9beae1ea8930, we are supposed to pass down flags, not just 0 or 1.
Luckily, 1 happened to be FOLL_WRITE, so we did the right thing by
chance.

Moreover, get_user_pages is deprecated in favor of its locked/unlocked/
fast variants.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Only noticed now that we are accounting for that in 4.4 already, but not
yet in 4.14+.

 mm/mlock.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 392a7567b577..7244eab0bcc3 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -868,7 +868,8 @@ void user_shm_unlock(size_t size, struct user_struct *user)
 #ifdef CONFIG_IPIPE
 int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	int ret, write, len;
+	unsigned int gup_flags = 0;
+	int ret, len;
 
 	if (vma->vm_flags & (VM_IO | VM_PFNMAP))
 		return 0;
@@ -880,9 +881,10 @@ int __ipipe_pin_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 		return ret < 0 ? ret : 0;
 	}
 
-	write = (vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE;
+	if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
+		gup_flags |= FOLL_WRITE;
 	len = DIV_ROUND_UP(vma->vm_end, PAGE_SIZE) - vma->vm_start/PAGE_SIZE;
-	ret = get_user_pages(vma->vm_start, len, write, 0, NULL);
+	ret = get_user_pages_locked(vma->vm_start, len, gup_flags, NULL, NULL);
 	if (ret < 0)
 		return ret;
 	return ret == len ? 0 : -EFAULT;
-- 
2.16.4

