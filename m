Message-ID: <4C07BEEC.6080100@domain.hid>
Date: Thu, 03 Jun 2010 16:40:44 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: jan.kiszka@domain.hid
Content-Transfer-Encoding: quoted-printable
Subject: [Adeos-main] [PATCH] Fix rss acounting
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

A mismerge caused rss acounting to go wild as the rss vector was no
longer properly initialized.

Signed-off-by: Jan Kiszka <jan.kiszka@domain.hid>
---
 mm/memory.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index b91ded4..0f6be32 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -784,8 +784,9 @@ again:
 	}
 #else
 again:
-	init_rss_vec(rss);
 #endif
+	init_rss_vec(rss);
+
 	dst_pte =3D pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
 	if (!dst_pte) {
 		if (uncow_page)
--=20
1.6.0.2

