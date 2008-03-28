Date: Fri, 28 Mar 2008 20:06:45 +0800
From: jserv@domain.hid
Message-ID: <20080328120645.GA31103@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Disposition: inline
Subject: [Xenomai-core] [SOLO] [PATCH] Missing symbols in pSOS emulation
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hello list,

This patch fixes build errors of Xenomai/SOLO pSOS emulation due to
missing symbols.

Regards,
-jserv

diff --git a/psos/pt.c b/psos/pt.c
index 4e42a76..69d41dd 100644
--- a/psos/pt.c
+++ b/psos/pt.c
@@ -44,6 +44,8 @@ pt->bitmap[((n) / (sizeof(u_long) * 8))]
 #define pt_bitmap_tstbit(pt,n) \
 (pt_bitmap_pos(pt,n) & pt_block_pos(n))

+struct hash_table psos_pt_table;
+
 static struct psos_pt *get_pt_from_id(u_long ptid, int *err_r)
 {
        struct psos_pt *pt = (struct psos_pt *)ptid;
diff --git a/psos/rn.c b/psos/rn.c
index efe9e27..62529c2 100644
--- a/psos/rn.c
+++ b/psos/rn.c
@@ -29,6 +29,8 @@

 #define rn_magic       0x8181efef

+struct hash_table psos_rn_table;
+
 static struct psos_rn *get_rn_from_id(u_long rnid, int *err_r)
 {
        struct psos_rn *rn = (struct psos_rn *)rn;
 

