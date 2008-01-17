Message-ID: <478FA839.5070409@domain.hid>
Date: Thu, 17 Jan 2008 20:10:49 +0100
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060308020405050100060200"
Subject: [Adeos-main] [PATCH] cow-pinning: bark on bad pages
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Philippe Gerum <rpm@xenomai.org>
Cc: adeos-main <adeos-main@gna.org>

This is a multi-part message in MIME format.
--------------060308020405050100060200
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Use Linux standard pattern for walking through the page table hierarchy.

As we know that the warning I once saw with this applied was related to
another, already fixed bug, my feeling is far better about this variant
now. :)

Jan

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

--------------060308020405050100060200
Content-Type: text/x-patch;
 name="bark-on-bad-page.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bark-on-bad-page.patch"

---
 mm/memory.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.24-rc8-xeno_64/mm/memory.c
===================================================================
--- linux-2.6.24-rc8-xeno_64.orig/mm/memory.c
+++ linux-2.6.24-rc8-xeno_64/mm/memory.c
@@ -2827,7 +2827,7 @@ static inline int ipipe_pin_pmd_range(st
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		if (pmd_none_or_clear_bad(pmd))
 			continue;
 		if (ipipe_pin_pte_range(mm, pmd, vma, addr, next))
 			return -ENOMEM;
@@ -2845,7 +2845,7 @@ static inline int ipipe_pin_pud_range(st
 	pud = pud_offset(pgd, addr);
 	do {
 		next = pud_addr_end(addr, end);
-		if (pud_none(*pud) || unlikely(pud_bad(*pud)))
+		if (pud_none_or_clear_bad(pud))
 			continue;
 		if (ipipe_pin_pmd_range(mm, pud, vma, addr, next))
 			return -ENOMEM;
@@ -2879,7 +2879,7 @@ int ipipe_disable_ondemand_mappings(stru
 		pgd = pgd_offset(mm, addr);
 		do {
 			next = pgd_addr_end(addr, end);
-			if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+			if (pgd_none_or_clear_bad(pgd))
 				continue;
 			if (ipipe_pin_pud_range(mm, pgd, vma, addr, next)) {
 				result = -ENOMEM;

--------------060308020405050100060200--

